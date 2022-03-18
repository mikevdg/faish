The Squl Language
=================

Squl language syntax (version 0.3)
--------------------

A Squl module is made of many Squl statements. Each statement describes how a part of your application works.

A simple Squl statement looks like the following::

   list:( head:H tail:_ ) head:H.

This statement defines the head of a list to be the first element of a list.

Each statement consists of a number of clauses. In the example statement, there are two clauses. The first clause is "list:( head:H tail:_)" and the second clause is "head:H". Each clause has a label, then a colon, then a value. The first clause has the label "list", and a value which is a sub-statement. The second clause has the label "head" and the value "H". Finally, a statement is concluded with a period. A query has exactly the same syntax as a statement but concludes with a question mark instead of a period.

TODO: include a diagram::

    list:( head:H tail:_ ) head:H.
      |    \____________/     |      |
   label       value         label  value
   \________________/   \__________/
          clause                    clause
          \______________________/
                      statement

Labels can consist of zero to many printable Unicode characters other than a period, question mark, parenthesis, colon, square brackets or uppercase Latin characters. Each label in a statement must be unique within that statement, with the exception of the special label "if". [Note: this restriction will be removed in version 0.3]

The clauses in a statement are ordered. These are two different statements::

   father:alfred of:bob.
   of:bob father:alfred.

Values can be **atoms**, **variables**, **sub-statements** or **literals**.

**Atoms**, such as "alfred", are used as names, placeholders or symbols. They consist of the same characters as labels. For example, a list with a single element would be "head:singleElement tail:end.", where "singleElement" and "end" are atoms.

TODO: Maybe give atoms a prefix, such as #atom. 

**Variables**, such as "X", are values that begin with an uppercase Latin character followed by any number of characters that would be valid in a label. Alternatively, they could be the character "_", which creates a new unnamed variable every time it occurs. 

A variable's context is in a single statement: all instances of the same variable in a statement must have the same value, but if the same variable occurs in another statement, there is no relationship between the two statement's variables (unless those two statements have been unified - variables in the two statements might then have the same name, but are considered different from each other).

Variables differ in usage from imperative programming. Variables are not assigned values. Instead, they are "matched" or "bound" to values to create a new statement. This is described in more detail later.

**Sub-statements** are just statements, enclosed in parenthesis to prevent them from falling apart. Any variables in sub-statements are considered to be part of the whole statement, so that instances of those variables, should they be deeply nested in substatements, are still bound to other instances elsewhere in the same statement.

**Literals** are integers, floats, characters, strings, and so forth. These are enclosed in square brackets. The very first character of a literal determines what type that literal is. Some examples of literals are:

[+52]
   The positive integer 52. '+' and '-' define integers.

[-10]
   The negative integer -10. 

