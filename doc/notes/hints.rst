Execution Hints
===================

TODO: do hints only apply to statements in their own module?
TODO: Make hints apply to the statement after them. Maybe prefix them with ":: hint "?

An execution hint is a statement that guides the VM's investigation of a particular statement.

The eventual goal of Faish is that execution hints are generated automatically. Until then, some manual input by the original code author is required to ensure that queries actually find results.

Hints are specific to the version of the interpreter being used. The interpreter is free to ignore hints. The hints described below are specific to Faish 0.3.

When the interpreter is searching for results, it may find itself investigating sub-optimal, hopeless or infinitely recursive branches of the search tree. In fact, with no execution hints, many simple applications will not even succeed as the interpreter finds itself stuck investigating endless hopeless branches. 

You will notice during debugging that the interpreter, when investigating ( cn:~ map:~ result:~ ) that it can investigate search branches in any order:

* In a then-if statement, the interpreter is free to investigate the if-clauses in any order it wishes. This search is called "deduction".

* From an if-clause, modules visible from the current module (including itself) are searched, in any order, for anything matching that if-clause. This search is called "import", for lack of a better name.

* From an if-clause, specifically from an "import" search node, a search is made in that module for matches. This search is called "unification". Again, for lack of a better name.

The pattern is thus "deduction" -> "import" -> "unification", usually wrapping back to "deduction" when "unification" finds another then-if statement to investigate.

When faced with something like this, however, the search quickly becomes non-trivial::

	then:( cn:Hemnut map:Function result:Bokluz )
	if:( h:H emnut:Emnut hemnut:Hemnut )
	if:( cn:Emnut map:Function result:Okluz )
	if:( fn:Function :H result:B )
	if:( h:B emnut:Okluz result:Bokluz ).

As the clauses can be investigated in any order, the result is usually that the interpreter wastes time trying to find solutions for clauses that do not yet have enough variables unified to easily find a valid result. For example, on the query ( cn:[, 1,2,3,4] map:double result:X ), the interpreter could immediately attempt ( cn:Emnut map:double result:Okluz), which will result in infinite recursion as it uses the same then-if clause again to attempt to find ( cn:Emnut map:double result:Okluz ), recursively, forever. The interpreter is not magical; it needs guidance in the form of hints.

Note that, without hints, Faish 0.3 will investigate clauses as follows:

* if-clauses in a then-if statement are investigated in the order they are given. Hints are required to investigate clauses in another order.

* For import searches, modules are searched in the order they appear as imports.

* For unification searches, statements are investigated in the order they appear in the module.


Hints in Faish 0.3 have this signature::

	hint:(
		statement:S
		node:N
		thread:Td
		relayIn:Rin
		relayOut:Rout
		advice:A ).

where S, N, Rin and Td are provided, and you must provide a values for Rout and A. S is the statement being investigated. N is a special object that can be queried for more execution information (TODO).

The relays are provided soley for your benefit. Rin has the value that you gave Rout on the previous incarnation of advice for this node. On the very first incarnation, it has the value of 0, which you would typically ignore. Thereafter, you can use it to provide information on, e.g. which of the if-clauses to next pursue, or which element in an Catalog to look up.

Td is an identifier for the current thread. It has one of the values from the array passed in by a fork hint.

The interpreter is expecting A to be one of::

* ( investigateNextClause:N ). N is the Catalog of the if-clause that should be investigated next.

* ( useCatalog:Idx ), where Idx understands the same protocol as an array of statements. This is used for "unification" searchables. The array of statements is searched in order; it is the responsibility of the code author to ensure that the given statements are in the current module. Idx can be an array, an Catalog or something the user has concocted that understands ( array:A size:S ) and ( array:A Catalog:I value:V ).

* ( cull ), which aborts the current node.

