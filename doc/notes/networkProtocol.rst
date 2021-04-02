Squl Network Protocol
=====================

TODO: Screw it. Use ASN.1 rather than everything described below.


TODO:
* Ensure backwards and forwards compatibility.
* Make a compiler that generates C / Python / Java (etc) APIs for interacting with the protocol using a specification (aka Protocol Buffers).
* Consider sending blocks in the VM's native format across the network - i.e. somehow ensure security and stability, but still allow transfers to be done using e.g. DMA with zero processing.

This chapter describes a hypothetical binary stream protocol which can be used to communicate with a Squl server using TCP/IP or another streaming protocol such as POSIX sockets.

We describe the two endpoints of a connection as the client and the server; the server is a Squl interpreter and the client is a user interface, application or device wanting to interact with the server.

The client can be any device: a canvas, a command line (REPL / CLI), a filesystem, an interface to allow TCP/IP connections, or an interface to an LLVM compiler. This is the only manner currently implemented for a Squl server to interact with the outside world.

The server keeps a "working module" storing the accumulated state of the client. The working module imports whichever module that wanted to interact with the client.

The protocol consists of "commands" sent from client to server and from server to client. Each of these are Squl statements encoded as per below.

Generally, for each interaction the client would:

#. Create a new tock (declareSignature:t1234 numParams:[+0]!).
#. Add that tock to the working module (addToWorkingModule:(tick:t1233 tock:t1234)!).
#. Add events to the working module (addToWorkingModule:(device:console tock:t1234 event:(input:["hello]))!).
#. Create a query (createQuery:(device:console tock:t1234 action:X) qid:[+5]!).
#. Set optional limits on that query (query:[+5] resultLimit:[+1]!).
#. Start the query (startQuery:[+5]!).

Note that these are all going to the server together as a block for effiency.

..
    TODO: Should qids be atoms?

The server then responds with:

#. query:[+5] result:(device:console tock:t1234 action:["world]).
#. query:[+5] status:noMoreResults.

After the ``noMoreResults`` status, query 5 can be forgotten at both ends.


Blocks
------

At the lowest level, the protocol sends data in blocks. Each block starts with the byte 0xFF to signify the start of a block. After this comes an integer representing the size of the block in bytes, followed by the block contents. Each block contains one statement.

Blocks are used as a sanity check and might be removed in a future version of the protocol.

Statements
----------

Each statement has the following structure::

    12	<Sid> <variable bindings...>

The byte value "12" is a magic number as a sanity check. It can be removed in a future version of the protocol.

The ``<Sid>``, the signature Id, is an index into the signature dictionary (explained below).

``<variable bindings>`` is an array of variable bindings. The size is determined by looking up the entry in the statement dictionary.

The value in each variable binding can be a nested tree structure. Each element has the format::

    <Sid> <contents>

where the Sid is one of the following. Contents is either variable bindings, or special contents for special types. The following is the prepopulated shared statement dictionary (19 is just a magic number)::

    19	Variable			<VariableId integer>
    20	Integer				<value integer>
    21	Big Integer			<value bytes>
    22	32-bit float		<value float>
    23	64-bit float		<value float>
    24	reserved for 128-bit float.
    25	reserved for bigger floats
    26	reserved for even bigger floats.
    27	Array of statements			<size integer> <values...>
    28	Array of bytes (i.e. a String)		<size integer> <bytes...>
    29	Reserved for 16-bit integer arrays
    30	Array of 32-bit integers			<size integer> <integers>
    31	Reserved	for 64-bit integer arrays.
    32	Array of 32-bit floats
    33	Array of 64-bit floats
    34	Reserved for big float arrays
    35	Reserved for bigger float arrays
    36	Module literal.		<value bytes>
    37  Statement literal
    38  Parameter placeholder in a signature definition. <VariableId integer>

    45  (addImport:+ModuleLiteral)
    46  (addToWorkingModule:+Statement)
    47  (createQuery:+Q qid:+Qid)
    48  (qid:+Qid limitSeconds:+S)
    49  (qid:+Qid limitSteps:+St)
    50  (qid:+Qid limitDepth:+St)
    51  (qid:+Qid limitNumResults:+N)
    52  (startQuery:+Qid)
    53  (stopQuery:+Qid)
    54  (discardQuery:+Qid)
    55  (connection:disconnect)
    56  (declareSignature:+Sid arity:+N)
    57  (query:-Qid result:-Result)
    58  (query:-Qid status:noMoreResults)
    59  (query:-Qid status:moreResults)

    65  (code:C statement:S)
    66  (tick:Tp tock:Tn)
    67  (device:_ tock:_ event:_)
    68  (device:_ tock:_ action:_)
    69  (tStart)     -- the first tock.

..
    TODO: negative integers?
    TODO: typed signatures?
    TODO: query control - limits, restarting, stopping.

