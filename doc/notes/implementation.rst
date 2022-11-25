A VM Implementation
===================

This chapter describes a hypothetical implementation of a Squl VM.

See http://gulik.pbworks.com/w/page/55126238/Faish%20implementation for the original design notes. They will all eventually be moved here.

The VM design here is a block-based VM. The "heap" is divided into 4 kilobyte blocks, which are also stored to disk and sent across a network. The choice of 4 kilobytes is to match the size of a disk block or page in memory.

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

InPointers and OutPointers
--------------------------

A reference to a statement in the same block can be a direct 8-bit pointer. Each block is made out of 256 64-bit words, such that an 8-bit pointer is guaranteed to reference anything inside the block and nothing outside the block.

A reference to a statement in another block uses a 64-bit "OutPointer". A local 8-bit pointer will point to an OutPointer. The OutPointer in turn will point to an InPointer on another block. OutPointers are stored at the end of each block.

An InPointer is just data that is guaranteed to be fixed at those addresses, such that OutPointers remain valid even after manipulating data within a block.

A standard block has the following structure::

    [ InPointers | data |  OutPointers]

The boundaries between the InPointers, data and OutPointers are stored in block metadata::

                 v InPointer boundary
    [ InPointers | data |  OutPointers]
                        ^ OutPointer boundary