* ( tryNot ), which makes the interpreter attempt to investigate ( not:S ) instead of the statement, in an attempt to disprove the current clause. (TODO - don't need this one)

* ( fork:Array ), which creates a new thread of execution. Array is an array of thread names, and each value is passed back to you as the thread name (TODO - don't need this one).

* ( cache ), which informs the interpreter that the result of this deduction should be cached. (TODO: maybe a cache module could be provided and we can add our own statements to it? Maybe we need to pass a module around? When do we remove cached statements? )

* ( none ), which informs the interpreter to continue as normal.

TODO: bottom-up hints, informing the VM to do a bottom-up search first.

TODO: mutability hints, informing the VM that an object (complex statement or array) can be directly mutated and that backtracking is very unlikely to happen.

For example, the VM might perform this query when investigating ( cn:~ map:~ result:~ )::

	hint:(
		statement:( cn:[,1,2,3,4] map:double result:X )
		node:[N ...]
		thread:[+1]
		relayIn:[+1]
		relayOut:Rout
		advice:A )?

and the code author would include the following hint in the module::

	hint:(
		statement:( cn:\_ map:\_ result:\_ )
		node:\_
		thread:\_
		relayIn:Rin
		relayOut:( Rin + 1 )
		advice:( investigateNextClause:Rin )?

Hints can involve complex deductions, and hints themselves may have hints on them. Obviously, it's best to avoid recursive hints. (TODO: test recursive hints!). For example, a hint might be implemented as a machine learning algorithm or pattern-recognising neural network. This extra computation borrows from the same resource limits as the parent deduction (TODO). Complex hints are implemented in the same way as all other code::

    then:( hint:(statement:( a:~ b:~ ) node:~ thread:~ relayIn:~ relayOut:~ advice:( cull ) )
	if: ...complex logic

		
TODO: how to specify particular resource limits on a hint?

TODO: how to specify which module to investigate?  (useCatalog:)?

TODO: how do you test that part of the statement is a variable???		
		
investigateNextClause:N
---------------------------

The (investigateNextClause:N) hint informs the VM of the order that clauses in a then-if statement must be investigated.

::
	hint:(
		statement:( then:(cn:\_ map:\_ result:\_) if:(..) if:(..) )
		node:\_
		thread:\_
		relayIn:Rin
		relayOut:[= Rin+1]
		advice:( investigateNextClause:Rin ).

The given statement must be an entire then-if statement. Simple statements have no clauses. 

The relay can be used to determine which previous statement was investigated. You can give a number to the relay; the next time that the hint is queried, you will receive that number as Rin.

(TODO) If N is negative, then negation is searched instead. The clause searched will be the absolute value of N and the statement searched for will be ( not:C ) where C is the clause found. If a value is found, the search will be culled and backtrack at this point as the then-if statement will be considered impossible to solve.

(TODO) If multiple (investigateNextClause:) hints are found for a given statement, then they will all be attempted. [refer a comment in the (fork:) hint below].

Note that Faish 0.3 will investigate if-clauses in the order they appear. Without hints, Faish will not investigate them in any other order. To have clauses investigated in another order, this hint needs to be used.


useCatalog:Catalog
---------------------------

A catalog in Faish is the same concept as an index in a database. It is a data structure used to speed up queries. We use the name "catalog" because the word "index" is overloaded: an index can be a number used to find an element in an array, or an "index" can be a data structure used to speed up queries.

In Faish, a statement array, catalog and module are all the same thing, more or less. They all share the same implementation in the VM.  The difference is how they are used. A statement array would be used by the programmer to implement algorithms. A catalog is used to speed up queries and ensure that statements are investigated in a desired order. A module is used to store statements.

Every if-clause would have a catalog associated with it; these could be either the containing module (used as a catalog) of that clause, a catalog generated specifically for that clause, or a catalog provided by hints.

The (useCatalog:Catalog) hint forces the VM to use the given catalog when searching for statements matching the current one. The VM will then only search the provided Catalog in the order statements in that catalog appear.

(TODO) If more than one (useCatalog:Catalog) hint is found for a statement, then all of those hints (and thus catalogs) will be used. [refer a comment in the (fork:) hint below].

(TODO: what about searching other modules?)

Then-if statements will match if their conclusion matches the given statement.

The given statement should be a simple statement rather than a then-if statement. This hint is consulted when matches for an if-clause need to be found.

(TODO) The Catalog you provide must either be an array, or match the protocol of an array. It must understand::

    array:Catalog size:S?
	
	array:Catalog Catalog:I value:V.
	
where S is an integer and V is a statement.

(TODO) Negation can be included in the Catalog. If a clause is found which is ( not:V ) for some statement V matching the given statement, then ( not:V ) will be searched. If found, the search will continue.

Note that Faish 0.3 will investigate clauses in the order they appear in the module. This means that with careful ordering of statements, this hint will only be required if searching is required in more than one particular order.


cull
---------------------------

The (cull) hint simply stops any further investigation on the given statement. The given statement is a simple statement and may not be a then-if statement (TODO: why not?).

Search will backtrack, but if the parent node is on a then-if statement, the parent will not be made to fail. The parent can continue investigating to find other results.


tryNot
---------------------------

(TODO) will probably not be implemented.

Negation can be provide by:

* Negative numbers in investigateNextClause:

* Including not:~ in useCatalog:.


fork:Array
---------------------------

The (fork:Array) hint will allow the VM to fork (or spawn) more processes (or threads) and use more CPU cores. The given array in Array can contain any objects. The VM may fork one process for each object in the array.

This is where the (thread:) clause of the hint statement is used. Each object in the array will be assigned to a thread. The object will be returned to you in the next hint in the deduction.

The VM does not need to fork a process; if CPU cores are already fully utilised then it may remain single-threaded. In this case, further hints are still evaluated, one for each object in the array exactly as if processes had been forked.

The given statement, S, can be a then-if statement or a simple statement. If the given statement is a then-if statement, then typically a set of (investigateNextClause:N) hints would be provided using the (thread:) clause to differentiate between threads.

If a simple statement is provided then typically it would be coupled with a set of (useCatalog:) hints, again using their (thread:) clauses to differentiate between threads.

TODO: can (investigateNextClause:) and (useCatalog:) be used instead of (fork:)? If they return multiple results, the VM can make a thread for each result.


cache
---------------------------

(not implemented in Faish 0.3)

The (cache) hint will make the VM store the current statement in a cache module. The cache module will be H during further deductions to avoid re-doing long deductions.

Typically this would be used for storing the result of difficult deductions, or deductions that occur often.

The given statement can be either a then-if statement or a simple statement. The given statement may still have ununified variables. Use the built-in (variable:) or (statement:) to determine this.


none
---------------------------

The "none" hint informs the VM to continue as it would have if no hint were found.

This is used when (TODO: when? Why not just return no results to a hint?)