The VariableId can be any integer; it is scoped only within the current statement.


The Shared Signature Dictionary
-----------------------------------------------

Both the client and server maintain a shared signature dictionary, specific to this connection. This dictionary maps integers known as "Sid"s (i.e. "signature IDs") to statement signatures. Each signature has a number of parameters. Signatures contain no other data other than their Sid to denote uniqueness, meaning that the dictionary is just a mapping of Sid to their number of parameters.

For background, every statement has a signature. Two statements match if they share the same signature, and if all parameters match.

Atoms are statements of signatures with zero parameters.

Generally, the client would initiate a connection by asking the server to prepare all statements the client would need. The server would send one or more ``(declareSignature:arity:)`` before sending back the first query response that uses these.

The client can create new Sids starting from 22 and increasing. The server can create new Sids starting from 2^31 and decreasing.

The statement dictionary is pre-populated with these useful statements to bootstrap the protocol::

..
    TODO: regularize the query commands. E.g. (qid:Qid command:C)?

These are commands sent from the client to the server:

1. ``(addImport:+Module)!`` - add the given module to the imports for the working module. Used for initialization.
2. ``(addToWorkingModule:+X)!`` - Add the statement X to the working module.
3. ``(createQuery:+Q qid:+Qid)!`` - Run the query Q in the working module; Qid is a client-side ID used to track the query.
4. ``(query:Qid stepLimit:N)!``		-- Set limits on that particular query.
5. ``(query:Qid depthLimit:N)!``
6. ``(query:Qid timeLimit:Seconds)!``
7. ``(query:Qid resultLimit:NumResults)!`` -- Stop after this many results.
8. ``(startQuery:Qid)!``
9. ``(stopQuery:Qid).!``
10. ``(stopAllQuerys)!``
11. ``(forgetQuery:Qid)!``
12. ``(connection:disconnect)`` - disconnect.
13. ``(declareSignature:+Sid numParams:+N)`` - tell the server that I declare the given signature. Sid and N are integers.

..
    TODO: how to forget signatures?

These are commands sent from the server to the client:

14. ``(query:-Qid result:-Result)`` - the given result was found for the given query.
15. ``(query:-Qid status:noMoreResults)`` - the given query is exhausted.
16. ``(connection:disconnect)`` - disconnect.
17. ``(declareSignature:+Sid numParams:+N)`` - tell the client that I declare the given signature. Sid and N are integers. This is the same as the server's version.

These are also added to the statement dictionary for use as sub-statements:

18. ``(code:Code statement:Statement)``. Used in queries to ask the server to return the given statements. These would be implemented by a module.
19. ``(tick:tock:)``
20. ``(device:tock:event:)``
21. ``(device:tock:action:)``


In this way, the client can ask for the signatures of novel statements. Say that the client has never seen (example:~) before. The client sends:

#. createQuery:(code:["example:X] statement:S) qid:[+6]!
#. startQuery:[+6]!

The working module would import some other implementation module that implements the following::

    code:["example:X] statement:[\example:X].

The server responds with the following. The statement ($123456:x) has a signature of 123456 and arity 1 in both signature dictionaries and unifies with (example:x)):

#. declareSignature:[+123456] numParams:[+1].
#. query:[+6] result:(code:["example:X] statement:($123456:[\_])).
#. query:[+6] status:noMoreResults.


The code can be any literal. If the client wants, it can send the code to a compiler.

After this, the client and server can now use statements containing (example:~).

..
    TODO: what should endpoints do if we run out of Sids? - close the connection. It can be reestablished with fresh shared dictionaries.


Using this protocol
-------------------

Connections are established from client to the server. Before the client can interact meaningfully with the server, it needs to bootstrap it's protocol. Usually this would be achieved by performing queries for (code:statement:) to retrieve all the Sids it needs to interact with the server. The Sids can be found by tearing the resulting statement apart.

..
    TODO: somehow specify a protocol.

Initialization would also involve adding an import to the working module for the implementation using (addModule:+M). This would usually be provided to the client from its environment; for example, it would be a required parameter for a command line.

The client would run an event loop such as::

    while (connected) {
        insert a new tock (addToWorkingModule:(tick:+Tp tock:+Tn));
        insert events into the working module (addToWorkingModule:(device:+D tock:+T event:+E));
        query for actions (query:(device:+D tock:+T action:-A?) qid:+Qid);
        perform those actions;
    }

This client relies on receiving a (query:-Qid status:noMoreResults) before repeating the loop. A more complex client would be multithreaded and able to send or receive commands asynchronously.

This means that, during initialization, the client needs to find Sids for:

* ``(tick:tock:)``
* ``(device:tock:event:)``
* ``(device:tock:action:)``
* All the events and actions.

The client can create it's own tocks by allocating it's own atoms (i.e. Sids with zero parameters).

The client can create it's own Qids. These will most likely be integers, starting from, e.g. 1.



