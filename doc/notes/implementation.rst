A VM Implementation
=================

This chapter describes a hypothetical implementation of a Squl VM. Code examples in this chapter are in C.

See http://gulik.pbworks.com/w/page/55126238/Faish%20implementation for the original design notes. They will all eventually be moved here.

Desired Features
-------------

* Persistence to disk, block-by-block as needed.

* Fancy garbage collection

* Compliation via LLVM device.

* Profiling statistics are kept.

* VM is deterministic for debugging.


Modules
-------------

Statements can only exist inside a module. 

The VM has a root module in which it contains metadata about other modules. Module literals physically contain pointers to other modules - when the last module literal pointing to a module is garbage collected, so is its target module. The root module contains, among many other things, references to modules that each user has access to. Perhaps it contains a list of user's "desktop" modules, which in turn contain references to the modules each user has access to.

Modules are implemented using indexes. An index is an array of statements. Statements are added to and removed from these indexes, and the contents of a module can be listed by iterating over the index. Modules consist of:

* A primary index of it's contents.
* Secondary indexes to improve performance.
* A query module containing queries. Each query is also a module containing results found so far.
* Optional source code.
* A compiled version of the module.

An index starts as an array in a block, and can be promoted to a b-tree as it grows.

Most of these can be stored in a master module that contains information about a module, e.g. (the tab character is currently used to make module literals)::

A compiled module is a version of a module which has been optimised: statements have been reshuffled and, perhaps, compiled machine code is included somehow. This idea hasn't been investigated yet.::

	(in the master module)
	module:[	1234] sourceCode:[	123s].
	module:[	1234] queries:[	123q].
	module:[	1234] compiled:[	123c].
	module:[	1234] statementDefinition:[\ a:_ b:_] index:[	123ab].

Secondary indexes would be referenced directly from statement premises that would use them, but would also be useful to store here for compilation.

The address space is global across all storage on the cluster. Each module is an index that dwells in this global address space.

Modules can look like this::

    Log  -->   Bloom filter  -->   Indexes  -->   Blocks containing statements.

* The log is a (hash table? array?) containing entries for recent additions and deletions to the module. It also allows a base module to have multiple slightly-varying versions. Occasionally it is flushed and changes written to the indexes.

* The bloom filter is an optional optimisation over very large modules. It determines if a statement possibly exists in this module, or if the statement definitely does not exist in this module. It's a binary hash table over the statements with ignored collisions. It prevents unnecessary block reads.

* The indexes contain the master index which holds the module together, and a bunch of other indexes that are referenced directly by if-clauses. Indexes may also contain packed blocks.

* Blocks containing statements contain the module data. 

A module reference is a tuple of (index, write log, bloom filter) where the index is a pointer to an array, the write log is another array of insertions and removals, and the bloom filter is a boolean array.

Within a block, a module literal looks much like a statement, but is given the type of a module rather than a statement. It has the format (subject to change)::

	primaryIndex:P
	secondaryIndexes:S
	writeLog:L
	bloomFilter:B
	queries:Q
	cache:C
	compiled:Cm.

P and S are arrays of statements. Q is a list of (query:Q results:R) tuples. C is an array (maybe?) and Cm is ... perhaps Q should contain compiled queries.


Versioning Modules
------------------

(TODO: not sure how best to do this)

(TODO: it might be possible for the compiler to avoid this problem entirely??? Perhaps the compiler could keep track of what would, hypothetically, be (or not be) in a module at each stack frame?)

Modules need to have an efficient way to keep old versions if backtracking or rollback occurs.

The obvious approach is to keep a log with the module. The log contains recent additions and removals from that module and needs to be accessed first for every read operation. Occasionally it is "committed" to the module.

Another approach is to make the changes to the module inline and keep a "rollback log" of the changes that are necessary to restore that module to an older version.

The code itself executes deterministically, so it might be possible to use that as a rollback log.

Another approach is to make parts of the module copy-on-write. This is reasonable for small modules of a few bytes. 

If it can be proven that backtracking will not occur, then we do not need to track the old states of the module.

A VM optimisation is to allow multiple threads to modify the module inline, with mutexes to protect from race conditions and with guarantees that no backtracking will occur.


Blocks
------

Blocks are 4kb in size, and consists of 256 64-bit words::

    0 Header (and lambda)
    1 InPointer (and variable 1)
    2 InPointer (and variable 2)
    ... more InPointers
    n Block Entry
    ... more Block Entries
    255-m OutPointer
    ... more OutPointers
    255 OutPointer (the last one) 

The address space is 256. The Header and InPointers address space is re-used for lambda and variables; the storage is used for the block header and InPointers.

The number of InPointers and OutPointers are specified in the header. XXX or in block metadata which is stored elsewhere.

The VM can differentiate between pointers and OutPointers (FarRefs) by having all the OutPointers at the end of the block and keep the boundary in the block metadata.

XXX InPointers don't need to be included in the block. Each InPointer also has a (large) backreference list.

Statically typed storage
--------------------------

Stored elements can be:

* References, 8 bits pointing to something else in the block.
* Primitive types (bool, byte, int, float etc).
* Deciders, N bits, determining what the following bit of data is.

These are packed into 64-bit words. 

All the other types the VM needs can be defined in terms of these elements. Type declarations, for example, are packed statements following the same schema. Module references are statements holding everything the VM needs to know about modules. Compiled code is a statement containing an array of bytes.

A "decider" is a small number of bits that determine what the type of the rest of the data is. This occurs when there are multiple options for the type of an element. For example, an "Animal" might be a dog or a cat, so a leading bit would inform the VM that the following data is of format "dog" or format "cat". Deciders should be encoded using the fewest number of bits required, such that compiled code can have a jump table of every possible case to allow for throwing errors for invalid deciding values. Deciders are basically just enums.

The VM then knows, starting from a root set of elements of precoded types, what the type of everything other binary bit in the storage is by following the type system. In this way, object headers are not required, and compiled code can make assumptions about the structure of data.

TODO: we talk about arrays here, but there's no reason to only have ordered collections. There are many optimisations we could do if they were unordered (i.e. bags) such as packing together elements with predicatable data (e.g. multiple elements with the same value, or following a sequence). Indexing here is only efficient in a single packed block. Everything else is a search through a tree.