['K]
   The integer "75", which is the UTF-8 codepoint for the character "K".

["Hello, world!]
   A byte array containing UTF-8 codepoints. This is not a string; this is a byte array.

[# -12.6 ]
   The floating point number -12.6. 

Squl does not support strings and characters directly; it is intended that complex string handling is done by some imported module. This is because correct Unicode string manipulation is complex and updates are much easier to provide in modules. What we refer to as "strings" are actually byte arrays of UTF-8 codepoints; any indexing into a string will return bytes rather than potentially multi-byte characters or combining characters.

To include a newline character or any other special characters in a string literal, just type them in.::

    ["This string
    is broken over
    three lines.].

To put square brackets into any literal, you must ensure every opening square bracket have a matching closing square bracket in the literal::

    ["This string has [ an opening, ] and a closing square bracket in it.].

The exception to this is the character literal::

    [']] -- U+005B LEFT SQUARE BRACKET
    ['[] -- u+005D RIGHT SQUARE BRACKET

To put unmatched square brackets inside a literal, you will need to use some mechanism with the character literals to insert them.


Statement and variable literals
~~~~~~~~~~~~~~~~~~~~~~

Sometimes we want to work with a statement which contains variables, but we do not want these variables to be unified with anything, and we do not want a deduction to fail because these variables are not unified. For example, if we are adding a statement to a module, we want to preserve variables in that statement.

For this purpose, we can have a variable literal::

    [\ SomeVariable ]

In a similar fashion, an entire statement can be in the literal::

    [\ some:X statement:Y. ].

Unfortunately, the behaviour of variable or statement literals has not yet been decided as of Faish 0.3.

One other type of built-in literal is the module literal, but this is rarely used directly by a user but rather by utilities that the environment provides. These use the tab character as their defining character.

Squl language semantics
-----------------------

Matching / Unification
~~~~~~~~~~~~~~~~~~~~~~

An implementation of Squl would produce useful results from your program by combining statements to produce new ones, until a solution is found.

Take, for example, the list head example above::

   list:( head:H tail:Tail ) head:H.

Say that we want an answer to this query ("what is the head of the list [,a, b]?")::

list:(head:a tail:(head:b tail:end)) head:X?

The following matches are made, by finding possible substitutions for all the variables in both statements::

   H = a
   Tail = ( head:b tail:end )
   H = X

Here, we can see that H = a, and H = X, therefore X = a. The implementation then produces the following statement by substituting a for X::

   list:(head:a tail:(head:b tail:end)) head:a.

This would be the result returned by the implementation. Note that no mention is made of the original X; you as a user are expected to be intelligent enough to see what happened to it.

If multiple substitutions, other than variables, are found for a variable then matching will fail and no result will be returned. For example::

   list:( head:H tail:Tail ) head:H.
   list:( head:a tail:end ) head:b?

This produces the following substitutions::

   H = a
   Tail = end
   H = b

Here we have both H = a and H = b. Obviously a is not b, so this match would fail. If we had both H = a and H = a again, then it would succeed.

Substitutions also work with sub-statements. Say that we have these contrived statements::

   a:( a:X ) b:B.
   a:B b:( a:( b:c )).

Unifying (i.e. substituting variable) these together would produce the following substitutions::

   a:X = B
   B = a:( b:c )

Thus we can see that a:X = B = a:(b:c), thus a:X = a:(b:c), thus X = b:c, producing::

   a:( a:( b:c )) b:( a:( b:c )).

There are some instances where unification can cause infinite loops of sub-statements in a statement. This is not implemented in the current version of Faish, but might be an interesting and useless esoteric feature to later include. Currently such statements cause the matching to fail.

Then-if rules
~~~~~~~~~~~~~

To produce useful behaviour, we need some mechanism for being Turing-Complete. If-then rules achieve this by allowing for recursion.

An example if-then rule is::

   if:(bounces:X) then:(ball:X).

However, it is more typically written in this format::

   then:(
       bounces:X )
   if:(
       ball:X ).

This is just another statement, spread over several lines. This is the conventional syntax for complex statements and is described in the language conventions section below. 

Given, for example, the statement and query::

   ball:myBlueBall.
   bounces:myBlueBall?

Faish will then try to solve your query. First it searches for anything that matches "bounces:myBlueBall", and finds the if-then rule above. It then unifies the if-then statement to produce "then:(bounces:myBlueBall) if:(ball:myBlueBall).". Finally, it verifies the truth of the if-clause, by finding ball:myBlueBall, returning as result::

   bounces:myBlueBall.

An if-then statement can have as many if-clauses as it wants. The then-clause is considered usable if all variables in the then-clause have values, and all if-clauses have been deduced or found in the modules.


Searching
~~~~~~~~~

When trying to find a solution to a query, multiple search paths are usually possible. For example:

* If a statement has multiple matches in the modules, then each of these could be attempted in any order. TODO: not actually defined yet. Maybe I want them in order.

* If a then-clause has multiple if-clauses, then those if-clauses could be investigated. This is called "deduction".

The "if" clauses of a then-if statement are explored in the order they are written in.

Implementations are free to traverse the statements of a Squl application in whichever order they choose. There is, in fact, no guarantee your application will even run, but an implementation of Squl that does not actually produce useful results from your code will not be particularly popular.

The current implementation of Squl called "Faish" implements a search algorithm called "annotated jellyfish search". It works by mostly doing a depth-first search, but with a breadth-first search at the head. You can see this behaviour in the deduction browser.

There are two kinds of nodes: UnificationSearchables and DeductionSearchables. A UnificationSearchable will search for other statements matching the current goal. A DeductionSearchable will search clauses of then-if statements. Each UnificationSearchable makes DeductionSearchables for every then-if statement it finds. Each DeductionSearchable makes a UnificationSearchable for every clause. Basically, you alternate between the two as the search tree goes deeper.

Each time progress is made in the search, another child node is made. Only child nodes are made; parent nodes do not get modified. The search gets deeper and deeper, and eventually a solution to the original query is found as a leaf node in the search tree.

The jellyfish search traverses this tree. There is a breadth-first search at the head of the tree, and multiple depth-first searches coming from this breadth-first search. When a depth-first search hits a limit (such as a depth limit), one step of the breadth-first search is performed, and then search continues.

The search will be annotated. TODO. This is not implemented yet. Annotations are metadata that is added to statements to guide the search process. This metadata will override the default behaviour and add the ability to fork a search across multiple threads, abort a branch of the search, choose which branch to expore next, or set the depth limit deeper.


Equality and Non-Equality
~~~~~~~~~~~~~~~~~~~

The user can implement equality themselves by including the following statement::

	equal:X with:X.

However, the same cannot be said for inequality. For this, a built-in is provided. This will only succeed if the two variables have values that are not equal with each other::

	notEqual:X with:Y.

There are some problems with equality:

TODO: how does equality work with variables? Do they need to be unified first?

* Firstly, the special variable _ is never equal to anything, even another version of  itself.

* Some literals cannot be compared. Iterators cannot be compared. 

* Floating point numbers, as in all other programming languages, cannot be reliably compared.

* Every time you manually make a new atom or statement signature using the built-ins described below, these are completely new unique objects and can only be equal to themselves. (TODO: but this is only relevant as a deduction browser bug?)


Built-in Integer operations
~~~~~~~~~~~~~~~~~~~

Squl has built-in operations for integer arithmetic. These are quite long-winded and not indended for direct use.

When the mathematics allows, these rules can also be used in reverse::

   n:X plus:[+4] result:[+6]?


::
   n:X plus:Y result:Z.
       X plus Y equals Z.
   n:X multiply:Y result:Z.
       X multiplied by Y equals Z.
   n:X divide:Y result:Z.
       The inverse of multiplication, X divided by Y equals Z. Y may not be    zero.
   n:X modulo:Y result:Z
	Z is the remainder after dividing X by Y.
   n:X raisedTo:Y result:Z
	Z is X to the power of Y.
   n:X abs:Y.
	Y is the absolute / positive of X.
   n:X bitAt:Y result:Z.
      The Yth bit of X in binary is Z.
   n:X bitAnd:Y result:Z.
      X in binary logically ANDed with Y, results in Z.
   n:X bitOr:Y result:Z.
      X in binary logically ANDed with Y, results in Z.
   bitNot:Y result:Z.
      Y in binary with all bits reversed results in Z.
   
   n:X bitShift:Y result:Z.
      X in binary with all bits shifted right Y times results in Z.
   n:X bitXor:Y result:Z.
      X in binary with all bits XORed with Y results in Z.
   lesser:X greater:Y.
      X as an integer is less than Y.

The bit twiddling operations are not yet well defined (version 0.3). It is not yet certain what bit operations should operate on, or whether numbers are twos compliment or unsigned, or how many bits can be found in a number. 


Built-in string and character operations
~~~~~~~~~~~~~~~~~~~

The core Squl language doesn't actually have string or character support. Instead, integers are used to represent characters, and arrays of bytes are used to represent strings.

String and character manipulation is provided by importable modules. As these modules can be imported when needed, they are not part of the core language specification and the user is free to choose whichever string and character implementation they desire.

The user interface represents strings and characters as literals by storing the source code that was typed in.

Built-in array operations
~~~~~~~~~~~~~~~~~~~

::
	create:array size:N result:R.
		Create a new array of size N capable of holding anything.
	create:uint8Array size:N result:R.
		Create a new unsigned byte array of size N. 
	create:float32Array size:N result:R.
		Create a new 32-bit floating point number array of size N.
	array:A index:I value:E.
		Retrieve E, which is the Ith element of A (with the first element having index 1).
	array:A index:I insert:E result:R.
		Replace the element at position I in the array A with the value E, with result R.
	array:A index:I insertArray:Paste result:R.
		Replace elements in A from I onwards with the elements of the array Paste, with result R.
	array:A fromIndex:I toIndex:T result:R.
		Extract the elements from index I to T (inclusive) from array A and put them in R.
	array:A size:S.
		S is the size of array A.

Arrays are special objects in Squl. Arrays have a fixed length which is specified when they are created, There are 3 types of arrays available:

* Standard arrays containing statement components.
* Unsigned Byte arrays containing values from 0 to 255.
* Float arrays containing 32-bit floating point numbers.

TODO: Add an argument specifying what the new array should contain.

Squl (version 0.3) does not yet support other array formats.


Built-in statement, module and query operations
~~~~~~~~~~~~~~~~~~~

To implement negation, the following will only succeed if no results can be found by performing the query in the module of whatever uses it. Note that this is very likely to go into an infinite loop if an infinite loop is possible within the query::

	noResults:Query.

Using (noResults:~) is preferable to using the following built-ins to achieve the same result, as it is implemented more efficiently.

You will need the current module for most of the following built-ins::

	thisModule:ThisModule.
		Populate the given variable with a module literal for the current module.

To do a query on a module::

	module:Module query:Query iterator:Iterator.
                Perform Query in Module and allow results to be fetched using Iterator.

Any variables in Query need to be unified before Query will be performed. This would happen if this built-in is a clause in a then-if statement. For variables that are actually part of your query, you need to use variable literals. For example::

        then:~
	        if:( ~ A ~ )
		if:( module:M query:( a:A b:[\B] ) iterator:It ) .

Here, the built-in will not perform the query until a value for A is found. The query is then performed and the iterator will iterate over statements containing possible values for B.

(module:query:iterator:) will only return fully unified statements through the iterator. It will not give you any statements from the module that contain variables.

(XXX deprecate this:) You can also pass a statement literal to (module: query: iterator:) as a query. 

You can use the following built-in on the iterator to fetch results::

    iterator:Iterator value:Result next:NextIterator.
		Retrieve the next result for the iterator, and provide the next iterator for more results.
	iteratorIsExhausted:Iterator
		Will succeed if the given iterator has already given its last result.

To find the next result, you need to use this built-in again on NextIterator to find the next result, and so forth. If the iterator runs out of results, then (iterator: value: next:) will fail, but (iteratorIsExhausted:) will instead succeed.

Note that these iterators will not filter non-unique results. The results are fetched lazily; the query is not performed until the iterator is queried for a result. In this way, no depth, step or time limits are required (XXX not actually true).

A "Simple query" only returns immediate matches and does not perform any deduction. "Simple queries" can be performed by using::

        module:Module simpleQueryUnified:Query iterator:Iterator.
		Perform the given query simply, and return all fully-unified results.
	module:Module simpleQueryUnunified:Query iterator:Iterator.
		Perform the given query simply, and return all results, even those with variables. Variables are converted to variable literals.

"Fully unified" means that all variables in a statement have been replaced with values. A "simple query" is one that only finds matching statements; it does not explore clauses of then-if statements.

To return the number of unique results from a query::

	module:Module query:Query numResults:N depthLimit:Depth.			
		Perform the query Query in Module and return the number of unique results (N) with depth limit Depth.
	module:Module query:Query numResults:N stepLimit:Steps.
		Perform the query  Query in Module and return the number of unique results (N) with step limit Steps.
	module:Module query:Query numResults:N timeLimit:Seconds.
		Perform the query Query in Module and return the number of unique results (N) with time limit of Seconds seconds.

and also::

	module:Module simpleQuery:Query numResults:N.
		Perform Query simply, and return the number of unique results.

Here, all variables (of the standard sort) in Query must be unified before the query is performed. To keep variables ununified and able to take multiple values (for counting) we use variable literals, which are variables enclosed in square brackets such as [\X]. Variable literals are not matched or unified. For example::

        then:~
        if:( ~ A ~ )
	if:( module:M query:( a:A b:[\B] ) numResults:N timeLimit:[+2] ) .

Here, the query will not be performed until a value for A has been found. Once found, the query will be performed to find as many values of B as possible for a maximum of 2 seconds. Once all values have been found or 2 seconds elapses, duplicate results are eliminated and the number of unique results is used to populate N.

The limits used are the same as limits used in the GUI:
* A time limit is the number of seconds to run the query before giving up. 
* The step limit is the number of deductions that will be attempted before giving up. 
* The depth limit is the maximum depth that will be explored before giving up.

To get all values in a module, you can use a variable as the query::

	module:M simpleQueryUnunified:[\AllResults] iterator:Iterator.

For example, to copy a module::

	then:( module:M copied:Mcopy )
	if:( module:M simpleQueryUnunified:[\All] iterator:It )
	if:( addAll:It toModule:Mcopy ).
	
	then:( addAll:Done toModule:Module )
	if:( iteratorIsExhausted:Done ).
	
	then:( addAll:It toModule:Mcopy result: Mdone)
	if:( iterator:It nextResult:Statement nextIterator:ItNext )
	if:( module:Mcopy add:Statement result:Mnext )
	if:( addAll:ItNext toModule:Mnext result:Mdone ).

	-- Allow the use of multiple CPU cores, if available:
	then:( addAll:It toModule:Mcopy result:Mdone )
	if:( iterator:It fork:It1 fork:It2 )
	if:( addAll:It1 toModule:Mcopy result:M1 )
	if:( addAll:It2 toModule:Mcopy result:M2 )
	if:( module:M1 union:M2 result:Mdone ).


Maximising values
----------------------------------------

To find the biggest possible value of a particular variable, a then-if statement can have a "maximize" clause added to it. For example::

	then:( biggest:B )
		if:( manyValues:B something:A something:C )
		maximize:B.

Here, only one result will be found. A best effort will be made to find large values of B, and the largest one found is the only one returned as a value for B for further deduction.

TODO: this needs a limit on it! See MaximisationSearchable>>nextChild. Otherwise we won't find a largest value if the query doesn't end.


Modules
--------

::
	create:module result:New.
		Create a new module.
	module:Module add:Statement result:AnotherModule.
		Add the given statement (or statement literal as a statement, or signature) to the module, resulting in AnotherModule. This will not succeed until all non-literal variables in Statement have values. Any variable literals in Statement will be converted to variables.
	module:Module remove:Pattern result:AnotherModule.
		Remove all statements matching Pattern from Module. Pattern must not contain free variables. Use variable literals to remove multiple statements from the module (TODO).
	module:Module size:S.
		S is the number of statements in Module.

.. TODO: 
..	module:Module intersection:Another result:AnotherModule.
		AnotherModule contains only the statements that exist in both Module and Another.
	module:Module union:Another result:AnotherModule.
		AnotherModule is the result of merging Module with Another. 

To retrieve the contents of a module, perform a query on it.

Modules can only contain unique statements. Adding the same statement to a module multiple times will have the same effect as adding it once.


Statements
-----------------

::
	create:statementSignature module:Module arity:Arity result:New.
		Create a new statement signature, New, with arity Arity in module Module.
	create:statement fromSignature:Signature module:Module result:New.
		Create a new statement, New, from Signature, in module Module. The created statement will not be added to the module.
	statement:S signature:Si.
		Set Si to be the statement signature of S.
	statement:S arity:Size.
		Set Size to the number of clauses in statement S.
	statement:S index:I value:V.
 		Return the value, as V, at index I in statement S. Indexes are numbered from 1.
	statement:S index:I value:V result:Result.
		Modify the statement S, setting the value at index I to V, resulting in Result. This will only succeed if V contains no free variables. Any variable literals will be converted to variables (TODO).

Statements require a statement definition in order to be created. Only statements created from the same statement definition will (possibly) unify with each other. The statement definition stores the arity of the statement. All statements with the same definition will match and unify with each other.

When creating a statement, a module is required. This is for technical reasons (TODO: not any  more): the statement is physically created in memory allocated for that module, but will not be added to that module's index.

The human-readable version of a statement is stored separately from the statement in a source code module; a statement is implemented as a pointer to a statement definition and values for it's arguments. This is similar to object-oriented systems: the statement is an object and the statement definition is that object's class.

Statement signatures are special objects that are always literals. Statements created by these built-ins will also be literals. To make them queryable statements, add them to a module first.

To create a statement from scratch, that will not match any other statement::

    then:( newStatement:S )
        if:( create:statementDefinition arity:4 result:Sd )
        if:( create:statement definition:Sd result:S ).

To create statements that will (possibly) unify with each other, that same statement definition must be used again to create them.

Similarly, the components of a statement can be created and added to the statement. Note that creating a variable will actually create a "variable literal". When a statement is added to a module, "variable literals" will be converted to ordinary variables.

Atoms and variables can be created as follows:

::
	create:atom result:X.
		Creates a new atom literal.
	create:variable result:X.
		Creates a new variable literal.


You do not need to create literals; you can simply add then using an existing literal.


Checking Types
-----------------------

These built-ins will succeed if their argument is of their respective type::

	atom:X.
	statement:X.
	statementSignature:X.
	variable:X. 
	integer:X.
	float:X.
	array:X.
	uint8Array:X.
	float32Array:X.
	module:X.

You will notice that strings and characters are missing. This is because strings and characters are implemented using uint8Arrays.
