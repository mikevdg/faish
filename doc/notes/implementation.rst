A VM Implementation
=================

This chapter describes a hypothetical implementation of a Squl VM. Code examples in this chapter are in C.

See http://gulik.pbworks.com/w/page/55126238/Faish%20implementation for the original design notes. They will all eventually be moved here.

The VM design here is a block-based VM. The "heap" is divided into 4 kilobyte blocks, which are also stored to disk and sent across a network. The choice of 4 kilobytes is to match the same size of a disk block or page in memory. 

The following types of blocks are found in this VM:

* Standard blocks containing small numbers of statements.
* Packed blocks containing many of the same type of statements.
* Packed blocks containing one pritive data type, such as booleans, integers or floats.
* B-Tree branch nodes (implemented using packed blocks of block references).
* Index blocks (implemented using packed blocks).

Standard blocks are used to contain small numbers of statements. A standard block is made of 256 64-bit words, each addressable using 8 bit addresses. Each 64-bit word contains packed data. The packing of statements into 64-bit words is described in a later section.

A packed block is used to contain a large number of statements or repeated data. A packed block is used as the leaf node of a BTree. Packed blocks are created when an array becomes too large to fit into a single block and is promoted to a B-Tree.

Block metadata is stored externally to the block. A block does not have it's own header field inside itself. 

Blocks are stored in files. A reference to a block will contain it's location within that file. As blocks are a fixed 4k size, the least significant 12 bits of a block address can be stripped.

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

InPointers and OutPointers
--------------------------

A reference to a statement in the same block can be a direct 8-bit pointer. 

A reference to a statement in another block uses a 64-bit "OutPointer". A local 8-bit pointer will point to an OutPointer. OutPointers are kept at the end of the block and block metadata stores the boundary marker between the 64-bit words containing data and the OutPointers.

A standard block has the following structure::

                 v InPointer boundary
    [ InPointers | data |  OutPointers]
                        ^ OutPointer boundary