An array can be implemented as (TODO: this is not quite right): 

    :: [ array size (type byte) inline (type T) ] (type array (type T)).
    :: [ array size (type byte) contents (type arrayContents T) ] (type array (type T)).
    :: [ array size (type byte) tree (type treeNode T) ] (type array (type T)).
    :: [ array size (type long) btree (type btree T) ] (type array (type T)).

    [" TODO: what about packed integers, etc? I think these need dynamically defining ].
    :: [ arrayContents (type X) (type X) (type X) (type X) (type X) (type X) (type X) (type X) ] (type arrayContents X).
    :: [ branchNode (type treeNode T) (type treeNode T) (type treeNode T) (type treeNode T) (type treeNode T) (type treeNode T) (type treeNode T) (type treeNode T) ] (type treeNode T). 
    :: [ leafNode (type X) (type X) (type X) (type X) (type X) (type X) (type X) (type X) ] (type treeNode X).
    :: [ empty ] (type treeNode _).

This would be packed by the compiler as: 

    Decider   Size      Contents/b-tree
    "00"      3 bits    <packed contents if they fit into 59 bits)
    "01"      3 bits    8 bits      (51 bits unused)
    "10"      8 bits    8 bits      (46 bits unused)
    "11"      8 bit ref (...maybe pack the BTree type here?)

The different promotable types of array here are:

"00": The array contents fit into 48 bits, so we pack them inline.
"01": The array contents fit into a 64 bit word, so "contents" is a reference to that word.
"10": The array is a tree structure in blocks. "contents" points to branch nodes which point to either branch nodes or leaf nodes.
"11": The array is big enough to make a BTree. The size points to a 64-bit integer. The b-tree reference contains pointers to blocks.

