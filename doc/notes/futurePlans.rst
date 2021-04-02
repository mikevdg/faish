Future Plans for Squl and Faish
=========================

This chapter is not yet ready for inclusion in the official documentation.

The main goal of Squl is to be a programming language and information repository for artificial intelligences. There are a  large number of potential applications for an artificial intelligence, such as scheduling systems, navigation systems and task planning.

I would like a Squl virtual machine which can use the full power of an MPI-based computing cluster. It would use techniques from database systems to store the majority of its knowledge base on disk, and spread computation across a cluster of computers using MPI as the communications API.

A Squl virtual machine would be a persistent daemon. When it starts, it loads it's persisted state from disk, and persists its state back to disk on shutdown. The virtual machine would be on a local cluster; we assume the cluster has reliable low-latency connections between nodes. For now, we are interested in obtaining decent scalable performance rather than resiliance against node failure, although this is a worthwhile goal for later.

The virtual machine can have devices, such as a canvas or IDE, connect to it using the Squl network protocol over TCP/IP.

Compilation of Squl to machine code would be achieved using the LLVM compiler infrastructure. The Squl compiler would be written in Squl, following much of the design of a Prolog compiler. An API would be available (see the network protocol chapter) for the compiler to use to create LLVM IR and then have that compiled into machine code. The compiler itself could then be compiled into machine code.

The runtime would initially only contain:

* The LLVM API, which can somehow persist the compiled code.
* The Block Manager, possibly written in C.
* The MPI library.
* As a dependency of the above, the Squl network protocol adaptors.
* Some authentication system.
* Some logging system.

The Squl compiler can then be connected to this using the Squl network protocol API running on the Faish interpreter. It would bootstrap this environment by compiling the compiler and then use the compiled compiler to compile any other required modules.

The implementation would possibly be a combination of Squl and C. Squl is suitable for parsing and compilation, whereas C is more suitable for any components which require bit twiddling and systems programming. 

A higher-level language such as Smalltalk or Python would be used to implement an IDE. It might be possible to make an IDE using Squl, but this would require reimplementing a widget set.

It would be handy if the compiler could either directly generate and execute code (like a JIT), or output generated code for compilation into a stand-alone executable.


The Compiler
-------------------------

These are rough ideas for now.

The compiler would take a particular query and the module for that query, and output a data structure (which is a big nested statement). This data structure is an intermediate representation which can be directly iterated over and fed into an LLVM API to generate machine code. The API would probably be a tock-based API which can invoke the various LLVM methods to generate LLVM IR.

At each step, statement metadata needs to be consulted to determine the best course of action. The execution must exactly match the behaviour of the interpreter.

Each UnificationSearchable can be converted either into a big set of if/else statements, or an iterator. If/else statements would be used when the number of options are small, and an iterator would be used when the number of options is very large (such as when we iterate over a large database). The iterator can be multi-threaded.

Each DeductionSearchable would become a sequence of instructions. The clause ordering would be used to determine the order of instructions and each clause would become a method invocation which is possibly recursive. Somehow, backtracking needs to be incorporated into this.

Code to unify statements could be created by the compiler.

The compiler must be able to include debugging symbols.

We make the assumption that LLVM can make further important optimisations.


The Block Manager
------------------------------------

The compiler would output code that interacts directly with blocks and the block manager.

The block manager implements:

* Saving blocks to disk and loading blocks into memory.
* Sending blocks across the network to another node.
* Managing FarRefs.
* Intra- and inter-block garbage collection.
* Packing blocks.
* Creating and maintaining indexes.
* Replication of modules and indexes across nodes.


The LLVM API
-----------------------------------

The LLVM API would be a thin API that exposes the LLVM API as a tock-based API. Each function in, say, the C version of the LLVM API would be exposed as an action.


The MPI Libarary
-----------------------------------

I'm not sure how this would fit into everything yet.

The emitted code from the compiler would have some fork points. This is where a task can be sent to a remote node.

Some component would need to keep track of where tasks are.
