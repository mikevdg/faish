Introduction
============

This document describes the programming language Squl. Squl is a logic-based declarative programming language. It is quite similar to Prolog, but with a more verbose syntax.

Origins
-------

Squl is a declarative programming language intended to be used for research into various AI techniques. 

* The Squl language is, hopefully, "expressively complete". This means that the language can store and manipulate any concept a human can express.

* A Squl interpreter should be able to accept any syntactically valid Squl statement without having issues with infinite loops. This allows for experimentation with randomly generated statements.

* A Squl implementation is ideally implemented using persistence. Any generated data will survive a restart of the interpreter without requiring any exporting to files.

"Faish" is the implementation of the "Squl" language. "Faish", the name, is inspired by an AI fish (available from the "execute" menu - it was an experiment with automatic code generation that is not yet completed). "Squl", the name, was inspired from a "school of fish". Better naming suggestions are welcome.

"Squl" is not related to SQL.


Differences from Prolog
-----------------------

Squl derives many of its characteristics from the Prolog programming language. The syntax is quite different; Squl is more descriptive and lacks the conciseness of Prolog.

Whereas Prolog's execution semantics are based on a depth-first search, Squl's execution semantics are not defined explicitly, other than an informal approach of "trying not to be useless". Prolog requires that the programmer understand the execution semantics and uses them to his/her advantage by introducing cuts and recursion into specific places of a statement, both to aid efficient execution and to avoid infinite recursion. In comparison, Squl does not have a cut operator, and a Squl implementation is free to investigate clauses in whatever order it finds useful. This comes with a (massive) performance penalty as dead ends are investigated, but allows much more flexibility with the implementation and a more pure approach to logic programming. Squl has been designed for experimentation rather than for speed.

Prolog implements negation by failure. This is also available in Squl, but is an optional extra should the programmer want to define negation in this way.

Prolog allows custom pre-fix, post-fix or infix operators to be defined. These are not available in Squl. Squl does, however, have custom literal definitions which can achieve some of the same functionality.

Prolog does input and output in an impure manner, by relying on execution semantics. Squl, instead, does input and output by inverting control. Rather than a module requesting input and output, the environment asks the module what it wants to input and output, and when it wants to do this. The module can include certain statements which inform the execution environment to enable various input and output devices.

Future roadmap
-----------------------

Faish is written using Smalltalk and currently is a slow, interpreted, single threaded, in-memory implementation of Squl. Future plans include making it fast, compiled, multi-threaded, distributed and persistent, but for now we have what we have.

The following is entirely speculative, and features listed in this section may or may not ever come into existence. However, it is worthwhile documenting these ideas so that users of Faish and the Squl language have an idea of the direction the language is heading.

Foremostly, it is intended that Faish is an environment for research into artificial intelligence. The Squl language is too cumbersome to be used as a general purpose language, and it's strength lies in its ability to encode concepts rather than algorithms. To this end, a Squl interpreter must always be able to sensibly process a nonsense Squl module without serious side effects (such as being stuck in an infinite loop) such that experiments with self-mutating or evolving code are possible.

It is intended that Faish becomes a database engine that can be run across a cluster of computers for scalability. Modules are kept on disk and paged to/from memory as required. MPI will possibly be the technology used for inter-node communication. It is intended that your modules can take advantage of a supercomputer by exploiting whatever concurrency is available in your module, and that modules can be exceptionally large by being kept on disks (possibly across nodes) rather than in memory. This is the reason that Faish "imports" and "exports" modules to files rather than executes a file directly as Prolog does: Faish is intended to be a deductive database engine rather than a simple interpreter.

Faish's user interface and IDE is meant to be a stand-alone client that connects, possibly using TCP/IP and ASN.1, to the database engine. Currently they are unfortunately closely interlocked.

There will be two user interfaces: the IDE, and a runtime UI. The runtime UI is just a simple canvas implementation that connects to a remote (or automatically started) Faish engine. You can start up the runtime UI with a URL, and it will load up the module (and its dependencies) at that URL and run it.

The canvas API is intended to become a simple 2D graphics and event handling API, powerful enough to implement simple user interfaces. The command line API will be replaced with a pure Squl implementation that uses the canvas API.

The main code editor will, at some stage, undergo a massive facelift. It will resemble a text editor more closely, but with each "paragraph" being an editable object, and these objects being one of: statements, tests for those statements, queries, documentation, or metadata. Thus your queries will be inline with your code, but only persisted queries will remain if you close and re-open the editor window. This will be implemented keeping in mind the massive potential size of modules (i.e. don't load the module into memory!), and that the module is potentially on a remote computer with some network lag.