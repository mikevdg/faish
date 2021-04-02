Faish architecture
================

This describes a hypothetical future architecture of Faish.

Faish will be comprised of:

* The embeddable interpreter library.
* A Faish server.
* An IDE, which is a network client.
* A command-line client 
* A graphical client
* Other clients.

The embeddable interpreter will be a C library which can be included and used within other applications as an embedded language for such uses as game A.I. It will interpret binary squl code and be able to optionally persist to disk.

The Faish server uses the embeddable interpreter to implement a network server, written in C. It can be distributed across a cluster using MPI.

The IDE can be written in any other language, probably Smalltalk. It uses a custom network protocol to connect to a Faish server.

The network protocol - binary format
--------------------------------------

--> See networkProtocol.rst.

A binary network protocol will be used.

The interaction starts with a client connecting to the server and authenticating. Then, the client sends a query, and the server asynchronously sends back query results. The client can send out however many queries it wants and wait for results to come back. Each result contains the ID of the query from which it originates.

Queries are considered open until the server sends a result back to the client indicating either a time out or that there are no more results. The client can also choose to close a query. 

Queries can have a durability of "session" or "eternal". A "session" durability means the query will be closed when the client disconnects.

Each query and query result is a statement, meaning that the network protocol consists entirely of statements being sent in both directions. Each statement starts with a size, measured in bytes, of the statement followed by the size of that statement XORed with 0x000000ff as a sanity check to ensure we are actually at the start of a statement. 0xff is used because some languages don't have signed integers and other languages don't even have integers (!). The size is sent as a network byte order (big-endian) signed 32-bit integer. It might be worthwhile having a maximum statement size setting somewhere; 2GiB of data is a bit difficult to chew.

Both ends of the connection maintain a shared statement definition dictionary. Statement definition updates and requests are sent to maintain this. The server can at any stage send statement definitions to the client, and the client can request at any stage statement definitions it does not know. The statement definition dictionary is pre-populated with commonly used statements used in the network protocol. The server chooses the statement definition IDs. The client cannot create new statement definitions; it must send statements to the server as strings to be compiled, and the server will send back the statement definitions.

An atom is a statement definition with 0 args. then-if statements are definitions, with separate entries for each arity of then-if. Variables are definitions.

Statements are sent by flattening them. The statement tree is recursed left to right and the results are written out. If a definition can't be found, the server needs to be asked to compile a statement.

Both ends of the connection maintain the list of active queries. The client chooses the query IDs.

Commands, such as a command to add a statement to a module, are also sent as "result-less queries" with the only results being a confirmation or an error. 

Each int is an signed big-endian 32-bit integer.

After the size comes either a statement definition from the server, a statement definition request from the client, a query or a query result.

* server-to-client statement definition: 0x10 <int definition-id> <int numargs> <byte-array signature>
* client-to-server statement definition request: 0x11 <int definition-id>
* client-to-server query or command: 0x12 <int query-id> <statement contents>
* server-to-client query or command response: 0x13 <int query-id> <statement contents>

TODO: blocks can be top-level components too?

Statements are:

* Statement, atom or variable: 0x20 <int definition-id> ...args...

The number of arguments is found by looking at the definition dictionary.

Literals are:

* Integer, 32-bit signed big-endian: 0x21 <int32 value>
* Integer, 64-bit signed big-endian:0x22 <int64 value> 
* Integer, big: 0x23 followed by twos-compliment value chopped into 7-bit pieces. The MSB of each octet is a continuation bit set to 1 except for the last octet, which has 0 to signify the end of the integer.
* Float, 32-bit IEEE-754: 0x24 <float32 value>
* Float, 64-bit IEEE-754: 0x25 <float64 value>
* Array (byte-array, also a string), bytes: 0x26 <int32 size> <bytes...>
* Array, 32-bit signed integers: 0x27 <int32 size> <int32... values>
* Array, 32-bit floats: 0x28 <int32 size> <...floats...>
* Array, 64-bit floats: 0x29 <int32 size> <...floats...>
* Statement literal, 0x2A <int definition-id> ...args...
* Module literal, 0x2B <...???...>

* Custom literal block, source code: 0x30 <byte-array value>

The network protocol - interaction
--------------------------------------

Queries and commands are sent and query results are received back. The statement definition dictionary is pre-populated so that the following protocol can be used. The first line of each is sent by the client and the possible results are listed after.

::
    module:[] compile:["source]!
    compiled:( ...statement... ).
    query:[+id] closed:noMoreResults.
    ...any new statement definitions are also sent.

::
    module:[] statementIndex:[+14] source:X?
    module:[] statementIndex:[+14] source:["a:b.].

TODO: put these back up in the core protocol above.

::
    closeQuery:[+id].
    queryId:[+id] confirm:isClosed.
    ...or 
    queryId:[+id] error:errorType message:["Disk fail].
    queryId:[+id] error:errorType message:["Compilation failed] position:[+codePos].

::
    queryId:[+id] module:[] durability:session query:(...query statement...)?
    queryId:[+id] result:~.
    queryId:[+id] closed:noMoreResults.
    or queryId:[+id] closed:timeOut.
    or queryId:[+id] closed:stepsExceeded.


:: todo - add IDs to these?
    ...reuse the reflection API here.
    module:[	...] add:[" ...].
    module:[	...] add:( ~ ).
    module:[	...] remove:( ~ ).
    deleteModule:[]
    createModule:X?

Other devices can easily be added to the network protocol, e.g. a canvas. Interaction would start by the client asking for all its possible I/O operations to be compiled.
