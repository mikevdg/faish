The Plan
========
(*) = written in Squl 

Next up
-------

# Convert colons to spaces in the parser*
# Make the basic CLI / file device dirctly in VW.
# Use the file device to load and compile Squl files.
# Move to GIT.
# Port the basic interpreter from VW to Pharo.
# Implement server using ASN.1
# Implement a real CLI / file device client.
# Implement LLVM client.
# Implement Compiler
# Implement module storage.
# Implement Debugger.
# Throw away Smalltalk version.
# Implement all missing bits below.

The Core
--------

* Basic interpreter in Smalltalk DONE
* Parser* IN PROGRESS
* LLVM device (in C)
* Block-based module storage (in C)
* Compiler*
* Load module dependencies over HTTP*

Scalability
-----------

* Module replication
* Multithreading, thread hints*

Tooling
---------

* Squl test suite*

The Language
-------------

* Operators*
* String library*
* Collections library*
* Time and date library*
* Widgets on canvas*

The IDE
-------

* Language server protocol support*
* Debug server (for MS Code) *
    - or a native debug client using canvas.
    - depends on the compiler.
* File directory <-> Module sync for IDE and version control*

The Environment
----------------

* Central repository*
* Local repository cache*

Devices
-------

* Canvas
* CLI / Stdin / Stdout
* Files
* Network
* 3D physics environment / AI environment.

Other
------

* Bottom-up nodes (maybe? Can it be done top-down using hints instead?)