(It seems that "01" isn't worthwhile having!).

We can derive the type of the array. If we have a reference to the array, we kind of know it's type:

    :: [ personArray (type array (type person)) ].   
    :: [ customer name (type string) address (type string) ] (type person).
    :: [ employee name (type string) reportsTo (type employee) ] (type person).

Here, the array contains elements that are either a customer or an employee. This can be implemented either by including a deciding bit on each reference, or including the deciding bit on the data itself. It seems to be more pragmatic to include the deciding bit on the persons themselves. Anything else that uses this type can only refer to a "person", so any reference in this system could be to either a customer or an employee.

    Bit packing of (type person):
    <decider "0"> <name, 8 bits> <address, 8 bits>
    <decider "1"> <name, 8 bits> <reportsTo, 8 bits>
    
There are spare bits here, so if the name is 5 bytes or fewer then they can be packed into the same word. Alternatively, in a packed array, these entries are both 17 bits so we can pack three of them into each word.
    
The packing procedure needs to fit structures into 64-bit words. Some statements, such as those with more than 8 positions, might need to be split by adding references in them pointing to other words containing more parts of the statement. Some statements might have left over space that other statements can be inlined into. Statements with hierarchies might be able to be flattened.




Dynamically typed statement storage
-----------------------------------

XXX statically typed statement storage removes the need for headers. However, we still need some dynamic typing to implement algebraic types.

Statements can be stored as dynamically typed block entries, and the compiler can do the static type analysis stuff later.

Every block entry has the following format::

    [type][...contents...]

Where type is one of:

* Naked statement component.
* Statement with variable bindings
* Statement structure.
* Statement structure with more than 5 arguments??? (implemented as array).
* Signature
* Integer
* Float
* Statement literal
* Module reference
* A variable? Possibly with a binding.

* String (implemented as an array)
* Boolean array
* Inline 8-bit int array (also for strings)??
* Integer array (8-bit / 16-bit / 32-bit / 64-bit; signed / unsigned)
* Float array (8-bit / 16-bit / 32-bit / 64-bit)
* Statement array
* Packed statement array
* Compiled code (implemented as an array)
* Big Integer (implemented as an array)
* InPointer backreferences (implemented as an array)
* All of the above array types as btrees.
* FarRef

A statement with variable bindings has the form (where [structure] refers to a structure. [var1] through [var6] are variable bindings for variables 1 through 6, pointing to other statements::

    [type=statement] [structure] [num vars] [var1] [var2] [var3] [var4] [var5] 
    ... [var6] [var7] [var8] [var9] [var10] [var11] [var12] [var13]
    ... etc

A statement structure refers to a signature and up to 5 values to populate it's signature. The unbound variables refer to variables deep inside the statement::

    [type=statement structure] [sig] [num args] [arg1] [arg2] [arg3] [arg4] [arg5] 
    ... [arg6] [arg7] [arg8] [arg9] [arg10] [arg11] [arg12] [arg13]
    ... etc

TODO: structures may not be needed. A compiler might convert them to structs on a call stack, manipulate that, then convert them back to this storage format on completion; it will made a copy of the whole statement regardless of any binding mechanism we might have.


A statement signature has the format (where _ is a wasted byte). Arity can be from 0 (an atom) to 5::

    [type=signature] [arity] _ _ _ _ _ _ 

An atom would be a statement with an arity of 0.

An integer and float have the format:

    [type=integer] _ _ _ [32-bit integer]

    [type=float] _ _ _ [32-bit float]

A statement/atom/variable/literal literal is::

    [type=statement literal] [ref] _ _ _ _ _ _

A module reference is::

    [type=module reference] [7 bytes of reference]

A far ref is:

    [type=far ref] [7 bytes of far ref]

An array is (where the [array type] is one of the array types)::

    [array type] [size] [6 bytes of array]
    [8 more bytes of array]
    [8 more bytes of array]
    ...   

If the array is larger than 254 bytes, then it needs to be promoted to a btree.

A btree resembles a module reference::

    [btree array type] [7-bytes of reference]


Long statements
---------------

If a statement has more than 5 positions, then it can be split up. E.g.::
   
    a:a b:b c:c d:d e:e f:f g:g.

Can become (internally):

    a:a b:b c:c d:d more:(e:e f:f g:g).

This allows for a statement to span across multiple blocks.

Lots of variables
----------------

If a statement has more than 5 variables, various implementation options are available:

* A statement can refer to more statements directly, with more variable bindings. The head of a statement tree are all variable bindings.

* Or, a statement can be an array (possibly promotable if you want to go down the path of crazy) or a linked list.

xxx
-----------------


Each entry takes 64 bits. Many of these types can sprawl over several words.

TODO: how do we determine between statements and farrefs? Or, anything and a farref?

Answer: farrefs can be bunched together at the end of the block address space, and block metadata can describe where that boundary is.

	- integers, floats, module references, variable literals should be copied instead.
	- small arrays could be copied. Maybe?
	- big arrays should have their handles copied.
	- That only leaves statements. We could declare that (c=255) or perhaps (a=255) to be a FarRef maybe?

TODO: how do we determine between an integer and a big integer?
	- We don't have primitive big integers? Overflows just fail. We implement them in Squl?
	- We add them as a primitive type. This will cause type explosion with all multi-integer operations.
	- We have a bit flag in the integer.

TODO: How do we compile code that uses integer arithmetic? Do we continuously check for overflows?

Statements have a number of if-clauses. The then-clause counts as a clause for the purposes of counting the clauses. Statements that are not then-if statements are defined as having 1 clause. Statements with 0 clauses are statement definitions or atoms.

The entry at 0 has multiple uses. The data at that location is the block heading. The address space at 0 is used for lambda, and for the variable "_".

The address space from 1 up to the (number of InPointers)/4 is used for both InPointers and variables. The data is used for InPointers; the address space is used for variables. InPointers are only two bytes each, and thus are packed four to each word. If more address space is needed for variables, the (number of InPointers) in the block header is increased by multiples of 4 and the InPointer values set to zero.

Each array type is further broken down into small arrays that fit in the block, and big arrays that span several blocks.

Statement definitions are statements with lambdas in all argument positions. We can add typing information to all lambdas.

Statement definitions look like this (see below for details)::

    254  a=2 c=0 0(int) 0(statement)	       -- h:<int> emnut:<statement>

"254" is the entry index in the block. This is a word located at index 254.

"a=2" means there are two arguments, both lambdas with typing information.

"c=0" means there are no clauses, thus is a statement definition.

"0(int)" is a lambda typed as an integer. The "(int)" would be a byte representing the type of integers.

TODO: do we gain anything by adding typing information to all variables?



Dynamic typing idea
--------------------

This will probably not be implemented. These notes are just to record this idea.

If we were to do dynamic typing, the type of each word would need to be determined just by looking at the word.

If we steal some address space from signed integers, we can say that signed integers must start with 111 or 000, which reduces their values from 2^63 <= n < -2^63 to 2^60 <= n < -2^60.

We can also steal some address space from floating point numbers. [64-bit] Floating point numbers have as their most significant bits a sign (0 or 1 for - and +), then an 11-bit exponent. We can steal several of these values.

In this way, the resulting address space consists of valid integers and valid floating point numbers, meaning that once their type is determined, they can be used directly to do arithmetic. When stored again, we need to compare the most significant bits to make sure their type has not changed.

The address space then has as most significant bits::

    000 - Positive integer
    001 - Float (positive large)
    010 - Float (positive small)
    011 - Object
    100 - Object
    101 - Float (negative large)
    110 - Float (negative small)
    111 - Negative integer

(there may be mistakes, but I think I have it correct). Floating point exponents have unusual formats; binary 01111111 represents 0; 10000000 represents 1, with values going up and down from there using usual binary arithmetic. 

The two prefixes 011 and 100 are now available to define other types.

An expanded version allows for more address space stealing::

    0000 - Positive integer
    0001 - Positive integer (or object)
    0010 - Object
    0011 - Float (positive small)
    0100 - Float (positive large)
    0101 - Object
    0110 - Object
    0111 - Object
    1000 - Object
    1001 - Object
    1010 - Object
    1011 - Float (positive small)
    1100 - Float (positive large)
    1101 - Object
    1110 - Negative integer (or object)
    1111 - Negative integer

This gives us 8 or 10 more object types. The object types remaining once integers and floats are taken out are:

* Statement, definition or atom.
* FarRef.
* Arrays of:
	- Boolean
	- Integers (of different sorts)
	- Floats (of different sorts)
	- Statements
	- Packed statements
* Big integer
* Module reference
* Variable literal

"Variable" does not need to be in this list as it can be determined by address space.

The different types of integer are:

* 8 bit signed
* 8 bit unsigned (a byte array, or string)
* 16 bit signed
* 16 bit unsigned
* 32 bit signed
* 32 bit unsigned
* 64 bit signed
* 64 bit unsigned

The different types of float are:

* 32 bit
* 64 bit

Furthermore, each array has two variants: small and big.

This gives us 6 basic types and 2 variants of 10 array types. We could split the address space up as::

    0000 - Positive integer
    0001 - Positive integer 
    0010 - Statement
    0011 - Float (positive small)
    0100 - Float (positive large)
    0101 - FarRef
    0110 - Small array
    0111 - Big array
    1000 - Big integer
    1001 - Module reference
    1010 - Variable literal
    1011 - Float (positive small)
    1100 - Float (positive large)
    1101 - 
    1110 - Negative integer
    1111 - Negative integer

The next 4 bits of an array type (big or small) could be defined as::

    0000 - 8 bit unsigned integer
    0001 - 8 bit signed integer
    0010 - 16 bit unsigned integer
    0011 - 16 bit signed integer
    0100 - 32 bit unsigned integer
    0101 - 32 bit signed integer
    0110 - 64 bit unsigned integer
    0111 - 64 bit signed integer
    1000 - Statements
    1001 - Packed statements
    1010 - Boolean arrays
    1011 -    
    1100 - 32-bit float
    1101 - 64-bit float
    1110 - 
    1111 - 


Statement Literals
--------------------

Statement literals have the same format as a statement, complete with FarRef disambiguation. It can store only a variable to be a variable literal.


	
Flattening statements
--------------------

Statements have a tree structure. For example::

	a:( b:( c:d ) ) d:e.

is::

 		      b: - c: - d
		  /
	   a:d: 
		  \
		      e

This tree has the root at the left hand side. Each level of the tree until the leaves contain statement definitions, e.g. "a:d:". The leaves contain literals, atoms or variables.

The tree can be encoded in prefix format. In this format, each node is written, then it's children are written, recursively::

    (a:d:) (b:) (c:) (d) (e).

Each of these is a statement definition, which determines what it matches and how many arguments it has. A statement definition is the same as a statement and has:

* The number of arguments.
* The number of if-clauses it has.
* The statement contents
* TODO - what else?

The statement contents is the flattened statement hierarchy in prefix format. It would consist of at least one clause. If it consists of more than one clause, it is a then-if statement where the first clause is the then- clause.

The number of arguments is the number of *unique* variables in this statement.

If the number of clauses is zero, then this is a statement definition. 

If the number of clauses is zero and the number of arguments is zero, this is an atom declaration or a statement with no variables. If the first byte of the statement contents is 0, it is an atom.

Within the flattened statement, any lambdas (λ) or variables are argument placeholders. The number of these is declared as the number of arguments. Each lambda or variable also includes a primitive type declaration (TODO: think about this). Thus we might have a block containing (then:(c:A) if:(a:(c:A) b:B) if:(c:B)). ::

    0 Block header / lambda
    1 Variable			-- A
    2 Variable			-- B
    ...empty space...
    253 a=4, c=2 255 1 254 255 1 2 255 2 -- (then:(c:A) if:(a:(c:A) b:B) if:(c:B))
    254 a=2, c=0 0(statement) 0(statement)	-- Declaration of a:b:
    255 a=1, c=0 0(statement)   -- Declaration of c:

The leftmost number is the pointer address. Here, we just use an index starting from 0, but these could be memory addresses or block targets. Everything after a "--" is a comment.

The "a=N" gives the number of arguments. The "c=N" is the number of clauses.

Here, 254 and 255 contain statement definitions. Their arguments are filled with lambdas which declare the types. The type declaration would just be an extra byte after each zero (lambda).

253 contains the actual statement. It has four arguments, one for each variable.

Here is an example containing the list [1,2,3], stored as (h:[+1] emnut:(h:[+2] emnut:(h:[+3] emnut:empty))). The list is in 249.::

    0 Block header / lambda
    ...empty space...
    249  255 250 255 251 255 252 253
    250  [+1]
    251  [+2]
    252  [+3]
    253  a=0 c=0			       -- empty
    254  a=2 c=0 0(int) 0(statement)	       -- h:<int> emnut:<statement>
    255  a=2 c=0 0(statement) 0(statement)     -- h:<statement> emnut:<statement>

Here, there are two definitions for (h:emnut:), one for each permutation of primitive types.


Variables as placeholders
----------------------------------

Each statement begins with a link to another statement or definition that contains variables. Following that first link is a number of statement trees, each giving a value for one of those variables.
	
The arguments give values for variables in each preceeding linked statement. The first byte is a link to a statement or definition; the bytes after represent trees that give values for each of the variables in that linked statement.

Variable 0 is special. Other variables are numbered 1..N, using the address space that the InPointers inhabit. When populated by arguments, they use these numbers for the argument position.

For example, (a:A b:B c:A) would look like this::

    0  Block header
	1  A
	2  B
	254 255 1 2 1			-- a:A b:B c:A
    255  a=3 c=0 0(statement) 0(statement) 0(statement) -- a:b:c:

Then, when we use 254 for unification::

    252 254 253 2			-- a:foo b:B c:foo.
    253 a=0 c=0 0(atom)		-- foo
	
Notice here that 252 only has two arguments. Argument 1 is variable 1: "A". Argument 2 is variable 2. Generalised, argument N is variable N.

When unification occurs, we make a new statement with variable values as arguments. For example, consider this code::

    (1) list:( h:Tail emnut:empty ) tail:Tail.

    (2) then:( list:(h:A emnut:(h:B emnut:Rest)) tail:Tail )
        if:( list:( h:B emnut:Rest ) tail:Tail ).

and the query::

    list:( h:[+1] emnut:(h:[+2] emnut:empty)) tail:Tail?

We encode the module as::

    0  Block header / lambda
    1  Tail
    2  A
    3  B
    4  Rest
    ...empty space...
    250  a=n c=1 252 255 2 255 3 4 1 252 255 3 4 1 -- statement (2)
    251  a=1 c=0 252 255 1 253 1		-- statement (1)
    252  a=0 c=0 0(statement) 0(statement)      -- list:<statement> tail:<statement>
    253  a=0 c=0			        -- empty
    254  a=2 c=0 0(int) 0(statement)	        -- h:<int> emnut:<statement>
    255  a=2 c=0 0(statement) 0(statement)      -- h:<statement> emnut:<statement>

TODO: 254 would not be created at compile time? Perhaps it would be created when the query is compiled?

TODO: how do we know how many words a statement can sprawl over? 250 won't fit in a single word. But we can decode the clause and continue to the next word if the clause isn't finished decoding.

Then we encode the query::

    247  a=1 c=0 252 254 248 254 249 253 1 -- The query.
    248  [+1]
    249  [+2]


The solution would be (list:(h:[+1] emnut:(h:[+2] emnut:empty)) tail:[+2]), which would be encoded as::

    246  a=0 c=0 247 249

Which is the query, but with the variable Tail given the value [+2].

In reality, many other statements would have been created during deduction. If unification isn't complete and variables have no values, those variables would be assigned more variables::

    245  a=1 c=0 247 1

Each variable in a statement is scoped for that statement only. Here, the variable "Tail" for 247 is a separate variable from the variable "Tail" for 245. They will, however, have the same value as 245 assignes Tail as an argument in the same position as the other Tail.

TODO: To decode any statement, we need to completely traverse it's tree. This sucks, performance-wise. I cannot see any shortcuts without caching information such as number of arguments and types. Even if we used dynamic typing, we'd still be looking up number of arguments for everything.

Entry zero, used as lambda, could also be used for the catch-all variable "_".


Unifying with sub-statements
-------------------------------

Given this::

	a:(a:A) b:A.
	a:A b:a?
	
Which is encoded thusly::

	252  a=1 c=0 255 1 252						-- a:A b:a?
	252  a=0 c=0 0(...)							-- a
	253  a=1 c=0 255 254 1 1					-- a:(a:A) b:A
	254  a=1 c=0 0(statement)					-- a:
	255  a=2 c=0 0(statement) 0(statement)		-- a:b:

	
When 252 is investigated, A is unified with (a:a) which does not exist. Statement 253 needs splitting up so that (a:A) can be referred to(note the entry indexes)::

	251  a=1 c=0 254 1			-- a:A
	253  a=1 c=0 255 251 1 1	-- a:(a:A) b:A
	
Note here that 253 fills in variable 1 from 251 with a new variable 1 in 253. Every free variable in a referred statement needs to be filled, either with another statement, or with a variable.

In this way, variables are scoped only within the statement they are in. If a part of a statement is split out to be referred to by other statements, as an argument it must have as value another variable. (TODO: explain this better.)
	
	

Lambda optimisations
-------------------------------

TODO: This can be done using variables. 0 is probably only useful for adding typing information to statement definitions.

This is an idea that could be used to decrease memory use and copying. Large datastructures could be shared as a template with placeholder lambdas and as instances of those templates with values for the placeholders.

Lambdas are placeholders that can be put in the statement. These form places in the statement where arguments can be filled. An index of 0 represents the lambda, as the address is otherwise unused. Position 0 in a block contains the block header which means we can use a reference to 0 for other purposes. 

Lambdas are an implementation detail and are never visible to the user. 

Say we have::

	a:b c:d.
	a:d c:d.

We could encode these as::

	0 Block header, lambda
	1 Definition, args=2		-- a:c:
	2 Definition, args=0		-- b
	3 Definition, args=0		-- d
	4 Statement 		1 0 3	-- a:λ c:d
	5 Statement		4 2		-- a:b c:d
	6 Statement		4 3		-- a:d c:d

Here, we can share part of the statement. This enables us to share large parts of statements, such as most of a list except for the last element. This is how long lists and trees can be manipulated efficiently.
	
Lambdas allow us to use fixed-sized words to store statements. With a WORD_SIZE of 64 bits and using a byte for each reference, there are only 7 bytes available to encode the statement, assuming we lose 1 byte to store the type and number of arguments. 

If we have a long statement, we can encode it using lambdas. For example:

	head:a tail:( head:b tail:( head:a tail:( head:b tail:( head:a tail:( head:b tail:end ))))).
	
	0 λ
	1 Definition, args=2		-- head:tail:
	2 Definition, args=0		-- a
	3 Definition, args=0		-- b
	4 Definition, args=0		-- end
	5 Statement		1 2 1 3 1 2 0 -- head:a tail:( head:b tail:( head:a tail:λ ))
	6 Statement		1 3 1 2 1 3 0 -- head:b tail:( head:a tail:( head:b tail:λ ))
	7 Statement		5 6 4	-- The whole long statement

Here, the statement is at index 7. It takes statement 5 and fills its lambda with statement 6. Statement 6 has a lambda too, which is filled with the atom in index 4.

Each statement entry can have any number of lambdas. However, statements with unfilled lambdas cannot be part of the module's source.

To make efficient use of lambdas, the VM must do some guessing as to which branches and variables in a statement might end up similar. If it guesses inefficiently, the shared data structure might have more differences than similarities.

Idea: lambdas contain typing information. They exist as two bytes: 0 and a byte representing the type.


Unification and bindings
----------------------------------

(brainstorming; this may be unrelated to the above. The current approach is to copy statements reasonably efficiently).

Challenges with unification and bindings are:

* Each variable might have many values as different unifications are explored.
* Backtracking means that a variable might have a value, then not have a value.
* Concurrency means that multiple values for a variable are simultaneously explored.
* A variable might be linked to another variable forming a chain. Once a value for any of these variables is found, all of the variables in the chain get this value.
* Variables might appear in sub-statements unified from other variables.
* More stuff I haven't thought of.

We refer to the stack of UnificationSearchables and DeductionSearchables as "the stack". We assume the use of Jellyfish search: except for the head, we do a depth-first search with backtracking. The bottom of the stack has the oldest searchables, the top of the stack is the most recent searchables.

A particular difficulty is that a variable in a statement at the bottom of the stack might have a variable unified by something far up the stack (I think?). 

In the stack, a variable is assigned only once. When backtracking occurs, that variable might be unassigned. A variable will not change value (although this could be an optimisation for later, by fetching the next value of a UnificationSearchable directly).

If we assume Jellyfish search with depth-first searching, variables can be simple bindings. Statements still need to be 'instances', or copied from their originals as, for example, a then-if statement might be used multiple times in the same deduction. They only need to be copied once, with the copies shared up and down the deduction.

Each variable is either unassigned or assigned a value. UnificationSearchables contain a list of variables that were unified by this searchable. When backtracking, the UnificationSearchables will reset those variables value to be unassigned and try again (or just immediately set it to the next possible value).

If a variable is bound to another variable, then we iterate to the end of the chain of variables. If there is a loop (which might not contain the current variable) then we break open the loop.

This list of modified variables could just be added as nodes in The Stack on top of each UnificationSearchable. This would allow any number of them without the need for another data structure.


Concurrency and Jellyfish breadth-first search
------------------------------------------------------------

With Jellyfish search, if a stack reaches a depth limit, search on that "tentacle" is paused for potential later resumption, and search begins again from the root by stealing depth-first nodes and performing a single step of a breadth-first search. The same would be done if a second CPU would like to cooperate in the search.

Here we can take advantage of blocks. We can stash away all of the blocks of the paused search, steal a root node by making a copy of it and start another search with new blocks. 

Root nodes should have short simple statements, meaning that copying them will be efficient. 


Indexes
--------------------

Indexes are primary used to speed up access to statements. They are also used to keep track of a module's contents. Indexes hold the whole system together.

Indexes are arrays. Arrays start as small objects of a few bytes that dwell inside a block, but can be promoted to be multiple blocks in size.

Block zero is the "root" block and contains a pointer to the "Module list index". The "Module list index" is an index which contains a link to every module's master index.

Every module master index contains FarRefs to all statements in each module. The first entry in each module master index points to the source code for that module; this is a module literal which points to another module (which is yet another index containing FarRefs to statements) which contains the source code for the originating module.

Diagramaticaly::

	Root block  -->   Module list index   -->   Module master indexes  -->  Data

An index is a sorted collection. It would be stored in blocks like data, possibly following the mechanisms that B-Trees use. Each module is an index which stores the ordering of the statements in that module.

Secondary indexes can be built over particular statement definitions or statement arguments to speed up some operations.

Every entry in an index is a FarRef. They need to make an entry in the target's backreference list to prevent it being garbage collected, but the backreference does not need to be navigable back to the index. It only needs to know that it points back to a root for garbage collection (as the master index of each module. is the root set for extra-GC).

To add or delete a statement from a module, you would add or delete from the index. 

Every if-clause in a then-if statement refers to an index. It might need to refer into an index at the place where its matches begin.


Cache modules
-----------------------

Cache modules are used for memoisation. Hints can suggest that a deduction result is added to the module's corrosponding cache module. Searches subsequently then also search the cache.

Otherwise, cache modules are just ordinary modules. They may have some "most-recently-used" optimisation on them to delete seldom used statements::

    (dieing statements) <--- (live statements)   <--- add new statements to this end.

The oldest, say, 10% of a cache module can be "dieing". If these are references and successfully used, these statements are removed from the dieing section added again as "recently used" statements. Otherwise, whenever the VM is short of space or the cache module hits its size limit, the dieing statements are purged.


Storing modules in binary

On Blocks
--------------------

This VM stores all data in blocks. Each block is BLOCK_SIZE words long (e.g. BLOCK_SIZE=256), with each word being WORD_SIZE bits (e.g. WORD_SIZE=64). With these example values, each block will be 4096 bytes long and be a uint64[256] array. This fits conveniently into a memory page, disk block or network packet, meaning that memory accesses and disk accesses will be conveniently aligned to page boundaries. Other values may be used to experiment with gaining better performance.

The VM persists itself to disk. Blocks are kept in disk files or partitions. The blocks are mmap() into memory as needed and manipulated in place.

Blocks can store:
* Data
* Indexes over that data
* Management metadata.

Each block starts with a header at position 0. This header contains the type of the block and possibly other information about the block. (TODO: what other information?). Positions 1 through BLOCK_SIZE-1 then contain words of data.

Block Types
--------------------

* Statement blocks
* Array blocks
    - Arrays of statements
    - Packed arrays of 
        - booleans 
        - bytes 
        - integers (words, 64-bit)
        - floats 
        - packed statements
* Index blocks (array of words)
* Backreference lists (array of words).


References
--------------------

So far we have only used 8-bit references (assuming BLOCK_SIZE=256) which can only refer to other entries in the same block. To refer to other blocks, we use an invention called "Far References" or "FarRefs". The 8-bit references are referred to as "NearRefs" in comparison.

A "FarRef" is a tuple of (InPointer, Node ID, Block  index) and is stored in one of the words in the block. A FarRef refers to another word in another block. FarRefs are used transparently; anything which refers to a FarRef will think that it is referring directly to that FarRef's target.

Every block has a set of InPointers which are fixed references to entries in that block. These occur at the start of the block. The block header 

Most importantly, InPointers form the root set for intra-block garbage collection.

So, diagramatically::

	Block A					Block B
	+----------+				+----------+
	| 0            |        Block B		| ...3        |
	| 1 FarRef |---->InPointer----->| 4 9        |  (element 4 is an InPointer refering to 9.
	| 2 1          |				| 5           |
	+-----------+				+----------+


The Block Manager
--------------------

The Block Manager is a component that is responsible for managing the location, type and status of blocks.

Each block lives on a particular node. Each node is a process on the local or a remote computer. Each node has a memory-mapped (mmap) file. A block index is simply the location in that file at byte number (index * 4096).

The block manager manages:

* The network address of each node.
* Adding and removing nodes from the network.
* Creating new blocks.
* Initializing and managing garbage collection.
* Locking and unlocking blocks for exclusive access.
* Location of block replicas on other nodes.
* 

FarRefs
--------------------

A FarRef is 64 bits:

* 8 bits for the InPointer index at the remote block. 
* 24 bits for the node ID. 
* 32 bits for the index of the block on that node.
 
The InPointer might refer either to an actual InPointer in a statement block, or to a packed element in a packed block.

TODO: we need to steal perhaps 8 bits from this to allow the VM to determine between a statement and a FarRef. If a statement has 255 as its number of elements, it is a FarRef instead::

    a=255 (InPointer index) (Node ID) (Block ID)

The Block Header
--------------------

The block header is the first entry in the block. It is 64 bits long. It contains the following information:

* Block type ( statements / packed / index ) (8 bits)
* Number of InPointers (8 bits)
* Next free entry (8 bits)
* 

Garbage collection
--------------------

GC might not be needed. Check that it is needed first.


--

There are two types of garbage collection used: intra-GC and extra-GC. 

Intra-GC is garbage collection that happens within a block. Any common garbage collection algorithm can be used. The InPointers for that block form the root set. FarRefs are treated just like any other object, except that a backreference must be removed whenever one is removed from a block.

For example, mark-sweep can be used. Because all entries in the block are a fixed size, a bit array can be allocated to mark entries. No compaction is needed because all holes are the same size.

Extra-GC uses a backreference-keeping garbage collector. This is just like a reference-counting garbage collection, except that instead of counting the number of references, we actually keep the whole list of references back to objects referring to our object::


	Block A	
	+-------------+
	| 0 InPtr 12  |  --> BackReference list
	| 1 InPtr 14  |  --> BackReference list
	| etc	      |
	| 12 13       |
	| 13 OutPtr   |  --> To another InPtr
	| 14 etc      |
	+-------------+

* InPointers point to an element inside the current block. They are fixed in position and referred to by OutPointers.

* Each InPointer has a BackReference list of other blocks that contain OutPointers to this block. (TODO: do they also have a count of references? OutPointers can move around).

* OutPointers point to InPointers in other blocks. They are ordinary entities that can be GCed by intra-GC. When they are collected, they get removed from the corrosponding BackReference list.


Each InPointer has a backreference list. Each FarRef has one entry in it's target's backreference list back to itself. These backreference lists would probably only contain one or two entries, but some can become very large. Backreference lists can be implemented as arrays in the same block that can be promoted to packed blocks.

Backreference lists need to be sorted (or hashed, or something). When a FarRef is garbage collected, the backreference in it's target's InPointer's backreference list needs to be removed. This needs to be done efficiently, meaning that a hash table or sorted collection needs to be used. 

BackReference lists, like reference counting, are still prone to cycles. To prevent this, the first entry in any backreference list is one that can be traced back to the root of the GC (which would be the master index, discussed later). If the first entry is removed, the other entries are searched for a path back to the root. This search might have cycles, so we would need to mark references as we search to prevent infinite loops. If no path back to a root node can be found, then the node and everything that this thread just marked is garbage. (Beware though if this is multi-threaded; another thread might be marking things but might yet find a connection back to a root).

Note that there is a lot of potential concurrency here. If an intra-GC collects a FarRef, then an extra-GC for that FarRef can be forked off. Multiple extra-GCs can run concurrently, collectively cooperating to find a path back to the root.

BackReference lists can be implemented as promotable arrays. Each InPointer can be 16 bits; 8 bits for the local pointer, and 8 bits to point to a local promotable array that is the backreference list. When the backreference list grows too much (e.g. past 16 entries), it is promoted to it's own packed array block.

Alternative: Reference counting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Backreference lists might be overkill. Reference counting might be a better option if the backreference lists are only used to detect cycles.

Cyclic references need to be detected somehow.

Using a bloom filter
~~~~~~~~~~~~~~~~~~~~

An optimisation would be to use a bloom filter so that the block that contains the originating FarRef can be, with some difficulty, found. This works as follows: a backreference list is used until it reaches a certain size, and then it gets promoted to a bloom filter. The bloom filter uses the originating block address as it's hash. By reversing the hash back to a list of blocks, we have a subset of blocks that can be searched to find references. Removing an entry from the bloom filter requires iterating over all blocks in that hash to search for any remaining FarRefs.

I'm not sure how bloom filters can be used to make a global GC faster.


Remote blocks
--------------------

Blocks might be located on a remote host. This VM is designed to be run on a computer cluster using the MPI message sending API to communicate between nodes. 

Potentially, this VM could also be designed to work publicly across the Internet and connect to untrusted high-latency nodes.

The block ID address space is split up on each host. The bottom half of the address space is the mmap() file containing local blocks. The top half of the address space is split up, allocating some to each remote host that we need to have communication with.

When a block from a remote host needs to be accessed, there are two ways this can be achieved. We can either move the block to this local host, which entails moving the block into our local address space and using the backreference list to update all FarRefs to point to us. Or, we can just make a local replica of the remote block which involves making a copy of the block in the upper address space and getting the block manager to make a note that any FarRefs actual refer to a foreign address space.

If a local replica of a remote block is made, the FarRefs in that block need to be translated when they are accessed. They will either refer to the remote system's local blocks, or the remote system's locally cached blocks from other remote systems.

When FarRefs to remote blocks are made, a message needs to be sent to the remote host to make it add a remote reference to the backreference lists for the target object. I'm not sure how this would be done - either backreference entries need to be able to refer to a remote host, or a block ID in the upper address space needs to be designated on the remote host to refer to the originating host.

All writes to the module's log need to be broadcast to all participating hosts. They can then individually decide what to do with those changes.

Alternatively, FarRefs (OutPointers) could have the following structure:

    [ host ][ block address ][ InPointer # ]
    
Where 
* host is a few bytes to uniquely identify that remote host.
* The block address uniquely identifies that block on that host.
* The InPointer address is a pointer to an InPointer at that block. This is 8 bits or fewer.

This scheme allows FarRefs to be migrated to other hosts without modification.

If we use 26 bits for the host, 32 bits for the block address and 6 bits for InPointers, then we could address a theoretical total of 67 million hosts, each host serving 17 tebibyte VMs. 

If we use 39 bits for the host, 19 bits for the block address and 6 bits for InPointers, then we could address a theoretical total of 549 billion hosts, each host serving 2 gibibyte VMs. Multiple hosts could coexist on the same computer.

If we pushed the host out to a different word, then we have what seems to be an inexhaustable address space. Several FarRefs would point to the same host, meaning that the overhead is mitigated to some degree. 

A server can potentially host multiple hosts. Perhaps the host could also be a virtual host used for referring to blocks that are replicated by a replication service.

Fast-copying remote blocks
---------------------------

If blocks do not need to be modifed when moving from one host to another, then we can fast-copy that block. If that block can arrive from an untrusted host and be used, then we have an extremely fast communication protocol. Fast-copying means that little CPU is consumed with integrating that block into the VM. Hardware remote DMA could also be used on nodes that have this capability.

For this to work, the structure of the block needs to be valid even if that block contains random garbage. Using a corrupted block will not harm a currently running VM. 

Local references are all 8 bits and are always valid references within the context of a block. They physically cannot refer to data outside the block.

FarRefs might be invalid. They might refer to an invalid host, invalid block or invalid InPointer. These need to be verified before use.

BackReferences need to be thought about.

Data within the block might be corrupt. Arrays might contain loops, making them in effect infinitely long. Unicode sequences might be poisoned. 


Statement Arrays
--------------------

Arrays are used for:

* When the programmer needs an array.
* Indexes (and, thus, modules)
* Write logs to modules (?)
* BackReference lists (?) (which are arrays of references)

Arrays need to be able to:

* Be appended - changing the size of the array.
* Handle insertions and removals (shunting other entries forwards or backwards)
* Be indexed
* Be modified.
* Be usable for hash tables.

TODO: learn more about hashing and hash tables. Can a hash be broken up and used as a fast path through an index?

Small arrays begin life inside a block as a small object. Once they occupy more than half the block (128 words or more), they are promoted to a large array.

A small array looks like this::

    +---- Block ---------+
    | 0 Block type = statement
    | ...
    | 13 Reference to 14
    | 14 Array (type=statement, size=4)
    | 15  [1] (array element 1)
    | 16  [2]  ...
    | 17  [3]
    | 18  [4]  (array element 4)
    | 19 ...
    +--------------------+


Large arrays that fit in one block look like this::

    +---- Block ---------+
    | 0 Block type = statement
    | ...
    | 13 Reference to 14
    | 14 Array (type=largeStatement, block ID=24 )
    | 15 ...
    +--------------------+
    
    +---- Block 24 ------+
    | 0 Block type = statement array data, number of InPointers=68, next free=77
    | 1 InPointers (1 through 8) to 9 10 11 12 13 14 15 16
    | 2 InPointer (9 through 16) to 17 18 19 20 21 22 23 24
    | 3 InPointer ...
    | ...
    | 9 (array element 1) 
    | 10 (array element 2)
    | 11 ...
    | ...
    | 76 (array element 68)
    +--------------------+


Large arrays that use more than one block look like this::

    +---- Block ---------+
    | 0 Block type = statement
    | ...
    | 13 Reference to 14
    | 14 Array (type=largeStatement, block ID=24 )
    | 15 ...
    +--------------------+
    
    Block 24 is an index block containing 4 entries (nextFree-1 )

    +---- Block 24 ------+
    | 0 Block type = statement array index, number of InPointers=0, nextFree=5
    | 1 See Block 25, index=1
    | 2 See Block 26, index=224 (i.e. Block 25 contains 1 through 223)
    | ...
    +--------------------+
    
    Block 25 is one of the data blocks, but could be another index block.

    +---- Block 25 ------+
    | 0 Block type = statement array data, number of InPointers=255, next free=255
    | 1 InPointers (1 through 4) to 32 33 34 35
    | 2 InPointer (5 through 9) to 36 37 38 39
    | 3 InPointer ...
    | ...
    | 32 (array element 1) ... ...
    | 33 (array element 2) ... ...
    | ...
    | 255 (array element 223)
    +--------------------+


The reference to the array contains:
* The type of array 
* Total size (small arrays only. Large array sizes can be calculated)
* (for packed statement arrays) The prefix
* A reference to the root index block or directly to the data block if there is only one.

The index might be omitted (a single data block would be in its place); it might be a single block or it might be a large b-tree of blocks.

Each index block contains tuples of (index, block ID). The index is the index offset of the first element in the given block. The block ID points to either another index block, or to the data block.

Data blocks may only be partially full. The header of the index and data blocks already contains a "Next free entry" reference which indicates how full that block is. 

Index and data blocks behave like B-Tree blocks for merging, etc. 

Arrays of statements just use ordinary statement blocks in the array. The 256 InPointers are used for array indexes. The rest of the block stores the statements. Arrays of statements would not have backreference lists. The block containing the array can also contain statements or other data that the array refers to. If anything else wants to refer to the same object as is what is in the array, it must be promoted to a FarRef.

Idea: the runtime stack could be an array of statements. (node:deductionSearchable statement:... parent:... etc).


Boolean, Byte, Integer, Float, Packed Statement arrays
--------------------

(TODO)

Boolean, Byte, Integer, Float and Packed Statement arrays can only contain basic data, but are compressed and optimised for use with GPU (OpenCL / CUDA / SPIR-V) or SIMD instructions.

A packed statement is one where the array definition contains a statement prefix, and all lambdas in that prefix are packable data: bytes, integers, floats, or entries in the source block that the array is referenced from. Packed statement arrays resemble arrays of structs with inline data.

When packing statements, the statement prefix is stored in the array definition, which is an entry in a standard block. The array definition is a tuple of (block ID, prefix).

Idea: When first accessed, these arrays can be unpacked (in their entirety or as an array segment) into an actual array in memory or on the GPU. When snapshots occur, these arrays can be packed again from memory back into blocks and stored to disk.

If you unpack these arrays from disk blocks into memory separate from block storage, then they can be uploaded to GPUs or have SIMD instructions run over them.

If unpacking / packing of arrays is implemented, each array would look like this:

Array definition  -->  Index blocks  -->  Data blocks

The index blocks here are standard. The data blocks have a type of "packed" or something, and contain only raw data to be unpacked.

Packed blocks are more easily inserted and removed than unpacked blocks. Unpacked blocks are more easily iterated over and indexed. If an array is undergoing a lot of insertion and removal, then it might be better to leave it packed. In fact, unpacking won't need to be implemented until SIMD instructions are implemented.

The array definition would store the format of the entries in the array.

--

Idea: These arrays can be volatile with an initializer. A volatile array is never stored to disk but rather regenerated at runtime when required.

Idea: Implement weak references???

Unpacking a boolean or byte array before use is one way of avoiding the problem of addressing byte array elements.

Idea: Generated machine code could be unpacked and packed using byte arrays.

Packed arrays are an optimisation and aren't required for a functional VM, except for backreference lists.




Compound Arrays
--------------------

A compound array is one that is implemented using several other types of array. Some parts might be packed statements, other parts might be small or large arrays. These segments are all concatenated together by an abstraction to form the compound array.

Compound arrays could be used:

* to more efficiently pack arrays of statements. Heterogeneous sections can be stored in standard array segments; homogeneous sections can be packed into packed statement array segments.

* to store massive arrays that exceed the capacity of one computer's memory or one computer's disk space.



The Root block
--------------------

The root block is block 0 on any disk file. It stores:

* The root module.
* Core statement definitions:
	- ...
* Locations of other nodes.

Actually, once you have the root module, everything else can go in there. Initially, the root module would fit into block 0. Eventually it would be promoted to a large array.


Profiling statistics
------------------------------

The compiler should be able to add flags for keeping profiling statistics.

Some of these should be recorded as events with timestamps so they can be put on a graph.

* Usefulness of a statement (num times used).

* # deductions

* # steps
  
* % backtracking
  
* % aborts
  
* # duplicated results
  
* % negation searches
  
* Compiler optimisations used.
  
* Total nodes under a branch
  
* % time spent in hints
  
* Loop detection?
  
* # of threads over time
  
* % idle time on remote nodes


Deterministic execution
------------------------------

The VM and compiler should execute the same code in exactly the same way. If a bug occurs, the timestamp of that bug should be noted, then the VM can be reverted to the most recent checkpoint and re-played to the bug's timestamp.

Deterministic execution means that all I/O operations (i.e. adding events to working modules) happens in a repeatable fashion, and that queries perform exactly the same every time they are performed.

Deterministic execution allows for time-travel debugging. Snapshots can be made every second (or derived from, e.g. a snapshot 15 minutes ago if the user is willing to wait 15 minutes). This allows a debugger to travel forwards and backwards in time with a maximum UI lag of one second.

All forms of non-determinism needs to be captured:

* Device I/O and failures.

* Thread communication

* Inter-node communication

* Timers (during time-travel, these need to be simulated)

* (disk latency??)

* (disk errors??)

All device I/O happens between queries. Only the events that are used (see Usefulness above) by the next query need to be kept.

Thread communication and inter-node communication (probably very similar) will depend on how they are implemented. Threads will probably be sharing parent search nodes and cache modules.




OLD NOTES
===================

Statically typed experiment (with the problem: how would statement links work?)

Statements
----------

Each module index is an array of links to statements. Each statement has the following format::

    [type][contents...]

[type] is 8 bits and is a pointer to a statement definition. [contents] are 7 entries for that block with their type specified in the statement definition.

Statement Definitions
---------------------

Statement definitions (signatures) are::

    [SIG][types...]

where SIG is a constant and ignored except for verifying the integrity of a block. Types are 7 entries long and are either one of the following predefined types or another statement definition (these occupy the address space of the InPointers and variables)::

* 0				Naked statement component, or unused.
* STATEMENT			A Statement or atom
* INTEGER 			Integer literal
* FLOAT 			Float literal
* STATEMENT_LITERAL 		Statement, atom, variable literal
* SIG				Statement definition literal
* MODULE_REFERENCE 		Module Reference literal
* ARRAY 			Array


Note that a type could refer to an OutPointer which then needs to be followed.

If a statement appears in the module index and has type 0, it means it's a naked statement component such as a string comment, integer tag or an atom floating around by itself in the module.

The arity of a statement can be determined by looking at how many of the type elements are populated. A "0" means that that type element is not used; so all non-zero type elements are counted up to find the arity of that statement definition.

For example, a naked string would look like this (24 is the address)::

    24: 0 25 _ _ _ _ _ _   -- type=0, refer to 25.
    25: 9 TODO h e l l o \n  -- the string "hello\n"

An atom would look like this:

    24: 25 _ _ _ _ _ _ _  -- The atom at 25.
    25: 1 0 0 0 0 0 0 0   -- A statement of arity 0.

(hello:[+1] world:["world]) would look like this ::

    24: 25 26 27 _ _ _ _  -- (hello:[+1] world:["world]) 
    25: SIG INTEGER STRING 0 0 0 0 0   -- signature (hello:int world:string)
    26: 0 0 0 0 0 0 0 1   -- [+1]
    27: w o r l d 0 _ _   -- ["world]

Literals
--------

Integers, Floats, Module References all have 64 bits to be what they are. For example, (a:[+15]) is::

    24: 25 26 _ _ _ _ _ 		-- a:[+15]
    25: SIG INTEGER 0 0 0 0 0 0 	-- (a:integer)
    26: 0 0 0 0 0 0 0 15 		-- [+15]

Arrays are described below.

A statement literal is just a link to another statement, following the same rules as a module index.

E.g. (a:[\b:c]) is::

    24: 25 26 _ _ _ _ _ 		-- (a:[\b:c])
    25: SIG STATEMENT_LITERAL 0 0 0 0 0 0 -- (a:)
    26: 27 28 _ _ _ _ _ _ 		-- (b:c)
    27: SIG STATEMENT 0 0 0 0 0 0 0 	-- (b:)
    28: 29 _ _ _ _ _ _ _ 		-- (c)
    29: SIG _ _ _ _ _ _ _ 		-- (c)

A statement definition literal is a link to a statement definition.


Arrays
------

Arrays can be:

* String (same implementation as u8 array, but displayed differently)
* Boolean array
* Integer array (8-bit / 16-bit / 32-bit / 64-bit; signed / unsigned)
* Float array (8-bit / 16-bit / 32-bit / 64-bit)
* Statement array
* Packed statement array
* Compiled code?
* Big Integer 

In a statement definition, 

Arrays have the following format::

    [LITERAL_DEFINITION][array type]

Where [array type] is one of the above. This can share the "literal type" address space.