An OutPointer has the following structure::

     39 bits   19 bits          6 bits
    [  host  ][ block address ][ InPointer # ]

The host refers to block storage on a potentially remote computer. The "host" values are global across the network; an OutPointer remains valid when moved to a remote host.

The block address is the address of that block at that host. This is the location of the block in the file, after multiplying by 4096. The size of 19 bits is chosen arbitrarily; it allows for a file size of 2GB for each file. Multiple hosts can be run on the same computer to expand past this limit.

An "InPointer" is just a word in the block which may not be moved, as it is refered to by blocks across disk and across a network. These "InPointer" words are otherwise treated exactly the same as data. InPointers form the root set for garbage collection.


Statically typed storage
--------------------------

TODO: make a formal text format to present packed data and block structure.

Each 64-bit word in a standard block is packed data. The structure of this packed data is determined by the typing system. 

Given an example type declaration::

    :: [ person age (type integer) name (type string) ] (type person).

An integer is 32 bits, and a string would be a reference to an array of bytes. This statement can be packed into a 64-bit word as::

    [ age, 32 bits ][ name, 8 bit reference ][ 24 bits unused ]

Now if we have the following type declaration::

    :: [ father (type person) of (type person) ].

This can be packed as, with both references pointing to persons:

    [ 8 bit reference ][ 8 bit reference ] [ 56 bits unused ].

When we want to extract data, we know the type of each word based on the pointer to that word. Every pointer in the VM has a type in this manner.

Stored elements in a 64-bit packed word can be:

* References, 8 bits pointing to something else in the block.
* Primitive types (bool, byte, int, float etc).
* Deciders, N bits, determining what the type of the following data is.

All the other types the VM needs can be defined in terms of these elements. Type declarations, for example, are packed statements following the same schema. Module references are statements holding everything the VM needs to know about modules. Compiled code is a statement containing an array of bytes. Arrays are tree structures of statements until they are promoted into b-trees.

A "decider" is a small number of bits that determine what the type of the rest of the data in that word is. This occurs when there are multiple options for the type of an element. For example, an "Animal" might be a dog or a cat, so a leading bit would inform the VM that the following data is of format "dog" or format "cat". Deciders should be encoded using the fewest number of bits required, such that compiled code can have a jump table of every possible case to allow for throwing errors for invalid deciding values. Deciders are basically just enums.

One detail to remember about deciders is that as a module is modified with new types, existing deciders might need to be made of more bits. A solution for this is to have multiple bit packing recipes for the same type of statement.

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

Arrays begin life as statements or data structures inside a block. Once they have grown past a particular size threshold, they are promoted to B-Trees.

TODO: we talk about arrays here, but there's no reason to only have ordered, indexable collections. There are many optimisations we could do if they were unordered (i.e. bags) such as packing together elements with predicatable data (e.g. multiple elements with the same value, or following a sequence). Indexing here is only efficient in a single packed block. Everything else is a search through a tree.

TODO:
* Collections can be growable or fixed size. (OrderedCollection, Array)
* Collections can be ordered. (OrderedCollection, Array) or (Bag)
* Collections can be indexable.
* Collections might not allow duplicates. (Set / HashMap)

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
    "00"      3 bits    <packed contents if they fit into 59 bits>
    "01"      3 bits    8 bits      (51 bits unused)
    "10"      8 bits    8 bits      (46 bits unused)
    "11"      8 bit ref (...maybe pack the BTree type here?)

The different promotable types of array here are:

"00": The array contents fit into 48 bits, so we pack them inline.
"01": The array contents fit into a 64 bit word, so "contents" is a reference to that word.
"10": The array is a tree structure in blocks. "contents" points to branch nodes which point to either branch nodes or leaf nodes.
"11": The array is big enough to make a BTree. The size points to a 64-bit integer. The b-tree reference contains pointers to blocks.

(It seems that "01" isn't worthwhile having!).

We can derive the type of the array. If we have a reference to the array, we know it's type:

    :: [ personArray (type array (type person)) ].

    :: [ customer name (type string) address (type string) ] (type person).
    :: [ employee name (type string) reportsTo (type employee) ] (type person).

Here, the array contains elements that are either a customer or an employee. This can be implemented either by including a deciding bit on each reference, or including the deciding bit on the data itself. It seems to be more pragmatic to include the deciding bit on the persons themselves. Anything else that uses this type can only refer to a "person", so any reference in this system could be to either a customer or an employee.

    Bit packing of (type person):
    <decider "0"> <name, 8 bits> <address, 8 bits>
    <decider "1"> <name, 8 bits> <reportsTo, 8 bits>

There are spare bits here, so if the name is 5 bytes or fewer then they can be packed into the same word. Alternatively, in a packed array, these entries are both 17 bits so we can pack three of them into each word.

The packing procedure needs to fit structures into 64-bit words. Some statements, such as those with more than 8 positions, might need to be split by adding references in them pointing to other words containing more parts of the statement. Some statements might have left over space that other statements can be inlined into. Statements with hierarchies might be able to be flattened.

Garbage collection
------------------

There are two types of garbage collection: intra-block garbage collection and inter-block garbage collection.

Intra-block garbage collection is trivial. Any existing GC algorithm, such as mark/sweep, can be used using the InPointers as the root set. The structure of each word and where the 8-bit pointers are in each word is known from the typing system and block packing. Block compaction is supported because every 64-bit word in the block can be moved around except for the InPointers and OutPointers, which are already contiguous at the front and end of the block respectively.

A mark/sweep garbage collection algorithm can use a 256-bit array for the flags it requires. An intra-block garbage collection is limited to collecting 4k of memory, meaning that they should be fast and not cause noticable GC pauses.

Inter-block garbage collection is implemented using a back-reference tracking garbage collecter. This algorithm is similar to a reference counting garbage collection algorithm except that we keep a list of all references instead of just a count.

InPointers are guaranteed to be in a fixed place in each block. Every InPointer has a back-reference list. These are stored in block metadata outside the block. Each back-reference list is an array, which is promotable to a b-tree if it should grow large. A back-reference list is an array of words having the same structure as OutPointers -- each array entry contains the host, block and address of an OutPointer that refers to a particular InPointer.

When an OutPointer is removed by the intra-block garbage collecter, the virtual machine will traverse it to the InPointer it refers to, and then remove that OutPointer from the InPointer's back-reference list. When a back-reference list becomes empty, that reference is now known to be collectable garbage. The process can now continue by performing an intra-GC on that other block, potentially cascading into more inter- and intra- GCs.

BackReference lists, like reference counting, are still prone to cycles. To prevent this, the first entry in any backreference list is one that can be traced back to the root of the GC. If the first entry is removed, the other entries are searched for a path back to the root. This search might have cycles. If no path back to a root node can be found, then the InPointer and everything that this thread just marked is garbage. (Beware though if this is multi-threaded; another thread might be marking things but might yet find a connection back to a root). The search back to the GC root does not need to be exhaustive; any back-reference which is first in its list is guaranteed to be traceable back to the root, so the search can stop when it finds a back-reference list with a valid first item. Note that a search like this is expensive: blocks need to be searched through backwards.

A back-reference garbage collection algorithm has a lot of storage overhead, but also many benefits:

* This algorithm works well with blocks stored on persistent storage (disk) or across a network.
* Blocks stored on disk do not need to be loaded into memory to be processed. Back-reference lists are external to the block and can remain empty indefinitely, incurring only extra disk space usage. A disk-intensive GC can be scheduled at a convenient time.
* It does not necessarily pause execution, other than when locking blocks for writing.
* It is naturally highly concurrent and distributed.
* Garbage collection can be done by any thread or any number of threads.

One could imagine a cluster with a load balancer that schedules garbage collections. A host would accumulate notifications from other hosts that particular back-reference lists need to be modified. When appropriate, the load balancer would stop sending traffic to that host, so that the host can be in a "soft offline" state to perform potentially disk-intensive garbage collection. When completed, the host would rejoin the cluster.

It is hoped that using blocks with internal 8-bit references for the majority of references in the heap will help mitigate the overhead of storing back-references.

Using this scheme, other operations are possible. As we can find all references to a word, we can split or merge blocks. InPointers and OutPointers at the ends of the block can be compacted if there are holes. Blocks can be migrated to other hosts.

Host File Structure
-------------------

The file is entirely 4k blocks of 64-bit packed words. Blocks are accessed by index starting from 0. All state stored and used by the VM to maintain itself is stored in packed statements.

At this level of abstraction, only primitive types and references are implemented. Until modules are defined (below), the virtual machine can only allocate and modify blocks and words, and invoke garbage collection.

TODO: keep track of the state of worker threads? 

TODO: types for variable sized integers.

There is, in fact, only one statement in the entire host. It is at block 0, word 0 in the file, and is of type::

     :: [ host magicWord (type uInt16)
          id (type integer) 
          modules (type array module) 
          numberOfBlocks (type integer)
          blocks (type array blockMetadata)
          deallocatedBlocks (type array blockReference) ].


This statement stores the Id of the host and the modules within that host. This one statement contains everything in this host. This statement is continually mutated by the virtual machine as it executes. In fact, it is not really a statement but more of a data structure. It cannot be queried, as it lives outside the concept of a module. Nevertheless, we are polite, so once modules are implemented, we include the type of this root statement in the root module.

The virtual machine has the packing recipe of this and other basic statements built-in so that it has enough information to read packing recipes.

The magic word is a convention at the start of every file that helps operating systems and utilities to recognise file types. It has a fixed value.

Block metadata is stored in the "root statement"::

    :: [    block id (type integer) 
            inPointerBoundary (type byte) 
            outPointerBoundary (type byte) 
            backReferences (type array outPointer) ]
        (type blockMetadata).


Modules
-------------

A module is an array of statements. A module might have a name. There are different types of modules::

* Code modules. Source code is stored in the module and statement ordering is maintained.
* Standard module. These are created by code for use by code.
* Cache modules. Statements might be forgotten from these at any stage.

Statements in a module are usually ordered for the user's benefit, but ordering is not required when compiling queries.

Block metadata is kept here to manage the blocks in the VM. When blocks are deallocated, they are added to the deallocatedBlocks list for later re-use. Potentially, a defragmentation routine could be made to shrink the host file.

Each module is defined as::

     :: [ module name (type string) indexes (type array moduleIndex) ]      (type module).
     :: [ (type typeDefinition) (type packRecipe) (type array word) ]       (type moduleIndex).

The (type typeDefinition) is a statement type declaration. A packRecipe is read by the VM to decode words. A word is a 64-bit unsigned integer.

TODO: I've lost ordering in a module!

A moduleIndex is an array of statements of one particular type. Each word in this array is packed in the same way, so that a decider is not needed for each statement. TODO: can we have arrays of packed words larger or smaller than 64 bits?

::
    :: [ (type array recipeEntry ) ]                                        (type packRecipe).
    :: [ (type integer) bits integer ]                                      (type recipeEntry).
    :: [ (type integer) bits float ]                                        (type recipeEntry).
    [" etc for the other primitive types. ].
    :: [ (type integer) bits decider (type array typeDefinition) ]          (type recipeEntry).
    :: [ reference (type typeDefinition) ]                                  (type recipeEntry).

A pack recipe informs the VM how to pack and unpack a word. For example, if we have::

    :: [ name (type string) age (type integer) hairColour (type colour) ]  (type person).

The packing recipe for this would be::

    [ (reference (type string))
      ([+32] bits integer)
      (reference (type colour)) ].

----

When a statement is declared without a type, e.g.::

    :: [father (type person) of (type person) ].

then that statement is given it's own type, and automatically inherits from (type o)::

    :: [father (type person) of (type person) ]  (type x1234).
    :: (type x1234) inherits (type o).

This way, an array of that type can be made that will be efficently packed.

----

TODO old notes

Module literals physically contain pointers to other modules - when the last module literal pointing to a module is garbage collected, so is its target module.

A module would have a master array. This master array would contain an array for each type of statement in this module ::

    :: [ module (type module) type (type declaration T) statements (type array T).

e.g.::

    father.
    module [    myModule] type (:: [ father (type person) of (type person) ]) statements [
        father alfred of bob.
    father bob of charles.
    ].

    grandfather.
    module [    myModule] type T statements [
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
    7 [ 64 unused bits...!? ]

("~" is used to omit obvious details)

This is an interesting case. Variables are kept in the declaration of the statement, so there is no data here to store in the word. (XXX really?)

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

There are two types of garbage collection used: intra-GC and -GC.

Intra-GC is garbage collection that happens within a block. Any common garbage collection algorithm can be used. The InPointers for that block form the root set. FarRefs are treated just like any other object, except that a backreference must be removed whenever one is removed from a block.

For example, mark-sweep can be used. Because all entries in the block are a fixed size, a bit array can be allocated to mark entries. No compaction is needed because all holes are the same size.

Extra-GC uses a backreference-keeping garbage collector. This is just like a reference-counting garbage collection, except that instead of counting the number of references, we actually keep the whole list of references back to objects referring to our object::


    Block A
    +-------------+
    | 0 InPtr 12  |  --> BackReference list
    | 1 InPtr 14  |  --> BackReference list
    | etc          |
    | 12 13       |
    | 13 OutPtr   |  --> To another InPtr
    | 14 etc      |
    +-------------+

* InPointers point to an element inside the current block. They are fixed in position and referred to by OutPointers.

* Each InPointer has a BackReference list of other blocks that contain OutPointers to this block. (TODO: do they also have a count of references? OutPointers can move around).

* OutPointers point to InPointers in other blocks. They are ordinary entities that can be GCed by intra-GC. When they are collected, they get removed from the corrosponding BackReference list.


Each InPointer has a backreference list. Each FarRef has one entry in it's target's backreference list back to itself. These backreference lists would probably only contain one or two entries, but some can become very large. Backreference lists can be implemented as arrays in the same block that can be promoted to packed blocks.

Backreference lists need to be sorted (or hashed, or something). When a FarRef is garbage collected, the backreference in it's target's InPointer's backreference list needs to be removed. This needs to be done efficiently, meaning that a hash table or sorted collection needs to be used.


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

Alternatively, OutPointers could have the following structure::

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