An OutPointer has the following structure::

     39 bits   19 bits          6 bits
    [  host  ][ block address ][ InPointer # ]
    
The host refers to block storage on a potentially remote computer. The "host" values are global across the network; an OutPointer retains its validness when moved to a remote host. 

The block address is the address of that block at that host. This is the location of the block in the file, after multiplying by 4096. The size of 19 bits is chosen arbitrarily; it allows for a file size of 2GB for each file. Multiple hosts can be run on the same computer to expand past this limit.

An "InPointer" is just a word in the block which may not be moved, as it is refered to by blocks across disk and across a network. These "InPointer" words are otherwise treated exactly the same as data. If garbage collection is to be implemented, then these InPointers form a root set for this block.


Statically typed storage
--------------------------

Each word in a standard block is packed data. The structure of this packed data is determined by the typing system. 

Given an example type declaration::

    :: [ person age (type integer) name (type string) ] (type person).
    
An integer is 32 bits, and a string can have any length. This statement can be packed into a 64-bit word as::

    [ age, 32 bits ][ name, 8 bit reference ][ 24 bits unused ]
    
Then name would be a string, which (for the sake of this example) is a linked list of 7-character sections, packed as::

    [ 7 characters, 8 bits each ][ next, 8 bit reference ]

(An actual implementation of a string might be very different).

Now if we have the following type declaration:: 

    :: [ father (type person) of (type person) ].
    
This can be packed as, with both references pointing to persons:

    [ 8 bit reference ][ 8 bit reference ] [ 56 bits unused ].

When we want to extract data, we know the type of each word based on the pointer to that word. Every pointer in the VM has a type in this manner.

Stored elements can be:

* References, 8 bits pointing to something else in the block.
* Primitive types (bool, byte, int, float etc).
* Deciders, N bits, determining what the type of the following data is.
* Variables. 

These are packed into 64-bit words.

All the other types the VM needs can be defined in terms of these elements. Type declarations, for example, are packed statements following the same schema. Module references are statements holding everything the VM needs to know about modules. Compiled code is a statement containing an array of bytes.

A "decider" is a small number of bits that determine what the type of the rest of the data is. This occurs when there are multiple options for the type of an element. For example, an "Animal" might be a dog or a cat, so a leading bit would inform the VM that the following data is of format "dog" or format "cat". Deciders should be encoded using the fewest number of bits required, such that compiled code can have a jump table of every possible case to allow for throwing errors for invalid deciding values. Deciders are basically just enums.

Variables are numbered sequentially. These can use the same bit-packing logic as deciders. Variables only need to be stored when in a block. When used, they will be allocated in memory as typed local variables in compiled code.

The VM then knows, starting from a root set of elements of precoded types, what the type of everything other binary bit in the storage is by following the type system. In this way, object headers are not required, and compiled code can make assumptions about the structure of data.

Advanced word packing
---------------------

There is scope for many optimisations:

* To manage long statements with lots of arguments, statements can be split to parts that each fit into 64-bits.
* Nested statements can be flattened.
* Statements can be given multiple different packings. For example, if a statements packs into 48 bits but not 64 bits, then multiple different packings can be created to pack four of those statements across three words.
* Each packed section could be either inline data or a reference.


Arrays
-------

Arrays begin life as statements or data structures inside a block. Once they have grown to a particular size threshold, they are promoted to B-Trees. 

TODO: we talk about arrays here, but there's no reason to only have ordered collections. There are many optimisations we could do if they were unordered (i.e. bags) such as packing together elements with predicatable data (e.g. multiple elements with the same value, or following a sequence). Indexing here is only efficient in a single packed block. Everything else is a search through a tree.

An array can be implemented as:: 

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


Modules
-------------

A module is an array of statements. A module might have a name. There are different types of modules::

* Standard modules. Statements are permanent until removed. Statements are ordered.
* Cache modules. Statements might be forgotten from these at any stage. 

Statements in a module are usually ordered for the user's benefit, but ordering is not required when compiling queries. 

The VM has a root module in which it contains metadata about other modules. Module literals physically contain pointers to other modules - when the last module literal pointing to a module is garbage collected, so is its target module. The root module contains, among many other things, references to modules that each user has access to. Perhaps it contains a list of user's "desktop" modules, which in turn contain references to the modules each user has access to.

Modules are implemented using arrays of statements. Statements are added to and removed from these arrays, and the contents of a module can be listed by iterating over the array. As such, modules begin life as a statement containing an array within a block, and these will be automatically promoted to b-trees as the module grows.

XXX if you have an array containing entries for each type of statement, then this makes a lot of extra overhead when there is only one entry in each array.

A module would have a master array. This master array would contain an array for each type of statement in this module ::

    :: [ module (type module) type (type declaration T) statements (type array T).
    
e.g. 

    father.
    module [	myModule] type (:: [ father (type person) of (type person) ]) statements [
        father alfred of bob.
	father bob of charles.
    ].

    grandfather.
    module [	myModule] type T statements [
        grandfather A of C :-
	    father A of B,
	    father B of C 
    ] :-
        T = (:: [ grandfather (type person) of (type person) :- 
		father (type person) (type person),
		father (type person) (type person) ] ).

(T was moved down for readability)

This would be packed as::

    father.
    1 [ module->~ ][ declaration->~ ][ statements->2 ].
    2 [ ->3 ][ ->4 ]    // the array of all (:: [father (type person) of (type person) ] ).
    3 [ alfred->~ ][ bob->~ ].
    4 [ bob->~ ][ charles->~ ].
    
    grandfather.
    5 [ module->~ ][ declaration->~ ][ statements->6 ].
    6 [ ->7 ]           // the array of all (:: [ grandfather ~ ]).
    7 

("~" is used to omit obvious details)
    
The type declaration that is used to determine the format of packed words must be ground. 



Advanced modules
------------------

XXX Bloom filters

XXX write logs with new inserts/deletes/updates, to allow for rollbacks and versioning.


Versioning Modules


Long statements
---------------

If a statement has more than 5 positions, then it can be split up. E.g.::
   
    a:a b:b c:c d:d e:e f:f g:g.

Can become (internally):

    a:a b:b c:c d:d more:(e:e f:f g:g).

This allows for a statement to span across multiple blocks.


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

