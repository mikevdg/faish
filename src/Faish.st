<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® Personal Use Edition, 8.2 of 15 July 2016 on 29 January 2022 at 1:33:58 AM</time-stamp>


<component-created>
<name>Faish</name> <type>package</type>
</component-created><!-- Package Faish* -->


<component-property>
<name>Faish</name> <type>package</type>
<property>comment</property> <value>'Faish is a Prolog-like language intended for research into artifical intelligence.
'</value>
</component-property>

<name-space>
<name>Faish</name>
<environment>Smalltalk</environment>
<private>false</private>
<imports>
			private Smalltalk.*
			</imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</name-space>

<class>
<name>ErrorResult</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>ErrorResult</class-id>
<body>I pretend to be a FaishStatement to inform the user of the outcome of a failed search.</body>
</comment>

<class>
<name>ExceededTime</name>
<environment>Smalltalk</environment>
<super>ErrorResult</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<class>
<name>SearchResult</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>type statement </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>SearchResult</class-id>
<body>I need rewriting and all code that uses me needs refactoring.noFail and fail are no longer used much. BuiltIns no longer need to return a noFail.The only thing I'm useful for now is to return an error to the user. This can probably be done more effectively by returning a Searchable which is an error node.</body>
</comment>

<class>
<name>RecurseError</name>
<environment>Smalltalk</environment>
<super>Core.Error</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish-Exceptions</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<class>
<name>Searchable</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>depth module parent derivedFrom depthFirstChild searchType relay threadIdentifier goal hintsSearcher </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>Searchable</class-id>
<body>I am something which can be searched by a search algorithm. I represent just one node of a "search tree". I am searched on by a "SearchAlgorithm" subclass.Many search algorithms search for possibilities in a tree. For example, the travelling salesman problem could be thought of as a tree, where every intersection in the "city" is a node, and every direction leading out of that intersection is another branch or child of that node.I form a search tree. At any node (instances of me) in the search tree, you can invoke &gt;&gt;nextChild to return the next child. So, a breadth-first search would invoke &gt;&gt;nextChild on a single node until nil is returned, then start iterating through the children it got from those invocations. A depth-first search would invoke &gt;&gt;nextChild on the first node, then &gt;&gt;nextChild on the returned child, then &gt;&gt;nextChild on that returned child, and so forth until it hits the bottom of the search tree (where nil is returned).derivedFrom - is actually my parent node (as in, the node that made me from &gt;&gt;nextChild) in the search tree.parent - is the node from which my deduction was made. "thus" DeductionSearchables have "parents" which are many ancestors away.exhausted - I can't make any more children.noMoreResults - I, and none of my descendants, will ever return more results, as I am a DeductionSearchable with a failed if-clause.searchType - can be #none (not searched yet or search has gone past this node), #breadthFirst or #depthFirst. This was added to prevent depth-first search backtracking into breadth-first nodes.threadIdentifier - used in (fork:) hints. </body>
</comment>

<class>
<name>ImportListSearchable</name>
<environment>Smalltalk</environment>
<super>Searchable</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>currentImportIndex parentPremiseNum state nextImport rootImportIndex rootModule </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>ImportListSearchable</class-id>
<body>I return a bunch of ExportUnificationSearchables and UnificationSearchables, one for each module import.I'm made by a DeductionSearchable for each premise of an if-then rule.Import logic works as follows. To find a statement matching a query or premise, the following places are searched: * The current module.* Exported statements from the current module's imports.* The root module.* Exported statements from the root module's imports.* The module I test, if my module is a test module.if-then rules are not imported. If the conclusion of an if-then statement is matched, then the search follows the logic above with the current module being the module containing the if-then statement.The implementation is as follows. An ImportListSearchable will spawn:* A UnificationSearchable for the current module.* An ExportUnificationSearchable for each import of the current module.* A UnificationSearchable for the root module.* An ExportUnificationSearchable for each import of the root module.* A UnificationSearchable for testing my module's test target.So the search tree looks like this:ImportListSearchable	- UnificationSearchables...	- ExportUnificationSearchables, one per module each with		- ImportSimpleSearchers (to find simple matches)			* uses a MatchingGoalModuleSearcher		- ImportIfThenSearchers (to find if-then matches).			* uses a MatchingSimpleModuleSearcherTODO: - Don't always make me. Add a flag to a clause that says whether that clause is exported; if not then just make a UnificationSearchable.</body>
</comment>

<class>
<name>FaishStatementComponent</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>baked sid </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>FaishStatementComponent</class-id>
<body>I am the abstract superclass of FaishStatement, FaishVariable, FaishAtom.</body>
</comment>

<class>
<name>NotImplementedError</name>
<environment>Smalltalk</environment>
<super>Core.Error</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish-Exceptions</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<class>
<name>PriorityQueue</name>
<environment>Smalltalk</environment>
<super>Core.SortedCollection</super>
<private>false</private>
<indexed-type>objects</indexed-type>
<inst-vars>sizeLimit </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>PriorityQueue</class-id>
<body>A priority queue is a collection whereby an insert will put an element in the appropriate sorted position, and a retrieve will retrieve the element at the end of the queue.Effectively, I'm currently just a renamed SortedCollection with a maximum size limit. In the future I could be optimized to use a specilialized data structure.</body>
</comment>

<class>
<name>IteratorLiteral</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>next searcher value </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>IteratorLiteral</class-id>
<body>I'm used by some built-ins. I'm also a garbage collector's nightmare.I store a Searcher. &gt;&gt;value will return my value. It will return the same value each time.&gt;&gt;next will return another of me which has the next value of the searcher. It will return the same iterator each time.If value is nil, then I'm the last item in this iterator's sequence and &gt;&gt;isLast will return true.</body>
</comment>

<class>
<name>ForkSearchable</name>
<environment>Smalltalk</environment>
<super>Searchable</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>forkArray nextIndex </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>ForkSearchable</class-id>
<body>A ForkSearchable just makes a copy of its parent. Why? Read on...One of the available execution hints is "fork:", which is given an array. The array can contain anything. The VM then has the optional ability to create a new process/thread for each element in that array.After the fork, hints have the form:hint:(	statement:_	node:_	thread:Thread	relayIn:_	relayOut:_	advice:_ )?Here, Thread is one of the elements in the array. You can use this to differentiate between threads of execution in the same way as using the return value from fork().My children are just copies of my parent but with the threadIdentifier (in my superclass) set to an element of this array.</body>
</comment>

<class>
<name>ModuleSearcher</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>index goal position </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>ModuleSearcher</class-id>
<body>I am an interator over the Faish memory. I have a goal (a FaishStatement), and I iterate once over the entire memory returning whichever statements match that goal.Usually you'd want one of my subclasses.builtInsSearcher is a special searcher that first searches for built-in statements (n:plus:result: etc). In the future, it will be replaced with something faster, like a flag on premises if they match a built-in.goal is the statement I'm looking for.index is a module or array. It understands &gt;&gt;at: and &gt;&gt;size.position is my current position in the index.(TODO: 'index' is an ambiguous and slightly confusing name. Maybe use 'catalog'?)</body>
</comment>

<class>
<name>MatchingModuleSearcher</name>
<environment>Smalltalk</environment>
<super>ModuleSearcher</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>MatchingModuleSearcher</class-id>
<body>I find statements that match my goal, or whose conclusion will match my goal.</body>
</comment>

<class>
<name>MatchingSimpleModuleSearcher</name>
<environment>Smalltalk</environment>
<super>MatchingModuleSearcher</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>MatchingSimpleModuleSearcher</class-id>
<body>See ImportListSearchable comment for an overall picture of where I fit in.I am a MatchingMemorySearcher that does not return if:then: statements.</body>
</comment>

<class>
<name>FaishAtom</name>
<environment>Smalltalk</environment>
<super>FaishStatementComponent</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>value </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>FaishAtom</class-id>
<body>A FaishAtom is kind of like a Symbol. It represents a named concept.TODO: these should have contexts of some sort; some atoms will have the same name but different meanings depending on context. Use namespaces of some sort perhaps?</body>
</comment>

<class>
<name>ExceededSteps</name>
<environment>Smalltalk</environment>
<super>ErrorResult</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<class>
<name>ReadableNetworkError</name>
<environment>Smalltalk</environment>
<super>Core.Error</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>message </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<class>
<name>BetterHttpClient</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>BetterHttpClient</class-id>
<body>The standard HttpClient is fucked up. Exceptions are all over the place and unpresentable to the user. The contents don't even work.</body>
</comment>

<class>
<name>UnificationSearchable</name>
<environment>Smalltalk</environment>
<super>Searchable</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>moduleSearcher parentPremiseNum </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>UnificationSearchable</class-id>
<body>I can be searched on to unify clauses.Breadth: all memory clauses.Depth: number of variables in goalI am a very broad search, with the depth of the search tree being equal to the number of variables in the clause's goal and the breadth equal to the number of unifyable clauses in memory. Searching breadth-wise will search through all possible values for one unifyable variable. Searching depth-wise will start finding combinations for another variable. I try to unify goals. If the clause to be unified is "simple" (i.e. just like "a:X b:Y" without "if: then:" rules) then the whole clause is the goal. If the clause is "complex" ("if:(...) if:(...) then:(...)") then we pay attention to the variables in the "then:" clauses.</body>
</comment>

<class>
<name>FaishFloatArray</name>
<environment>Smalltalk</environment>
<super>Core.Array</super>
<private>false</private>
<indexed-type>objects</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>FaishFloatArray</class-id>
<body>If there is an actual float array in VW, I'd prefer to use that. Otherwise - here's a float array. Just remember to put only floats in it.</body>
</comment>

<class>
<name>FaishTODO</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>Faish.FaishTODO</class-id>
<body>TODO:0.5:* New compiler, LLVM?	1. Write IR as text to a file.	2. Compile and use to bootstrap a compiler.* Language server for MS Code.* Debugging symbols?Before 0.4 Release:* Move source of truth to files.* Make a parser, in Squl, that can load a whole file. Maybe cheat.* Built-ins for the new parser.* Get the debugger working for the new parser. (but how do you type in queries?)* Use a new file format. Imports can be statements.* (error ["Foo] )* (trace ["Foo] )* Built-in for determining how many clauses a then-if statement has.- noResults:() turns all variables into variable literals... including if they are in the outer statement. It should not contain non-literal variables before execution.- then:( test:X ) ... should be a test.- [	module] makes a module literal you can't add to.- DeductionBrowser needs to show hints subqueries, built-ins subqueries.- New compiler- Collections- Few changes to VM, just make it stable.- Implement custom heuristics- Write some tests for node culling.- Bug: Between depth-first and breadth-first, things seem to be searched twice. Test this.- Tests:	- adding to a statement doesn't affect the original.	- adding to a module doesn't affect the original.- New deduction tests:	- That D-node clauses are executed first breadth-first, then depth-first in order.	- That D-node clauses are executed in an order.	- That disproven D-node clauses will stop a pointless deduction.- Convert TestModuleBuiltins to a test module ("Builtins-Test Tests").if:- Implement Test Suites.Before 0.3 release (0.3 release has been aborted in preference for new language):* Exporting then importing modules screws up literals containing newlines.   - Won't fix - move source of truth to files. Only load them.- DoNotFailSearchables are not good. I don't understand what they should do. There must be a better way to not have DeductionSearchables cull on incomplete buit-ins. (DONE)- Character literals with square brackets broken.- When pre-loading hints and built-ins, every then-if clause also needs checking.	(code written. Needs testing.)- More testing on the import stuff. Did I get it all right?- Test importing a module from a file and having its imports load correctly.- Hints tests- Rename "index" to "catalog" (done in a few places).- DeductionBrowser bugs: 	- if the same import occurs twice in the module, the deduction browser can't handle it. (fix: don't allow the same module to be imported twice.)	- Built-ins happen in every imported module (fix: don't. )- Hints should allow the statement to be a statement literal. Maybe... it should always be a statement literal.- Add the hints chapter to the documentation.- DeductionSearchable culling not working any more (DONE, again).- From Squl code, newly created statements and statement signatures should be literals (DONE).- &gt;&gt;unwrap probably has bugs. e.g. unwrapping (a:X b:[\X] ) - X must be the same. Write tests.- Optimisation: built-in searches happen for every imported module. Make them only happen in the current module.Later:- Signature literals???- Proper syntax for different kinds of arrays. [|u8 1 2 3]. [|f32 32.6 38.32]. [| a:b. c:d. ].- I suspect that variables are not always equal to each other. Ununified variables should be equal when comparing statements. Perhaps make sure that the same variables within a statement occur in the same places?- If you manually make a string with a single square bracket, Faish will happily and incorrectly print it out.- Include not:(Query) results in the result list if something can be disproven.- How can we show query built-ins in the deduction browser?- Bug: time limits can't be cancelled. If you add a second time limit, the first will still fire.- &gt;&gt;childMade is not called from ExportUnificationSearchable&gt;&gt;nextChild. Is this a bug?- Optimise maximisation: use MaximisationVariables that only bind to larger values. This needs to be done at parse time.- Can Searchable-&gt;heuristic be removed? (no - it appears to be the depth.)- Profiling: count the number of steps, and how many of the steps were useless. Maybe put this in the deduction browser?- In the deduction browser, show visited-but-failed branches in a different colour. Maybe show visited branches with a number or colour so we can see where the interpreter has been?- Implement a "challenges" framework for people to try the 99 prolog puzzles on. Do this entirely in Squl.	- Make a GUI with the list of 99 challenges, and the current status of each.	- Make template modules for each which are copied when the user tries to do one.- Maybe... rename all primitive methods to be e.g. "builtinInteger:_ plus:_ result:_". $integer:~ plus:~ result:~.- TestRules&gt;&gt;testAnd: reduce the heuristic if there are no simple matches for clauses. In fact, cull the tree right there? Think about this.	- we can add metadata to if-clauses to say whether they do or don't have a match. This can be "compiled" beforehand.	- but "then:X if..." is always a match?- Tests: Also export test module when exporting a module.	- or maybe tests should be inline with the code. A CodeModule will create a compiled version to run.* Split up UI code from engine code; communicate using a socket.* Better canvas.	* Use micrometers for subcanvas.	* Properly define the subcanvas API - or rename it to simplecanvas.* Only give modules builtin access if an import matches the right UUID	- Ditto for builtins. See my airport notes.	- Probably better to use special metadata rather than imports. Then we can give the user "Not supported" errors. But then we miss out on nice documentation.	module:thisModule metadata:(useBuiltins:core uuid:["fodubade]).	module:thisModule metadata:(activateAPI:simplecanvas uuid:["detuyucha]).	* Change primitive implementation: must import a module to enable them.	- implementation must match a module UUID.	- Create a special module class.	- Module might be an actual module that also gives metadata and documentation.* user-defined literals	- Make a compiler in Squl.	- We probably need an array literal. [# 1 2 3]? Floats can be ints with a decimal point; ints can be [=1.3].* FaishStatement&gt;&gt;unifiedFrom:ifFail might not need to do unification twice any more.* Improve deduction UI.* Find a way of highlighting and describing special rules.	- a "specials" module? special:( syntaxError:_ position:_ ).* Filters	- split the string by colons.	- Find labels that contain the given string.	- Find atoms, variable names and string literals that contain the given string.* Read-only modules.- Debugger: Skip over solving a statement and bring me to the "thus" clause.- FaishModule&gt;&gt;add: - should not be processing special rules. - Make a benchmark.- FaishStatement&gt;&gt;unifyClause:with:ifFail seriously needs more tests.- Add context menu entry for "export statement"- In the deduction browser, add "Open rule in module".- Module view should be sorted.* allow multiple selection in some places, such as the module list.* Allow the user to type in module references. Possibly ask the user for more information.* if:(if:X then:Y) then:Z. UnificationSearchable&gt;&gt;nextChild does not make a UnificationSearchable if a DeductionSearchable is already made. - breakpoints, attached to a variable (stop when bound) or a statement (stop when matched).- logging statements- errors and exceptions? When a particular clause is evaluated (in an "impossible" situation), it can cause an error.- When opening the console or canvas, check the module and suggest the user adds particular statements.- QueryNode and a few other places use strings for queries instead of statements. Fix this.- CLI: rather than use a line to separate, old text should have a yellow background; new text should have a white background.- Use a bloom filter to check if a statement has (probably) been searched for.- Debugger: Allow the user to find the if-then statement that generated the current D node.- Debugger: Show statements being queried in the code editor.- Code editor	- Move source code into separate statements in the same module ("statement:[\~] source:["a:b.].)	- Completion; show what builtins and statements are available.	- Highlight statements that are not yet defined.- Module checking - allow users to implement their own type checking.- New Debugger (can be part of a new editor)	Make a new debugger that follows execution through the source code. Include:	- source code view that shows the current node in the stack and the variable bindings.	- a stack. child nodes remain child nodes, but a "thus..." clause will return to the parent.	- current variable bindings (reverse-engineer them?).	- buttons/keybindings for "next clause", "into", "try another match", "go up the stack".		- "next" and "prev"			- on a then-clause or stand-alone statement, cycle through statements matching the parent.			- on an if-clause, cycle through the if-clauses.		- "into" 			- on a then-clause, select an if-clause.			- on an if-clause, select a matching statement.			- on a stand-alone statement, unify with parent (actually makes the cursor go left).			- probably have two U-nodes in succession as well.		- "Go up the stack" - select the parent node so other options can be explored or backtracked.	- ability to set breakpoints on variables, clauses and statements.	- ability to set watches on variables.- New editor (see http://gulik.pbworks.com page "FaishIDE").- Allow clauses without labels. (process:P :[+14] :[+32] ). (DONE)- Put source code in adjacent modules. Remove all strings from FaishStatement.- Implement depth limits properly in the deduction browser.- bug: the deduction browser can't handle generated statements. Labels (signatures) are generated, and the label generated by the builtins are different each time they're made. No idea how to fix this.	The deduction browser works by doing one step, and then searching for that statement by equality comparisons. Can I find things by index rather than comparing statements? - Warn if a deduction fails because of a non-ground then/if clause.Later:* Rewrite in C.	* Add a LLVM device and Squl compiler in Squl.	* Add MPI support* Implement RL-Glue (unfortunately a dead project. Google has a new one.)* TCP/IP network support (client and server) (see protocol.rst in the notes)* Fancy statements	- statements with self-referential loops.	- deduction where a clause with unbound variables is taken away and matched: other instances of it in the parent statement should also be matched.	- Treat if-then rules as simple statements too.	- if:(...) then:(if:(a:b) then:(c:d)).- Deployment	- Stand-alone client (canvas) for deployment.	- Unix-based client for scripting (?)- How do you do concurrent modifications to an array?	- don't use arrays. Use something else, like an array tree.</body>
</comment>

<class>
<name>BreadthFirstSearchNode</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>target children leafNode </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>BreadthFirstSearchNode</class-id>
<body>I'm a node in the breadth first search of the Searcher. The searcher has a breadth-first search at the root.I wrap searchables. My target is a searchable.Terminology:* A search branch "fails" if no sub-branch or sub-node has found any results, at all.* A search branch "gives up" if a limit of some sort is reached. Here we use a depth limit.* A search branch is "culled" when it is found to be a branch that will never find any solution. Culling means removing that branch from our search altogether. This can happen on search advice from metadata or if a DeductionSearchable has a failed clause.Each of me has a depth-first search hanging off it, from my target. If a depth-first search "gives up", leafNode is set to the leaf node of that search so it can be resumed again later or culled.IIRC, I only keep children so they can be culled if need be.</body>
</comment>

<class>
<name>BuiltInsSearchable</name>
<environment>Smalltalk</environment>
<super>UnificationSearchable</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>exhausted </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>BuiltInsSearchable</class-id>
<body>I am a companion to the MemorySearcher. The memory searcher asks me first if the goal is a built-in statement.All of the built-ins are in the &gt;&gt;initialize method on my class side.</body>
</comment>

<class>
<name>FaishLiteral</name>
<environment>Smalltalk</environment>
<super>FaishStatementComponent</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>value </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>FaishLiteral</class-id>
<body>I hold literals, such as Strings, Integers, Floats. </body>
</comment>

<class>
<name>MaximisationSearchable</name>
<environment>Smalltalk</environment>
<super>UnificationSearchable</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>maximiseVariable </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<class>
<name>AbstractModule</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>axioms deductions name imports uuid modified errors cache readOnly needsReset </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>AbstractModule</class-id>
<body>I contain a lot of FaishStatements and I can work with them to make conclusions.Almost all of my state can be stored in my statements - for example, my name, my list of imports etc.Imports========I can "import" other modules. That means that the exported contents of those other modules are available to any deduction using me. These other modules are "software dependencies". Normally, these are just instances in the "imports" list. When I am written to a file or network stream, these are referred to by IDs instead of just using object pointers.IDs======IDs and handles are only used for writing modules to streams and locating/reading them again afterwards. If your modules live in, for example, a distributed Smalltalk image, these artifacts are not needed as modules can reference each other using object references.My "UUID" is actually an MD5 digest of my serialized (human readable, VCS tool usable) contents. It is used to make filenames for modules in repositories (so they can be quickly located by ID) and to help with module imports. Modules import specific versions of other modules, and the digest ensures that the other module has not been modified before being imported. The rationale behind this is to put the responsibility of upgrading software dependencies on the programmer rather than the users.When I'm serialized to a file or a stream over the network, my own ID (an MD5 digest) and the IDs of all imports are written out to the file. These are written in what is effectively a header and are excluded from the MD5 calculation for obvious reasons.At initialization, I'm given a random ID. This is a placeholder until I have contents to generate an actual ID from. The actual ID will be generated when &gt;&gt;writeOn: is used. Modules are, however, mutable, and during development of a module, the contents and thus the ID might change. Instead of recalculating the ID (the MD5 digest) of myself, which is an expensive operation, I just set a "modified" flag. If either I am serialized (using &gt;&gt;writeOn:) or something that refers to me is serialized, my ID / MD5 is recalculated. If I have been modified, I might need to be added to a repository if some depender on me is written out.Errors=========Reading a module from a stream should always succeed. If there are errors, they are kept in my "errors" instvar for later resolution.Possible errors include:- Syntax errors.	- Malformed statement	- Mismatched Squl version.	- End of file reached too early or too late.- Trying to add the same statement twice.- Cannot find an import.- Mismatching MD5 digest.- Invalid UTF-8 sequence.- File too largeTODO: Add a nice UI for handling each of these cases.TODO: Optimisation: have two areas: public (exported) and private. UnificationSearchable searches both. ExportUnificationSearchable only searches public.</body>
</comment>

<class>
<name>LegacyModule</name>
<environment>Smalltalk</environment>
<super>AbstractModule</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>testModule </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>LegacyModule</class-id>
<body>Deprecated. This class is for Faish v0.3 code, which used labels and values e.g. then:( ... )if:( ...).I store Squl as manually entered by humans.testModule is a reference to a TestModule which contains tests for me; it is only used for development. Its value is usually nil until a developer asks for the test module. Then I query "metadata:(testModule:X name:Y uri:Z) module:[	me]?" on myself and download whatever the user has just asked for.</body>
</comment>

<class>
<name>MatchingUnunifiedModuleSearcher</name>
<environment>Smalltalk</environment>
<super>MatchingModuleSearcher</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<class>
<name>LegacyFaishStatement</name>
<environment>Smalltalk</environment>
<super>FaishStatementComponent</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>args truth source evaluationOrder hintsAvailable importsAvailable </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>LegacyFaishStatement</class-id>
<body>I represent a statement. A statement is an unordered collection of label:value pairs. Labels are Symbols. Values can be names of variables, atoms, basic types (integers, strings, etc) or other statements.FaishStatements are immutable. Operations will return a new FaishStatement.TODO: Move parsing stuff out to another class.	- Better idea. Move it into Faish code!hintsAvailable: Whether there are executions hints that would match this statement. Otherwise skip hints. This is ignored for sub-statements that are not if-clauses.importsAvailable: Whether it is worthwhile searching imported modules (i.e. if anything is exported that would match this statement). Otherwise skip searching imports. This is ignored for sub-statements that are not if-clauses.</body>
</comment>

<class>
<name>OnlyOnceDo</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>block oneShot </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>OnlyOnceDo</class-id>
<body>Only perform the provided block once. Any further invocations of do: will do nothing.</body>
</comment>

<class>
<name>DeductionSearchable</name>
<environment>Smalltalk</environment>
<super>Searchable</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>premiseNum premiseCount isThus origStatement done </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>DeductionSearchable</class-id>
<body>I return one UnificationSearchable for each premise of an if-then statement. After that, I return a ImportListSearchable for each premise.premiseHasSearcher is a private boolean array. If an entry is true, I've already made a searcher for that premise. This is needed because hints can make premises in any order. It is not copied to childs.</body>
</comment>

<class>
<name>BrokenModuleSearcher</name>
<environment>Smalltalk</environment>
<super>ModuleSearcher</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>error </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>BrokenModuleSearcher</class-id>
<body>I'm used to relay an error to the user. Currently these errors are caused by malformed hints.</body>
</comment>

<class>
<name>UnificationSearchableFinished</name>
<environment>Smalltalk</environment>
<super>Searchable</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>UnificationSearchableFinished</class-id>
<body>I'm a placeholder for a goal when a UnificationSearchable finds an answer by itself without using a DeductionSearchable.I get used when very simple queries are made, e.g. father: a of: b.father: X of: b?I do not return results found using a DeductionSearchable. I only appear at the top level of the search tree.</body>
</comment>

<class>
<name>ModuleImport</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>module handle id name description repository </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>ModuleImport</class-id>
<body>I am stored in Faish literals as a link to another module.When a module is loaded, all its imports will be defined using statements of form "module:X metadata:(import:Y name:Z).". I occur in those statements in X and Y; I will be created firstly with a handle, then when the handles are resolved I will be given an ID, then finally the ID will be resolved into an actual module link, possibly by downloading that module.</body>
</comment>

<class>
<name>LegacyCacheModule</name>
<environment>Smalltalk</environment>
<super>LegacyModule</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>LegacyCacheModule</class-id>
<body>I am a module that self-limits how many statements I store. TODO: I need work. Anything that used me need to be re-written.Typical uses for me:	- Caches / memoization containers (size limited, discard unused)	- I/O, running instances (size limited, discard old (or unused?))	- Evolution chambres (size limited, discard unused).</body>
</comment>

<class>
<name>FaishVariable</name>
<environment>Smalltalk</environment>
<super>FaishStatementComponent</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>value </inst-vars>
<class-inst-vars>pool </class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>FaishVariable</class-id>
<body>I just represent a variable. When I get unified, replace me with a unified variable object.</body>
</comment>

<class>
<name>ExceededDepth</name>
<environment>Smalltalk</environment>
<super>ErrorResult</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<class>
<name>ErrorSearchable</name>
<environment>Smalltalk</environment>
<super>Searchable</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>message </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>ErrorSearchable</class-id>
<body>If an error happens during a query, I'm returned with the results.</body>
</comment>

<class>
<name>ExportUnificationSearchable</name>
<environment>Smalltalk</environment>
<super>UnificationSearchable</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>exportedModule </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>ExportUnificationSearchable</class-id>
<body>See ImportListSearchable comment for an overall picture of where I fit in.I am a UnificationSearchable, except that I'm searching in an import of some module. I only consider exported statements. For simple statements, my children will be made using the same behaviour as a UnificationSearchable.If the exported statement is an if-then statement, then two DeductionSearchables will be returned. One will be in the scope of the originating (importing) module, and the other will be in the scope of the imported module.</body>
</comment>

<class>
<name>EqualityMemorySearcher</name>
<environment>Smalltalk</environment>
<super>ModuleSearcher</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>EqualityMemorySearcher</class-id>
<body>I search memory testing whether it contains a statement equal to my goal (using &gt;&gt;=).</body>
</comment>

<class>
<name>DeductionError</name>
<environment>Smalltalk</environment>
<super>Core.Error</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish-Exceptions</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<class>
<name>LegacyFaishStatementSignature</name>
<environment>Smalltalk</environment>
<super>LegacyFaishStatement</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>LegacyFaishStatementSignature</class-id>
<body>I'm a statement signature. For example, the statement (a:b c:(d:e) ) has a signature of (a:~ c:~). The value of the second argument has the signature (d:~).I am a list of clauses, each clause having a lable. You'll notice that I'm just a subclass of FaishStatement. In a real implementation, each statement would have a link to it's signature and the values of its arguments.</body>
</comment>

<class>
<name>CodeModule</name>
<environment>Smalltalk</environment>
<super>AbstractModule</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>CodeModule</class-id>
<body>I'm a general purpose Faish module. I store code.I'm the module you get when you use the built-ins in Squl to make a module.</body>
</comment>

<class>
<name>Searcher</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>depthLimit keepGoing stepLimit duplicates wasStopped hasMoreResults currentNode breadthFirstQueue currentSearchDepthLimit timeLimit timerStarted </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Faish</category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>Searcher</class-id>
<body>I am a search algorith on the deduction tree.To use me, on a FaishModule do a query (FaishModule&gt;&gt;query:, pass a string). I will be the result. You should then invoke &gt;&gt;next on me repeatedly to get results.I return:	- a FaishStatement for a result.	- nil if there was a problem:		* Use &gt;&gt;hasMoreResults to determine if there are more results.		* Use &gt;&gt;wasDuplicate to determine if the last nil was just because a value was duplicated.		* Use &gt;&gt;wasStopped to determine if some limit (steps, time or depth) made me stop. currentNode is the node we are currently searching.revertNode is the "root node", although it might not be the root node if we do are doing a consult-the-metadata search. revertNode is a BreadthFirstSearchNode wrapping a Searchable.&gt;&gt;wasDuplicate has been implemented to prevent me getting stuck in a loop finding continual duplicated values.I seach through UnificationSearchables, DeductionSearchables and ImportListSearchables. I initially investigate DeductionSearchables to determine clause order. I will detect pointless search branches and cull them.In this version, UnificationSearchables and ImportListSearchables are not treated specially. Yet. Eventually I hope to improve the performance of UnificationSearchables and ImportListSearchables by asking metadata, which has access to indexes, past usage data and so forth.When you have a ( then:~ if:A if:B if:C ), and if A has been given up on after a heuristic becomes too low, and if B proves to be false, then all other child deductions (in this case, only A) will be aborted. This is done by having an array of pointers in the DeductionSearchable, one for each clause. In Exploit mode, a clauses' pointer will point to the leaf of that depth-first deduction, which can then be quickly culled by recursing back to self. If some child node is in Explore mode, then the pointer will point to that instead. When a D-node is in Explore mode, each clauses' pointer will point to each child.If several processes are executing a statement, then a clauses' pointer will somehow provide a mechanism to halt the other statement (possibly by sending an MPI message, which sets a flag, which the other process regularly checks. Or something). AskTheMetadata mode is just like Exploit mode, except that we ask statement metadata for the statement evaluation order. This could also include whether this statement can be evaluated across multiple processes and how to divvy the work. It could also determine that this branch is already a dead branch and abort the search.I am stateful: I should not be shared between threads. </body>
</comment>

<class>
<name>DoNotFailSearchable</name>
<environment>Smalltalk</environment>
<super>Searchable</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish</package>
</attributes>
</class>

<comment>
<class-id>DoNotFailSearchable</class-id>
<body>I am made as a search result when a BuiltIn fails because it had too many variables in it.If a built-in 'fails' because there were too many variables, then it would cause a parent DeductionSearchable to fail completely because one of its children has failed. If the children were implemented in a different order, then a result might have been found instead.This is the solution, albeit a bit hacky. I return myself as a nextChild forming an infinite tree branch. It should never be explored more than one step in because &gt;&gt;isWorthExploringPastDepth: will always return false.</body>
</comment>

<shared-variable>
<name>NextId</name>
<environment>BuiltInsSearchable</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>


<shared-variable>
<name>StatementsBuiltIn</name>
<environment>BuiltInsSearchable</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>



<shared-variable>
<name>state</name>
<environment>FaishAtom</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>



<shared-variable>
<name>Instance</name>
<environment>DoNotFailSearchable</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>



<shared-variable>
<name>Fail</name>
<environment>SearchResult</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>


<shared-variable>
<name>NoFail</name>
<environment>SearchResult</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>



<shared-variable>
<name>Instance</name>
<environment>ExceededSteps</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>



<shared-variable>
<name>StatementExport</name>
<environment>AbstractModule</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>


<shared-variable>
<name>StatementImport</name>
<environment>AbstractModule</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>


<shared-variable>
<name>StatementModuleName</name>
<environment>AbstractModule</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>



<shared-variable>
<name>Comparibles</name>
<environment>FaishLiteral</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>



<shared-variable>
<name>BasicLiteralTypes</name>
<environment>LegacyFaishStatement</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>


<shared-variable>
<name>readValueCase</name>
<environment>LegacyFaishStatement</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>



<shared-variable>
<name>Instance</name>
<environment>ExceededDepth</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish</package>
</attributes>
</shared-variable>



<methods>
<class-id>ErrorResult</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>

<methods>
<class-id>ErrorResult</class-id> <category>printing</category>

<body package="Faish" selector="printDebugOn:limit:">printDebugOn: str limit: n	^ self printOn: str.</body>

<body package="Faish" selector="printOn:">printOn: str 	self subclassResponsibility.</body>

<body package="Faish" selector="editString">editString	^ self printString.</body>
</methods>

<methods>
<class-id>ErrorResult</class-id> <category>testing</category>

<body package="Faish" selector="isStatement">isStatement	^ false.</body>
</methods>

<methods>
<class-id>ErrorResult</class-id> <category>pretending to be a statement</category>

<body package="Faish" selector="usefulness">usefulness 	^ 0.</body>

<body package="Faish" selector="statement">statement 	^ nil</body>

<body package="Faish" selector="bake">bake</body>
</methods>


<methods>
<class-id>ExceededTime</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: str 	str nextPutAll: 'Time exceeded or search halted by user.'.</body>
</methods>


<methods>
<class-id>SearchResult class</class-id> <category>class initialization</category>

<body package="Faish" selector="initialize">initialize	Fail := self new statement: nil; type: #fail.	NoFail := self new statement: nil; type: #noFail.</body>
</methods>

<methods>
<class-id>SearchResult class</class-id> <category>instance creation</category>

<body package="Faish" selector="errorResult:">errorResult: r	^ self new 		type: #error;		statement: r.</body>

<body package="Faish" selector="result:">result: r	^ self new 		type: #result;		statement: r.</body>

<body package="Faish" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>

<body package="Faish" selector="fail">fail	Fail isNil ifTrue: [ self initialize ].	^ Fail.</body>

<body package="Faish" selector="noFail">noFail	NoFail isNil ifTrue: [ self initialize ].	^ NoFail.</body>
</methods>


<methods>
<class-id>SearchResult</class-id> <category>accessing</category>

<body package="Faish" selector="statement:">statement: s	statement := s.</body>

<body package="Faish" selector="isResult">isResult	^ (statement isNil not and: [ type ~= #error ]) and: [ statement isVariable not ].</body>

<body package="Faish" selector="statement">statement	^ statement.</body>

<body package="Faish" selector="type">type	^type</body>

<body package="Faish" selector="isNoFail">isNoFail	^ type = #noFail.</body>

<body package="Faish" selector="type:">type: aSymbol	" Can be:		#fail -&gt; statement is nil, no results will ever be found.		#noFail -&gt; statement is nil, but results could be found had there been more populated variables (used by builtins).		#error -&gt; An error to show on the screen instead of a result. 		#result -&gt; there is a result! "	type := aSymbol.</body>

<body package="Faish" selector="isFail">isFail	^ type = #fail.</body>
</methods>

<methods>
<class-id>SearchResult</class-id> <category>testing</category>

<body package="Faish" selector="isError">isError	^ type = #error.</body>
</methods>

<methods>
<class-id>SearchResult</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	super initialize.	type := nil.	statement := nil.	^self</body>
</methods>


<methods>
<class-id>Searchable class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>


<methods>
<class-id>Searchable</class-id> <category>comparing</category>

<body package="Faish" selector="=">= another	(self statement = another statement) ifFalse: [ ^ false ].	(self module = another module) ifFalse: [ ^ false ].	(self depth = another depth) ifFalse: [ ^ false ].	(self class == another class) ifFalse: [ ^ false ].	^ true.</body>

<body package="Faish" selector="mostlyEquals:">mostlyEquals: another	(self class == another class) ifFalse: [ ^ false ].	((self statement) mostlyEquals: (another statement)) ifFalse: [ ^ false ].	(self module = another module) ifFalse: [ ^ false ].	(depth = another depth) ifFalse: [ ^ false ].	^ true.</body>

<body package="Faish" selector="hash">hash	" TODO: better hashing. "	^ self goal hash + self module hash + self depth hash.</body>
</methods>

<methods>
<class-id>Searchable</class-id> <category>accessing</category>

<body package="Faish" selector="depthFirstChild">depthFirstChild	^ depthFirstChild.</body>

<body package="Faish" selector="statement">statement	^ goal.</body>

<body package="Faish" selector="wasOriginallyParentOf:">wasOriginallyParentOf: anotherNode	^ false</body>

<body package="Faish" selector="depthFirstChild:">depthFirstChild: c	" The depth-first-search tree needs to be navigable in both directions so that nodes can be stolen for breadth-first searches. "	(depthFirstChild isNil not and: [ c isNil not ]) ifTrue: [ self halt. ].	depthFirstChild := c.</body>

<body package="Faish" selector="derivedFrom:">derivedFrom: aSearchable	" I exist to recurse back from the solution at a leaf of the search tree back to the root to increment the usefulness of all statements that were used to derive that solution. I'm usually equal to parent unless unification happened. "	(aSearchable==self) ifTrue: [ self halt ].	derivedFrom := aSearchable.	depth := aSearchable depth + 1.</body>

<body package="Faish" selector="searchType:">searchType: st	searchType := st.</body>

<body package="Faish" selector="module:">module: aModule	module := aModule.</body>

<body package="Faish" selector="module">module	" DeductionSearchables ask their parents for the module. "	^ module</body>

<body package="Faish" selector="origStatement"> origStatement	^ self subclassResponsibility. " but not all subclasses need this. "</body>

<body package="Faish" selector="relay">relay		^ relay</body>

<body package="Faish" selector="stealDepthFirstChild">stealDepthFirstChild	| result |	self isDead ifTrue: [ ^ nil ].	result := depthFirstChild.	depthFirstChild := nil.	^ result.</body>

<body package="Faish" selector="threadIdentifier:">threadIdentifier: newForkId	threadIdentifier := newForkId.</body>

<body package="Faish" selector="copy">copy	^ self class new copyFrom: self.</body>

<body package="Faish" selector="parent">parent	" Return... a parent. This is not the previous item in the search tree and is difficult to explain.	Usually I do refer to the previous item in the search tree. However, when a statement is fully unified, the next step is to find the prior DeductionSearchable that made the UnificationSearchable, which then becomes the parent instead. I.e. when a unification for a clause is found, the parent of that search step is actually whichever grandparent was trying to find a unified value for its clause."	^ parent.</body>

<body package="Faish" selector="notifyNextOfKin">notifyNextOfKin	" After I've been culled, my parent needs to be informed. Specifically, a DeductionSearchable has failed if a child has failed, so we need to notify it of a child's failure. "	parent isNil ifFalse: [ parent aChildHasFailed ].</body>

<body package="Faish" selector="aChildHasFailed">aChildHasFailed	" We are being notified that a child node failed. Subclasses implement me. "</body>

<body package="Faish" selector="derivedFrom">derivedFrom	^ derivedFrom.</body>

<body package="Faish" selector="isWorthExploringPastDepth:">isWorthExploringPastDepth: d	^ depth &lt; d.</body>

<body package="Faish" selector="rootModule">rootModule	"Return the module right at the top of the search hierarchy."	parent isNil ifTrue: [ ^ nil ].	^ parent rootModule.</body>

<body package="Faish" selector="searchType">searchType	" I return #none, #breadthFirst, #depthFirst, #dead. "	^ searchType.</body>
</methods>

<methods>
<class-id>Searchable</class-id> <category>testing</category>

<body package="Faish" selector="isError">isError	^ false.</body>
</methods>

<methods>
<class-id>Searchable</class-id> <category>private</category>

<body package="Faish" selector="errorNode:">errorNode: message	^ ErrorSearchable new		module: module;		message: message;		derivedFrom: self.</body>

<body package="Faish" selector="getHintsResult">getHintsResult	|  n  |	n := hintsSearcher nextStatement.	n isNil 		ifTrue: [ ^ nil ]		ifFalse: [ |  h  |			h := n atIndex: 1.			relay := h atIndex: 5.						^ h atIndex: 6. 		].</body>

<body package="Faish" selector="makeHintsSearcher">makeHintsSearcher	| os st inner simple  |	os := self origStatement.	os isNil ifFalse: [		os hintsAvailable ifFalse: [ ^ nil ]	].	hintsSearcher isNil ifFalse: [ ^ nil ].		st := module parseWithoutTypecheck:  '		hint:(			statement:S			node:n			thread:none			relayIn:[+0]			relayOut:Rout			advice:A )?'	onError: [ self error ].	inner := st atIndex: 1.	inner atIndex: 1 put: (goal copy bindAllVariables).		self relay isNil ifFalse: [		inner atIndex: 4 put: self relay.	].		threadIdentifier isNil ifFalse: [		inner atIndex: 3 put: threadIdentifier.	].	" Before we make a real Searcher, we first check whether there are any simple matches. The Searcher calls this method. If we don't do this, we end up back here in infinite recursion. "	simple := MatchingModuleSearcher module: module searchingFor: st.	simple nextNoFrills isResult ifTrue: [		" Okay, so we might not end up in an infinitely recursive loop. "		hintsSearcher := Searcher new query: st module: module.		hintsSearcher stepLimit: 100.	] ifFalse: [		^ nil 	].</body>

<body package="Faish" selector="hintsAreAvailable">hintsAreAvailable	^ hintsSearcher isNil not.</body>

<body package="Faish" selector="parentWhatIsDeductionSearchable">parentWhatIsDeductionSearchable	parent isNil ifTrue: [ ^ nil ].	^ parent parentWhatIsDeductionSearchable.</body>
</methods>

<methods>
<class-id>Searchable</class-id> <category>searching</category>

<body package="Faish" selector="isSuccessfull">isSuccessfull	" Some descendant of mind found an answer to the query! Don't kill DeductionSearchables! "	^ searchType = #successfull.</body>

<body package="Faish" selector="isGoal">isGoal	" Am I what was being searched for? "	self subclassResponsibility.</body>

<body package="Faish" selector="isDead">isDead	" Return whether this node or any ancestors will ever return results. "	^ (searchType = #dead).</body>

<body package="Faish" selector="isDepthFirst">isDepthFirst	^ searchType = #depthFirst.</body>

<body package="Faish" selector="makeSuccessfull">makeSuccessfull	" Some descendant of mind found an answer to the query! Don't kill DeductionSearchables! "	(searchType = #dead) ifTrue: [ self halt ].	(searchType = #breadthFirst) ifFalse: [		searchType := #successfull.	].</body>

<body package="Faish" selector="nextChild">nextChild	" I return a Searchable, which is a child node of me in a search tree. "	self subclassResponsibility</body>

<body package="Faish" selector="cull">cull	" Inform this node that it has been discovered that no branch below him will ever find a result. This can happen by consulting metadata or if a DeductionSearchable child fails. "	(searchType = #successfull) ifTrue: [ 		self halt.	].	searchType := #dead.</body>

<body package="Faish" selector="isBreadthFirst">isBreadthFirst	^ searchType = #breadthFirst.</body>
</methods>

<methods>
<class-id>Searchable</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	depth := 0.	searchType := #none.	threadIdentifier := nil.	^ super initialize.</body>

<body package="Faish" selector="depth:">depth: n	" How many DeductionSearchables are there between me and the original query?"	depth := n.</body>

<body package="Faish" selector="depth">depth	^ depth.</body>

<body package="Faish" selector="parent:">parent: anotherSearchable	anotherSearchable isNil ifFalse: [			parent := anotherSearchable.			].</body>

<body package="Faish" selector="copyFrom:">copyFrom: another	depth := another depth.	relay := another relay.</body>
</methods>

<methods>
<class-id>Searchable</class-id> <category>debugging</category>

<body package="Faish" selector="isSiblingOf:">isSiblingOf: anotherSearchable	" Used to implement 'step over' "		" This is a terrible implementation. "	^ (anotherSearchable derivedFrom origStatement = derivedFrom origStatement)</body>
</methods>

<methods>
<class-id>Searchable</class-id> <category>printing</category>

<body package="Faish" selector="printDebugString">printDebugString	| str | 	str := WriteStream on: (String new: 80).	self printDebugOn: str limit: 4000.	^ str contents.</body>

<body package="Faish" selector="printDebugOn:limit:">printDebugOn: str limit: n	| limit |	limit := n.		self statement isNil ifTrue: [		str nextPutAll: 'goal is nil (?)'	] ifFalse: [		self statement printDebugOn: str limit: limit.	].	str cr; cr; 		nextPutAll: 'This node is a ';		nextPutAll: (self class name); cr;		nextPutAll: 'Depth: ';		nextPutAll: (depth printString); cr;		nextPutAll: 'Is dead (No descendant of mine can make more children): ';		nextPutAll: (self isDead printString); cr.		origStatement isNil ifFalse: [		str cr; cr;			nextPutAll: 'Original statement properties: ['.		origStatement hintsAvailable ifTrue: [			str nextPutAll: 'hintsAvailable, '.		].		origStatement importsAvailable ifTrue: [			str nextPutAll: 'importsAvailable '.		].		str nextPutAll: ['].'].	] ifTrue: [		str cr; cr; nextPutAll: 'Original statement is nil.'	].</body>
</methods>

<methods>
<class-id>Searchable</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="goal">goal	^ goal.</body>

<body package="Faish" selector="&lt;=">&lt;= another	" Used in the BeamSearch and by DeductionSearchable. "	self halt.	^ self heuristic &lt;= another heuristic.</body>

<body package="Faish" selector="goal:">goal: aGoal		goal := aGoal.</body>

<body package="Faish" selector="sourceCode">sourceCode	^ goal sourceCode.</body>
</methods>


<methods>
<class-id>ImportListSearchable class</class-id> <category>instance creation</category>

<body package="Faish" selector="module:searchingFor:"> module:aModule searchingFor: query	" I'm used as the starting point for any query. "	| result |	result := self new module: aModule; 		goal: query;		setRootModule.	^ result.</body>

<body package="Faish" selector="module:parent:parentPremiseNum:searchingFor:derivedFrom:">module: module parent: parent parentPremiseNum: premiseNum searchingFor: findMe derivedFrom: derivedFrom	^ self new		module: module;		parent: parent;		parentPremiseNum: premiseNum;		goal: findMe;		derivedFrom: derivedFrom.</body>
</methods>


<methods>
<class-id>ImportListSearchable</class-id> <category>accessing</category>

<body package="Faish" selector="setRootModule">setRootModule	rootModule := self module.</body>

<body package="Faish" selector="statement">statement	^ self goal.</body>

<body package="Faish" selector="rootModule">rootModule	(rootModule isNil ifTrue: [ rootModule := parent rootModule ]).	^ rootModule.</body>

<body package="Faish" selector="copy">copy	^ self shallowCopy. " Override my superclass. "</body>

<body package="Faish" selector="origStatement">origStatement	" TODO: same as UnificationSearchable. Perhaps we should have a common ancestor class? "	|  p |	p := self parentWhatIsDeductionSearchable.	p isNil ifTrue: [		^ nil	] ifFalse: [		^ p originalStatementForPremiseNum: parentPremiseNum.	].</body>
</methods>

<methods>
<class-id>ImportListSearchable</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: aStream	aStream nextPutAll: 'I '.	self goal printOn: aStream limit: 40.	aStream nextPutAll: ' in ';		nextPutAll: module name printString.</body>
</methods>

<methods>
<class-id>ImportListSearchable</class-id> <category>searching</category>

<body package="Faish" selector="nextRootImport">nextRootImport	| result |	(rootImportIndex &gt; module imports size) ifTrue: [ ^ nil ].	result := module imports at: rootImportIndex.	rootImportIndex := rootImportIndex + 1.	^ result.</body>

<body package="Faish" selector="nextCurrentImport">nextCurrentImport	| result |	(currentImportIndex &gt; module imports size) ifTrue: [ ^ nil ].	result := module imports at: currentImportIndex.	currentImportIndex := currentImportIndex + 1.	^ result.</body>

<body package="Faish" selector="nextChild">nextChild	" Return the next of these four children:		1. currentU: a UnificationSearchable for the current module.		2. currentE: ExportUnificationSearchable for each of the current module's imports.		3. A UnificationSearchable for the root module.		4. rootE: A ExportUnificationSearchable for each of the root module's imports. "	| result |	 	(state = #builtIns) ifTrue: [		state := #currentU.		^ (BuiltInsSearchable			module:module			parent: self			parentPremiseNum: parentPremiseNum			searchingFor: goal)			derivedFrom: self.	].		" First try a plain UnificationSearchable on the current module. "	(state = #currentU) ifTrue: [		state := #currentE.		^ (UnificationSearchable			module: module			parent: self			parentPremiseNum: parentPremiseNum			searchingFor: goal)			derivedFrom: self.	].	" Then try an ExportUnificationSearchable for each of the current module's imports.         If that fails, go straight on to searching the root module. "	(state = #currentE) ifTrue: [		nextImport := self nextCurrentImport.		nextImport isNil ifTrue: [			" We didn't find anything, so we move directly on to searching the root module using a UnificationSearchable. "			" (state = #rootU) ifTrue: [ etc "			state := #rootE.			(self rootModule = module) ifTrue: [ 				" We are the root module, so don't search myself twice. "				^ self nextChild. 			].			^ (UnificationSearchable				module: self rootModule				parent: self				parentPremiseNum: parentPremiseNum				searchingFor: goal)				derivedFrom: self.		].		" Find in current module's imports. "		(nextImport exports: goal) ifTrue: [			result := (ExportUnificationSearchable				module: module				parent: self				parentPremiseNum: parentPremiseNum				searchingFor: goal)				derivedFrom: self.			result inExportedModule: nextImport.			^ result.				] ifFalse: [			^ self nextChild.		].	].	" Search the root module's imports using ExportUnificationSearchables. "	(state = #rootE) ifTrue: [		(self rootModule = module) ifTrue: [ 			" We are the root module, so don't search myself twice. "			state := #exhausted.			^ self nextChild. 		].		nextImport := self nextRootImport.		nextImport isNil ifTrue: [ 			" Next state: search for a test module. "			state := #exhausted.			^ self nextChild.		].		" Find in root module's imports. "		(nextImport exports: goal) ifTrue: [			result := (ExportUnificationSearchable				module: module				parent: self				parentPremiseNum: parentPremiseNum				searchingFor: goal)				derivedFrom: self.			result inExportedModule: nextImport.			^ result.				] ifFalse: [			^ self nextChild.		].			].	(state = #exhausted) ifTrue: [ 		^ nil.	].	self error: 'Coding error: state is weird.'.</body>

<body package="Faish" selector="isGoal">isGoal	^ false.</body>
</methods>

<methods>
<class-id>ImportListSearchable</class-id> <category>initialize-release</category>

<body package="Faish" selector="searchingFor:">searchingFor: findMe	goal := findMe.</body>

<body package="Faish" selector="parentPremiseNum:">parentPremiseNum: premiseNum	parentPremiseNum := premiseNum.</body>

<body package="Faish" selector="initialize">initialize	super initialize.	currentImportIndex := 1.	rootImportIndex := 1.	state := #builtIns.	^ self.</body>
</methods>


<methods>
<class-id>FaishStatementComponent class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>


<methods>
<class-id>FaishStatementComponent</class-id> <category>comparing</category>

<body package="Faish" selector="mostlyEquals:">mostlyEquals: Another	" Used for comparing statements that may contain tricksy non-comparable literals. "	self subclassResponsibility.</body>

<body package="Faish" selector="=">= another	^ self subclassResponsibility.</body>
</methods>

<methods>
<class-id>FaishStatementComponent</class-id> <category>accessing</category>

<body package="Faish" selector="bindAllVariables">bindAllVariables</body>

<body package="Faish" selector="at:">at: key	self subclassResponsibility.</body>

<body package="Faish" selector="matches:">matches: something	^ self = something.</body>

<body package="Faish" selector="sid">sid	^sid</body>

<body package="Faish" selector="unbindAllVariables">unbindAllVariables	^ self.</body>

<body package="Faish" selector="unwrap">unwrap	" Return a copy of me with statement, atom and variable literals replaced with their contents. "	^ self.</body>

<body package="Faish" selector="identityNumber">identityNumber	" Return a number indicitive of my ranking and size. "	self subclassResponsibility.</body>

<body package="Faish" selector="sid:">sid: anObject	sid := anObject</body>

<body package="Faish" selector="value">value	" To make testing easier. Tests usually call, e.g. FaishLiteral&gt;&gt;value to compare, and this will provide something that fails. "	^ self.</body>

<body package="Faish" selector="statement">statement	self halt: 'I''m not a statement.'.</body>

<body package="Faish" selector="isTrue">isTrue	^ false.</body>

<body package="Faish" selector="makeTrue">makeTrue	" See my implementation in FaishStatement. For bits of a statement, I can't be true. This applies to premises, which are assumed to be statements. "</body>

<body package="Faish" selector="truth">truth	" See FaishStatement&gt;&gt;truth. "	^ false.</body>

<body package="Faish" selector="at:ifAbsent:">at: key ifAbsent: aBlock	self subclassResponsibility.</body>
</methods>

<methods>
<class-id>FaishStatementComponent</class-id> <category>testing</category>

<body package="Faish" selector="isStatementLiteral">isStatementLiteral	^ false.</body>

<body package="Faish" selector="isIteratorLiteral">isIteratorLiteral	^ false.</body>

<body package="Faish" selector="isVariableLiteral">isVariableLiteral	^ false.</body>

<body package="Faish" selector="isUnwrappable">isUnwrappable	^ false.</body>

<body package="Faish" selector="isAtomLiteral">isAtomLiteral	^ false.</body>

<body package="Faish" selector="isLiteral">isLiteral	^ false.</body>

<body package="Faish" selector="isVariable">isVariable	^ false.</body>

<body package="Faish" selector="isCharacter">isCharacter	^ false.</body>

<body package="Faish" selector="isStatement">isStatement	^ false.</body>

<body package="Faish" selector="isInteger">isInteger	^ false.</body>

<body package="Faish" selector="isArray">isArray	^ false.</body>

<body package="Faish" selector="isFaishLiteral">isFaishLiteral	^ false.</body>

<body package="Faish" selector="isAtom">isAtom	^ false.</body>

<body package="Faish" selector="isNumber">isNumber	^ false.</body>

<body package="Faish" selector="isFullyUnified">isFullyUnified	self subclassResponsibility.</body>

<body package="Faish" selector="isString">isString	^ false.</body>

<body package="Faish" selector="isFloat">isFloat	^ false.</body>

<body package="Faish" selector="isSyntaxError">isSyntaxError	^ false.</body>

<body package="Faish" selector="isModuleLiteral">isModuleLiteral	^ false.</body>

<body package="Faish" selector="isNotMetadata">isNotMetadata	^ true.</body>
</methods>

<methods>
<class-id>FaishStatementComponent</class-id> <category>matching</category>

<body package="Faish" selector="matchesGoal:">matchesGoal: aGoal	^ self matches: aGoal.</body>
</methods>

<methods>
<class-id>FaishStatementComponent</class-id> <category>printing</category>

<body package="Faish" selector="printBracedOn:limit:">printBracedOn: aStream limit:n	(n &lt; 0) ifTrue: [ 		aStream nextPutAll: '...'.		^ -1 	].	^ self printOn: aStream limit:n.</body>

<body package="Faish" selector="printOn:limit:">printOn: aStream limit:n	(n &lt; 0) ifTrue: [ ^ -1].	self printOn: aStream.	^ n-1.</body>

<body package="Faish" selector="printWithDoubleBrackets:on:">printWithDoubleBrackets: aString on: aStream	aString do: [ :each |		aStream nextPut: (each asCharacter).	].</body>

<body package="Faish" selector="writeOn:">writeOn: aStream	self printOn: aStream.</body>
</methods>

<methods>
<class-id>FaishStatementComponent</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="wasUseful">wasUseful	" Used in a FaishStatement to mark statements as useful for later heuristics. "</body>

<body package="Faish" selector="copyPreserveVariables">copyPreserveVariables	" Private method. If I'm not a statement, then it is harmless to use myself instead of a copy. If I'm a variable, then I need to return self rather than make a copy. "	^ self.</body>

<body package="Faish" selector="bake">bake	" baked is either nil or true. "	baked := true.</body>

<body package="Faish" selector="heuristic">heuristic	" The magic number is approximately proportional to my size and depth. It is used for sorting and hashing. "	self subclassResponsibility.</body>

<body package="Faish" selector="&lt;=">&lt;= another	^ self identityNumber &lt;= another identityNumber.</body>

<body package="Faish" selector="hash">hash	^ self identityNumber hash.</body>

<body package="Faish" selector="baked">baked	" baked is either nil or true. "	^ true == baked.</body>

<body package="Faish" selector="recurseWith:atEachLevel:">recurseWith: x atEachLevel: aBlock	" See FaishStatement&gt;&gt;recurseWith:atEachLevel: "	aBlock value: self value: x.</body>

<body package="Faish" selector="recurseWith:atEachLevel:ifFail:">recurseWith: x atEachLevel: aBlock ifFail: failBlock	" See FaishStatement&gt;&gt;recurseWith:atEachLevel: "	self isAtom ifTrue: [ 		x isAtom ifTrue: [ 			(self = x) ifFalse: [ ^ failBlock value ].		] ifFalse: [ 			x isVariable ifFalse: [ ^ failBlock value ] 		].	].	self isLiteral ifTrue: [ 		x isLiteral ifTrue: [ 			(self = x) ifFalse: [ ^ failBlock value ].		] ifFalse: [ 			x isVariable ifFalse: [ ^ failBlock value ] 		].	].	aBlock value: self value: x.</body>

<body package="Faish" selector="copy">copy	^ self subclassResponsibility.</body>

<body package="Faish" selector="copyUsingVariableMapping:">copyUsingVariableMapping: mapping	^ self copy.</body>

<body package="Faish" selector="recurse:">recurse: aBlock	" See FaishStatement&gt;&gt;recurse: "	aBlock value: self.</body>
</methods>


<methods>
<class-id>PriorityQueue</class-id> <category>adding</category>

<body package="Faish" selector="pop">pop	" Remove the highest ranking item. "	^ super last.</body>

<body package="Faish" selector="sizeLimit:">sizeLimit: n	sizeLimit := n.</body>

<body package="Faish" selector="add:">add: element	(self size &gt; sizeLimit) ifTrue: [ self removeFirst ].	^ super add: element.</body>
</methods>

<methods>
<class-id>PriorityQueue</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	sizeLimit := 100.	^self</body>
</methods>


<methods>
<class-id>IteratorLiteral class</class-id> <category>instance creation</category>

<body package="Faish" selector="searcher:">searcher: aSearcher	^super new initializeFrom: aSearcher.</body>
</methods>


<methods>
<class-id>IteratorLiteral</class-id> <category>comparing</category>

<body package="Faish" selector="=">= another	" TODO: do I need to implement &gt;&gt;hash as well? VW won't let me. "	^ (self value = another value) and: [ self searcher = another searcher ].</body>
</methods>

<methods>
<class-id>IteratorLiteral</class-id> <category>accessing</category>

<body package="Faish" selector="searcher">searcher	^ searcher</body>

<body package="Faish" selector="isLast">isLast	^ value == nil.</body>

<body package="Faish" selector="value">value	^ value.</body>

<body package="Faish" selector="next">next	next isNil ifTrue: [ 		" Make the next iterator only when requested. "		value isNil ifTrue: [ 			" Then we are the last iterator. "			^ self.		].		next := self class searcher: searcher. 	].	^ next.</body>
</methods>

<methods>
<class-id>IteratorLiteral</class-id> <category>initialize-release</category>

<body package="Faish" selector="initializeFrom:">initializeFrom: aSearcher	| v |	v := aSearcher nextStatement.	v isNil ifFalse: [ 		value := v copy bindAllVariables bake.	].	searcher := aSearcher.	^ self.</body>
</methods>


<methods>
<class-id>ForkSearchable</class-id> <category>accessing</category>

<body package="Faish" selector="forkArray:">forkArray: a	forkArray := a.</body>

<body package="Faish" selector="nextThreadIdentifier">nextThreadIdentifier	nextIndex := nextIndex + 1.	(nextIndex &gt; forkArray size) ifTrue: [ 		^ nil.	].	^ forkArray at: nextIndex.</body>

<body package="Faish" selector="goal">goal	" *** This method was defined by Searchable as a subclass responsibility.	Replace its body with a proper implementation. *** "	self error: 'Subclass responsibility stub not reimplemented'</body>

<body package="Faish" selector="origStatement">origStatement	" The original statement is the statement in the module from which my goal is derived. Usually my goal has had some unification done. It is stored here so that it can have its usefulness incremented if it was found to be useful. "	^origStatement</body>

<body package="Faish" selector="statement">statement	" *** This method was defined by Searchable as a subclass responsibility.	Replace its body with a proper implementation. *** "	self error: 'Subclass responsibility stub not reimplemented'</body>
</methods>

<methods>
<class-id>ForkSearchable</class-id> <category>searching</category>

<body package="Faish" selector="isGoal">isGoal	^ false.</body>

<body package="Faish" selector="nextChild">nextChild	| p t |	t := self nextThreadIdentifier.	t isNil ifTrue: [ ^ nil ].	p := parent copy.	p threadIdentifier: t.	^ p.</body>
</methods>

<methods>
<class-id>ForkSearchable</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize		super initialize.	nextIndex := 0.	^self</body>
</methods>


<methods>
<class-id>ModuleSearcher class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>

<methods>
<class-id>ModuleSearcher class</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="module:searchingFor:">module: m searchingFor: goal	^ self new module: m; searchingFor: goal.</body>
</methods>


<methods>
<class-id>ModuleSearcher</class-id> <category>comparing</category>

<body package="Faish" selector="=">= another	" Good enough. This is only used in comparing statements, via an IteratorLiteral. "	^ self class == another class.</body>

<body package="Faish" selector="isBroken">isBroken	^ false.</body>
</methods>

<methods>
<class-id>ModuleSearcher</class-id> <category>Search protocol</category>

<body package="Faish" selector="clear">clear</body>

<body package="Faish" selector="isRunning">isRunning		^ false.</body>
</methods>

<methods>
<class-id>ModuleSearcher</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="searchingFor:">searchingFor: aGoal	goal := aGoal.</body>

<body package="Faish" selector="module:">module: m	index := m.	position := 1.</body>

<body package="Faish" selector="module">module	^ index</body>

<body package="Faish" selector="goal">goal	^ goal.</body>

<body package="Faish" selector="copyFrom:">copyFrom: another	index := another module.	goal := another goal.	position := another position. "This is the important one."</body>

<body package="Faish" selector="next">next	^ self subclassResponsibility.</body>

<body package="Faish" selector="position">position	^ position.</body>

<body package="Faish" selector="nextIncludingUnunified">nextIncludingUnunified	^ self subclassResponsibility.</body>

<body package="Faish" selector="nextStatement">nextStatement	^ self next statement.</body>

<body package="Faish" selector="copy">copy	^ self class new copyFrom: self.</body>

<body package="Faish" selector="printOn:">printOn: aStream	| result completed |	result := super printOn: aStream.	(index size &gt; 0) ifTrue: [		completed := position / index size.		completed printOn: aStream.	].		^ result.</body>
</methods>


<methods>
<class-id>MatchingModuleSearcher</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	super initialize.	^self</body>
</methods>

<methods>
<class-id>MatchingModuleSearcher</class-id> <category>searching</category>

<body package="Faish" selector="nextNoFrills">nextNoFrills	" Search for the result, no caching, no builtins. "	| result |	" TODO: use indexing. "	[			position &gt; index size ifTrue: [ ^ SearchResult fail ].		(index at: position) matchesGoal: goal 	]  whileFalse: [		position := position + 1 ].			result := index at: position.	position := position + 1.	^ SearchResult result: result.</body>

<body package="Faish" selector="nextIncludingUnunified">nextIncludingUnunified	|  |	"cacheSearcher isNil ifFalse: [		result := cacheSearcher nextIncludingUnunified.		result isNil			ifFalse: [ ^ result ]			ifTrue: [ 				cacheSearcher := nil.				^ SearchResult fail.			 ]	]."	^ self nextNoFrills.</body>

<body package="Faish" selector="next">next	| result statement |	result := self nextIncludingUnunified.	statement := result statement.	[ statement isNil not and: [ statement isFullyUnified not ] ] whileTrue: [ 		result := self nextIncludingUnunified.		statement := result statement ].	^ result.</body>
</methods>


<methods>
<class-id>MatchingSimpleModuleSearcher</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>

<methods>
<class-id>MatchingSimpleModuleSearcher</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="nextIncludingUnunified">nextIncludingUnunified	| result |	" This isn't particularly efficient "	[			position &gt; index size ifTrue: [ ^ SearchResult fail ].		(index at: position) matches: goal 	]  whileFalse: [		position := position + 1 ].			result := index at: position.	position := position + 1.	^ SearchResult result: result.</body>
</methods>


<methods>
<class-id>FaishAtom class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>

<methods>
<class-id>FaishAtom class</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="from:">from: aString	^ self new value: aString.</body>
</methods>


<methods>
<class-id>FaishAtom</class-id> <category>comparing</category>

<body package="Faish" selector="signatureHash">signatureHash	^ self hash.</body>

<body package="Faish" selector="mostlyEquals:">mostlyEquals: another	^ value = another value.</body>
</methods>

<methods>
<class-id>FaishAtom</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="isFullyUnified">isFullyUnified	^ true.</body>

<body package="Faish" selector="arity">arity	^ 0.</body>

<body package="Faish" selector="heuristic">heuristic	^ value inject: 0 into: [ :i :each |		each asInteger + i ].</body>

<body package="Faish" selector="value">value 	^ value</body>

<body package="Faish" selector="hash">hash	^ value hash.</body>

<body package="Faish" selector="copy">copy	^ self. "I'm immutable. "</body>

<body package="Faish" selector="isAtom">isAtom	^ true.</body>

<body package="Faish" selector="=">= another	^ value = another value.</body>

<body package="Faish" selector="printOn:">printOn: aStream	(value isNil) ifTrue: [		aStream nextPut: $a.		self identityHash printOn: aStream.	] ifFalse: [		aStream nextPutAll: value.	].</body>

<body package="Faish" selector="value:">value: aString	baked ifNotNil: [ ^ self error: 'Immutable object.' ].	value := aString asSymbol.</body>
</methods>


<methods>
<class-id>ExceededSteps class</class-id> <category>instance creation</category>

<body package="Faish" selector="instance">instance	(Instance isNil) ifTrue: [ Instance := self new ].	^ Instance.</body>
</methods>


<methods>
<class-id>ExceededSteps</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: str 	str nextPutAll: 'Steps exceeded.'.</body>
</methods>


<methods>
<class-id>ReadableNetworkError class</class-id> <category>instance creation</category>

<body package="Faish" selector="message:">message: message	^ self new message: message.</body>

<body package="Faish" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>ReadableNetworkError</class-id> <category>initialize-release</category>

<body package="Faish" selector="message:">message: m	message := m.</body>

<body package="Faish" selector="message">message	^ message.</body>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>


<methods>
<class-id>BetterHttpClient class</class-id> <category>instance creation</category>

<body package="Faish" selector="executeRequest:onError:">executeRequest: request onError: aBlock	" Get that web page as a stream. url is just a string. "	| response client error |	client := Net.HttpClient new.	error := nil.	" The next few lines are just fucking bullshit. Seriously, Cincom, get a fucking clue on how to manage exceptions. "	[		[[[ response := client executeRequest: request 		] on: OsInaccessibleError do: [ :ex | error := 'Could not connect to ', request url printString ]. 		] on: TimeoutExceeded do: [ :ex | error := 'Timeout exceeded when trying to connect to ', request url printString ]		] on: Net.NetError do: [ :ex | error := ex description ].	] ensure: [ client close ].		(error isNil) ifFalse: [ 		^ aBlock value: error. 	].	^ response.</body>

<body package="Faish" selector="getStream:onError:">getStream: urlString onError: aBlock	" Get that web page as a stream. url is just a string. "	| request response body |	(urlString beginsWith: 'http://') ifFalse: [ 		^ aBlock value: 'URL does not begin with ''http://''. Sorry to be pendantic about this.'.	].	request := Net.HttpRequest get: urlString.	response := self executeRequest: request onError: aBlock.	body := response body.	^ ReadStream on: (body decodedValue). " decodedValue - also fucking bullshit. Why not just &gt;&gt;contents, like the documention FUCKING SAYS!? "</body>
</methods>


<methods>
<class-id>BetterHttpClient</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>


<methods>
<class-id>UnificationSearchable class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>

<methods>
<class-id>UnificationSearchable class</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="module:parent:searchingFor:">module: m parent: p searchingFor: q	^ self new module: m parent: p parentPremiseNum: nil searchingFor: q.</body>

<body package="Faish" selector="module:parent:parentPremiseNum:searchingFor:">module: m parent: p parentPremiseNum: premiseNum searchingFor: q	^ self new module: m parent: p parentPremiseNum: premiseNum searchingFor: q.</body>
</methods>


<methods>
<class-id>UnificationSearchable</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	^ super initialize.</body>

<body package="Faish" selector="unifyParentPremiseWith:">unifyParentPremiseWith: statement	| p |	p := self parentWhatIsDeductionSearchable.	" This unifies the given premise of the deduction: "	p isNil ifTrue: [ 		" Then there are no DeductionSearchables. The parents must all be UnificationSearchables. "		| root |		root := self.		[ root parent isNil ] whileFalse: [ root := root parent ].		^ UnificationSearchableFinished new 			goal: (root goal unifiedFrom: statement ifFail: [ self error. ^ nil. ]).	 ].	^ p copyAndUnifyPremise: parentPremiseNum with: statement.</body>

<body package="Faish" selector="copyFrom:">copyFrom: another	moduleSearcher := another moduleSearcher copy.	module := another module.	parent := another parent.	parent isNil ifFalse: [		depth := parent depth.	].	parentPremiseNum := another parentPremiseNum.	^ super copyFrom: another.</body>
</methods>

<methods>
<class-id>UnificationSearchable</class-id> <category>accessing</category>

<body package="Faish" selector="parentPremiseNum">parentPremiseNum	^ parentPremiseNum</body>

<body package="Faish" selector="module:parent:parentPremiseNum:searchingFor:">module: m parent: p parentPremiseNum: pp searchingFor: q	| |	module := m.	goal := q.	parent := p.	parentPremiseNum := pp.	self makeModuleSearchers.</body>

<body package="Faish" selector="moduleSearcher">moduleSearcher	^ moduleSearcher.</body>

<body package="Faish" selector="origStatement">origStatement	parentPremiseNum isNil ifTrue: [		^ nil.	].	^ self parentWhatIsDeductionSearchable originalStatementForPremiseNum: parentPremiseNum.</body>
</methods>

<methods>
<class-id>UnificationSearchable</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: aStream	aStream nextPutAll: 'U '.	self goal printOn: aStream.	aStream nextPutAll: ' in ';		nextPutAll: module name printString.</body>
</methods>

<methods>
<class-id>UnificationSearchable</class-id> <category>searching</category>

<body package="Faish" selector="processNextChild:">processNextChild: c	" Used by &gt;&gt;nextChild in me and a subclass. "	self goal isVariable ifTrue: [ ^ self newUnificationSearchableWithGoal: c ].	(c isIfThenRule and: [ self goal matches: c conclusion ]) ifTrue: [		^ self 			newDeductionSearchableWithGoal: c 		      ifFail: [ ^ self nextChild ].	] ifFalse: [		c isFullyUnified ifTrue: [			parent isNil ifTrue: [ 				" Answer was trivially found with no deduction. "				self goal unifiedFrom: c ifFail: [ 					" This is safe because the MemorySearcher should eventually run out of results. "					^ self nextChild ].				^ (UnificationSearchableFinished new goal: c) 					module: module;					derivedFrom: self;					origStatement: c; 					yourself. 			] ifFalse: [ 				" Then a value has been found for one of the premises of the DeductionSearchable that made me. "				^ (self unifyParentPremiseWith: c) 					derivedFrom: self;					yourself.			]. 		] ifFalse: [ | result |			result := self goal unifiedFrom: c ifFail: [ c ].			result isFullyUnified ifTrue: [				parent isNil ifTrue: [					^ UnificationSearchableFinished new 						goal: result;						derivedFrom: self;						module: module;						origStatement: c.				] ifFalse: [					| result2 |					result2 := (self unifyParentPremiseWith: result)						derivedFrom: self;						yourself.					^ result2.				].			] ifFalse: [				" We make two UnificationSearchables in a row on the search tree to keep trying to find the unbound variables. "				"^ (self newUnificationSearchableWithGoal: result) origStatement: c. (TODO: why origStatement:?)"				^ (self newUnificationSearchableWithGoal: result).			] 		] 	].	self halt: 'This code should not be reachable. You have found a bug. '.</body>

<body package="Faish" selector="nextChild">nextChild	| c |	c := moduleSearcher nextIncludingUnunified.	" TODO: this is all deprecated nonsense now. The SearchResult class is deprecated and modulesearchers return a statement or nil.			c will be a SearchResult, and can be one of 'result', 'noFail' or 'fail':	* A 'result' is a node with potentially more grandchildren.	* A 'fail' means that c can't make any more children and is depleted.	* A 'noFail' is a special case; if a built-in has too many variables, then it can't return results even though it would have returned a result if the variables had been unified already. E.g. (n:N plus:[+4] result:M) would have lots of potential values for N and M, but I decided not to make built-ins return all the possible values as this exploratory behaviour should happen at a higher level where more intelligence can be implemented.	'noFail' exists because if any child of a DeductionSearchable fails with no results, then the DeductionSearchable fails. If one of these children was a built-in and the nodes were explored in a non-optimal order, then the DeductionSearchable would fail prematurely. Thus, noFails do not could towards children deaths. "	c isResult ifTrue: [ | result |		result := self processNextChild: c statement.		"self addToCache: (result goal)."		^ result.	].	c isFail ifTrue: [		^ nil.	].	c isError ifTrue: [		^ self errorNode: (c statement).	].	self error: 'Impossible scenario.'.</body>

<body package="Faish" selector="isGoal">isGoal	^ false.</body>
</methods>

<methods>
<class-id>UnificationSearchable</class-id> <category>private</category>

<body package="Faish" selector="newUnificationSearchableWithGoal:">newUnificationSearchableWithGoal: goal	| result |	result := UnificationSearchable module: module parent: parent parentPremiseNum: parentPremiseNum searchingFor: goal.	" The goal is the same as mine, so the parent should be my parent. "	result derivedFrom: self.	^ result.</body>

<body package="Faish" selector="makeModuleSearchers">makeModuleSearchers	" Overridden in a subclass. "	| hint |	self makeHintsSearcher.		self hintsAreAvailable ifFalse: [ 		" TODO: duplicated with code below. "		moduleSearcher := MatchingModuleSearcher module: module searchingFor: goal.		^ self.	].	hint := self getHintsResult.		" TODO: what about (none), (cull), (fork:)? "		hint isNil ifTrue: [		moduleSearcher := MatchingModuleSearcher module: module searchingFor: goal.	] ifFalse: [		(hint matches: (module parse: 'useCatalog:I.')) ifTrue: [			| catalog |			catalog := (hint atIndex: 1). 			catalog isArray ifTrue: [				moduleSearcher := MatchingModuleSearcher module: catalog value searchingFor: goal.			] ifFalse: [				" TODO allow user-defined indexes - invoke squl queries to use them. "				moduleSearcher := BrokenModuleSearcher new setError: ('useCatalog hint has an invalid catalog: ', catalog printString).				]		] ifFalse: [			moduleSearcher := BrokenModuleSearcher new setError: ('Unknown hint: ', hint printString).		]	]</body>

<body package="Faish" selector="newDeductionSearchableWithGoal:ifFail:">newDeductionSearchableWithGoal: g ifFail: failBlock	| newGoal result |	newGoal := g unifiedGoalFrom: self goal ifFail: failBlock.	g isNil ifTrue: [ self halt ].	g isMaximizeRule ifTrue: [		result := (MaximisationSearchable			from: (self copy) 			goal: newGoal)			module: module;			derivedFrom: self;			origStatement: g.	] ifFalse: [ 		result := (DeductionSearchable 			from: (self copy) 			goal: newGoal)			module: module;			derivedFrom: self;			origStatement: g.	].		^ result.</body>
</methods>


<methods>
<class-id>FaishFloatArray</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>


<methods>
<class-id>Faish.FaishTODO class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>Faish.FaishTODO</class-id> <category>changelog</category>

<body package="Faish" selector="aboutSourceCode">aboutSourceCode	"I want to refactor the way that source code is managed. Each module has the source code in it. Below, the compiled module contains the statements and statement signitures. There are three ways to do it:# compiled module  -&gt;   source module# source module  -&gt; compiled module# all in the same module.The first option has the compiled module pointing to the source code. The second option has the source module pointing to the compiled module. The former allows the programmer to find source code from a given 'binary distribution' of a module.The last option, where all is in the same module, is good where the source code is available and desired. However, it procludes binary distributions. Few people care about source code.It is possible to strip a module. All original source code can be removed. Some signature source code can be removed if it is not referenced in other modules. If a statement is not exported from this module, and if that statement or clause does not occur in any module imported by this module (including the root module), then the statement signature can be elided.Storing source code-----------A statement such as:first:(second:[''Foo]).becomes:1 Signature  _a /1   (i.e. arity=1)2 Signature  _b /13 [''Foo]4 Statement  1 2 3 The signatures need names for other modules to find them, so we annotate them with source code. This would be used when binary modules from outside are brought in for linking. They too would need to annotate their signatures, and then signatures would need to be compared and links changed when modules are linked. Identical signatures would be changed to point to the same place.(I think) all signatures would need annotating because imports would need to be searched. If... a statement (or clause) can be proven to not be available in other modules exports then its signature annotation can be elided.5 Statement  ( metadata:( signature:[\1] source:[''first:] ))6 Statement  ( metadata:( signature:[\2] source:[''second:] ))Original source code for statements with formatting, uncompiled literals, operators, etc, can be kept:7 Statement  ( metadata:( statement:[\4] source:[''first:(second:[''Foo]).] )).Use a prefix to all source-code statements so they don't end up in code dumps."</body>

<body package="Faish" selector="release0_4">release0_4	""</body>

<body package="Faish" selector="release0_3">release0_3	"- Cannot use the deduction browser when a _ exists (DONE).- Update docs with new builtins: noResults:~ and notEqual:~with:~ (DONE)- Find a solution for importing (noResults:Q) from another module. (DONE )- Bug: 'Run all tests' doesn't manage processes right. Ooooh - its because of a query built-in. (DONE)- Strings should be arrays of ints. Chars should be ints. (DONE)- Strings are now byte arrays.- Implemented noResults:~, notEqual:~ with:~.- FaishStatement&gt;&gt;bindAllVariables should use variable literals. Maybe? Something that equals the same thing rebound. (DONE)- Fix up the DeductionNode heuristics. The second resolved statement should have a massively lower heuristic.	- When a deduction node utterly fails, abort the other premises. (DONE)		- Write tests for this.- Implement the whole language (DONE)	- Tests for:		- Array builtins 		- Extra int builtins.		- Float builtins		- Module builtins	- Array (and string) literals operations		create:uint8array size:N result:Array.		(also uint16, uint32, uint64, int8, int16, int32, int64, float32, float64, float128, statement(?) )		array:Array index:I element:Element.		array:Array index:I insert:Element result:NewArray.		array:Array startingAt:MyStart insertFrom:OtherArray from:Start to:End result:Result.		array:Array from:Start to:End result:ResultArray. (copy on write array).		(These four can be implemented in Squl:)		array:Array map:Fn result:Result. // Do a transformation on each element.		array:Array select:Fn result:Result. // Find elements matching the Fn. 		array:Array aggregate:Fn result:Result // Combine all elements.		array:Array inject:Value fn:Fn result:Result // Iterate over all elements in sequence.		array:Array size:N.	- More integer operations - (n:_ raisedTo:_ result:_), (integer:_ float:_), (n:_ abs:_).	- Floats (DONE: float notation is [#12.6] ).	- Float Operations; see category ""Float-&gt;mathematical functions"" for a list. sin, arcSin, floorLog10, etc.. - Remove statement literals??? (Kind of done, but not sure about this).- Tests: ""run all tests"" runs tests in the current module. Tests are all in the current module, not separate. (DONE)- Remove special treatment of test modules. All tests should now just be inline. (DONE)- Implement statement and module reflection (DONE, different to below ideas)	create:codeModule result:New.	create:module result:New.	create:statement module:M result:Statement.	module:M index:Index put:Statement result:R.	module:M afterIndex:Index insert:Statement result:R.	module:M removeAtIndex:Index result:R.	module:M index:Index statement:S. (can be used to find Index or S).	module:M query:Q result:Iterator.	module:M simpleQuery:Q result:Iterator.	module:M simpleQueryIncludingUnunified:Q result:Iterator. hmm.	module:M query:Query numResults:N searchDepth:D timestamp:T. 	module:M size:Size.	module:M mergeWith:OtherModule result:Result.	iterator:It value:Value next:NextIterator.		statement:S size:Size.	statement:S index:Index label:Label value:Value. (can be used to find Index or Label)	atom:Atom.	statement:Statement.	variable:Variable.	string:_. (literals can just be used inline)	integer:_.	float:_.	statementLiteral:_.	moduleLiteral:_.	array:_.	atom:Atom asString:String. (also a constructor).	label:Label asString:String. (maybe labels are atoms?).	variable:Variable asString:String.	(matching statements?)- Go through all the built-ins. Make them return noFail if needed. (DONE)	- How will I make these built-ins efficient in the future? Compile if there are guarantees that things are... not variables???- The ""depth"" in Searchable needs to act like a step limit instead (WONT DO).- Bug: n:[+4] plus:X result:Y will cause the parent to fail even though it might have solutions. (DONE)- Refactor all built-ins to return a SearchResult. (DONE)- A special maximise: clause. This goes in with the if: clauses and only has a variable. (DONE)	Some work was done to do maximisation using module:query:maximise: but there were problems with argmax and variable bindings. It's far better to have a special maximise: clause. A then-if statement with a maximise: clause will only return one statement. If there are multiple results for the maximum value, a randomly chosen one is returned. 	I'm not sure about adding step/depth/time limits to it.- When there are errors after loading a module, store those errors (as statements?) for revisiting and repairing. 	- Load whole module.		- Return whether an error has occurred or not. Module&gt;&gt;containsErrors?		Some work has been done, but error handling is still not perfect.	- Syntax errors. syntaxError:["" Statement text ]. (DONE)	- Broken imports.	- Load atomically statement by statement. Split by '.' followed by whitespace. (Problem: what about literals? '.\n' is valid inside a literal.).- Deduction browser seems a bit buggy. It should do a jellyfish search but it goes all over the show. Test it. (DONE)	- Separate presentation from the stepping; run the query separately from the tree. (DONE)	- Stepping P04 will crash. (DONE)- Document how to write code in a file that can be loaded. (DONE - in the modules section)- Allow loading modules by entering a URL.- Tests don't have question marks after the queries. (DONE)- Typing in junk after the '.' seems to work okay. No syntax error? (DONE)- Change literal delimiters: square brackets must match up. (DONE)- ( statement:_ asLiteral:_ ) not implement if neither is a variable. (DONE)- modulo operator (DONE)- ""n:_ mult:_ result:_"" -&gt; ""n:_ multiply:_ result:_"". (DONE)- Premises of a then-if statement without metadata are evaluated in the order they were written.- Documentation!	- Jellyfish search (DONE in language.rst).- Iterators aren't finished yet. TODOs exist, and are hit. No tests. How do you know when an iterator is depleted? (DONE)- Right-clicking on an edited statement has unused menu items (DONE - removed menu).- builtinModuleAdd: does not test for all unified variable, and does not bind/unbind variables. (DONE)- Cannot search for just a variable, e.g. (X?) (DONE)"</body>
</methods>

<methods>
<class-id>Faish.FaishTODO</class-id> <category>initialize-release</category>

<body package="Faish" selector="indexes">indexes"Indexes help the interpreter. Every UnificationSearchable refers to an index to find results.Users can manually create their own indexes to customize the order that UnificationSearchables do.UnificationSearchables are only interested in matching statements. If an index includes a whole lot of non-matching statements, time is wasted. Thus - I propose that the index used will always match the current goal. Indexes can be slices over other indexes, making this more efficient.As a result, every statement that can be unified (including each then-if clause) needs a link to an index.Indexes can be:* Indexes on all statements.* Indexes on a particular sub-clause. This needs a statement to match on, where a variable becomes the index.* Slices on another index. Also needs a statement with at least one variable.Indexes can be:* In b-tree nodes, or* As a collection in a module.Index ordering can be:* Ascending (use the index backwards for descending)* Custom formulae* Manually created."</body>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>

<body package="Faish" selector="pruningAlgorithms">pruningAlgorithms"These comments have been moved to InvestigativeAbortiveSearch comment. You can delete this now. If any searchable fails, it's D-node ancestor will have failed (recursively towards it's parents as well). Any deductions from that D-node's clauses are now wasting effort. These can be culled. No more children will be spawned from these nodes, and existing children can be found and culled.But - how do we find the nodes that can be culled? They're not navigable in that direction.Aside: built-ins with too many variables will fail, but only because they need more populated variables. Beware of this. Do not propogate these failures to their parents.Deduction nodes can be in one of three modes:1) Exploration (breadth-first)2) Exploitation (depth-first)3) Ask the metadata.If a D-node has multiple child searchables, we say it is 'forked'. This will happen when search down one child gives up, and another child is attempted. This might happen a lot.So - some pruning algorithms:1) Keep a flag that are shared by a forked D-node and every child. If the D-node fails, the children all know immediately. Downside: each child will need a list of flags, and these could get long.2) Set a global flag when a D-node is forked. (TODO: when it is unset?). When the flag is noticed, threads will instead recurse back to see if the D-node is one of their parents.	2.1) You can limit the search backwards by heuristics; don't bother going past the D-nodes heuristic (because heuristics always decrease).	2.2) Add a version to all nodes. Increment the version when a D-node is forked. Then recurse back through all parents until a parent of that version is found (and thus increase all recursed nodes to that version), or the dead D-node is found.3) Just leave it and cope with the overhead. The overhead might be less than the alternatives here.4) Make assumptions about execution. We can remove whole blocks if we know the whole block is children of that forked D-node. If we backtrack using the tree (rather than the beam search) then we know when we fork D-nodes, and we can chop off whole branches for GC.5) Keep a reference to leaf nodes at the forked D-node.Each clause in a D-node gets a leaf-node reference. This points to the deepest exploitation-mode child D-node, or the next exploration node if there is one. The leaf node reference can be used to quickly cull a whole branch by exploring from the leaf node back. The leaf node reference can also point to another process somehow; in this case, the process must periodically check some flag that can be set from the leaf node reference somehow to determine if it is exploring a cullable branch.Thus, the algorithm components are as follows:- When doing a depth-first search, we keep a reference to an ancestor D-node and the clause we spawned from for backtracking to.- If doing a depth-first search and we encounter either an exploration statement, then we set our ancestor's leaf node to the exploration statement's D-node. Then we use the exploration statement's D-node as our new ancestor node.- If doing a depth-first search and the heuristic expires (because it is less than ...TODO) then we use the current node as the leaf node and we backtrack.- If we find a node is cullable:	* All children are exhausted.	* Built-ins were not found.	U-nodes: keep culling up the ancestry if no children are possible.		D-nodes: The whole node can be culled.		- Follow all leaf node links, then trace back along them back to self culling all nodes.				- If the leaf node is already culled, we're doing it wrong.		- cull self, notify parent.		- maybe: add (not:~) to the cache?"</body>

<body package="Faish" selector="cachingAndLoopDetection">cachingAndLoopDetection"When do you add a statement to the cache?- when it has had a variable filled in? This is the result of an expensive search.- when a-&gt;b and b-&gt;c, then add a-&gt;c. But if a-&gt;c then it's a loop.- noResults:X?Cached statements that prevent loops are useful. How do you determine whether a statement leads to a loop?	- Cached statements won't prevent loops... how would the result of a loop be added to a cache?	- If a statement is cached, it is possibly from a loop?If there are multiple processes, and a process adds a statement to the cache, then other processes know that that statement is work in progress - and that... any results will also be available in the cache?"</body>

<body package="Faish" selector="compilation">compilation"I still don't know how to do compilation. Here are some ideas.* A program's inputs are statements. A program's output are query results. Queries might need to be compiled first.* Each rule pattern (if-then statement signature) compiles to a function.* A function's arguments are probably variables, although some might be instantiated. Not sure about this.* Each function can 'return' zero to infinite matches. Maybe these results are added to the 'search queue' rather than returned.* Non-rule statements ('facts') can be compiled to functions if there are only a few of them.* If there are a lot of rules (&gt;1000 maybe?), then we might need to fail-over to interpreting as compiled code might be too big.E.g.a:b.a:c.could compile as: void a(arg) {	if (arg=='b') {		Push a:b onto the search queue.		// Or maybe return 'true'?	} else if (arg=='c') {		Push a:c onto the search queue.	} else {		// return false??	}	// Alternatively, use a precompiled look-up table... which will probably be faster than above anyway!	// or use a database index.}==================then:(a:a)	if:(b:b).then:(a:a)	if:(c:c).void a(arg) {	if (b('b')) {		return true;	} else {		if (c('c')) {			return true;		}	}}// Some mechanism for avoiding infinite loops is needed. Maybe add a count-down integer to the arguments?===================a:a.a:b.then:(b:X) if:(a:X).// We need to return multiple possible variable bindings.// Consider an if-then rule to be a set of variable bindings with structure.void b(VariableBinding x) { // All variables in if-then rule as args.	a(x);}// VariableBinding is then basically the same as Searchable.// We could also add a recursion limit to it.// void a() is then the same as above. ====================Matching can be either:	- more specific, or	- more general.Take, e.g. 'a:(a:X).'.A more general match would be 'a:Y.'.A more specific match would be 'a:(a:(a:Z)).'.A complicating factor is that extra clauses may be more general or more specific.To compile...then:(a:X) if: ....then:(a:(a:(a:X))) if: ....void a_dispatch(VariableBinding x) {	if (x starts with 'a:(a:_)') {		a_a_a(x);	// etc for all other more specific signatures	// complications here from other clauses?	} else {		a(x);	}}===================What about backtracking? Enclose each function call in a while() loop?then:(a:X) if:(b:X) if:(c:X).// Notice the similarity to DeductionSearchable and UnificationSearchable here.a(VariableConfiguration v) { // maybe v is a pointer into the search queue?	VariableConfiguration mine = v.copy(); // v is owned by my parent.	do {		if(b(mine)) {			do {				// Maybe another copy is needed here?				if(c(mine)) {					v = mine????					// probably add result to search queue. 				}			} while (mine.keepGoing())		}	} while (mine.keepGoing())}// keepGoing() can return false if the search tree is getting too deep.====================Each clause has a potentialNumResults. This can be 0 to infinity. You want to try unifying the clauses with the least potentialNumResults first.Simple clauses: just count them up.if-then clauses: guess? If there is no recursion, you can follow them and count up the results.if-then clauses with recursion: potentially infinite.if-then clauses with loops: infinite.built-ins: usually 1. Definitely do these first if they're unified enough.You'll also have a dependency graph of variables to bind.=====================If several if-clauses do not share variables with each other, then they can be searched in parallel.If an unbound variable is shared among several if-clauses, then those clauses need to be searched in sequence, depth-first-ish starting with the clause most likely to lead to few and easy results. They can in theory be searched in parallel, but this is very likely to be inefficient.Bound variables can be ignored.Keep in mind that 'parallel' might be multi-threading on the same machine, or message passing across several machines. "</body>

<body package="Faish" selector="metadataAdvice">metadataAdvice"During deduction, the interpreter needs advice about what to do next.* When hitting a DeductionSearchable, it needs to know the order in which to investigate clauses.* On a UnificationSearchable, it wants to use a particular index which specifies an ordering of statements to try.* Sometimes on a UnificationSearchable or DeductionSearchable, it might want to know if a new thread can be forked.* Sometimes you just want to abort a node.Thus:statement:(...)node:(	type:deductionSearchable	thread:~	totalThreads:~	parent:~	details:(		nextClause:~		)	)contextBefore:CbcontextAfter:Caadvice:Advice.Advice is one of:(cull)(fork:F)			-- Fork F threads. F will appear again in totalThreads.(nextClause:N)		-- For DeductionSearchables. If a negative number, then attempt not(clause) instead.(useIndex:Ix)		-- For unificationSearchables, where Ix could be user generated, or even manually enteredAn index is basically a searchable collection. It is indexed by a statement used as a search key."</body>
</methods>


<methods>
<class-id>BreadthFirstSearchNode class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>BreadthFirstSearchNode</class-id> <category>accessing</category>

<body package="Faish" selector="leafNode:">leafNode: anObject	leafNode := anObject</body>

<body package="Faish" selector="nextChild">nextChild	" I will find another node, stealing them if I have to, but only going one level deep. "	| next stolenNode result |		next := target nextChild.	next isNil ifFalse: [ 		result := BreadthFirstSearchNode new target: next.		children add: result.		^ result.	] ifTrue: [ 		" Steal the depth-first node. The current node has no more children. "		stolenNode := target stealDepthFirstChild.		stolenNode isNil ifFalse: [			( leafNode == self ) ifTrue: [ self halt: 'Is this a bug?'. ].			result := BreadthFirstSearchNode new target: stolenNode;				leafNode: leafNode.			leafNode := nil. " Because the stolen node now has the leaf node. "			children add: result.			^ result.		].		" If the target is dead, we'll fall through here and return nil. "	].	^ nil.</body>

<body package="Faish" selector="target">target	^target</body>

<body package="Faish" selector="target:">target: anObject	target := anObject</body>

<body package="Faish" selector="leafNode">leafNode	^leafNode</body>

<body package="Faish" selector="cullChildrenIfDead">cullChildrenIfDead	target isDead ifTrue: [ 		leafNode isNil ifFalse: [ leafNode cull ].		children do: [ :each | each target cull ].	].</body>
</methods>

<methods>
<class-id>BreadthFirstSearchNode</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: aStream	aStream nextPutAll: 'a BreathFirstSearchNode ('.	target printOn: aStream.	aStream nextPut: $).</body>
</methods>

<methods>
<class-id>BreadthFirstSearchNode</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	super initialize.	children := List new.	^self</body>
</methods>


<methods>
<class-id>BuiltInsSearchable class</class-id> <category>class initialization</category>

<body package="Faish" selector="initialize">initialize	" This is the canonical list of built-ins. BuiltInsSearcher initialize. "	| s m |	NextId := 1.	" Idea: this could be better implemented using a special module. "	" TODO: somehow allow for plugins??? "	StatementsBuiltIn := Dictionary new.	s := StatementsBuiltIn.	m := AbstractModule new. "Only used for parsing. "	" Integers "	s at: (m parse: 'n:X plus:Y result:Z.')	   put: [ :handler :statement | handler builtinAddToSum: statement ].	s at: (m parse: 'n:X multiply:Y result:Z.')	   put: [ :handler :statement | handler builtinMultiply: statement ].	s at: (m parse: 'n:X divide:Y result:Z.')	   put: [ :handler :statement | handler builtinDivide: statement ].	s at: (m parse: 'n:X modulo:Y result:Z.')	   put: [ :handler :statement | handler builtinModulo: statement ].	s at: (m parse: 'n:X raisedTo:Y result:Z.')	   put: [ :handler :statement | handler builtinRaisedTo: statement ].	s at: (m parse: 'n:X abs:Z.')	   put: [ :handler :statement | handler builtinAbs: statement ].	s at: (m parse: 'n:X bitAt:Y result:Z.')	   put: [ :handler :statement | handler builtinBitAt: statement ].	s at: (m parse: 'n:X bitAnd:Y result:Z.')	   put: [ :handler :statement | handler builtinBitAnd: statement ].	s at: (m parse: 'n:X bitOr:Y result:Z.')	   put: [ :handler :statement | handler builtinBitOr: statement ].	s at: (m parse: 'bitNot:Y result:Z.')	   put: [ :handler :statement | handler builtinBitNot: statement ].	s at: (m parse: 'n:X bitShift:Y result:Z.')	   put: [ :handler :statement | handler builtinBitShift: statement ].	s at: (m parse: 'n:X bitXor:Y result:Z.')	   put: [ :handler :statement | handler builtinBitXor: statement ].	" Comparisons "	s at: (m parse: 'lesser:X greater:Y.')	   put: [ :handler :statement | handler builtinLesserGreater: statement ].	" Arrays, also used for Strings "	s at: (m parse: 'create:array size:N result:R.')	   put: [ :handler :statement | handler builtinCreateArray: statement ].		s at: (m parse: 'create:uint8Array size:N result:R.')	   put: [ :handler :statement | handler builtinCreateUInt8Array: statement ].	s at: (m parse: 'create:float32Array size:N result:R.')	   put: [ :handler :statement | handler builtinCreateFloat32Array: statement ].	"(also uint16, uint32, uint64, int8, int16, int32, int64, float32, float64, float128, statement(?) ). I've only made two basic ones so that things can be tested."		s at: (m parse: 'array:A index:I value:E.')	   put: [ :handler :statement | handler builtinArrayAtIndex: statement ].	s at: (m parse: 'array:A index:I insert:E result:R.')	   put: [ :handler :statement | handler builtinArrayInsert: statement ].	s at: (m parse: 'array:A index:I insertArray:Paste result:R.')	   put: [ :handler :statement | handler builtinArrayInsertArray: statement ].	s at: (m parse: 'array:A fromIndex:I toIndex:T result:R.')	   put: [ :handler :statement | handler builtinArrayCopy: statement ].	s at: (m parse: 'array:A size:S.')	   put: [ :handler :statement | handler builtinArraySize: statement ].	" Array iteration can be implemented in Squl code. "	" Module queries "	s at: (m parse: 'thisModule:ThisModule.')	   put: [ :handler :statement | handler builtinModuleThis: statement ].	s at: (m parse: 'module:Module query:Query numResults:N depthLimit:Depth.')	   put: [ :handler :statement | handler builtinModuleNumResultsDepthLimit: statement ].	s at: (m parse: 'module:Module query:Query numResults:N stepLimit:Steps.')	   put: [ :handler :statement | handler builtinModuleNumResultsStepLimit: statement ].	s at: (m parse: 'module:Module query:Query numResults:N timeLimit:Seconds.')	   put: [ :handler :statement | handler builtinModuleNumResultsTimeLimit: statement ].	" Fetching results doesn't need limits because fetches can be lazy, meaning existing query limits can be used. "	s at: (m parse: 'module:Module query:Query iterator:Iterator.')	   put: [ :handler :statement | handler builtinModuleQuery: statement ].	s at: (m parse: 'iterator:Iterator value:Value next:AnotherIterator.')	   put: [ :handler :statement | handler builtinIteratorNext: statement ].	s at: (m parse: 'iteratorIsExhausted:Iterator.')	   put: [ :handler :statement | handler builtinIteratorExhausted: statement ].	" Simple queries; these don't need limits. "	s at: (m parse: 'module:Module simpleQuery:Query numResults:N.')	   put: [ :handler :statement | handler builtinModuleSimpleNumResults: statement ].	s at: (m parse: 'module:Module simpleQueryUnified:Query iterator:Iterator.')	   put: [ :handler :statement | handler builtinModuleSimpleQuery: statement ].	s at: (m parse: 'module:Module simpleQueryUnunified:Query iterator:Iterator.')	   put: [ :handler :statement | handler builtinModuleSimpleQueryUnunified: statement ].	s at: (m parse: 'noResults:Q.')	   put: [ :handler :statement | handler builtinNoResults: statement ].	" Equality can br easily implemented as (equal:X with:X), but inequality is less simple. Thus: "	s at: (m parse: 'notEqual:X with:Y.')	   put: [ :handler :statement | handler builtinNotEqual: statement ].	" Module lifecycle, accessing "	s at: (m parse: 'create:module result:New.')	   put: [ :handler :statement | handler builtinModuleCreate: statement ].	s at: (m parse: 'module:Module add:Statement result:R.')	   put: [ :handler :statement | handler builtinModuleAdd: statement ].	" TODO: think about whether this should be the opposite of add: "	s at: (m parse: 'module:Module remove:Statement result:R.')	   put: [ :handler :statement | handler builtinModuleAdd: statement ].	" TODO 	s at: (m parse: 'module:Module union:Another result:R.')	   put: [ :handler :statement | handler builtinModuleUnion: statement ].	s at: (m parse: 'module:Module intersection:Another result:R.')	   put: [ :handler :statement | handler builtinModuleIntersection: statement ]."	s at: (m parse: 'module:Module size:S.')	   put: [ :handler :statement | handler builtinModuleSize: statement ].	" Statement lifecycle, accessing. "	" Creating a statement does not add it to the module. "	" Statements are instances of their definitions. Definitions are just unique identifiers with an arity. Any human-readable version of that statement is kept in an adjacent source module. "	s at: (m parse: 'create:statementSignature module:Module arity:Arity result:New.')	   put: [ :handler :statement | handler builtinStatementSignatureCreate: statement ].	s at: (m parse: 'create:statement fromSignature:Signature module:Module result:New.')	   put: [ :handler :statement | handler builtinStatementCreate: statement ].	s at: (m parse: 'statement:S signature:Si.')	   put: [ :handler :statement | handler builtinStatementGetSignature: statement ].	s at: (m parse: 'statement:S arity:Size.')	   put: [ :handler :statement | handler builtinStatementSize: statement ].	s at: (m parse: 'statement:S index:I value:V.')	   put: [ :handler :statement | handler builtinStatementGetValue: statement ].	s at: (m parse: 'statement:S index:I value:V result:Result.')	   put: [ :handler :statement | handler builtinStatementSetValue: statement ].	" Basic type checking "	s at: (m parse: 'atom:X.')	   put: [ :handler :statement | handler builtinIsAtom: statement ].	s at: (m parse: 'statement:X.')	   put: [ :handler :statement | handler builtinIsStatement: statement ].	s at: (m parse: 'statementSignature:X.')	   put: [ :handler :statement | handler builtinIsStatementSignature: statement ].	s at: (m parse: 'variable:X.')	   put: [ :handler :statement | handler builtinIsVariable: statement ].	s at: (m parse: 'integer:X.')	   put: [ :handler :statement | handler builtinIsInteger: statement ]. 	s at: (m parse: 'float32:X.')	   put: [ :handler :statement | handler builtinIsFloat: statement ]. 	s at: (m parse: 'array:X.')	   put: [ :handler :statement | handler builtinIsArray: statement ]. 	s at: (m parse: 'uint8Array:X.')	   put: [ :handler :statement | handler builtinIsArray: statement ]. 	s at: (m parse: 'float32Array:X.')	   put: [ :handler :statement | handler builtinIsArray: statement ]. 	" String is not here, because I plan that strings are implemented using arrays. "	s at: (m parse: 'module:X.') "TODO - module:X? "	   put: [ :handler :statement | handler builtinIsModuleLiteral: statement ].	" Creating things "	s at: (m parse: 'create:atom result:X.')	   put: [ :handler :statement | handler builtinCreateAtom: statement ].	s at: (m parse: 'create:variable result:X.')	   put: [ :handler :statement | handler builtinCreateVariable: statement ].</body>
</methods>

<methods>
<class-id>BuiltInsSearchable class</class-id> <category>class side stuff</category>

<body package="Faish" selector="nextId">nextId 	NextId := NextId + 1.	^ ('l',(NextId printString)) asSymbol.</body>
</methods>

<methods>
<class-id>BuiltInsSearchable class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>


<methods>
<class-id>BuiltInsSearchable</class-id> <category>built-ins arrays</category>

<body package="Faish" selector="builtinArrayInsertArray:">builtinArrayInsertArray: statement	"array:A index:I insertArray:V result:R."	| a i v r newA result |	a := statement atIndex: 1.	i := statement atIndex: 2.	v := statement atIndex: 3.	r := statement atIndex: 4.	a isVariable ifTrue: [ ^ SearchResult noFail ].	i isVariable ifTrue: [ ^ SearchResult noFail ].	v isVariable ifTrue: [ ^ SearchResult noFail ].	(a isArray) ifFalse: [ ^ SearchResult fail ].	(i isInteger) ifFalse: [ ^ SearchResult fail ].	i value &lt; 1 ifTrue: [ ^ SearchResult fail ].	i value &gt; (a value size) ifTrue: [ ^ SearchResult fail ].	(r isVariable) ifFalse: [ ^ SearchResult fail ].	(v isArray) ifFalse: [ ^ SearchResult fail ].	(a value isKindOf: ArrayedCollection) ifTrue: [ 		result := statement copy.		newA := a value copy.		newA replaceFrom: (i value) to: (i value + v value size-1) with: (v value).		result at: #result put: (FaishLiteral value: newA).		^ SearchResult result: result.	].	^ SearchResult fail.</body>

<body package="Faish" selector="builtinCreateArray:">builtinCreateArray: statement	"create:array size:N result:R."	| n result |	n := statement at: #size.	(statement at: #result) isVariable ifFalse: [ ^ SearchResult fail ].	n isVariable ifTrue: [ ^ SearchResult noFail ].	n isInteger ifFalse: [ ^ SearchResult fail ].		(n value &gt; 0) ifFalse: [ ^ SearchResult fail ].	result := statement copy.	result at: #result put: (FaishLiteral value: (Array new: (n value))).	^ SearchResult result: result</body>

<body package="Faish" selector="builtinArraySize:">builtinArraySize: statement	"array:A size:S."	| a s result |	a := statement atIndex: 1.	s := statement atIndex: 2.	a isVariable ifTrue: [ ^ SearchResult noFail ].	(a isArray) ifFalse: [ ^ SearchResult fail ].	s isVariable ifTrue: [		result := statement copy.		result at: #size put: (FaishLiteral value: (a value size)).		^ SearchResult result: result.	].	s isInteger ifTrue: [		((statement at: #size) value = (a value size)) ifTrue: [			^ SearchResult result: statement.		]	].	^ SearchResult fail.</body>

<body package="Faish" selector="builtinCreateFloat32Array:">builtinCreateFloat32Array: statement	"create:uint8Array size:N result:R."	| n result |	" Heh. Where are VW's float arrays? I can't find them. "	n := statement at: #size.	(statement at: #result) isVariable ifFalse: [ ^ SearchResult fail ].	n isVariable ifTrue: [ ^ SearchResult noFail ].	n isInteger ifFalse: [ ^ SearchResult fail ].		(n value &gt; 0) ifFalse: [ ^ SearchResult fail ].	result := statement copy.	" TODO: use an actual float array. "	result at: #result put: (FaishLiteral value: (FaishFloatArray new: (n value))).	^ SearchResult result: result</body>

<body package="Faish" selector="builtinArrayInsert:">builtinArrayInsert: statement	"array:A index:I insert:V result:R."	| a i v r newA result |	a := statement atIndex: 1.	i := statement atIndex: 2.	v := statement atIndex: 3.	r := statement atIndex: 4.		a isVariable ifTrue: [ ^ SearchResult noFail ].	i isVariable ifTrue: [ ^ SearchResult noFail ].	v isVariable ifTrue: [ ^ SearchResult noFail ].	(a isArray) ifFalse: [ ^ SearchResult fail ].	(i isInteger) ifFalse: [ ^ SearchResult fail ].	i value &lt; 1 ifTrue: [ ^ SearchResult fail ].	i value &gt; (a value size) ifTrue: [ ^ SearchResult fail ].	(r isVariable) ifFalse: [ ^ SearchResult fail ].	(a value isMemberOf: ByteArray) ifTrue: [ 		v isInteger ifFalse: [ ^ SearchResult fail ].		v value &lt; 0 ifTrue: [ ^ SearchResult fail ].		v value &gt; 255 ifTrue: [ ^ SearchResult fail ].		result := statement copy.		newA := a value copy.		newA at: (i value) put: (v value).		result at: #result put: (FaishLiteral value: newA).		^ SearchResult result: result.	].	(a value isMemberOf: FaishFloatArray) ifTrue: [ 		v isFloat ifFalse: [ ^ SearchResult fail ].		result := statement copy.		newA := a value copy.		newA at: (i value) put: (v value).		result at: #result put: (FaishLiteral value: newA).		^ SearchResult result: result.	].				(a value isMemberOf: Array) ifTrue: [ 		result := statement copy.		newA := a value copy.		newA at: (i value) put: (v value).		result at: #result put: (FaishLiteral value: newA).		^ SearchResult result: result.	].		^ SearchResult fail.</body>

<body package="Faish" selector="builtinArrayCopy:">builtinArrayCopy: statement	"array:A fromIndex:S toIndex:E result:R."	| a s e r newArray result |	a := statement atIndex: 1.	a isVariable ifTrue: [ ^ SearchResult noFail ].	(a isArray) ifFalse: [ ^ SearchResult fail ].	s := statement atIndex: 2.	s isVariable ifTrue: [ ^ SearchResult noFail ].	(s isInteger) ifFalse: [ ^ SearchResult fail ].		e := statement atIndex: 3.	e isVariable ifTrue: [ ^ SearchResult noFail ].	(e isInteger) ifFalse: [ ^ SearchResult fail ].		(s value &lt; 1) ifTrue: [ ^  SearchResult fail ].	(e value &lt; s value ) ifTrue: [ ^  SearchResult fail ].	(e value &gt; (a value size)) ifTrue: [ ^ SearchResult fail ].	r := statement atIndex: 4.	r isVariable ifFalse: [ | aArray rArray |		" We compare the arrays. "		r isArray ifFalse: [ ^ SearchResult fail ].		rArray := r value.		( rArray size = ( 1 + e value - s value ) ) ifFalse: [ ^ SearchResult fail ].		aArray := a value.		1 to: (rArray size) do: [ :i | 			(aArray at: (s value + i - 1)) = (rArray at: i) ifFalse: [ ^ SearchResult fail ].		].		^ SearchResult result: statement.	].	" We copy a new array. "		newArray := (a value) copyFrom: (s value) to: (e value).	result := statement copy.	result atIndex: 4 put: (FaishLiteral new value: newArray).	^ SearchResult result: result.</body>

<body package="Faish" selector="builtinCreateUInt8Array:">builtinCreateUInt8Array: statement	"create:uint8Array size:N result:R."	| n result |	n := statement at: #size.	(statement at: #result) isVariable ifFalse: [ ^ SearchResult fail ].	n isVariable ifTrue: [ ^ SearchResult noFail ].	n isInteger ifFalse: [ ^ SearchResult fail ].		(n value &gt; 0) ifFalse: [ ^ SearchResult fail ].	result := statement copy.	result at: #result put: (FaishLiteral value: (ByteArray new: (n value))).	^ SearchResult result: result</body>

<body package="Faish" selector="builtinArrayAtIndex:">builtinArrayAtIndex: statement	"array:A index:I value:V."	| a i result |	a := statement at: #array.	i := statement at: #index.		a isVariable ifTrue: [ ^ SearchResult noFail ].	i isVariable ifTrue: [ ^ SearchResult noFail ].	(a isArray) ifFalse: [ ^ SearchResult fail ].	(i isInteger) ifFalse: [ ^ SearchResult fail ].	(statement at: #value) isVariable ifFalse: [ 		((a value at: (i value)) = (statement at: #value) value ) ifTrue: [			^ SearchResult result: statement.		] ifFalse: [ ^ SearchResult fail ].	 ].		i value &lt; 1 ifTrue: [ ^ SearchResult fail ].	i value &gt; (a value size) ifTrue: [ ^ SearchResult fail ].	result := statement copy.	result at: #value put: (FaishLiteral value: (a value at: (i value)) ).	^ SearchResult result: result.</body>

<body package="Faish" selector="builtinIsArray:">builtinIsArray: statement	"array:A."	| a  |	a := statement at: #array.	a isVariable ifTrue: [ ^ SearchResult noFail ].	(a isArray) ifTrue: [ 		^ SearchResult result: statement.	] ifFalse: [ 		^ SearchResult fail.	].</body>
</methods>

<methods>
<class-id>BuiltInsSearchable</class-id> <category>built-ins implementation</category>

<body package="Faish" selector="builtinBitShift:">builtinBitShift: statement	"n:X plus:Y result:Z."	| a b c |	a := statement at: #n.	b := statement at: #bitShift.	c := statement at: #result.	c isVariable ifTrue: [		a isInteger ifTrue: [			b isInteger ifTrue: [				| result |				result := statement copy.				result at: #result put: (FaishLiteral value: (					a value bitShift: b value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.					].	(a isInteger and: [b isInteger and: [ c isInteger ]])		ifTrue: [ 			((a value bitShift: b value) = c value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail ] ]. 	^ nil.</body>

<body package="Faish" selector="builtinCreateVariable:">builtinCreateVariable: statement	"create:variable result:X."	| a result |	a := statement atIndex: 2.	a isVariable ifTrue: [		| name v |		v := FaishVariable new.		name := 'A', v identityHash printString.		v value: name.		result := statement copy.		result atIndex: 2 put: (FaishLiteral value: v).		^ SearchResult result: result.	] ifFalse: [		a isVariableLiteral ifTrue: [			^ SearchResult result: statement.		]	].	^ SearchResult fail.</body>

<body package="Faish" selector="timestamp">timestamp	^ FaishLiteral value: (Time millisecondClockValue).</body>

<body package="Faish" selector="builtinAbs:">builtinAbs: statement	"n:X abs:Y."	| a b |	a := statement atIndex: 1.	b := statement atIndex: 2.		a isNumber ifTrue: [		b isNumber ifTrue: [			(a abs = b ) ifTrue: [				^ SearchResult result: statement			] ifFalse: [				^ SearchResult fail. 			]		] ifFalse: [			b isVariable ifTrue: [ | r |				r := statement copy.				r atIndex: 2 put: (FaishLiteral value: (a abs)).				^ SearchResult result: r.			] 		] 	] ifFalse: [		a isVariable ifTrue: [			" Two possible results can be returned here - a is positive b, a is negative b."			^ SearchResult noFail.		]	].	^ SearchResult fail.</body>

<body package="Faish" selector="builtinIsFloat:">builtinIsFloat: statement	"float32:X."	| a |	a := statement at: #float32.	a isFloat ifTrue: [		^ SearchResult result: statement.	] ifFalse: [		a isVariable ifTrue: [			^ SearchResult noFail.		] ifFalse: [			^ SearchResult fail.		]	].</body>

<body package="Faish" selector="builtinAddToSum:">builtinAddToSum: statement	"n:X plus:Y result:Z."	| a b c |	a := statement atIndex: 1.	b := statement atIndex: 2.	c := statement atIndex: 3.	a isVariable ifTrue: [		b isNumber ifTrue: [			c isNumber ifTrue: [				| result |				result := statement copy.				result at: #n put: (FaishLiteral value: (					c value - b value )).				^ SearchResult result: result.			] 		].		^ SearchResult noFail.	].	b isVariable ifTrue: [		a isNumber ifTrue: [			c isNumber ifTrue: [				| result |				result := statement copy.				result at: #plus put: (FaishLiteral value: (					c value - a value )).				^ SearchResult result: result.			] 		].		^ SearchResult noFail.					].	c isVariable ifTrue: [		a isNumber ifTrue: [			b isNumber ifTrue: [				| result |				result := statement copy.				result at: #result put: (FaishLiteral value: (					a value + b value )).				^ SearchResult result: result.			] 		].		^ SearchResult noFail.					].	(a isNumber and: [b isNumber and: [ c isNumber ]])		ifTrue: [ 			((a value + b value) = c value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail ] ]. 	^ SearchResult noFail.</body>

<body package="Faish" selector="builtinIsAtom:">builtinIsAtom: statement	"atom:X."	| a |	a := statement at: #atom.	a isAtom ifTrue: [		^ SearchResult result: statement.	] ifFalse: [		a isVariable ifTrue: [			^ SearchResult noFail.		] ifFalse: [			^ SearchResult fail.		]	].</body>

<body package="Faish" selector="builtinBitAt:">builtinBitAt: statement	"n:X bitAt:Y result:Z."	| a b c |	a := statement at: #n.	b := statement at: #bitAt.	c := statement at: #result.	c isVariable ifTrue: [		a isInteger ifTrue: [			b isInteger ifTrue: [				| result |				result := statement copy.				result at: #result put: (FaishLiteral value: (					(a value) bitAt: (b value) )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.					].	(a isInteger and: [b isInteger and: [ c isInteger ]])		ifTrue: [ 			((a value bitAt: b value) = c value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail ] ]. 	^ SearchResult fail.</body>

<body package="Faish" selector="builtinBitXor:">builtinBitXor: statement	"n:X bitXor:Y result:Z."	| a b c |	"XOR is awesome. Using the same operation, any missing value can be found."	a := statement at: #n.	b := statement at: #bitXor.	c := statement at: #result.	a isVariable ifTrue: [		b isInteger ifTrue: [			c isInteger ifTrue: [				| result |				result := statement copy.				result at: #n put: (FaishLiteral value: (					c value bitXor: b value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.	].	b isVariable ifTrue: [		a isInteger ifTrue: [			c isInteger ifTrue: [				| result |				result := statement copy.				result at: #plus put: (FaishLiteral value: (					c value bitXor: a value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.					].	c isVariable ifTrue: [		a isInteger ifTrue: [			b isInteger ifTrue: [				| result |				result := statement copy.				result at: #result put: (FaishLiteral value: (					a value bitXor: b value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.					].	(a isInteger and: [b isInteger and: [ c isInteger ]])		ifTrue: [ 			((a value bitXor: b value) = c value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail] ]. 	^ SearchResult fail.</body>

<body package="Faish" selector="builtinMultiply:">builtinMultiply: statement	"n:X multiply:Y result:Z."	| a b c |	a := statement atIndex: 1.	b := statement atIndex: 2.	c := statement atIndex: 3.	a isVariable ifTrue: [		b isNumber ifTrue: [			c isNumber ifTrue: [				| result |				(b value = 0) ifTrue: [ ^ nil ].				(c value \\ b value) = 0 ifFalse: [ ^ nil ].				result := statement copy.				result atIndex: 1 put: (FaishLiteral value: (					c value / b value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.	].	b isVariable ifTrue: [		a isNumber ifTrue: [			c isNumber ifTrue: [				| result |				(a value = 0) ifTrue: [^ nil ].				(c value \\ a value) = 0 ifFalse: [ ^ nil ].				result := statement copy.				result atIndex: 2 put: (FaishLiteral value: (					c value / a value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.					].	c isVariable ifTrue: [		a isNumber ifTrue: [			b isNumber ifTrue: [				| result |				result := statement copy.				result atIndex: 3 put: (FaishLiteral value: (					a value * b value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.					].	(a isNumber and: [b isNumber and: [ c isNumber ]])		ifTrue: [ 			((a value * b value) = c value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail ] ]. 	^ nil.</body>

<body package="Faish" selector="builtinIsStatement:">builtinIsStatement: statement	"statement:X."	| a |	a := statement atIndex: 1.	(a isStatement or: [a isStatementLiteral]) ifTrue: [		^ SearchResult result: statement.	] ifFalse: [		a isVariable ifTrue: [			^ SearchResult noFail.		] ifFalse: [			^ SearchResult fail.		]	].</body>

<body package="Faish" selector="builtinLesserGreater:">builtinLesserGreater: statement	"lesser:X greater:Y."	| a b |	a := statement at: #lesser.	b := statement at: #greater.	a isNumber ifTrue: [		b isNumber ifTrue: [			(a value &lt; b value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail ].		].	].	^ SearchResult noFail.</body>

<body package="Faish" selector="builtinDivide:">builtinDivide: statement	"n:X divide:Y result:Z."	| a b c |	a := statement at: #n.	b := statement at: #divide.	c := statement at: #result.	a isVariable ifTrue: [		b isInteger ifTrue: [			c isNumber ifTrue: [				| result |				result := statement copy.				result at: #n put: (FaishLiteral value: (					c value * b value )).				^ SearchResult result: result.			] 		].		^ SearchResult noFail.	].	b isVariable ifTrue: [		a isNumber ifTrue: [			c isNumber ifTrue: [				| result |				c value = 0 ifTrue: [ ^ nil ].				(a value \\ c value) = 0 ifFalse: [ ^ nil ].				result := statement copy.				result at: #plus put: (FaishLiteral value: (					a value / c value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.					].	c isVariable ifTrue: [		a isNumber ifTrue: [			b isNumber ifTrue: [				| result |				b value = 0 ifTrue: [ ^ nil ].				(a value \\ b value) = 0 ifFalse: [ ^ nil ].				result := statement copy.				result at: #result put: (FaishLiteral value: (					a value / b value )).				^ SearchResult result: result.			] 		].		^ SearchResult noFail.					].	(a isNumber and: [b isNumber and: [ c isNumber ]])		ifTrue: [ 			( b value = 0 ) ifTrue: [ ^ nil ].			((a value / b value) = c value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail ] ]. 	^ SearchResult fail.</body>

<body package="Faish" selector="builtinBitAnd:">builtinBitAnd: statement	"n:X bitAnd:Y result:Z."	| a b c |	a := statement at: #n.	b := statement at: #bitAnd.	c := statement at: #result.	c isVariable ifTrue: [		a isInteger ifTrue: [			b isInteger ifTrue: [				| result |				result := statement copy.				result at: #result put: (FaishLiteral value: (					a value bitAnd: b value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.					].	(a isInteger and: [b isInteger and: [ c isInteger ]])		ifTrue: [ 			((a value bitAnd: b value) = c value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail ] ]. 	^ SearchResult fail.</body>

<body package="Faish" selector="builtinIsStatementSignature:">builtinIsStatementSignature: statement	"statementSignature:X."	| a |	" A future implementation will have a difference between statements and signatures. "	a := statement atIndex: 1.	a isStatementLiteral ifTrue: [		^ SearchResult result: statement.	] ifFalse: [		a isVariable ifTrue: [			^ SearchResult noFail.		] ifFalse: [			^ SearchResult fail.		]	].</body>

<body package="Faish" selector="builtinIsModuleLiteral:">builtinIsModuleLiteral: statement	"module:X."	| a |	a := statement at: #module.	a isModuleLiteral ifTrue: [		^ SearchResult result: statement.	] ifFalse: [		a isVariable ifTrue: [			^ SearchResult noFail.		] ifFalse: [			^ SearchResult fail.		]	].</body>

<body package="Faish" selector="builtinBitOr:">builtinBitOr: statement	"n:X bitOr:Y result:Z."	| a b c |	a := statement at: #n.	b := statement at: #bitOr.	c := statement at: #result.	c isVariable ifTrue: [		a isInteger ifTrue: [			b isInteger ifTrue: [				| result |				result := statement copy.				result at: #result put: (FaishLiteral value: (					a value bitOr: b value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.					].	(a isInteger and: [b isInteger and: [ c isInteger ]])		ifTrue: [ 			((a value bitOr: b value) = c value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail ] ]. 	^ nil.</body>

<body package="Faish" selector="builtinCharCodepoint:">builtinCharCodepoint: statement	"char:Char codePoint:Integer"	" This isn't implemented because we don't want characters in the core language. Characters are aweful - they can be multi-byte composed monstrosities. 	Instead, we only support bytes, and arrays of bytes. Characters and Strings are implemented in libraries. "	| a b |	self halt: 'Don''t implement this.'.	a := statement at: #char.	b := statement at: #codePoint.		a isVariable ifTrue: [		b isInteger ifTrue: [			| result |			result := statement copy.			result at: #char put: (FaishLiteral value: (b value asCharacter)).			^ result		].		^ nil.	].	b isVariable ifTrue: [		a isCharacter ifTrue: [			| result |			result := statement copy.			result at: #codePoint put: (FaishLiteral value: (a value asInteger)).			^ result		].		^ nil.					].	(a isCharacter and: [b isInteger])		ifTrue: [ 			(a value asInteger = b value) 				ifTrue: [ ^ statement ]				ifFalse: [ ^ nil ] ]. 	^ nil.</body>

<body package="Faish" selector="builtinIsVariable:">builtinIsVariable: statement	"variable:X."	| a |	a := statement atIndex: 1.	" Obviously it can't be a variable. It needs to be a statement literal. "	a isLiteral ifTrue: [		a value isVariable ifTrue: [			^ SearchResult result: statement.		] 	].	^ SearchResult fail.</body>

<body package="Faish" selector="builtinModulo:">builtinModulo: statement	"n:X divide:Y result:Z."	| a b c |	a := statement at: #n.	b := statement at: #modulo.	c := statement at: #result.	c isVariable ifTrue: [		a isNumber ifTrue: [			b isNumber ifTrue: [				| result |				b value = 0 ifTrue: [ ^ nil ].				result := statement copy.				result at: #result put: (FaishLiteral value: (					a value \\ b value )).				^ SearchResult result: result			] 		].		^ SearchResult noFail.					].	(a isNumber and: [b isNumber and: [ c isNumber ]])		ifTrue: [ 			( b value = 0 ) ifTrue: [ ^ nil ].			((a value \\ b value) = c value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail ] ]. 	^ nil.</body>

<body package="Faish" selector="builtinBitNot:">builtinBitNot: statement	"bitNot:Y result:Z."	| b c |	b := statement at: #bitNot.	c := statement at: #result.	b isVariable ifTrue: [		c isInteger ifTrue: [			| result |			result := statement copy.			result at: #bitNot put: (FaishLiteral value: (				c value bitInvert)).			^ SearchResult result: result		]. 		^ SearchResult noFail.					].	c isVariable ifTrue: [		b isInteger ifTrue: [			| result |			result := statement copy.			result at: #result put: (FaishLiteral value: (				b value bitInvert)).			^ SearchResult result: result		]. 		^ SearchResult noFail.					].	(b isInteger and: [c isInteger])		ifTrue: [ 			((b value bitInvert) = c value) 				ifTrue: [ ^ SearchResult result: statement ]				ifFalse: [ ^ SearchResult fail ] ]. 	^ SearchResult fail.</body>

<body package="Faish" selector="builtinCreateAtom:">builtinCreateAtom: statement	"create:atom result:X."	| a |	a := statement atIndex: 2.	a isVariable ifTrue: [ | r |		r := statement copy.		r atIndex: 2 put: (FaishLiteral value: (FaishAtom new)).		^ SearchResult result: r.	] ifFalse: [		a isAtom ifTrue: [			^ SearchResult result: statement.		]	].	^ SearchResult fail.</body>

<body package="Faish" selector="builtinIsInteger:">builtinIsInteger: statement	"integer:X."	| a |	a := statement at: #integer.	a isInteger ifTrue: [		^ SearchResult result: statement.	] ifFalse: [		a isVariable ifTrue: [			^ SearchResult noFail.		] ifFalse: [			^ SearchResult fail.		]	].</body>

<body package="Faish" selector="builtinRaisedTo:">builtinRaisedTo: statement	"n:X raisedTo:Y result:Z."	| a b c |	a := statement atIndex: 1.	b := statement atIndex: 2.	c := statement atIndex: 3.	a isNumber ifTrue: [		b isNumber ifTrue: [			c isNumber ifTrue: [				((a raisedTo: b)=3) ifTrue: [ 					^ SearchResult result: statement.				] ifFalse: [					^ SearchResult fail.				]			] ifFalse: [				c isVariable ifTrue: [ | r |					r := statement copy.					r atIndex: 3 put: (FaishLiteral value: (a raisedTo: b)).					^ SearchResult result: r.				]			]		] ifFalse: [			b isVariable ifTrue: [				c isNumber ifTrue: [ | r |					r := statement copy.					r atIndex: 2 put: (FaishLiteral value: (c log: b)).					^ SearchResult result: r.				] ifFalse: [					c isVariable ifTrue: [						^ SearchResult noFail.					] ifFalse: [						^ SearchResult fail.					]				]			] ifFalse: [				^ SearchResult fail.			]		]	] ifFalse: [		" This can be done in theory - sqrt for a=2, other roots. But I can't find those operations."		a isVariable ifTrue: [			^ SearchResult noFail.		]	].	^ SearchResult fail.</body>
</methods>

<methods>
<class-id>BuiltInsSearchable</class-id> <category>private</category>

<body package="Faish" selector="moduleQueryUnbind:">moduleQueryUnbind: statement	" Work with the builtinModuleXstatementuery: methods. Unbind the statement. Return nil if error. "	| unbound |	(statement isStatement or: [ statement isVariableLiteral or: [statement isStatementLiteral] ]) ifFalse: [ ^ nil ].	statement isVariableLiteral ifTrue: [		unbound := statement value.	] ifFalse: [		statement isStatementLiteral ifTrue: [			unbound := statement value		] ifFalse: [			unbound := statement copy unbindAllVariables.		]	].	^ unbound.</body>

<body package="Faish" selector="prepend:to:">prepend: c to: tail	| result |	result := String new: (tail size + 1).	result at: 1 put: c.	result replaceFrom: 2 to: (result size) with: tail startingAt: 1.	^ result.</body>

<body package="Faish" selector="makeModuleSearchers">makeModuleSearchers	" I don't need to do this. "</body>

<body package="Faish" selector="tailOf:">tailOf: aString	| result |	result := String new: (aString size - 1).	result replaceFrom: 1		to: (result size)		with: aString		startingAt: 2.	^ result.</body>

<body package="Faish" selector="tail:isTailOf:">tail: aTail isTailOf: aString	" Return true if aTail is equal to aString without the first character. "	2 to: aString size do: [ :i | 		(aTail at: (i-1)) = (aString at: i)			ifFalse: [ ^ false ] ].	^ true.</body>
</methods>

<methods>
<class-id>BuiltInsSearchable</class-id> <category>searching</category>

<body package="Faish" selector="nextChild">nextChild	" I've been through a few iterations and still need refactoring.	SearchResult is no longer needed. I can return a Statement, or nil for a fail. "	| result |	exhausted ifTrue: [ ^ nil ].	exhausted := true. " We only return one goal for now. "	goal isVariable ifTrue: [ ^ nil ].	StatementsBuiltIn keysAndValuesDo: [ :key :action |		(goal matches: key) ifTrue: [			result := action value: self value: goal.			" TODO: These methods need to be refactored to all return a SearchResult. "			(result isMemberOf: SearchResult) ifTrue: [				result isResult ifTrue: [					^ self processNextChild: result statement.				].				result isNoFail ifTrue: [					^ DoNotFailSearchable new						goal: goal;						derivedFrom: self.				].				" Must be a fail then. "				result isFail ifTrue: [					^ nil.				].				self halt: 'impossible case'.			] ifFalse: [				^ self halt: 'TODO'.			].		] 	].	^ nil.</body>
</methods>

<methods>
<class-id>BuiltInsSearchable</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	super initialize.	exhausted := false.	^self</body>
</methods>

<methods>
<class-id>BuiltInsSearchable</class-id> <category>printing</category>

<body package="Faish" selector="sourceCode">sourceCode	^ goal sourceCode.</body>

<body package="Faish" selector="printOn:">printOn: aStream	aStream nextPutAll: 'P '. " P for primitive "	self goal printOn: aStream.</body>
</methods>

<methods>
<class-id>BuiltInsSearchable</class-id> <category>built-ins modules</category>

<body package="Faish" selector="builtinStatementSignatureCreate:">builtinStatementSignatureCreate:statement	"create:statementSignature module:M arity:A result:Si."	| m a si result nothing newsig |	m := statement at: #module.	a := statement at:#arity.	si := statement at: #result.	a isVariable ifTrue: [ ^ SearchResult noFail ].	m isVariable ifTrue: [ ^ SearchResult noFail ].	si isVariable ifFalse: [ ^ SearchResult fail ].	a isInteger ifFalse: [ ^ SearchResult fail ].	m isModuleLiteral ifFalse: [ ^ SearchResult fail ].	(a value &lt; 0) ifTrue: [ ^ SearchResult fail ].	(a value = 0 ) ifTrue: [ 		newsig := FaishAtom new value: (self class nextId).		result := statement copy.		result at: #result put: newsig.			^ SearchResult result: result.	].	newsig := LegacyFaishStatementSignature new.	nothing := FaishAtom from: 'nothing'.	1 to: a value do: [ :i | 		newsig addLabel:(self class nextId) value:nothing.	].	result := statement copy.	" It needs to be a literal. Otherwise all sorts of nasty funky stuff could happen, and the debugger has a spaz."	result at: #result put: (FaishLiteral new value: newsig).	^ SearchResult result: result</body>

<body package="Faish" selector="builtinIteratorNext:">builtinIteratorNext:statement	"iterator:Iterator value:Value next:AnotherIterator."	| prev value next nextIterator result |	prev := statement atIndex: 1.	value := statement atIndex: 2.	next := statement atIndex: 3.	prev isVariable ifTrue: [ ^ SearchResult noFail ].	prev isIteratorLiteral ifFalse: [ ^ SearchResult fail ].	prev value isLast ifTrue: [ ^ SearchResult fail ].	(value isVariable) ifFalse: [		( value matches: prev value value ) ifFalse: [ ^ SearchResult fail ].	].	(next isVariable) ifFalse: [		" Untested code. "		( next value = prev value next) ifFalse: [			^ SearchResult fail.		]	].		prev value value isNil ifTrue: [ ^ SearchResult fail ].	result := statement copy.	" We need to bind the variables to make sure we actually return a result. "	result atIndex: 2 put: (prev value value).	nextIterator := prev value next.	result atIndex: 3 put: (FaishLiteral value: nextIterator ).	^ SearchResult result: result.</body>

<body package="Faish" selector="builtinModuleThis:">builtinModuleThis:statement	"thisModule:M."	| m |	m := statement at: #thisModule.	m isVariable ifTrue: [		| result |		result := statement copy.		result at: #thisModule put: (FaishLiteral value: (ModuleImport new module: module)).		^ SearchResult result: result	] ifFalse: [		^ SearchResult fail.	].</body>

<body package="Faish" selector="builtinStatementCreate:">builtinStatementCreate:statement	"create:statement fromSignature:Si module:M result:Si."	| m si result newstatement |	" It doesn't look like I do much. I don't, but this is needed for API compatibility when I make a real VM. "	si := statement at: #fromSignature.		si isVariable ifTrue: [ SearchResult noFail ].	m := statement at: #module.	m isVariable ifTrue: [ SearchResult noFail ].	result := statement at: #result.	(si isStatementLiteral) ifFalse: [ ^ SearchResult fail ].	result isVariable ifFalse: [ ^ SearchResult fail ].	m isModuleLiteral ifFalse: [ ^ SearchResult fail ].	newstatement := si copy.	result := statement copy.	result at: #result put: newstatement.	^ SearchResult result: result.</body>

<body package="Faish" selector="builtinIteratorExhausted:">builtinIteratorExhausted:statement	"iteratorExhausted: It "	| it |	it := statement atIndex: 1.		it isVariable ifTrue: [ ^ SearchResult noFail ].	it isIteratorLiteral ifFalse: [ ^ SearchResult fail ].		it value isLast ifTrue: [		^ SearchResult result: statement	] ifFalse: [		^ SearchResult fail.	].</body>

<body package="Faish" selector="builtinNotEqual:">builtinNotEqual:statement	"notEqual:X with:Y"	| s s2 |	s := statement atIndex:1.	s2 := statement atIndex:2.	s isVariable ifTrue: [ ^ SearchResult noFail ].	s isFullyUnified ifFalse: [ ^ SearchResult noFail ].	s2 isVariable ifTrue: [ ^ SearchResult noFail ].	s2 isFullyUnified ifFalse: [ ^ SearchResult noFail ].	( s = s2 ) 		ifTrue: [ ^ SearchResult fail ]		ifFalse: [ ^ SearchResult result: statement ].</body>

<body package="Faish" selector="builtinModuleNumResultsDepthLimit:">builtinModuleNumResultsDepthLimit: statement	"module:M query:Q numResults:N depthLimit:D "	| m query numResultsVar numResults searchDepthLiteral searchDepth result |	m := statement atIndex: 1.	query := statement atIndex: 2.	numResultsVar := statement atIndex: 3.	searchDepthLiteral := statement atIndex: 4.		m isVariable ifTrue: [ ^ SearchResult noFail ].	query isVariable ifTrue: [ ^ SearchResult noFail ].	searchDepthLiteral isVariable ifTrue: [ ^ SearchResult noFail ].	" TODO: should we allow checking of number of results, where N is an integer? "	m isModuleLiteral ifFalse: [ ^ SearchResult fail ].	query isStatement ifFalse: [ ^ SearchResult fail ].	searchDepthLiteral isInteger ifFalse: [ ^ SearchResult fail ].	searchDepth := searchDepthLiteral value.	(searchDepth &lt; 1) ifTrue: [ ^ SearchResult fail ].	result := statement copy.	(result atIndex: 2) bindAllVariables.	numResults := m value module numResultsFor: query depthLimit: searchDepth.	numResultsVar isVariable ifTrue: [		result atIndex: 3 put: (FaishLiteral value: numResults).		^ SearchResult result: result.	] ifFalse: [		numResultsVar isInteger ifTrue: [			(numResults = (numResultsVar value)) 				ifTrue: [ ^ SearchResult result: result ]				ifFalse: [ ^ SearchResult fail ]		] ifFalse: [ ^ SearchResult noFail ].	].			" Unreachable. "	^ SearchResult fail.</body>

<body package="Faish" selector="builtinModuleCreate:">builtinModuleCreate:statement	"create:module result:M."	| m |	m := statement at: #result.	m isVariable ifTrue: [		| result |		result := statement copy.		result at: #result put: (FaishLiteral value: (ModuleImport new module:(CodeModule new))).		^ SearchResult result: result	] ifFalse: [		^ SearchResult fail.	].</body>

<body package="Faish" selector="builtinModuleNumResultsStepLimit:">builtinModuleNumResultsStepLimit: statement	"module:M query:Q numResults:N stepLimit:D "	| m query numResultsVar numResults searchDepthLiteral searchDepth result |	m := statement atIndex: 1.	query := statement atIndex: 2.	numResultsVar := statement atIndex: 3.	searchDepthLiteral := statement atIndex: 4.		" TODO: should we allow checking of number of results, where N is an integer? "	m isVariable ifTrue: [ ^ SearchResult noFail ].	query isVariable ifTrue: [ ^ SearchResult noFail ].	searchDepthLiteral isVariable ifTrue: [ ^ SearchResult noFail ].	m isModuleLiteral ifFalse: [ ^ SearchResult fail ].	query isStatement ifFalse: [ ^ SearchResult fail ].	searchDepthLiteral isInteger ifFalse: [ ^ SearchResult fail ].	searchDepth := searchDepthLiteral value.	(searchDepth &lt; 1) ifTrue: [ ^ SearchResult fail ].	result := statement copy.	(result atIndex: 2) bindAllVariables.	numResults := m value module numResultsFor: query stepLimit: searchDepth.	numResultsVar isVariable ifTrue: [		result atIndex: 3 put: (FaishLiteral value: numResults).		^ SearchResult result: result.	] ifFalse: [		numResultsVar isInteger ifTrue: [			(numResults = (numResultsVar value)) 				ifTrue: [ ^ SearchResult result: result ]				ifFalse: [ ^ SearchResult fail ]		] ifFalse: [ ^ SearchResult fail ].	].			" Unreachable. "	^ SearchResult fail.</body>

<body package="Faish" selector="builtinModuleSimpleNumResults:">builtinModuleSimpleNumResults: statement	"module:M simpleQuery:Q numResults:N  "	| m query numResultsVar numResults result unbound |	m := statement atIndex: 1.	query := statement atIndex: 2.	numResultsVar := statement atIndex: 3.	m isVariable ifTrue: [ ^ SearchResult noFail ].	m isModuleLiteral ifFalse: [ ^ SearchResult fail ].	unbound := self moduleQueryUnbind: query.	unbound ifNil: [ ^ SearchResult fail ].		result := statement copy.	(result atIndex: 2) bindAllVariables.	numResults := m value module numResultsFor: unbound depthLimit: 2. "UnificationSearchable -&gt; UnificationSearchableFinished"	numResultsVar isVariable ifTrue: [		result atIndex: 3 put: (FaishLiteral value: numResults).		^ SearchResult result: result.	] ifFalse: [		numResultsVar isInteger ifTrue: [			(numResults = (numResultsVar value)) 				ifTrue: [ ^ SearchResult result: result ]				ifFalse: [ ^ SearchResult fail ]		] ifFalse: [ ^ SearchResult fail ].	].			" Unreachable. "	^ SearchResult fail.</body>

<body package="Faish" selector="builtinStatementGetSignature:">builtinStatementGetSignature:statement	"statement:S signature:Si."	| s sig result |	" TODO: you could also use this to find all statements of a signature. "	s := statement atIndex: 1.	sig := statement atIndex: 2.		s isVariable ifTrue: [ ^ SearchResult noFail ].	s isStatementLiteral ifFalse: [ ^ SearchResult fail ].	result := statement copy.	sig isVariable 	ifTrue: [		result atIndex: 2 put:(FaishLiteral new value: (s value signature)). ]	ifFalse: [ 		((s value signature) = sig value) ifFalse: [			^ SearchResult fail ]].			^ SearchResult result: result</body>

<body package="Faish" selector="builtinModuleAdd:">builtinModuleAdd:statement	"module:M add:Statement result:M2"	| m s m2 result |	m := statement atIndex:1.	s := statement atIndex:2.	m2 := statement atIndex:3.	s isVariable ifTrue: [ ^ SearchResult noFail ].	" We are not going to implement diffing two modules to find the statement that changed. "	s isFullyUnified ifFalse: [ ^ SearchResult noFail ].	m isVariable ifTrue: [ 		" We are removing a statement. "		m2 isVariable ifTrue: [				^ SearchResult noFail 		].		m2 isModuleLiteral ifFalse: [ ^ SearchResult fail ].		m := m2 value module copy.		m remove: s copy unbindAllVariables.		result := statement copy.		result atIndex: 1 put: (FaishLiteral value: (ModuleImport new module:m)).		^ SearchResult result: result.	].	m2 isVariable ifTrue: [ 		" We are adding a statement. "		m isVariable ifTrue: [				^ SearchResult noFail 		].		m isModuleLiteral ifFalse: [ ^ SearchResult fail ].		m2 := m value module copy.		m2 add: s copy unbindAllVariables.		result := statement copy.		result atIndex: 3 put: (FaishLiteral value: (ModuleImport new module:m2)).		^ SearchResult result: result.	].	^ SearchResult noFail.</body>

<body package="Faish" selector="builtinStatementSize:">builtinStatementSize:statement	"statement:X arity:Y."	| s result |	" It doesn't look like I do much. I don't, but this is needed for API compatibility when I make a real VM. "	s := statement atIndex: 1.	s isVariable ifTrue: [ ^ SearchResult noFail ].	(s isStatement and: [ 	(statement at: #arity) isVariable ] )	ifTrue: [		result := statement copy.		result at: #arity put: (FaishLiteral new value: (s size)).		^ SearchResult result: result	] ifFalse: [ 		^ SearchResult fail. 	].</body>

<body package="Faish" selector="builtinModuleSimpleQuery:">builtinModuleSimpleQuery: statement	"module:Module simpleQuery:Query results:ResultsModule. "	| m q result iterator searcher unbound |	m := statement atIndex: 1.	m isVariable ifTrue: [ ^ SearchResult noFail ].	m isModuleLiteral ifFalse: [ ^ SearchResult fail ].	q := statement atIndex: 2.	unbound := self moduleQueryUnbind: q.	unbound ifNil: [ ^ SearchResult fail ].	searcher := MatchingModuleSearcher module: (m value module) searchingFor: unbound. 	iterator := IteratorLiteral searcher: searcher.	result := statement copy.	(result atIndex: 2) bindAllVariables.	result atIndex: 3 put: (FaishLiteral value: iterator).	^ SearchResult result: result.</body>

<body package="Faish" selector="builtinModuleNumResultsTimeLimit:">builtinModuleNumResultsTimeLimit: statement	"module:M query:Q numResults:N timeLimit:D "	| m query numResultsVar numResults searchDepthLiteral searchDepth result |	m := statement atIndex: 1.	query := statement atIndex: 2.	numResultsVar := statement atIndex: 3.	searchDepthLiteral := statement atIndex: 4.		m isVariable ifTrue: [ ^ SearchResult noFail ].	query isVariable ifTrue: [ ^ SearchResult noFail ].	searchDepthLiteral isVariable ifTrue: [ ^ SearchResult noFail ].	" TODO: should we allow checking of number of results, where N is an integer? "	m isModuleLiteral ifFalse: [ ^ SearchResult fail ].	query isStatement ifFalse: [ ^ SearchResult fail ].	searchDepthLiteral isInteger ifFalse: [ ^ SearchResult fail ].	searchDepth := searchDepthLiteral value.	(searchDepth &lt; 1) ifTrue: [ ^ SearchResult fail ].	result := statement copy.	(result atIndex: 2) bindAllVariables.	numResults := m value module numResultsFor: query timeLimit: searchDepth.	numResultsVar isVariable ifTrue: [		result atIndex: 3 put: (FaishLiteral value: numResults).		^ SearchResult result: result.	] ifFalse: [		numResultsVar isInteger ifTrue: [			(numResults = (numResultsVar value)) 				ifTrue: [ ^ SearchResult result: result ]				ifFalse: [ ^ SearchResult fail ]		] ifFalse: [ ^ SearchResult fail  ].	].			" Unreachable. "	^ SearchResult fail.</body>

<body package="Faish" selector="builtinStatementGetValue:">builtinStatementGetValue:statement	"statement:S index:I value:V."	| st s i v s2 result |	st := statement atIndex: 1.	i := statement atIndex: 2.	v := statement atIndex: 3.		st isVariable ifTrue: [ ^ SearchResult noFail ].	i isVariable ifTrue: [ ^ SearchResult noFail ].	(st isStatement or: [st isStatementLiteral]) ifFalse: [ ^ SearchResult fail ].	s := st unwrap.	i isInteger ifFalse: [ ^ SearchResult fail ].	i value &lt; 1 ifTrue: [ ^ SearchResult fail ].	i value &gt; (s arguments size) ifTrue: [ ^ SearchResult fail ].	v isVariable ifTrue: [		s2 := (s atIndex: (i value)) copy.		result := statement copy.		s2 isVariable ifTrue: [ s2 := s2 wrap ].		result atIndex: 3 put: s2.		^ SearchResult result: result.	] ifFalse: [		(v unwrap = (s atIndex: (i value) )) ifTrue: [			^ SearchResult result: statement.		].	].	^ SearchResult fail.</body>

<body package="Faish" selector="builtinModuleSimpleQueryUnunified:">builtinModuleSimpleQueryUnunified: statement	"module:Module simpleQueryUnunified:Query results:ResultsModule. "	| m q result iterator searcher unbound |	m := statement atIndex: 1.	m isVariable ifTrue: [ ^ SearchResult noFail ].	m isModuleLiteral ifFalse: [ ^ SearchResult fail ].	q := statement atIndex: 2.	unbound := self moduleQueryUnbind: q.	unbound ifNil: [ ^ SearchResult fail ].		searcher := MatchingUnunifiedModuleSearcher module: (m value module) searchingFor: unbound. 	iterator := IteratorLiteral searcher: searcher.	result := statement copy.	(result atIndex: 2) bindAllVariables.	result atIndex: 3 put: (FaishLiteral value: iterator).	^ SearchResult result: result.</body>

<body package="Faish" selector="builtinModuleSize:">builtinModuleSize: statement	"module:M size:N."	| m s |	m := statement atIndex:1.	s := statement atIndex:2.	m isModuleLiteral ifTrue: [		s isVariable ifTrue: [ | r  |			r := statement copy.			r atIndex: 2 put: (FaishLiteral value: (m value size)).			^ SearchResult result: r.		] ifFalse: [			s isNumber ifTrue: [				(s value = module size) ifTrue: [					^ SearchResult result: statement.				]			]		]	].	^ SearchResult fail.</body>

<body package="Faish" selector="builtinModuleQuery:">builtinModuleQuery: statement	"module:Module query:Query iterator:Iterator. "	| m q result searcher iterator unbound |	m := statement atIndex: 1.	m isVariable ifTrue: [ ^ SearchResult noFail ].	m isModuleLiteral ifFalse: [ ^ SearchResult fail ].	q := statement atIndex: 2.	q isFullyUnified ifFalse: [ ^ SearchResult noFail ].		" In theory, we could support comparing iterators. But heck. "	(statement atIndex: 3) isVariable ifFalse: [ ^ SearchResult fail ].	unbound := self moduleQueryUnbind: q.	unbound ifNil: [ ^ SearchResult fail ].		searcher := Searcher new query: unbound module: (m value module). 	searcher stepLimit: 10000. " TODO: get this, somehow, from the search that is calling me. "	iterator := IteratorLiteral searcher: searcher.	result := statement copy.	"(result atIndex: 2) bindAllVariables."	result atIndex: 3 put: (FaishLiteral value: iterator).	^ SearchResult result: result.</body>

<body package="Faish" selector="builtinStatementSetValue:">builtinStatementSetValue:statement	"statement:S index:I value:V result:Result."	| s sv i v s2 result |	s := statement atIndex: 1.	i := statement atIndex: 2.	v := statement atIndex: 3.		s isVariable ifTrue: [ ^ SearchResult noFail ].	i isVariable ifTrue: [ ^ SearchResult noFail ].	v isVariable ifTrue: [ ^ SearchResult noFail ].		s isStatementLiteral ifFalse: [ ^ SearchResult fail ].	sv := s value.	i isInteger ifFalse: [ ^ SearchResult fail ].	i value &lt; 1 ifTrue: [ ^ SearchResult fail ].	i value &gt; (sv arguments size) ifTrue: [ ^ SearchResult fail ].	(statement atIndex: 4) isVariable ifFalse: [ ^ SearchResult fail ].		result := statement copy.	s2 := sv copy.	s2 atIndex:(i value) put: v unwrap.	result atIndex: 4 put: (FaishLiteral value: s2).	^ SearchResult result: result.</body>

<body package="Faish" selector="builtinNoResults:">builtinNoResults:statement	"noResults:Q.	 Succeed if the query Q cannot find results. Use the existing step/depth/time limits. "		"TODO: this should fail if statement contains non-escaped variables. 	 Before execution, all variables should be unescaped. "		| q result next unbound searcher |	q := statement atIndex:1.	q isVariable ifTrue: [ ^ SearchResult noFail ].	q isStatement ifFalse: [ ^ SearchResult fail ]. " Continue searching. I don't know why anybody would ever implement this though."	unbound := q copy unbindAllVariables.		searcher := Searcher new query: unbound module: module. 	searcher stepLimit: 10000. " TODO: get this, somehow, from the search that is calling me. "	next := searcher next. " We only care about whether there is not one result. "		next isNil ifTrue: [ 		result := statement copy.		(result atIndex: 1) bindAllVariables.		^ SearchResult result: result.	].	" But what if we get a StepsExceeded? Still fail? "	^ SearchResult fail.</body>
</methods>


<methods>
<class-id>FaishLiteral class</class-id> <category>instance creation</category>

<body package="Faish" selector="comparibles">comparibles	" Return a list of all comparible classes. "	Comparibles isNil ifTrue: [ | c |		Comparibles := OrderedCollection new.		c := Comparibles. "Shorthand"		c add: ArrayedCollection.		c add: Character.		" Not float. "		c add: SmallInteger.		" TODO: big integers. "		" IteratorLiterals? "		" c add: FaishStatement. --removed because statements can be created with primitives, making them uncomparible."		c add: ByteString.		c add: ByteArray.		" Not variables. _ will always be different from each other. "		c add: ModuleImport.	].	^ Comparibles.</body>

<body package="Faish" selector="reset">reset	" FaishLiteral reset "	Comparibles := nil.</body>

<body package="Faish" selector="value:">value: anObject	^ self new value: anObject.</body>
</methods>


<methods>
<class-id>FaishLiteral</class-id> <category>comparing</category>

<body package="Faish" selector="=">= anotherLiteral	| myClass otherClass |	(anotherLiteral isMemberOf: FaishLiteral) ifFalse: [ ^ false ].	myClass := self value class.	otherClass := anotherLiteral value class.	myClass = otherClass ifFalse: [ ^ false ].	^ self value = anotherLiteral value</body>

<body package="Faish" selector="mostlyEquals:">mostlyEquals: anotherLiteral	| myClass otherClass |	(anotherLiteral isMemberOf: FaishLiteral) ifFalse: [ ^ false ].	myClass := self value class.	otherClass := anotherLiteral value class.	myClass = otherClass ifFalse: [ ^ false ].	(((self class comparibles) includes: myClass)		and: [ (self class comparibles) includes: otherClass ])	ifTrue: [		^ self value = anotherLiteral value	] ifFalse: [		^ true. "Probably. We can't compare them. "	].</body>
</methods>

<methods>
<class-id>FaishLiteral</class-id> <category>testing</category>

<body package="Faish" selector="isIteratorLiteral">isIteratorLiteral	^ value isMemberOf: IteratorLiteral.</body>

<body package="Faish" selector="isVariableLiteral">isVariableLiteral	^ value isKindOf: FaishVariable.</body>

<body package="Faish" selector="isUnwrappable">isUnwrappable	^ ((self isStatementLiteral) or: [ self isVariableLiteral ]) or: [ self isAtomLiteral ].</body>

<body package="Faish" selector="isAtomLiteral">isAtomLiteral	^ value isKindOf: FaishAtom.</body>

<body package="Faish" selector="isLiteral">isLiteral	^ true.</body>

<body package="Faish" selector="isCharacter">isCharacter	^ self isInteger.</body>

<body package="Faish" selector="isInteger">isInteger	^ value isInteger.</body>

<body package="Faish" selector="isArray">isArray	^ value isKindOf: SequenceableCollection.</body>

<body package="Faish" selector="isNumber">isNumber	^ value isInteger or: [ value isKindOf: LimitedPrecisionReal].</body>

<body package="Faish" selector="isString">isString	^ value isKindOf: ByteArray.</body>

<body package="Faish" selector="isFloat">isFloat	^ value isKindOf: LimitedPrecisionReal. " ...nerds. Call it a float. "</body>

<body package="Faish" selector="isModuleLiteral">isModuleLiteral	^ value isKindOf: ModuleImport.</body>

<body package="Faish" selector="isStatementLiteral">isStatementLiteral	^ value isKindOf: LegacyFaishStatement.</body>
</methods>

<methods>
<class-id>FaishLiteral</class-id> <category>accessing</category>

<body package="Faish" selector="sid">sid	" See FaishSession&gt;&gt;prepopulateSignatures:"	self isInteger ifTrue: [ ^ 20 ].	self notYetImplemented.</body>

<body package="Faish" selector="value">value	^value</body>
</methods>

<methods>
<class-id>FaishLiteral</class-id> <category>initialize-release</category>

<body package="Faish" selector="value:">value: anObject	( anObject isKindOf: Fraction ) ifTrue: [		value := anObject asFloat.		^ self.	].	value := anObject</body>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	value := nil.	^self</body>
</methods>

<methods>
<class-id>FaishLiteral</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: aStream	^ self printOn: aStream limit: 4000000.</body>

<body package="Faish" selector="printStatementLiteralOn:limit:">printStatementLiteralOn: aStream limit: numChars	| n s c |	" Delete me "	s := ReadWriteStream on: (String new: 80).	n := numChars.	n := value printOn: s limit: n.	s reset.	aStream nextPut: $\.	n := n - 1.	[ s atEnd ] whileFalse: [ 		c := s next.		aStream nextPut: c.		(c = $]) ifTrue: [ 			aStream nextPut: $].		].		n := n - 1.	].	aStream nextPut: $..	aStream nextPut: $].	^ n - 3.</body>

<body package="Faish" selector="printOn:limit:">printOn: aStream limit: numChars	aStream nextPut: $[.	(value isKindOf: FaishLiteral) ifTrue: [		aStream nextPut: $\.		value printOn: aStream limit: (numChars-2).		aStream nextPut: $].		^ numChars - 2.	].	( value isString or: [ value isKindOf: ByteArray ]) ifTrue: [		aStream nextPut: $".		self printWithDoubleBrackets: value on: aStream.		aStream nextPut: $].		^ numChars - (value size) - 3.	].	(value isKindOf: Character) ifTrue: [		(value = $] ) ifTrue: [			aStream nextPut: $]; nextPut: $].			^ numChars - 3.		].		aStream nextPut: $'.		aStream nextPut: value. 		aStream nextPut: $].		^ numChars - 4.	].	value isInteger ifTrue: [		value &gt;= 0 ifTrue: [ aStream nextPut: $+ ].		value printOn: aStream.		aStream nextPut: $].		^ numChars - 3 - (value displayString size).	].	(value isMemberOf: FaishVariable) ifTrue: [		aStream nextPut: $\.		aStream nextPutAll: (value printString).		aStream nextPut: $].		^ numChars - 3 - (value value size).	].	(value isKindOf: LimitedPrecisionReal) ifTrue: [		aStream nextPut: $#.		value printOn: aStream.		aStream nextPut: $].		^ numChars - 3 - (value displayString size).	].	(value isKindOf: FaishStatementComponent) ifTrue: [		^ self printStatementLiteralOn: aStream limit: numChars.	].	(value isMemberOf: ModuleImport) ifTrue: [		value handle isNil not ifTrue: [ 			aStream nextPut: $	;				nextPutAll: value handle;				nextPut: $].			^ numChars - 3 - (value handle size).		] ifFalse: [ ^ numChars -1 ].	].	(value isKindOf: SequenceableCollection) ifTrue: [ | s |		" TODO: decent array literal syntax. "		aStream nextPutAll: ' '.		( value isKindOf: ByteArray ) ifTrue: [ 			" Assume that byte arrays are strings. "			aStream nextPut: $'.			s := 1.			value do: [ :each |				aStream nextPut: (Character codePoint: each ).				s := s + (each printString size) + 1.			].		] ifFalse: [			s := 1.			value do: [ :each |				aStream nextPutAll: (each printString).				aStream nextPut: $ .				s := s + (each printString size) + 1.			].		].		aStream nextPut: $].		^ numChars - s - 1.	].	(value isKindOf: IteratorLiteral) ifTrue: [ | s |		s := '" (iterator not printable) ]'.		aStream nextPutAll: s.		^ numChars - s size.	].	self halt: 'Funny looking literal managed to sneak into a statement somehow.'.</body>
</methods>

<methods>
<class-id>FaishLiteral</class-id> <category>converting</category>

<body package="Faish" selector="unwrap">unwrap	" If I contain a statement, atom or variable, return it. "	(self isUnwrappable) ifTrue: [ ^ self value ] ifFalse: [ ^ self ].</body>
</methods>

<methods>
<class-id>FaishLiteral</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="copy">copy	^ FaishLiteral value: value copy.</body>

<body package="Faish" selector="heuristic">heuristic	" This seems to conveniently work for most objects. "	^ value hash.</body>

<body package="Faish" selector="&lt;=">&lt;= anotherLiteral	^ self value &lt;= anotherLiteral value</body>

<body package="Faish" selector="isFullyUnified">isFullyUnified	^ true.</body>
</methods>


<methods>
<class-id>MaximisationSearchable class</class-id> <category>instance creation</category>

<body package="Faish" selector="from:goal:">from: anotherSearchable goal: aGoal	^ self new parent: anotherSearchable; goal: aGoal.</body>
</methods>


<methods>
<class-id>MaximisationSearchable</class-id> <category>accessing</category>

<body package="Faish" selector="goal">goal	^ goal conclusion</body>
</methods>

<methods>
<class-id>MaximisationSearchable</class-id> <category>searching</category>

<body package="Faish" selector="nextChild">nextChild	| searcher next nextValue biggestValue biggestStatement |	searcher := Searcher new 		deductionQuery: goal 		module: module		heuristic: nil " TODO: not used. "		derivedFrom: derivedFrom		origStatement: goal.	searcher stepLimit: 5000. "TODO"	biggestValue := nil.	biggestStatement := nil.	[ searcher hasMoreResults ] whileTrue: [		" TODO: an optimization would be to make the variable a MaximisationVariable. It will only bind to values bigger than the current one. Also, the search should consult metadata and cleverly use indexes. "		next := searcher next.		next isNil ifTrue: [			^ self processNextChild: biggestStatement conclusion. " Will be nil if nothing found. "		].		nextValue := self getMaximiseVariableValue: next.		biggestValue isNil ifTrue: [ 			biggestValue := nextValue.			biggestStatement := next.		] ifFalse: [ 			(biggestValue &lt;= nextValue) ifTrue: [				biggestValue := nextValue.				biggestStatement := next.			].		].	].	^ self processNextChild: biggestStatement conclusion.</body>

<body package="Faish" selector="isGoal">isGoal	" TODO: ??? "	^ false.</body>

<body package="Faish" selector="getMaximiseVariableValue:">getMaximiseVariableValue: next	goal " is an then-if statement "		recurseWith: next		atEachLevel: [ :me :other |			(me == maximiseVariable) ifTrue: [				^ other.			].		].	self error.</body>
</methods>

<methods>
<class-id>MaximisationSearchable</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	super initialize.	^self</body>

<body package="Faish" selector="statement:">statement: aGoal	goal := aGoal.	maximiseVariable := aGoal maximiseVariable.</body>
</methods>


<methods>
<class-id>AbstractModule class</class-id> <category>class initialization</category>

<body package="Faish" selector="initialize">initialize	" These are pre-parsed module templates. "	StatementModuleName := (AbstractModule new) parse: 'module:ThisModule metadata:(name:Y).'.	StatementImport := (AbstractModule new) parse: 'module:ThisModule metadata:(importModule:X name:Y uri:Z).'.</body>
</methods>

<methods>
<class-id>AbstractModule class</class-id> <category>instance creation</category>

<body package="Faish" selector="hintQuery">hintQuery	| hintString stream |	hintString := 'hint:(			statement:S			node:_			thread:_			relayIn:_			relayOut:_			advice:_ ).'.	stream := ReadStream on: hintString.	^ LegacyFaishStatement readFrom: stream onError: [ self error ].</body>

<body package="Faish" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>AbstractModule</class-id> <category>intelligence</category>

<body package="Faish" selector="doReward">doReward	" Moot point - this module probably is manually coded. "</body>

<body package="Faish" selector="doEvolution">doEvolution</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>accessing</category>

<body package="Faish" selector="isTestModule">isTestModule	self halt: 'Remove me!'.</body>

<body package="Faish" selector="isReadOnly">isReadOnly	readOnly isNil ifTrue: [ ^ false ].	^ readOnly.</body>

<body package="Faish" selector="exports:">exports: aStatement	" Return whether this module exports statements which could match aStatement. I.e. return true if there is a statements, export:X where X matches aStatement. "	| m q next |	" TODO: make me faster. Or, make it such that I'm not even needed. One problem is that you can't search for export:(then:Foo if:...)."	q := self parse: 'export:X?'.	m := MatchingSimpleModuleSearcher module: self searchingFor: q.	[ 			next := m nextIncludingUnunified.		next isResult  	] whileTrue: [ 		( next statement matchesGoal: next statement) ifTrue: [ ^ true ].	].	^ false.</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>copying</category>

<body package="Faish" selector="copy">copy	| result |	result := super copy.	^ result copyFrom: self.</body>

<body package="Faish" selector="copyFrom:">copyFrom: another	axioms := another statements copy.</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>private</category>

<body package="Faish" selector="processSpecialStatement:">processSpecialStatement: aStatement	" Test whether that statement is special (e.g. metadata:(name:[""foo]) ) and react accordingly.	  Special rules are currently:		* module:thisModule metadata:(name:Foo) (redefines name, will fail if there is already a name)		* module:thisModule metadata:(import:AnotherModuleUUID name:name) (adds a module import). "	aStatement isVariable ifTrue: [ 		" It matches everything. "		^ self 	].	(aStatement matches: StatementModuleName) ifTrue: [		self renameFromStatement: aStatement. 		^ self. 	].	(aStatement matches: StatementImport) ifTrue: [		self addImportFromStatement: aStatement.		 ^ self. 	].</body>

<body package="Faish" selector="addImportFromStatement:">addImportFromStatement: aStatement	| moduleImport |	moduleImport := ((aStatement at: #metadata) at: #importModule) value.	moduleImport module isNil ifTrue: [ 		moduleImport findModuleOnError: [ :message :pos |			errors add: message.			^ self.		].	].	imports add: moduleImport module.</body>

<body package="Faish" selector="renameFromStatement:">renameFromStatement: aStatement	name := ((aStatement at: #metadata) at: #name) value asString.</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>queries</category>

<body package="Faish" selector="withQuery:do:ifNoResults:limitTo:">withQuery: aString do: aBlock ifNoResults: anotherBlock limitTo: maxNumResults	" Do the query. If a result is found, pass it as an argument into aBlock. Otherwise evaluate anotherBlock. I return either the result of anotherBlock value, or nil. "	| query result n |	n := maxNumResults.	query := Searcher new queryString: aString module: self onError: [ :errorString :i | self halt: errorString ].	query stepLimit: 5000.	" Determine if there are no results. "	result := query next.	( result isNil and: [ query hasMoreResults not ] ) 		ifTrue: [ ^ anotherBlock value ]		ifFalse: [ aBlock value: result ].	" Do the iteration. "	[ query hasMoreResults ] whileTrue: [		n := n - 1.		( n &lt; 1 ) ifTrue: [ ^ nil ].		result := query next.		result isNil ifFalse: [ aBlock value: result ].	].	^ nil.</body>

<body package="Faish" selector="query:">query: aString	" Don't use this method. It's only used for tests. Use &gt;&gt;query:onError: which will give you a chance to handle errors. "	| result |	result := self queryString: aString onError: [ :errorString :sourceIndex | self halt: errorString ].	result stepLimit: 10000.	^ result.</body>

<body package="Faish" selector="queryString:onError:">queryString: aString onError: errorBlock	" Return the query, derived from my memory. If the query has variables in it, try to unify those variables with existing knowledge. If the query is not true (i.e. it can not be derived from the database), return nil. 	You need to set a limit on the query, or it will fail."	| result |	result := Searcher new queryString: aString module: self onError: errorBlock.	^ result.</body>

<body package="Faish" selector="numResultsFor:stepLimit:">numResultsFor: aQuery stepLimit: steps	" Perform that query and return the number of results found. Limit deductions to a number of steps. Return the number of unique results. Use depth=1 for a simple query. "	| query n next |	query := Searcher new query: aQuery module: self.	query stepLimit: steps.	n := 0.	[ query hasMoreResults and: [ query wasStopped not ]  ] whileTrue: [		next := query next.		(next isNil not and: [ next isStatement ]) ifTrue: [ n := n + 1 ].	].	^ n.</body>

<body package="Faish" selector="withQuerySimply:do:ifNoResults:limitTo:">withQuerySimply: aString do: aBlock ifNoResults: anotherBlock limitTo: maxNumResults	" Do the query. If a result is found, pass it as an argument into aBlock. Otherwise evaluate anotherBlock. I return either the result of anotherBlock value, or nil. "	| query searcher result n |	" TODO: it makes no sense to have maxNumResults. "	n := maxNumResults.	query := self parse: aString onError: [ :errorString :i | self halt: errorString ].	searcher := MatchingModuleSearcher module: self searchingFor: query.	" Determine if there are no results. "	result := searcher next.	( result isResult ) 		ifTrue: [ aBlock value: result statement ]		ifFalse: [ ^ anotherBlock value ].	" Do the iteration. "	[ 			result := searcher next.		result isResult 	] whileTrue: [			aBlock value: result statement.			n := n - 1.			( n &lt; 1 ) ifTrue: [ ^ nil ].		].	^ nil.</body>

<body package="Faish" selector="numResultsFor:timeLimit:">numResultsFor: aQuery timeLimit: time	" Perform that query and return the number of results found. Limit deductions to a number of steps. Return the number of unique results. Use depth=1 for a simple query. "	| query n next |	query := Searcher new query: aQuery module: self.	query timeLimit: time.	n := 0.	[ query hasMoreResults ] whileTrue: [		next := query next.		(next isNil not and: [ next isStatement ]) ifTrue: [ n := n + 1 ].	].	^ n.</body>

<body package="Faish" selector="querySimply:">querySimply: aString	^ self querySimply: aString onError: [ :errorString :sourceIndex | self halt: errorString ].</body>

<body package="Faish" selector="numResultsFor:depthLimit:">numResultsFor: aQuery depthLimit: depth	" Perform that query and return the number of results found. Limit deductions to depth levels. Return the number of unique results. Use depth=1 for a simple query. "	| query n next |	query := Searcher new query: aQuery module: self.	query depthLimit: depth.	n := 0.	[ query hasMoreResults ] whileTrue: [		next := query next.		(next isNil not and: [ next isStatement ]) ifTrue: [ n := n + 1 ].	].	^ n.</body>

<body package="Faish" selector="query:onError:">query: aStatement onError: errorBlock	" Return the query, derived from my memory. If the query has variables in it, try to unify those variables with existing knowledge. If the query is not true (i.e. it can not be derived from the database), return nil. 	You need to set a limit on the query, or it will fail."	| result |	result := Searcher new query: aStatement module: self.	^ result.</body>

<body package="Faish" selector="querySimply:onError:">querySimply: aString onError: errorBlock	" Return the query, but do no deduction. Only find simple results and do not interpret or return if:then: rules. "	| query ms |	query := self parse: aString onError: errorBlock.	ms := MatchingSimpleModuleSearcher module: self searchingFor: query.	^ ms.</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	axioms := OrderedCollection new.	imports := OrderedCollection new.	" All empty modules have the same uuid and are equal. "	uuid :=  (Security.MD5 hash: (0 printString)) asHexString.	modified := true.	needsReset := false.	self clearErrors.</body>

<body package="Faish" selector="allTestsDo:">allTestsDo: aBlock	| q |	q := self parse: 'test:X?'.	axioms do: [ :each |  | test |		test := nil.		(each conclusionMatches: q) ifTrue: [			test := each conclusion.		] ifFalse: [			(each matches: q) ifTrue: [ 				test := each at: #test.			]		].		test isNil ifFalse: [			test isStatement ifTrue: [				aBlock value: (test value)			]		].	].</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>id</category>

<body package="Faish" selector="repositoryFilename">repositoryFilename	self recalculateIdIfNeeded.	^ uuid, '.squl'.</body>

<body package="Faish" selector="recalculateId">recalculateId	| moduleSourceStream result |	" Recalculated my MD5 digest, and return the source code as a string for possibly reuse by the caller. "	moduleSourceStream := WriteStream on: (String new: 4096).	axioms do: [ :each |		each writeOn: moduleSourceStream.		moduleSourceStream cr; cr.	].	result := moduleSourceStream contents. " possible optimisation: use &gt;&gt;collection instead here to prevent copying. "	uuid := (Security.MD5 hash: result) asHexString.	modified := false.	^result.</body>

<body package="Faish" selector="uuid">uuid	" TODO: use &gt;&gt;id instead. "	^ self id.</body>

<body package="Faish" selector="recalculateIdIfNeeded">recalculateIdIfNeeded	modified ifTrue: [ self recalculateId ].</body>

<body package="Faish" selector="id">id	^ uuid.</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>hints</category>

<body package="Faish" selector="reset">reset	" Clear and re-query all the hints. In the future, I might do other stuff."	|  hintQ hintI |	" There are quite a few possible ways of doing this. This one is the 'nuke it from orbit' approach. "		" See also prepareHintsFor&gt;&gt;"		hintQ := AbstractModule hintQuery.	hintI := hintQ atIndex: 1.		axioms do: [:each | 		each isStatement ifTrue: [			self setHintsAvailableForStatement: each preparedHintsQuery: hintQ arg1: hintI.		].	].	needsReset := false.</body>

<body package="Faish" selector="setHintsAvailableForStatement:preparedHintsQuery:arg1:">setHintsAvailableForStatement: s preparedHintsQuery: hintQ arg1: hintI	| q |	s hintsAvailable: false.	hintI atIndex: 1 put: s.	q := MatchingUnunifiedModuleSearcher module: self searchingFor: hintQ.	(q next) isResult ifTrue: [		s hintsAvailable: true.	].	( s isIfThenRule ) ifTrue: [		s premisesDo: [ :each |			each isStatement ifTrue: [ 				each hintsAvailable: false.				hintI atIndex: 1 put: each.				q := MatchingUnunifiedModuleSearcher module: self searchingFor: hintQ.				(q next) isResult ifTrue: [					each hintsAvailable: true.				].			].		].	].</body>

<body package="Faish" selector="prepareHintsFor:">prepareHintsFor: statement	" See also &gt;&gt;reset. "	| hintQ hintI |	hintQ := AbstractModule hintQuery.	hintI := hintQ atIndex: 1.	self setHintsAvailableForStatement: statement preparedHintsQuery: hintQ arg1: hintI.</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>streams</category>

<body package="Faish" selector="readFrom:onError:">readFrom: aStream onError: errorBlock	| nextStatement sizeString moduleIds |	" TODO: calculate the MD5 digest as we read the module in. "	" TODO: improve error handling on bad files. "		self expect: 'Application/vnd.squl1 ModuleExport size=' from: aStream.	sizeString := self readUpToNewLineFrom: aStream. " TODO: use it as well. "	moduleIds := self readModuleIdsFrom: aStream onError: [ :e :i :moduleImportLine |		self addStatement: (LegacyModule syntaxErrorStatement:moduleImportLine position: 0 message: e).	].		[ 		aStream atEnd	] whileFalse: [		| fs |		fs := LegacyFaishStatement new.		nextStatement := fs readFrom: aStream onError: [ :message :pos |			| statementString |			statementString := fs sourceCode, (self readUpTo: $. from: aStream), '.'.			self addStatement: (LegacyModule syntaxErrorStatement: statementString position: pos message: message).			nil.		].		nextStatement isNil ifFalse: [ 			nextStatement recurse: [ :each |				each isModuleLiteral ifTrue: [					each value id: (moduleIds at: each value handle ifAbsent: [ nil ]).				]			].			self add: nextStatement.		].	].	self recalculateId.	self reloadImports.	self reloadName.</body>

<body package="Faish" selector="expect:from:">expect: aString from: aStream	1 to: aString size do: [ :i |		(aStream next = (aString at: i)) ifFalse: [			^ self error: 'Expected: ', aString.		].	].</body>

<body package="Faish" selector="writeOn:">writeOn: aStream	| moduleSource |	" TODO: a streaming version of this that doesn't take so much memory. "	moduleSource := self recalculateId.	" TODO: Unicode marker. "	aStream		nextPutAll: 'Application/vnd.squl1 ModuleExport size=';		nextPutAll: moduleSource size printString;		cr;		nextPutAll: self handle;		nextPut: $:;		nextPutAll: uuid;		cr.	imports do: [ :each |		each recalculateIdIfNeeded.		aStream nextPutAll: each handle;			nextPut: $:;			nextPutAll: each uuid;			cr.	].	aStream nextPutAll: '--'; cr.	aStream nextPutAll: moduleSource.</body>

<body package="Faish" selector="readUpTo:from:">readUpTo: aCharacter from: aStream	| next result |	result := WriteStream on: (String new: 80).	[ 		next := aStream next.		(next = aCharacter) or: [ aStream atEnd ]	] whileFalse: [ 		(next = Character lf) ifFalse: [			result nextPut: next		]	].	^ result contents.</body>

<body package="Faish" selector="readModuleIdsFrom:onError:">readModuleIdsFrom: aStream onError: errorBlock	| next result handle digest splitIndex |	result := Dictionary new.	next := nil.	[		next := self readUpToNewLineFrom: aStream.		( next = '--' ) ifTrue: [ ^ result ].		next isEmpty ifFalse: [			splitIndex := next indexOf: $:.			(splitIndex &lt; 1) ifTrue: [ 				^ errorBlock 					value: 'Module reference does not have a colon in it.' 					value: (aStream readPosition) 					value: next.			].			handle := next copyFrom: 1 to: splitIndex-1.			digest := next copyFrom: splitIndex + 1 to: (next size).			result at: handle put: digest.		].	] repeat.</body>

<body package="Faish" selector="readFrom:">readFrom: aStream	^ self readFrom: aStream onError: [ :errorString :i | ^ self halt: errorString ].</body>

<body package="Faish" selector="readUpToNewLineFrom:">readUpToNewLineFrom: aStream	| next result |	" Be super tolerant of cr / lf issues. Stupid Windows."	result := WriteStream on: (String new).	[ 		next := aStream next.		((next = Character cr) or: [ next = Character lf]) or: [ aStream atEnd ]	] whileFalse: [ 		result nextPut: next	].	next := aStream peek.	" Remove LFs after CRs. Also be tolerant of other ways of doing it, even if they're retarded. "	((next = Character cr) or: [ next = Character lf]) ifTrue: [		aStream next.	]. 	^ result contents.</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: aStream	name isNil ifTrue: [ 		aStream nextPutAll: 'Unnamed module'.	] ifFalse: [		aStream nextPutAll: name asString.	].	" TODO: remove me. I only exist until I've fixed up all my existing modules."	errors isNil ifTrue: [ ^ self ].	errors isEmpty ifFalse: [ 		aStream nextPutAll: ' (broken!)'	].</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>public</category>

<body package="Faish" selector="handle">handle	" Return a fairly unique yet human readable handle to represent this module. "	| result |	name isNil ifTrue: [ ^ 'mEmpty' ].	result := WriteStream on: (String new: 20).	result nextPut: $m. "m for module :-) "	name do: [ :each | 		each isAlphaNumeric ifTrue: [			result nextPut: each.		]	].	result nextPutAll: (axioms size printString).	^ result contents.</body>

<body package="Faish" selector="findInCache:">findInCache: aStatement	| searcher |	cache isNil ifTrue: [ ^ nil ].	searcher := EqualityMemorySearcher module: cache searchingFor: aStatement.	^  searcher next.</body>

<body package="Faish" selector="remove:">remove: aRule	modified := true.	axioms remove: aRule.	(aRule matches: (self parse:'module:Z metadata:(importModule:X name:Y).'))		ifTrue: [ self reloadImports ].	needsReset := true.</body>

<body package="Faish" selector="isModuleImport">isModuleImport 	^ false.</body>

<body package="Faish" selector="insert:before:">insert: aRule before: anIndex	" Add the rule; return nil if the rule already exists. 	Note that OrderedCollection&gt;&gt;insert:before: is private and shouldn't be used. It doesn't behave the way you think it does. Use &gt;&gt;add:beforeIndex: instead."	aRule bake.		(self containsRule: aRule) ifTrue: [ ^ nil ].	self processSpecialStatement: aRule.	modified := true.	axioms add: aRule beforeIndex: anIndex.	needsReset := true.</body>

<body package="Faish" selector="addStatement:onError:">addStatement: aString onError: errorBlock	| rule |	rule := self parse: aString onError: errorBlock.	(self add: rule) isNil ifTrue: [ ^ nil ].	^ rule.</body>

<body package="Faish" selector="addToCache:">addToCache: aRule	(cache isNil not) ifTrue: [ 		cache add: aRule.	].</body>

<body package="Faish" selector="description">description	^ 'TODO: description for module ', self name.</body>

<body package="Faish" selector="name">name	name isNil ifTrue: [ ^ 'Unnamed module ', (self uuid first: 4) ].	^ name.</body>

<body package="Faish" selector="removeAllMatching:">removeAllMatching: aString	| removeUs |	" Unfortunately, we can't yet iterate over a module while its being modified. "	removeUs := Bag new.	self withQuerySimply: aString 	do: [ :each | removeUs add: each ]	ifNoResults: []	limitTo: 500.	removeUs do: [ :each | self remove: each ].</body>

<body package="Faish" selector="cache">cache	^ cache</body>

<body package="Faish" selector="clearErrors">clearErrors	errors := OrderedCollection new.</body>

<body package="Faish" selector="size">size	^ axioms size.</body>

<body package="Faish" selector="errors">errors	errors isNil ifTrue: [ errors := OrderedCollection new ]. "TODO: remove me"	^ errors.</body>

<body package="Faish" selector="repository">repository	" Called by the UI to display on the imports screen. "	^ 'Installed'.</body>

<body package="Faish" selector="resetIfNeeded">resetIfNeeded	needsReset ifTrue: [ self reset ].	imports do: [ :each | each resetIfNeeded ].</body>

<body package="Faish" selector="replace:with:">replace: oldRule with: newRule	" Replace the old rule with the new rule. Return nil if the newRule already exists. "	| i |	(self containsRule: newRule) ifTrue: [ ^ nil ].	i := axioms indexOf: oldRule.	i = 0 ifTrue: [ axioms add: newRule. ^ self. ].	newRule bake.	modified := true.	axioms at: i put: newRule.	(newRule matches: (self parse:'module:Z metadata:(importModule:X name:Y).'))		ifTrue: [ self reloadImports ].	needsReset := true.</body>

<body package="Faish" selector="find:">find: aRule	^ axioms indexOf: aRule.</body>

<body package="Faish" selector="reloadName">reloadName	self 		withQuerySimply: 'module:ThisModule metadata:(name:Name)?'		do: [ :each |  			self renameFromStatement: each.		]		ifNoResults: [			name := 'Unnamed module'.		] 		limitTo: 1.</body>

<body package="Faish" selector="imports">imports 	^ imports.</body>

<body package="Faish" selector="addStatement:">addStatement: aString	| rule |	rule := self parse: aString.	(self add: rule) isNil ifTrue: [ ^ nil ].	^ rule.</body>

<body package="Faish" selector="addImport:">addImport: anotherModule	| importRule addedRule anotherModuleName |	anotherModuleName := anotherModule name.	anotherModuleName isNil ifTrue: [ anotherModuleName := 'Unnamed module' ].	" We break encapsulation a bit to avoid special rules handling. Ideally, I'd just use &gt;&gt;addRule:. "	importRule := self parse: 'module:[	thisModule] metadata:(importModule:replaceMe name:["', anotherModuleName, '] uri:unknown).'.	importRule source: nil.	(importRule at: #module) value 		module: self;		handle: (self handle).	(importRule at: #metadata) at: #importModule put: (FaishLiteral new value: (ModuleImport new module: anotherModule)).	importRule bake.	modified := true.	addedRule := axioms add: importRule.	addedRule isNil ifTrue: [ ^ nil ].	" And, simply, ..."	imports add: anotherModule.</body>

<body package="Faish" selector="addRule:">addRule: aString	" Deprecated. Use &gt;&gt;addStatement:onError: instead. "	self addStatement: aString onError: [ :errorString :sourceIndex | self halt: errorString ].</body>

<body package="Faish" selector="containsRule:">containsRule: aFaishStatement	" Return true if I already contain the given statement. "	| ms |	ms := EqualityMemorySearcher module: self searchingFor: aFaishStatement.	^ (ms next) isNil not.</body>

<body package="Faish" selector="add:">add: aRule	" Add the rule; return nil if the rule already exists. "	aRule bake.		(self containsRule: aRule) ifTrue: [ ^ nil ].	self processSpecialStatement: aRule.	modified := true.	needsReset := true.	axioms add: aRule.</body>

<body package="Faish" selector="statements">statements	^ axioms</body>

<body package="Faish" selector="name:">name: aName	| s |	modified := true.	self removeAllMatching: 'module:ThisModule metadata:(name:X).'.	s := self parse:  'module:[	thisModule] metadata:(name:["', aName, ']).'.	s source: nil. " We don't want the term thisModule to be written out! "	(s at: #module) value 		module: self;		handle: (self handle).	self add: s.	name := aName</body>

<body package="Faish" selector="reloadImports">reloadImports	self clearErrors.	imports := OrderedCollection new.	self 		withQuerySimply: 'module:ThisModule metadata:(importModule:X name:Y uri:Z)?'		do: [ :each |  | moduleImport |			moduleImport := ((each at: #metadata) at: #importModule) value.			moduleImport module isNil ifTrue: [				moduleImport findModuleOnError: [ :message :i |					errors add: message. nil.				]. 				modified := true.			].			(moduleImport module) isNil ifFalse: [ 				imports add: (  moduleImport module).			].		]		ifNoResults: [] 		limitTo: 500.</body>

<body package="Faish" selector="at:">at: n	^ axioms at: n.</body>
</methods>

<methods>
<class-id>AbstractModule</class-id> <category>compiling</category>

<body package="Faish" selector="checkForLostVariables:onError:">checkForLostVariables: statement onError: errorBlock	" Check that no variable occurs only once in a statement. "	| variables |	statement isIfThenRule ifFalse: [^ self ].		variables := Dictionary new.	statement recurse: [:each | 		each isVariable ifTrue: [			variables at: each put: (1 + (variables at: each ifAbsent: [0])).		].	].	variables keysAndValuesDo: [:key :value |		(value==1 and: [key isAnonymous not]) ifTrue: [			^ errorBlock value: 'Not all variables appear more than once.' value:1.		]	]</body>

<body package="Faish" selector="parseWithoutTypecheck:onError:">parseWithoutTypecheck: aString onError: errorBlock	| stream result |	stream := ReadStream on: aString asString trimBlanks.	result := LegacyFaishStatement readFrom: stream onError: errorBlock.		self prepareHintsFor: result.	^ result.</body>

<body package="Faish" selector="parse:">parse: aString	^ self parse: aString onError: [ :errorString :i | ^ self halt: errorString ].</body>

<body package="Faish" selector="parse:onError:">parse: aString onError: errorBlock	| stream result |	stream := ReadStream on: aString asString trimBlanks.	result := LegacyFaishStatement readFrom: stream onError: errorBlock.		self checkForLostVariables: result onError: errorBlock.	self typecheck: result onError: errorBlock.		self prepareHintsFor: result.	^ result.</body>

<body package="Faish" selector="typecheck:onError:">typecheck: statement onError: errorBlock	"I gave up on this. I can't convert a statement to a soft-statement. "		"| q r s errorT t |	q := self parseWithoutTypecheck: 'typeCheck:Statement inModule:Module result:Result.' onError: [ ^ self error ].	q atIndex: 1 put: (FaishLiteral value: statement).	q atIndex: 2 put: (FaishLiteral value: (ModuleImport new module:self)).	r := self query: q onError: [ self halt ].		r timeLimit: 1.	s := r next.	(s isNil and: [ r hasMoreResults not ]) ifTrue: [ ^ self ].	s isStatement ifFalse: [ ^ self ].		t := s atIndex: 3.	errorT := self parseWithoutTypecheck: 'error:_.' onError: [^ self error].	(t matches: errorT) ifTrue: [		^ errorBlock value: ('Typechecking failed: ', (t atIndex: 1) value asString) value:1.	]."</body>
</methods>


<methods>
<class-id>LegacyModule class</class-id> <category>utilities</category>

<body package="Faish" selector="syntaxErrorStatement:position:message:">syntaxErrorStatement: statementString position: i message:errorMsg	" Return a string, which contains a parseable syntax error statement containing statementString. "	| str |	str := WriteStream on: (String new: (statementString size + 'syntaxError: ["].' size)).	str nextPutAll: 'error: ["'.	str nextPutAll: (LegacyModule sanitizeErrorString: errorMsg).	str nextPutAll: '] source: ["'.	str nextPutAll: (LegacyModule sanitizeErrorString: statementString).	str nextPutAll: '] position:[+'.	str nextPutAll: (i printString).	str nextPutAll: '].'.	^ str contents.</body>

<body package="Faish" selector="sanitizeErrorString:">sanitizeErrorString: aString	" Make sure that any literals in the string have matching square brackets. "	| numOpenBrackets result |	numOpenBrackets := 0.	result := WriteStream on: (String new: aString size).	aString do: [ :each | 		(each = $[ ) ifTrue: [			numOpenBrackets := numOpenBrackets + 1.		].		(each = $] ) ifTrue: [			(numOpenBrackets = 0) ifTrue: [				result nextPutAll: ' x[x '.			] ifFalse: [					numOpenBrackets := numOpenBrackets - 1.			]		].		result nextPut: each.	].	(numOpenBrackets &gt; 0) ifTrue: [		result nextPutAll: ' x'.		numOpenBrackets timesRepeat: [			result nextPut: $].		]	].	^ result contents.</body>
</methods>


<methods>
<class-id>LegacyModule</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	readOnly := false.	^self</body>
</methods>

<methods>
<class-id>LegacyModule</class-id> <category>accessing</category>

<body package="Faish" selector="readOnly:">readOnly: boolean	readOnly := boolean.</body>
</methods>


<methods>
<class-id>CodeModule</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>

<methods>
<class-id>CodeModule</class-id> <category>printing</category>

<body package="Faish" selector="sourceCodeFor:">sourceCodeFor: aStatement	self notYetImplemented.</body>
</methods>


<methods>
<class-id>MatchingUnunifiedModuleSearcher</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>

<methods>
<class-id>MatchingUnunifiedModuleSearcher</class-id> <category>searching</category>

<body package="Faish" selector="next">next	^ self nextIncludingUnunified.</body>
</methods>


<methods>
<class-id>LegacyFaishStatement class</class-id> <category>class initialization</category>

<body package="Faish" selector="initialize">initialize	| b |	" FaishStatement initialize "	BasicLiteralTypes := Dictionary new.	b := BasicLiteralTypes.	b at: $' put: [ :variables :content :errorBlock | 		(content size &lt; 1) ifTrue: [ ^ errorBlock value: 'Empty character literal!' value:0 ].		FaishLiteral value: (( content at: 1) asInteger ) 	].	b at: $] put: [ :variables :content :errorBlock | FaishLiteral value: $] ].	b at: $" put: [ :variables :content :errorBlock | FaishLiteral value: (content asByteArray) ].	b at: $# put: [ :variables :content :errorBlock | FaishLiteral value: (Float readFrom: (ReadStream on: content)) ].		b at: $+ put: [ :variables :content :errorBlock | FaishLiteral value: (Integer readFrom: (ReadStream on: content)) ].	b at: $- put: [ :variables :content :errorBlock | FaishLiteral value: (0 - (Integer readFrom: (ReadStream on: content))) ].	b at: $\ put: [ :variables :content :errorBlock | FaishLiteral value: ( LegacyFaishStatement readStatementLiteralFrom: content variables: variables onError: errorBlock) ].	b at: $  put: [ :variables :content :errorBlock | FaishLiteral value: ( LegacyFaishStatement readArrayFrom: content variables: variables onError: errorBlock) ].	b at: $	 put: [ :variables :content :errorBlock | FaishLiteral value: (ModuleImport new handle: content) ].</body>
</methods>

<methods>
<class-id>LegacyFaishStatement class</class-id> <category>parsing</category>

<body package="Faish" selector="readStatementLiteralFrom:variables:onError:">readStatementLiteralFrom: aString variables: variables onError: errorBlock	| nextChar in totem |	totem := LegacyFaishStatement new. 	in := ReadStream on: (aString, '.'). "Add a full-stop on the end for good measure."	totem skipWhiteSpace: in.			totem source: (WriteStream on: (String new: (aString size))).	nextChar := in peek.	nextChar isNil ifTrue: [ ^ errorBlock value: 'String literal is empty.' value: 0 ].			(nextChar isUppercase) ifTrue: [ 		^ totem readVariableFrom: in variables: variables onError: errorBlock.	].	(nextChar = $_) ifTrue: [ 		in next.		^ FaishVariable new.	].	(nextChar = $( ) ifTrue: [ | result |		in next. 		totem skipWhiteSpace: in.		result := totem readFrom: in variables: variables onError: errorBlock.		totem skipWhiteSpace: in.		nextChar := in next. 		(nextChar = $) ) ifFalse: [ 			" Then it was a $. or a $?. See &gt;&gt;readSubStatementFrom:variables: "			errorBlock value: 'Missing right parenthesis in this statement. ' value: (in position).			^ nil ].		^ result.	].	(nextChar = $[ ) ifTrue: [		in next.		^ totem readLiteralFrom: in variables: variables onError: errorBlock. "Will consume the $] at the end. "	].	" This is an embarrassing hack, but I'm not going to refactor the parser now. "	((aString indexOf: $:) &gt; 0) ifTrue: [		^ totem readFrom: in variables: variables onError: errorBlock.	] ifFalse: [		^ totem readAtomFrom: in variables: variables onError: errorBlock.	].</body>

<body package="Faish" selector="readArrayFrom:variables:onError:">readArrayFrom: aString variables: variables onError: errorBlock	| in totem result |	totem := LegacyFaishStatement new. 	in := ReadStream on: aString.	totem skipWhiteSpace: in.			totem source: (WriteStream on: (String new: (aString size))).	result := OrderedCollection new.	[ in atEnd ] whileFalse: [		result add: (totem readValueFrom: in variables: variables onError: errorBlock ).		totem skipWhiteSpace: in. "To stop parsing at the end of the literal string."	].	^ result.</body>

<body package="Faish" selector="readFrom:onError:">readFrom: stream onError: errorBlock	^ self new readFrom: stream onError: errorBlock.</body>
</methods>

<methods>
<class-id>LegacyFaishStatement class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>


<methods>
<class-id>LegacyFaishStatement</class-id> <category>comparing</category>

<body package="Faish" selector="mostlyEquals:">mostlyEquals: another	" Used for comparing statements that may contain tricksy non-comparable literals. "	|  otherArgs  |	(another isMemberOf: LegacyFaishStatement) ifFalse: [ ^ false ].	otherArgs := another arguments.	(args size = otherArgs size) ifFalse: [ ^ false ].	1 to: args size do: [ :i | 		| a b |		a := args at: i.		b := otherArgs at: i.		((a key) = (b key)) ifFalse: [ ^ false ].		((a value) mostlyEquals: (b value)) ifFalse: [			^ false		].	].	^ true.</body>

<body package="Faish" selector="hash">hash	^ args hash.</body>

<body package="Faish" selector="=">= another	(another isMemberOf: LegacyFaishStatement) ifFalse: [ ^ false ].	^ args = another arguments .</body>

<body package="Faish" selector="signatureHash">signatureHash	" Make a hash using only my signature. "	^ (args collect: [ :each | each key]) hash.</body>
</methods>

<methods>
<class-id>LegacyFaishStatement</class-id> <category>accessing</category>

<body package="Faish" selector="truth">truth	^ truth.</body>

<body package="Faish" selector="hintsAvailable">hintsAvailable	^hintsAvailable</body>

<body package="Faish" selector="variables">variables	| result |	result := IdentitySet new.	self recurse: [ :each |		each isVariable ifTrue: [ result add: each ] ].	^ result.</body>

<body package="Faish" selector="premises">premises	| result i |	" TODO: remake the FaishStatement data structure to be separated into premises and conclusion. "	result := Array new: (self premiseCount).	i := 1.	args do: [ :each |		(each key = #if and: [ each value isStatement or: [ each value isVariable ] ]) ifTrue: [ 			result at: i put: (each value).			i := i + 1.		].	].	^ result.</body>

<body package="Faish" selector="size">size	^ args size.</body>

<body package="Faish" selector="bindingOfVariable:originalStatement:">bindingOfVariable: x originalStatement: q	" Return the value that the variable x has been bound to. "	" We don't really support variable bindings yet, but we need to in the future. When we do, q can be removed from the arguments. "	self recurseWith: q atEachLevel: [ :each :other | 		(each = x) ifTrue: [ ^ other ].		(other = x) ifTrue: [ ^ each ].	] ifFail: [].</body>

<body package="Faish" selector="at:ifAbsent:">at: aSymbol ifAbsent: aBlock	| all |	all := args select: [ :each | each key = aSymbol ].	all isEmpty ifTrue: [ ^ aBlock value ].	" TODO: multiple clauses with the same label trips this up: "	^ (all at: 1) value.</body>

<body package="Faish" selector="premisesDo:">premisesDo: aBlock	args do: [ :each |		(each key = #if and: [ each value isStatement or: [ each value isVariable ] ]) ifTrue: [ 			aBlock value: (each value).		].	].</body>

<body package="Faish" selector="numVariables">numVariables	| result |	result := 0.	self recurse: [ :each |		each isVariable ifTrue: [ result := result + 1 ] ].	^ result.</body>

<body package="Faish" selector="isSyntaxError">isSyntaxError	^ ( ( (args size = 3) 		and: [ (args at: 1) key = #error ] )		and: [ (args at: 2) key = #source ] ) 		and: [ (args at: 3) key = #position ].</body>

<body package="Faish" selector="flattened">flattened	| result |	result := OrderedCollection new.	self recurse: [ :each | 		(each isStatement and: [each isNotMetadata]) ifTrue: [ 			result add: each.		]	].	^ result.</body>

<body package="Faish" selector="atIndex:put:">atIndex: index put: value	value isNil ifTrue: [ self error ].	^ (args at: index) value: value.</body>

<body package="Faish" selector="hintsAvailable:">hintsAvailable: anObject	hintsAvailable := anObject</body>

<body package="Faish" selector="atIndex:">atIndex:index	^ (args at: index) value.</body>

<body package="Faish" selector="makeTrue">makeTrue	baked ifNotNil: [ ^ self error: 'Undercooked statement.' ].	self isFullyUnified ifFalse: [ self error: 'I can''t be true; I''m not all unified!' ].	truth := true.	^ self.</body>

<body package="Faish" selector="importsAvailable">importsAvailable	^ importsAvailable.</body>

<body package="Faish" selector="argsMatching:">argsMatching: anAssociation	" Return any of my arguments that match the key and value of anAssociation. "	^ args select: [ :each |		(each key = anAssociation key)			and: [ each value matches: anAssociation value ] ].</body>

<body package="Faish" selector="atAll:">atAll: aSymbol 	" The only current valid invocation of me is with #if as argument. Having other similar multiple clauses is not yet supported. "	^ (args select: [ :each | each key = aSymbol ]) collect: [ :each | each value ].</body>

<body package="Faish" selector="arguments">arguments	^ args.</body>

<body package="Faish" selector="premiseAt:">premiseAt: n	^ self premises at: n.</body>

<body package="Faish" selector="statement">statement	" I'm a statement! "	^ self.</body>

<body package="Faish" selector="at:">at: aSymbol	^ self at: aSymbol ifAbsent: [ self error: 'Statement does not have this clause: ', aSymbol printString. nil ].</body>

<body package="Faish" selector="premiseCount">premiseCount	^ args inject: 0 into: [ :count :each | (each key = #if and: [ each value isStatement or: [ each value isVariable ]]) ifTrue: [ count + 1 ] ifFalse: [ count ] ].</body>

<body package="Faish" selector="signature">signature	" This is for long-term planning. Eventually, statements will be made from signatures, which are just statement definitions with an arity. This alleviates the need to have any human-readable forms in the statement implementation. Statements with the same signature will match each other at the outermost level.Until the implementation changes, we just fake it. "	^ LegacyFaishStatementSignature from: self.</body>

<body package="Faish" selector="unwrap">unwrap	" Return a copy of me with statement, atom and variable literals replaced with their contents. "	^ self class new unwrapFrom: self.</body>

<body package="Faish" selector="maximiseVariable">maximiseVariable	" Return the variable designated for maximisation in a then:if:maximise: statement. We assume you've already assertained that this is a maximisation statement. "	args do: [ :each | 		(each key = #maximize) ifTrue: [ ^ each value ].	].	self error.</body>

<body package="Faish" selector="isModuleImport">isModuleImport	^ false.</body>

<body package="Faish" selector="conclusion">conclusion	self isIfThenRule ifFalse: [ ^ self ].	^ ((args select: [ :each | each key = #then ]) at: 1) value.</body>
</methods>

<methods>
<class-id>LegacyFaishStatement</class-id> <category>returns new</category>

<body package="Faish" selector="copy">copy	" Return a copy of me as a FaishUnifiedStatement, with unifyable variables. "	^ LegacyFaishStatement new initializeFrom: self usingVariableMapping: nil.</body>

<body package="Faish" selector="copyUsingVariableMapping:">copyUsingVariableMapping: mapping	" Return a copy of me as a FaishUnifiedStatement, with unifyable variables. "	^ LegacyFaishStatement new initializeFrom: self usingVariableMapping: mapping.</body>

<body package="Faish" selector="unifiedFrom:ifFail:">unifiedFrom: anotherStatement ifFail: failBlock	" Replace all my variables with values in anotherStatement. Return false if unification cannot be done."	| c other |	" Recurse through myself, following anotherStatement at the same time. Every time a variable is found, try to replace that variable with the same value from anotherStatement. "	(self = anotherStatement) ifTrue: [  ^ self ].	c := self copy.	other := anotherStatement copy.	^ other unifyClause: other with: c ifFail: [ ^ failBlock value ].</body>

<body package="Faish" selector="copyPreserveVariables">copyPreserveVariables	" Return a copy of me as a FaishUnifiedStatement, with the same variables. This is a private method. "	| variableMapping |	variableMapping := IdentityDictionary new.				self recurse: [ :each | 		each isVariable ifTrue: [			variableMapping at: each put: each 		] 	].	^ LegacyFaishStatement new initializeFrom: self usingVariableMapping: variableMapping.</body>

<body package="Faish" selector="unifiedGoalFrom:ifFail:">unifiedGoalFrom: goal ifFail: failBlock	" Replace all my variables with values in anotherStatement. Return false if unification cannot be done. "	| c other |	(self conclusion = goal) ifTrue: [ ^ self ].	c := self copy.	other := goal copy.	^ c unifyClause: (c conclusion) with: other ifFail: [ ^ failBlock value ].</body>
</methods>

<methods>
<class-id>LegacyFaishStatement</class-id> <category>private</category>

<body package="Faish" selector="unifyDoSubstitutionBindings:">unifyDoSubstitutionBindings: bindings	" Search for all variables mapped directly to other variables (A -&gt; B) and substitute them with what the second variable maps to. We ignore variables that point to statements containing variables; those are dealt with later. "	" Be wary here. &gt;&gt;unifyDoSubstitutionBindings... changes bindings and removes stuff from it. We're iterating over that! "	bindings keys sorted do: [ :eachKey |  | eachValue |		(bindings includesKey: eachKey) ifTrue: [			" If may have been removed by a previous iteration. "			eachValue := bindings at: eachKey.			eachValue isVariable ifTrue: [ 				self unifyDoSubstitutionBindings: bindings loopPreventSet: (IdentitySet new) atKey: eachKey replaceValue: eachValue.			].		].	].</body>

<body package="Faish" selector="recurse:">recurse: aBlock	" Recurse through me, evaluating aBlock at each level. "	aBlock value: self.	args do: [ :each | each value recurse: aBlock ].</body>

<body package="Faish" selector="isKindOfRule:">isKindOfRule: type	" Return true only if I am an if-then rule. "	| foundThen foundIf foundMaximize |	foundThen := foundIf := foundMaximize := false.	args do: [ :each | 		(each key = #if) ifTrue: [			foundIf := true.			( each value isStatement or: [ each value isVariable ]) ifFalse: [				^ false. 			].		] ifFalse: [ 			(each key = #then) ifTrue: [ 				foundThen ifTrue: [ ^ false ].				foundThen := true.				( each value isStatement or: [ each value isVariable ]) ifFalse: [					^ false. 				].				" We don't yet allow statements of the form 'if:... then:(c:d) then:(b:c)'.  "				" TODO: that might be a good idea. "			] ifFalse: [				" Then the clause isn't if, and isn't then.  "				((each key = #maximize) and: [ each value isVariable ]) ifTrue: [ 					foundMaximize ifTrue: [ ^ false ]. " There can be only one. If you want more than one, add them together. "					foundMaximize := true.				] ifFalse: [ 					^ false. 				]			]		]	].	( type = #ifThen) ifTrue: [ 		^ foundIf &amp; foundThen.	] ifFalse: [		( type = #maximize ) ifTrue: [			^ foundIf &amp; foundThen &amp; foundMaximize.		]	].	^ false.</body>

<body package="Faish" selector="unifyDoSubstitutionBindings:loopPreventSet:atKey:replaceValue:">unifyDoSubstitutionBindings: bindings loopPreventSet: loopPreventSet atKey: a replaceValue: b	" Replace the binding of eachKey in bindings with what the variable eachValue points to. "	| c |" Assume the binding was A -&gt; B (as per this method's parameters). In the bindings, we find B -&gt; C, or B -&gt; notAVariable. If we find B -&gt; notAVariable, then we rebind A to make A -&gt; notAVariable and leave B -&gt; notAVariable.If we find B -&gt; C, then we need to recurse. more comments after the code."	(loopPreventSet includes: a) ifTrue: [		^ b. " Break out of the recursion loop "	].	c := bindings at: b ifAbsent: [ 		^ b.	].			c isVariable ifTrue: [ 		c := self 			unifyDoSubstitutionBindings: bindings 			loopPreventSet: (loopPreventSet copy add: a; yourself)			atKey: b			replaceValue: c.	].	((bindings at: a) ~= b) ifTrue: [ self halt. ].	bindings at: a put: c.	^ c.</body>

<body package="Faish" selector="isFullyUnified">isFullyUnified	self recurse: [ :each | each isVariable ifTrue: [ ^ false ] ].	^ true.</body>

<body package="Faish" selector="bake">bake	| result |	args isEmpty ifTrue: [ self error: 'Nothing to bake.' ].	args do: [ :each | each value bake ].	result := super bake.	^ result.</body>

<body package="Faish" selector="recurseWith:atEachLevel:ifFail:">recurseWith: anotherStatement atEachLevel: aBlock ifFail: failBlock	|  himArgs  |	" Recurse through me, evaluating aBlock at each level and keeping track with anotherStatement. "	aBlock value: self value: anotherStatement.	anotherStatement isStatement ifTrue: [		himArgs := anotherStatement arguments.		(anotherStatement size ~= args size) ifTrue: [ ^ failBlock value ].		1 to: (args size) do: [:i | | me him |			me := args at: i.			him := himArgs at: i.			( me key = him key ) ifFalse: [ 				^ failBlock value			].			me value recurseWith: him value atEachLevel: aBlock ifFail: failBlock.		].	 ] ifFalse: [		anotherStatement isVariable ifFalse: [			" I am a statement. anotherStatement is not a statement or variable. "			^ failBlock value.		]	].</body>

<body package="Faish" selector="recurseWith:atEachLevel:">recurseWith: anotherStatement atEachLevel: aBlock	" Recurse through me, evaluating aBlock at each level and keeping track with anotherStatement. "	^ self recurseWith: anotherStatement atEachLevel: aBlock ifFail: [ RecurseError raiseSignal ].</body>

<body package="Faish" selector="unifyAddBindingForVariable:bindingTo:bindings:loopPreventionSet:ifFail:">unifyAddBindingForVariable: me bindingTo: other bindings: bindings loopPreventionSet: noLoops ifFail: failBlock	" Basically, do 'bindings at: me put: other', but making sure that only one entry exists in bindings for each variable (me). "	|  meBinding |	" Documentation is below. "	(noLoops includes: me) ifTrue: [  ^ self. " Let it go. Failure will be caught later. " ].	(bindings includesKey: me) ifTrue: [		meBinding := bindings at: me.				other recurseWith: meBinding atEachLevel: [ :otherEach :meBindingEach | 			otherEach isVariable ifTrue: [ 				(otherEach == meBindingEach) ifFalse: [ 					self 						unifyAddBindingForVariable: otherEach						bindingTo: meBindingEach						bindings: bindings						loopPreventionSet: (noLoops copy add: me; yourself)						ifFail: failBlock.				].			].			meBindingEach isVariable ifTrue: [ 				(otherEach == meBindingEach) ifFalse: [ 					" Then other is more specific than meBinding. "					bindings removeKey: me.					bindings at: me put: other.					self 						unifyAddBindingForVariable: meBindingEach						bindingTo: otherEach						bindings: bindings						loopPreventionSet: (noLoops copy add: me; yourself)						ifFail: failBlock.				].			].		] ifFail: failBlock.	] ifFalse: [		bindings at: me put: other.	]."Like the method description says, I just do 'bindings at: me put: other.' with the following complications described below.meBinding is a possible existing binding for me in the bindings dictionary. noLoops is a loop prevention set; when calling myself recursively, any variables that I've replaced are added to it to prevent me going into infinite recursion.1. If meBinding exists and it is less specific than other, then we replace it with other. We also add another binding to prevent lost information.2. If meBinding exists and it is more specific than other, then we leave it and make sure we match it. 3. Obviously if no binding exists then we just add it.'specific' means that a statement is longer than another. X is less specific than a:X. a:(a:(a:A)) is more specific than a:(a:B). I haven't thought through how this works with multiple variables. There's probably a bug there.Examples:1)say that bindings is A=a:B (meBinding := a:B)we want to add A=a:(a:C). (me := A, other := a:(a:C)) )then:	Add A=a:(a:C) to bindings	Add B=a:C to bindings using this method (because A = a:B = a:(a:C), therefore B=a:C).2)	say that bindings is A=a:(a:C) (meBinding := a:(a:C) )we want to add A=a:B. (me := A, other := a:B )then:	We don't need to add anything to bindings for A because it is already there and more specific than other.	Add B=a:C to the bindings using this method. 3) say that bindings is A=a:Bwe want to add A=a:B. (me := A, other := a:B )then:	We don't do anything.4)say that bindings is A=a:(a:C), B=a:C (meBinding := a:(a:C) )we want to add A=a:B. (me := A, other := a:B )then:	We don't need to add anything to bindings for A because it is already there and more specific than other.	Add B=a:C to the bindings using this method:		(calling this method recursively:)		say that bindings is A=a:(a:C), B=a:C (meBinding := a:(a:C) )		we want to add B=a:C. (me := B, other := a:C )			We don't do anything because it's already there."</body>

<body package="Faish" selector="unifyPopulateBindings:unifyClause:with:ifFail:">unifyPopulateBindings: bindings unifyClause: myClause with: otherClause ifFail: failBlock	" Populate the given bindings dictionary for substitution. Return whether a binding contains a variable mapped to another variable. "	| result |	result := false. 	myClause recurseWith: otherClause atEachLevel: [ :me :other |		me isVariable ifTrue: [ 			other isVariable ifTrue: [ result := true ].			" Complicated version of 'bindings at: me put: other': "			self 				unifyAddBindingForVariable: me				bindingTo: other				bindings: bindings				loopPreventionSet: (IdentitySet new)				ifFail: failBlock.		].		other isVariable ifTrue: [			self 				unifyAddBindingForVariable: other				bindingTo: me				bindings: bindings				loopPreventionSet: (IdentitySet new)				ifFail: failBlock.		].	] ifFail: failBlock.	^ result.</body>

<body package="Faish" selector="unifyReplaceBindings:loopPreventSet:ifFail:">unifyReplaceBindings: bindings loopPreventSet: loopPreventSet ifFail: failBlock	1 to: args size do: [ :i |		| arg argName |		argName := (args at: i) key.		arg := (args at: i) value.		(arg isVariable and: [ bindings includesKey: arg ]) ifTrue: [ 			| b |			(loopPreventSet includes: arg) ifTrue: [ failBlock value ].			b := (bindings at: arg) copyPreserveVariables.			args at: i put: (argName -&gt; b).			b isStatement ifTrue: [ " Recurse into the new value. "				b					unifyReplaceBindings: bindings 					loopPreventSet: (loopPreventSet copy add: arg; yourself)					ifFail: failBlock.			].		] ifFalse: [ 			arg isStatement ifTrue: [ 				arg 					unifyReplaceBindings: bindings 					loopPreventSet: loopPreventSet					ifFail: failBlock.			]		].	]."This simple looking bit of code is surprisingly difficult to get right. Basically, we recurse over the statement and replace any variables with their bindings.The problem is statements like this:a:(foo:P) b:P.a:Q b:(bar:P).We need to be careful not to end up in infinite recursion. This is why we have the loopPreventSet. It contains all variables that we've substituted in the current call stack. If we come across the same variable twice, we've hit a loop in the bindings (and otherwise I suspect that it's safe to substitute without recursing infinitly). Possible optimisations:- Iterating over a statement should be possible without recursion. We only need to keep the clause number.- Let any potential loop go, just make sure everything else in Faish can handle statements with loops.- Use tortoise/hare loop detection maybe? On a tree, both the tortoise and hare would require a stack to iterate over the tree. - Use a linked list for the identity set. "</body>
</methods>

<methods>
<class-id>LegacyFaishStatement</class-id> <category>testing</category>

<body package="Faish" selector="isIfThenRule">isIfThenRule	^ self isKindOfRule: #ifThen.</body>

<body package="Faish" selector="isNotMetadata">isNotMetadata	args do: [ :each | 		((each key = #metadata) or: [each key = #export]) ifTrue: [ 			^ false.		].	].	^ true.</body>

<body package="Faish" selector="isStatement">isStatement	^ true.</body>

<body package="Faish" selector="isMaximizeRule">isMaximizeRule	^ self isKindOfRule: #maximize.</body>
</methods>

<methods>
<class-id>LegacyFaishStatement</class-id> <category>modification</category>

<body package="Faish" selector="addLabel:value:">addLabel: label value: aValue	" Private method "	baked ifNotNil: [ ^ self error. ].	args add: (Association key: label asSymbol value: aValue).</body>

<body package="Faish" selector="replaceVariable:with:">replaceVariable: var with: newValue	| newNewValue |	baked ifNotNil: [ ^ self error ].	self == newValue ifTrue: [ 		" If this happens, we'd create a self-referencing loop in the statement which, although interesting, makes things crash.		  Maybe in the future it would be a cool, although baffling, thing to implement. "		self halt: 'When does this happen?'.		^ nil ].		" TODO: this line can be removed. It just a sanity check. "	newValue recurse: [ :each | (each = var) ifTrue: [ ^ nil ] ]. 	newNewValue := newValue copy. " Make sure variables are unique. "	args do: [ :each |		| v |		v := each value.		((v isVariable) and: [v == var ])			ifTrue: [ each value: newNewValue ]			ifFalse: [				v isStatement ifTrue: [					v replaceVariable: var with: newNewValue ] ] ].	^ self. " Only return nil on failure. "</body>

<body package="Faish" selector="unifyPremise:with:ifFail:">unifyPremise: n with: goal ifFail: aBlock	" Replace all my variables with values in anotherStatement. Return false if unification cannot be done. "	| ifPhrase other result copy |		copy := self copy.	ifPhrase := copy premises at: n.	other := goal copy.	"Why are we doing this:?"	other unifyClause: other with: ifPhrase ifFail: [ ^ aBlock value ].		"If you follow the call stack back, then we know that goal came from the memory and is fully unified, so we can safely assume that ifPhrase is true. "	result := copy unifyClause: ifPhrase with: other ifFail: [ ^ aBlock value ].	ifPhrase makeTrue.	^ result.</body>

<body package="Faish" selector="unifyClause:with:ifFail:">unifyClause: myClause with: otherClause ifFail: failBlock	" Replace all my variables with values in anotherStatement. "	| bindings hasSubs |	" Documentation below "	baked ifNotNil: [ ^ self error ].	bindings := IdentityDictionary new. " Mapping of variables in both myClause and otherClause to their values. "	hasSubs := self unifyPopulateBindings: bindings unifyClause: myClause with: otherClause ifFail: failBlock.	" hasSubs means that the bindings contain a variable mapped to another variable. "	hasSubs ifTrue: [		self unifyDoSubstitutionBindings: bindings	].	self unifyReplaceBindings: bindings loopPreventSet: (IdentitySet new) ifFail: failBlock.	^ self."This is more tricky than it looks. There are, as you see above, two steps:1) Find the variables in both statements. 2) Replace those variables.Simple, right? Heh. Keep following the code.Finding the variables will match up any embedded variables in other or in the bindings. See the comments in unifyAddBindingForVariable:...Replacing those variables will also recurse through the variable bindings, replacing embedded variables as it finds them and keeping a watch out for any nasty variable substitution loops. Replacing needs to be done after finding the variables to ensure that all variables have been found and substitutions are known for them.I highly suspect there's an elegant, extremely fast technique for unification, but this implementation took a *very* long time to get right. I suspect you can add information to the variable instances themselves for the bindings rather than use a dictionary. If you number the variables, you can use an index into an array to find them as well."</body>

<body package="Faish" selector="unbindAllVariables">unbindAllVariables	" Convert variable literals into variables"	baked ifNotNil: [ ^ self error ].	args do: [ :each |		| v |		v := each value.		(v isVariableLiteral)			ifTrue: [ each value: v value ]			ifFalse: [				v isStatement ifTrue: [					v unbindAllVariables ] ] ].	^ self. " Only return nil on failure. "</body>

<body package="Faish" selector="bindAllVariables">bindAllVariables	" Make every variable bound. This is used in (module:query:results) and friends. See BuiltInsSearcher&gt;&gt;builtInModuleQuery:"	baked ifNotNil: [ ^ self error ].	args do: [ :each |		| v |		v := each value.		(v isVariable)			ifTrue: [ each value: (FaishLiteral value: v ) ]			ifFalse: [				v isStatement ifTrue: [					v bindAllVariables ] ] ].	^ self. " Only return nil on failure. "</body>

<body package="Faish" selector="at:put:">at: aSymbol put: aValue	| |	baked ifNotNil: [ self error ].	aSymbol isNil ifTrue: [ self error ].	aValue isNil ifTrue: [ self error ].		args do: [ :each | 		each key = aSymbol ifTrue: [			each value: aValue. ^ self. ] ].	self error: 'Argument does not exist in this statement.'.</body>
</methods>

<methods>
<class-id>LegacyFaishStatement</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	baked ifNotNil: [ ^ self error ].	args := OrderedCollection new.	truth := false. " Used in deduction. "	evaluationOrder := nil. " Only used by if-then statements. See &gt;&gt;evaluationOrder"	hintsAvailable := false. 	importsAvailable := true. " Until proven false. "</body>

<body package="Faish" selector="unwrapFrom:">unwrapFrom: anotherStatement	|  |	baked ifNotNil: [ ^ self error. ].	anotherStatement arguments do: [ :each |		args add: (each key -&gt; (each value unwrap)).	].</body>

<body package="Faish" selector="initializeFrom:usingVariableMapping:">initializeFrom: anotherStatement usingVariableMapping: m	| variableMapping |	baked ifNotNil: [ ^ self error. ].	truth := anotherStatement truth.	sid := anotherStatement sid.	" We need to be careful that new instances of variables are made, and that the same variable in the new statement is the same instance "	m isNil 		ifTrue: [ 			variableMapping := IdentityDictionary new.						anotherStatement variables do: [ :each |				| copy |				copy := each copy.				variableMapping at: each put: copy ] ]		ifFalse: [ variableMapping := m ].	anotherStatement arguments do: [ :each |		each value isVariable ifTrue: [			args add: (each key -&gt; (variableMapping at: each value))		] ifFalse: [			args add: (each key -&gt; (each value copyUsingVariableMapping: variableMapping)) ] ].	" This might be needed. It's in the wrong place though. This function is recursive, but evaluationOrders only apply to then-if statements. "	"evaluationOrder := anotherStatement evaluationOrder shallowCopy."</body>
</methods>

<methods>
<class-id>LegacyFaishStatement</class-id> <category>parsing</category>

<body package="Faish" selector="isSeparator:">isSeparator: char	^ ((char = $) )		or: [char = $.])		or: [char = $?].</body>

<body package="Faish" selector="readVariableFrom:variables:onError:">readVariableFrom: in variables: variables onError: errorBlock	| varStr next name |	varStr := WriteStream on: (String new).	[	next := in peek.		next isNil ifTrue: [ ^ errorBlock value: ('Unexpected end of stream while reading variable name: ', self printString) value: (in position) ].		(self isNameCharacter: next) ifFalse: [ 			name := varStr contents asSymbol.			source nextPutAll: name.			^ variables at: name ifAbsent: [				variables at: name put: (FaishVariable from: name) ] ].		varStr nextPut: in next.	] repeat.</body>

<body package="Faish" selector="readLabelFrom:onError:">readLabelFrom: in onError: errorBlock	| nextChar label |	self skipWhiteSpace: in.		label := OrderedCollection new.	[ (nextChar := in next) isNil not ] whileTrue: [		source nextPut: nextChar.		(nextChar = $:) ifTrue: [ | result |			result := String withAll: label.			^ result.		] ifFalse: [ 			(#( $( $) $[ $] $ ) contains: [ :each | each = nextChar ]) ifTrue: [				^ errorBlock value: 'Parse error: label had a funny character.' value: (in position).			] ifFalse: [				label add: nextChar.			].		].	].	^ errorBlock value: 'Incomplete label when end of source reached.' value: (in position).</body>

<body package="Faish" selector="readSubStatementFrom:variables:onError:">readSubStatementFrom: in variables: variables onError: errorBlock	| sub |	self skipWhiteSpace: in.	sub := LegacyFaishStatement new 		source: source;		readFrom: in variables: variables onError: errorBlock.	^ sub.</body>

<body package="Faish" selector="readFrom:onError:">readFrom: aStream onError: errorBlock	| variables surroundedByParenthesis nextChar result  |	variables := Dictionary new.	source := WriteStream on: (String new).	self skipWhiteSpaceNoSource: aStream.	surroundedByParenthesis := (aStream peek = $().	result := self readFrom: aStream variables: variables onError: errorBlock.	(aStream peek) isNil ifTrue: [ 		errorBlock value: 'End of statement reached before a period or question mark was found.' value: (aStream position).		^ nil.	].	surroundedByParenthesis ifTrue: [		nextChar := aStream next. 		source nextPut: nextChar.		( nextChar ~= $) ) ifTrue: [			errorBlock value: 'Statement is missing a right parenthesis.' value: (aStream position).			^ nil.		].	].	nextChar := aStream next. 	source nextPut: nextChar.	( (nextChar ~= $.) and: [ nextChar ~= $? ] ) ifTrue: [		errorBlock value: 'Statement does not end in a period or question mark.' value: (aStream position).		^ nil.	].	self skipWhiteSpaceNoSource: aStream.	(args isEmpty and: [ result isVariable not ]) ifTrue: [		errorBlock value: ('No clauses appear in statement: ', self printString) value: (aStream position).		^ nil.	].	^ result.</body>

<body package="Faish" selector="skipWhiteSpaceNoSource:">skipWhiteSpaceNoSource: in	| nextChar |	[(nextChar := in peek) isNil not and: [nextChar isSeparator] ] whileTrue: [ 		in next 	].</body>

<body package="Faish" selector="isNameCharacter:">isNameCharacter: char	^ ( #( $( $) $. $? $[ $] $: ) contains: [ :each | char = each ]) not		and: [char isSeparator not].</body>

<body package="Faish" selector="readValueFrom:variables:onError:">readValueFrom: in variables: variables onError: errorBlock	" The value can be:		- a variable (begins with a capital letter),		- an atom,		- a primitive type (integer, float, string, collection, ...?)		- a sub-statement enclosed in parenthesis. "	| nextChar |	self skipWhiteSpace: in.	nextChar := in peek.	nextChar isNil ifTrue: [ 		errorBlock value: ('End of input reached where a value was expected: ', self printString) value: (in position).		^ nil 	].	" Switch { "	(nextChar isLetter) ifTrue: [ 		(nextChar isUppercase) ifTrue: [			^ self readVariableFrom: in variables: variables onError: errorBlock.		] ifFalse: [			^ self readAtomFrom: in variables: variables onError: errorBlock. 		] ] ifFalse: [	(nextChar = $( ) ifTrue: [ | result |		in next. 		source nextPut: $(.		result := self readSubStatementFrom: in variables: variables onError: errorBlock.		self skipWhiteSpace: in.		nextChar := in next. 		(nextChar = $) ) ifFalse: [ 			" Then it was a $. or a $?. See &gt;&gt;readSubStatementFrom:variables: "			errorBlock value: 'Missing right parenthesis in this statement. ' value: (in position).			^ nil ].		source nextPut: $).		^ result.	 		] ifFalse: [	(nextChar = $[ ) ifTrue: [		in next.		source nextPut: $[.		^ self readLiteralFrom: in variables: variables onError: errorBlock. "Will consume the $] at the end. "		] ifFalse: [	(nextChar = $_) ifTrue: [ 		source nextPut: $_.		in next.		^ FaishVariable new.	] ] ] ].	errorBlock value: ('Unexpected character while reading input: ', nextChar printString, ' statement: ', self printString) value: (in position).	^ nil.</body>

<body package="Faish" selector="readAtomFrom:variables:onError:">readAtomFrom: in variables: variables onError: errorBlock	| varStr next name |	varStr := WriteStream on: (String new).	[	next := in peek.		next isNil ifTrue: [ errorBlock value: ('Unexpected end of stream while reading atom name: ', self printString) value: (in position). ^ nil ].		(self isNameCharacter: next) ifFalse: [ 			name := varStr contents.			source nextPutAll: name.			^ FaishAtom from: name ].		varStr nextPut: in next.	] repeat.</body>

<body package="Faish" selector="readFrom:variables:onError:">readFrom: aStream variables: variables onError: errorBlock	| nextChar in |	in := aStream.	self skipWhiteSpace: in.		[ ((nextChar := in peek) isNil not)		and: [ (nextChar ~= $.) and: [ nextChar ~= $? ] ]	] whileTrue: [		| label value |		(self isSeparator: nextChar) ifTrue: [ 			args isEmpty ifTrue: [				errorBlock value: ('No clauses appear in clause: ', self printString) value: (in position).				^ nil.			].						^ self 		].		(in peek isUppercase) ifTrue: [ 			^ self readVariableFrom: in variables: variables onError: errorBlock.		].		label := self readLabelFrom: in onError: errorBlock.		label isNil ifTrue: [ ^ errorBlock value: ('Could not read statement label: ', self printString) value: (in position) ].		value := self readValueFrom: in variables: variables onError: errorBlock.		value isNil ifTrue: [ ^ errorBlock value: ('Could not read statement value: ', self printString, ' for label: ', label) value: (in position) ]. 		self addLabel: label value: value.		self skipWhiteSpace: in.	].	args isEmpty ifTrue: [		errorBlock value: ('No clauses appear in clause: ', self printString) value: (in position).		^ nil.	].			" End of input reached, successfully made a whole statement. "	^ self.</body>

<body package="Faish" selector="source:">source: aSourceStream	source := aSourceStream.</body>

<body package="Faish" selector="readLiteralFrom:variables:onError:">readLiteralFrom: in variables: variables onError: errorBlock	| literalStr next literal literalTypeChar nestedSquareBrackets |	literalTypeChar := in next. 	source nextPut: literalTypeChar.	literalTypeChar isNil ifTrue: [ ^ errorBlock value: ('Unexpected end of stream while reading literal: ', self printString) value: (in position) ].	nestedSquareBrackets := 0.	literalStr := WriteStream on: (String new).	[	next := in next.		next isNil ifTrue: [ ^ errorBlock value: ('Unexpected end of stream while reading literal: ', self printString) value: (in position) ].		(next = $] ) ifTrue: [ 			(nestedSquareBrackets = 0) ifTrue: [ 				literal := literalStr contents.				source nextPutAll: literal.				source nextPut: $].				^ self processLiteralType: literalTypeChar contents: literal variables:variables onError: [ :error :ignored |					^ errorBlock value: error value: in position 				].			] ifFalse: [				nestedSquareBrackets := nestedSquareBrackets - 1.			].		].		(next = $[ ) ifTrue: [			nestedSquareBrackets := nestedSquareBrackets + 1.		].		(next = Character lf) ifFalse: [			literalStr nextPut: next.		].	] repeat.</body>

<body package="Faish" selector="processLiteralType:contents:variables:onError:">processLiteralType: literalTypeChar contents: contents variables:variables onError: errorBlock	| action |	" Is it a basic type? "	action :=  BasicLiteralTypes 		at: literalTypeChar 		ifAbsent: [ nil ].	action isNil ifFalse: [		^ action value: variables value: contents value: errorBlock.	].	errorBlock value: ('Unknown literal character: ', literalTypeChar printString, ' for literal contents: ', contents) value: nil.	^ nil.	"TODO: Otherwise we do some fancy stuff with the module. "	" parseLiteral:Contents typeChar:LiteralTypeChar statement:??? result:Result?		result := module query: 'parseLiteral: ', contents, ' statement: ', XXX, ' result: X?'.		... change the statement I'm parsing into that... 		... I shouldn't be doing this until I've parsed the whole statement...	"</body>

<body package="Faish" selector="skipWhiteSpace:">skipWhiteSpace: in	| nextChar |	[(nextChar := in peek) isNil not and: [nextChar isSeparator] ] whileTrue: [ 		source isNil ifFalse: [			source nextPut: in next 		] ifTrue: [			in next.		].	].</body>
</methods>

<methods>
<class-id>LegacyFaishStatement</class-id> <category>deduction</category>

<body package="Faish" selector="matchesGoal:">matchesGoal: aGoal	^ (self conclusionMatches: aGoal) or: [self matches: aGoal]</body>

<body package="Faish" selector="matches:">matches: otherStatement	" Return true if each of my arguments have values in aStatement "	self 		unifyPopulateBindings: (IdentityDictionary new) 		unifyClause: self 		with: otherStatement 		ifFail: [ ^ false ].	^ true.</body>

<body package="Faish" selector="conclusionMatches:">conclusionMatches: aStatement	" Return whether I have a conclusion that matches with the given statement. "	^ self isIfThenRule and: [ self conclusion matches: aStatement ].</body>

<body package="Faish" selector="isTrue">isTrue	" Return whether all my clauses are true and I am fully unified. "	self premises isEmpty ifTrue: [ ^ truth ].	self premises do: [ :each | each truth ifFalse: [ ^ false ] ].	self conclusion isFullyUnified ifFalse: [ ^ false ].	^ true.</body>
</methods>

<methods>
<class-id>LegacyFaishStatement</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: aStream	| result |	result := self printOn: aStream limit: 80.	aStream nextPut: $..	^ result.</body>

<body package="Faish" selector="printQueryString">printQueryString	| str |	str := WriteStream on: (String new).	self printOn: str limit: 4096.	str nextPut: $?.	^ str contents.</body>

<body package="Faish" selector="sourceCodeGenerated">sourceCodeGenerated	| str |	str := WriteStream on: (String new).	self printOn: str limit:  4194304. " Statements cannot be bigger than 4MB. "	str nextPut: $..	^ str contents.</body>

<body package="Faish" selector="printDebugString">printDebugString	| str |	str := WriteStream on: (String new).	self printDebugOn: str limit: 4096.	^ str contents.</body>

<body package="Faish" selector="sourceCode">sourceCode	source isNil ifTrue: [ 		^ self sourceCodeGenerated.	].	^ source contents.</body>

<body package="Faish" selector="editString">editString	| str |	str := WriteStream on: (String new).	self printOn: str limit: 4096.	str nextPut: $..	^ str contents.</body>

<body package="Faish" selector="sourceCodeGeneratedAsQuery">sourceCodeGeneratedAsQuery	| str |	str := WriteStream on: (String new).	self printOn: str limit:  4194304. " Statements cannot be bigger than 4MB. "	str nextPut: $?.	^ str contents.</body>

<body package="Faish" selector="printBracedOn:limit:">printBracedOn: aStream limit:numChars	| first n |	first := true.	n := numChars.	(n &lt; 0 ) ifTrue: [ 		aStream nextPutAll: '...'.		^ -1 ].	" TODO: code smell - duplicated code with printOn: "	" TODO: also add appropriate newlines. "	aStream nextPut: $(.	aStream nextPut: $ .	n := n-2.	args do: [ :each | 		first ifFalse: [ aStream nextPut: $ . ].		n := n-1.		aStream nextPutAll: each key asString.		n := n - each key asString size.		aStream nextPut: $:.		n := each value printBracedOn: aStream limit: (n-1).		first := false.	].	aStream nextPut: $ .	aStream nextPut: $).	^ n - 2.</body>

<body package="Faish" selector="printDebugOn:limit:">printDebugOn: aStream limit: n	" Return this statement with heuristics. "	| first limit |	limit := n.	first := true.	args do: [ :each | 		aStream cr; tab.		aStream nextPutAll: each key asString.		aStream nextPut: $:.		limit := limit - (each key asString size) - 1.		each value isNil 			ifTrue: [ aStream nextPutAll: '&lt;broken&gt;' ]			ifFalse: [ limit := (each value printBracedOn: aStream limit:limit) ].		limit := limit - 2.		first := false.		((each key == #if) and: [ each value isTrue ] ) ifTrue: [ 			aStream tab; tab; nextPutAll: 'true!'.			limit := limit - 7.		].	].	aStream nextPut: $..	limit := limit - 1.	^ limit.</body>

<body package="Faish" selector="printOn:limit:">printOn: aStream limit:n	| first limit |	first := true.	limit := n.	args do: [ :each | 		first ifFalse: [ limit := limit - 1. aStream nextPut: $ . ].		aStream nextPutAll: each key asString.		aStream nextPut: $:.		limit := limit - (each key asString size + 1).		each value isNil 			ifTrue: [ aStream nextPutAll: '&lt;broken&gt;' ]			ifFalse: [ limit := each value printBracedOn: aStream limit:limit ].		first := false.	].	^ limit.</body>

<body package="Faish" selector="writeOn:">writeOn: aStream		^ aStream nextPutAll: self sourceCode.</body>
</methods>


<methods>
<class-id>OnlyOnceDo class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>OnlyOnceDo</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	oneShot := true.</body>

<body package="Faish" selector="do:">do: aBlock	oneShot ifTrue: [ 		oneShot := false.		^ aBlock value.	].</body>
</methods>


<methods>
<class-id>DeductionSearchable class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>

<methods>
<class-id>DeductionSearchable class</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="from:goal:">from: anotherSearchable goal: aGoal	^ self new parent: anotherSearchable; goal: aGoal.</body>
</methods>


<methods>
<class-id>DeductionSearchable</class-id> <category>accessing</category>

<body package="Faish" selector="visit:">visit: aVisitor	" Do double-dispatch "	aVisitor visitedByDeductionSearchable: self.</body>

<body package="Faish" selector="wasOriginallyParentOf:">wasOriginallyParentOf: anotherNode	^ isThus.</body>

<body package="Faish" selector="premiseNum">premiseNum	^premiseNum</body>

<body package="Faish" selector="goalIsRootQuery">goalIsRootQuery	^ (parent isNil) or: [ parent parent isNil ].</body>

<body package="Faish" selector="originalStatementForPremiseNum:">originalStatementForPremiseNum: n	^ origStatement premiseAt: n.</body>

<body package="Faish" selector="origStatement">origStatement	" The original statement is the statement in the module from which my goal is derived. Usually my goal has had some unification done. It is stored here so that it can have its usefulness incremented if it was found to be useful. "	^origStatement</body>

<body package="Faish" selector="aChildHasFailed">aChildHasFailed	" One of my children failed. It is now impossible for me to return any results. Thus: "	self cull.</body>

<body package="Faish" selector="goal">goal	parent isNil ifTrue: [ 		" We are the root of the query. The parent wants the whole statement. "		^ goal	] ifFalse: [		" The usual case. "		^ goal conclusion.	].</body>
</methods>

<methods>
<class-id>DeductionSearchable</class-id> <category>searching</category>

<body package="Faish" selector="isGoal">isGoal	^  (self goalIsRootQuery )		and: [ goal isTrue ].</body>

<body package="Faish" selector="nextChild">nextChild	self isDead ifTrue: [ 		^ nil 	].	^ self nextChildWithHints.</body>
</methods>

<methods>
<class-id>DeductionSearchable</class-id> <category>private</category>

<body package="Faish" selector="nextPremiseNum">nextPremiseNum	" Return the next premise. On return, premiseNum is equal to the index of that premise. "	(premiseNum &gt;= premiseCount) ifTrue: [ ^ nil ].	premiseNum := premiseNum + 1.	^ premiseNum.</body>

<body package="Faish" selector="parentsRelay">parentsRelay 	| p |	p := self parentWhatIsDeductionSearchable.	p isNil ifTrue: [		^ nil 	] ifFalse: [		^ p relay	].</body>

<body package="Faish" selector="unifyPremise:with:">unifyPremise: n with: statement	| result |	result := goal unifyPremise: n with: statement ifFail: [ 		" Fails when, e.g. you try to unify (a:X b:X) with (a:a b:b). "		^ nil 	].	goal := result.	premiseCount := goal premiseCount.</body>

<body package="Faish" selector="nextChildWithHints">nextChildWithHints	" Return the next premise. On return, premiseNum is equal to the index of that premise.		We can be subject to the following hints, in order of precidence:( cull ) ( fork:Array ) ( investigateNextClause:N )All of these only match then-if statements.( investigateNextClause:N ) might have a negative number for N.TODO: node accessTODO: thread numbersTODO: handle errors, somehow. (what errors? next clause does not exist...)"	| advice |	self makeHintsSearcher.	self hintsAreAvailable ifFalse: [		^ self nextPremiseNoHints.	].	advice := self getHintsResult.	advice isNil ifTrue: [ ^ nil ].		advice isAtom ifTrue: [ 		(advice value = #cull) ifTrue: [ ^ nil ].		(advice value = #none) ifTrue: [ ^ self nextPremiseNoHints ].		^ self errorNode: 'Unknown advice in hint ', advice printString.	].	advice isStatement ifTrue: [		(advice matches: (module parse: 'fork:Array.')) ifTrue: [			" Even on single-threaded VMs, we need to simulate the same behaviour as a multi-threaded application. We need to make a 'thread' for each argument of the given array."			(advice at: 1) value isArray ifTrue: [				^ ForkSearchable new					derivedFrom: self;					forkArray: (advice value).			] ifFalse: [				^ self errorNode: 'Unknown advice in hint: ', advice printString.			]		].		(advice matches: (module parse: 'investigateNextClause:N.')) ifTrue: [			|  nextPremiseNumLiteral nextPremiseNum  |			nextPremiseNumLiteral := advice atIndex: 1.			nextPremiseNumLiteral isInteger ifTrue: [				nextPremiseNum := nextPremiseNumLiteral value.								^ self nextChildForPremise: nextPremiseNum.			]		].	].	^ self errorNode: 'Unknown advice in hint: ', advice printString.</body>

<body package="Faish" selector="relay">relay	^ relay</body>

<body package="Faish" selector="copyAndUnifyPremise:with:">copyAndUnifyPremise: n with: statement	"  Return another goal that is a copy of me but with my goal being unified with g. "	| result |	result := self copy. " The result will have my parent, even though it is further down the search tree. "	result unifyPremise: n with: statement.	^ result satisfyParent.</body>

<body package="Faish" selector="parentWhatIsDeductionSearchable">parentWhatIsDeductionSearchable	^ self.</body>

<body package="Faish" selector="nextChildForPremise:">nextChildForPremise: nextPremiseNum	| premise d |		premise := goal premiseAt: nextPremiseNum.	d := ImportListSearchable		module: module		parent: self		parentPremiseNum: nextPremiseNum		searchingFor: premise		derivedFrom: self.	^ d.</body>

<body package="Faish" selector="satisfyParent">satisfyParent	" My parent is a unification clause (or nil when maximisation is happening). I know now that the result has indeed been found and it is my goal. 	"	| result |	parent isNil ifTrue: [		" When doing maximisation, I will be the root clause of a maximisation search and we want the full then-if statement for finding the variable. "		 ^ self 	].		goal isTrue " All premises unified, all premises true "		ifTrue: [ result := parent unifyParentPremiseWith: (self goal) ]		ifFalse: [ ^ self ].			result isNil " If there was no parent deductionSearchable, meaning the parent is the final goal "		ifTrue: [			" Check the derivedFrom: " self halt.			^ (UnificationSearchableFinished new goal: (self goal)) 				module: module; 				derivedFrom: parent.			"Which should be the same as my parent" 		] ifFalse: [ 			^ result.		].		" TODO: bug here? What if there are two UnificationSearchables in succession? "</body>

<body package="Faish" selector="nextPremiseNoHints">nextPremiseNoHints	| nextPremiseNum |	done ifTrue: [ ^ nil ].		nextPremiseNum := self nextPremiseNum.	nextPremiseNum isNil ifTrue: [ ^ nil ].		done := true.			^ self nextChildForPremise: nextPremiseNum.	" I've returned my one child. I shall now no longer return more children. This will be over-ridden by hints if you want that.		Each DeductionSearchable only has one child for the next premise that needs investigating. Without hints, this means that premises will be investigated in order, and if the first premise (or nth premise) fails, I won't continue searching at the second premise.	The reason for this is that searching for the second premise if the first did not return results is rarely wanted. It will have ununified variables, and the search space is just whacked out. If this behaviour is wanted, then hints should be used.	 "</body>
</methods>

<methods>
<class-id>DeductionSearchable</class-id> <category>initialize-release</category>

<body package="Faish" selector="origStatement:">origStatement: o	" Set the original statement in the module which was used to derive me. If I'm part of a deduction that finds a goal, then we increment the usefulness of this statement.Note how I'm used. I'm only ever called from UnificationSearchable&gt;&gt;nextChild. UnificationSearchables are the only ones that pull statements out the database, one per child, so each child holds on to that statement for later reward."	o isIfThenRule ifFalse: [ self halt ].	origStatement := o.</body>

<body package="Faish" selector="copyFrom:">copyFrom: another	self goal: another statement.	parent := another parent.	module := another module.	" If I'm being copied from another DeductionSearchable, then I'm not the original. I am half-way down a proof... so when I'm displayed in the Deduction viewer,"	isThus := true.	origStatement := another origStatement.	premiseNum := another premiseNum.	^ super copyFrom: another.</body>

<body package="Faish" selector="initialize">initialize	super initialize.	premiseNum := 0.	isThus := false.	done := false. " Whether I've returned my one node. "	" Most of my initialization is done using the other constructor methods. "	^self</body>
</methods>

<methods>
<class-id>DeductionSearchable</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: aStream	aStream nextPutAll: 'D '.	"noMoreResults ifTrue: [ 		aStream nextPutAll: '(child failed) '.	]."	isThus ifTrue: [		aStream nextPutAll: 'thus '.	].	goal printOn: aStream limit: 40.		aStream nextPutAll: ' in ';		nextPutAll: module name printString.</body>

<body package="Faish" selector="printDebugOn:limit:">printDebugOn: str limit: n	| limit |	super printDebugOn: str limit: n.	limit := n.	isThus ifTrue: [		str cr;			nextPutAll: 'Parent is: '; cr.		self parent printDebugOn: str limit: limit.			].</body>
</methods>

<methods>
<class-id>DeductionSearchable</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="goal:">goal: aStatement	goal := aStatement.	premiseCount := goal premiseCount.</body>
</methods>


<methods>
<class-id>BrokenModuleSearcher</class-id> <category>comparing</category>

<body package="Faish" selector="isBroken">isBroken	^ true.</body>
</methods>

<methods>
<class-id>BrokenModuleSearcher</class-id> <category>accessing</category>

<body package="Faish" selector="setError:">setError: anObject	error := anObject</body>

<body package="Faish" selector="error">error	^error</body>
</methods>

<methods>
<class-id>BrokenModuleSearcher</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="next">next	position = 1 ifTrue: [ 		position := 2.		" TODO: the error is a string, but SearchResults return statements. "		^ SearchResult errorResult: error.	] ifFalse: [		^ SearchResult fail	].</body>

<body package="Faish" selector="nextIncludingUnunified">nextIncludingUnunified	^ self next.</body>
</methods>

<methods>
<class-id>BrokenModuleSearcher</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	super initialize.	error := nil.	position := 1.	^self</body>
</methods>


<methods>
<class-id>UnificationSearchableFinished class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>


<methods>
<class-id>UnificationSearchableFinished</class-id> <category>searching</category>

<body package="Faish" selector="isSuccessfull">isSuccessfull	^ true.</body>
</methods>

<methods>
<class-id>UnificationSearchableFinished</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="heuristic">heuristic	" Shouldn't actually be called. "	^ 10000.</body>

<body package="Faish" selector="isGoal">isGoal	^ true.</body>

<body package="Faish" selector="nextChild">nextChild	^ nil.</body>

<body package="Faish" selector="origStatement:">origStatement: something	" To stop things crashing. I'm called in UnificationSearchable&gt;&gt;processNextChild: (near the (self unifyParentPremiseWith: result) bit) specifically when there are no DeductionSearchable ancestors. "</body>

<body package="Faish" selector="printOn:">printOn: aStream	aStream nextPutAll: 'Found:'.	goal printOn: aStream.</body>
</methods>


<methods>
<class-id>ModuleImport</class-id> <category>comparing</category>

<body package="Faish" selector="hash">hash	^ self id hash.</body>

<body package="Faish" selector="=">= anotherImport	(anotherImport class = self class) ifFalse: [ ^ false ].	^ self id = anotherImport id.</body>
</methods>

<methods>
<class-id>ModuleImport</class-id> <category>accessing</category>

<body package="Faish" selector="findModuleOnError:">findModuleOnError: handler	module := Faish.FaishModuleKeeper findModuleById: id.	module isNil ifTrue: [		module := FaishRepositoriesHolder findModuleById: id onError: handler.	].	module isNil ifTrue: [ handler value: 'Could not find module ', handle value:0 ].</body>

<body package="Faish" selector="description">description	^ String fromIntegerArray: description.</body>

<body package="Faish" selector="description:">description: aDescription	description := aDescription.</body>

<body package="Faish" selector="handle">handle	module isNil ifTrue: [ ^ handle ] ifFalse: [ ^ module handle ].</body>

<body package="Faish" selector="id:">id: newId	id := newId.</body>

<body package="Faish" selector="name:">name: aName	name := aName.</body>

<body package="Faish" selector="repository">repository	^ repository.</body>

<body package="Faish" selector="repository:">repository: aRepo	repository := aRepo.</body>

<body package="Faish" selector="name">name 	^ String fromIntegerArray: name.</body>

<body package="Faish" selector="uuid">uuid	" Deprecated. Just call it an ID. "	^ self id.</body>

<body package="Faish" selector="module">module	module isNil ifTrue: [ module := CodeModule new ].	^ module.</body>

<body package="Faish" selector="module:">module: newModule	( newModule isKindOf: AbstractModule) ifFalse: [ self halt. " a bug. " ].	module := newModule.</body>

<body package="Faish" selector="handle:">handle: newHandle	handle := newHandle.</body>

<body package="Faish" selector="isModuleImport">isModuleImport	^ true.</body>

<body package="Faish" selector="id">id	module isNil 		ifTrue: [ ^ String fromIntegerArray: id ] 		ifFalse: [ 	^ String fromIntegerArray: module id ].</body>
</methods>

<methods>
<class-id>ModuleImport</class-id> <category>downloading</category>

<body package="Faish" selector="importOnError:">importOnError: errorBlock	^ module := repository importModuleById: id onError: errorBlock.</body>
</methods>


<methods>
<class-id>LegacyCacheModule</class-id> <category>public</category>

<body package="Faish" selector="add:">add: aRule	" Add the rule; return nil if the rule already exists. "	aRule bake.		(self containsRule: aRule) ifTrue: [ ^ nil ].	modified := true.	axioms add: aRule.</body>
</methods>

<methods>
<class-id>LegacyCacheModule</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	^self</body>
</methods>


<methods>
<class-id>FaishVariable class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>

<methods>
<class-id>FaishVariable class</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="initialize">initialize	pool := Dictionary new. " #symbol -&gt; Variable "</body>

<body package="Faish" selector="from:">from: aSymbol	pool isNil ifTrue: [ self initialize ].	^ pool at: aSymbol ifAbsent: [ 		| new |		new := FaishVariable new value: aSymbol.		pool at: aSymbol put: new.		new ].</body>
</methods>


<methods>
<class-id>FaishVariable</class-id> <category>comparing</category>

<body package="Faish" selector="=">= anotherVariable	^ value = anotherVariable value.</body>

<body package="Faish" selector="mostlyEquals:">mostlyEquals: another	^ another isVariable. " Any variable will do. "</body>
</methods>

<methods>
<class-id>FaishVariable</class-id> <category>accessing</category>

<body package="Faish" selector="sid">sid 	^ 19.</body>
</methods>

<methods>
<class-id>FaishVariable</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="value:">value: aSymbol	baked ifNotNil: [ ^ self error ].	value := aSymbol.</body>

<body package="Faish" selector="value">value	^ value.</body>

<body package="Faish" selector="name">name 	value ifNil: [ ^ '_', self asOop asString ]. 	^ value</body>

<body package="Faish" selector="isAnonymous">isAnonymous	^ value isNil or: [ value = $_ ].</body>

<body package="Faish" selector="isFullyUnified">isFullyUnified	^ false.</body>

<body package="Faish" selector="printOn:">printOn: aStream	value isNil ifTrue: [		aStream nextPut: $_.		" Used when debugging identity: ."		aStream nextPutAll: self identityHash displayString	] ifFalse: [		aStream nextPutAll: value.		" Uncomment the following to help see the uniqueness of variables. "		"aStream nextPut: $_.		aStream nextPutAll: self identityHash displayString."	].</body>

<body package="Faish" selector="unifiedFrom:ifFail:">unifiedFrom: anotherStatement ifFail: failBlock	" I'm a variable. Everything unifies with me. "	^ anotherStatement.</body>

<body package="Faish" selector="privateRecurseArgs:atEachLevel:">privateRecurseArgs: origStatement atEachLevel: aBlock	" Double-dispatch from recurseArgs:atEachLevel:. At this stage, I'm going to keep going because a variable (me) can bind to a whole tree of statements. "	origStatement arguments do: [ :each |		each value recurseWith: self atEachLevel: aBlock.	]</body>

<body package="Faish" selector="hash">hash	^ self identityHash.</body>

<body package="Faish" selector="copy">copy	^ self class new value: (self value).</body>

<body package="Faish" selector="isVariable">isVariable 	^ true.</body>

<body package="Faish" selector="matches:">matches: anything	^ true.</body>

<body package="Faish" selector="heuristic">heuristic	^ value inject: 0 into: [ :i :each |		each asInteger + i ].</body>

<body package="Faish" selector="&lt;=">&lt;= anotherVariable	" Used in FaishStatement&gt;&gt;unifyDoSubstitutionBindings:loopPreventSet:atKey:replaceValue: "	self value isNil ifTrue: [ ^ true ].	anotherVariable value isNil ifTrue: [ ^ true ].	^ self value &lt;= anotherVariable value.</body>
</methods>

<methods>
<class-id>FaishVariable</class-id> <category>converting</category>

<body package="Faish" selector="wrap">wrap	^ FaishLiteral value: self.</body>
</methods>


<methods>
<class-id>ExceededDepth class</class-id> <category>instance creation</category>

<body package="Faish" selector="instance">instance	(Instance isNil) ifTrue: [ Instance := self new ].	^ Instance.</body>
</methods>


<methods>
<class-id>ExceededDepth</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: str 	str nextPutAll: 'Depth exceeded.'.</body>
</methods>


<methods>
<class-id>ErrorSearchable</class-id> <category>accessing</category>

<body package="Faish" selector="statement">statement	| s |	s := module parse: 'hintsError:x.'.	s atIndex: 1 put: (FaishLiteral value: message ).	^ s.</body>

<body package="Faish" selector="message:">message: anObject	message := anObject</body>

<body package="Faish" selector="message">message	^message</body>

<body package="Faish" selector="origStatement">origStatement	" The original statement is the statement in the module from which my goal is derived. Usually my goal has had some unification done. It is stored here so that it can have its usefulness incremented if it was found to be useful. "	^origStatement</body>

<body package="Faish" selector="goal">goal	|  result |	result := module parse: 'error:foo.'.	result atIndex: 1 put: (FaishLiteral value: message).	^ result.</body>
</methods>

<methods>
<class-id>ErrorSearchable</class-id> <category>testing</category>

<body package="Faish" selector="isError">isError	^ true.</body>
</methods>

<methods>
<class-id>ErrorSearchable</class-id> <category>searching</category>

<body package="Faish" selector="isGoal">isGoal	^ true.</body>

<body package="Faish" selector="nextChild">nextChild	^ nil.</body>
</methods>

<methods>
<class-id>ErrorSearchable</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	^self</body>
</methods>


<methods>
<class-id>ExportUnificationSearchable</class-id> <category>initialize-release</category>

<body package="Faish" selector="inExportedModule:">inExportedModule: aModule	" 'module' is the importing module. For this reason, we also keep a reference to the module which is what module imports. This gets used when we make our DeductionSearchable children for when if-then clauses have their conclusion searched.. "	exportedModule := aModule.	self makeModuleSearchers.</body>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	^self</body>
</methods>

<methods>
<class-id>ExportUnificationSearchable</class-id> <category>printing</category>

<body package="Faish" selector="printOn:">printOn: aStream	aStream nextPutAll: 'Ue '.	self goal printOn: aStream.	aStream nextPutAll: ' searching ';		nextPutAll: (exportedModule name printString);		nextPutAll: ' from ';		nextPutAll: module name printString.</body>
</methods>

<methods>
<class-id>ExportUnificationSearchable</class-id> <category>searching</category>

<body package="Faish" selector="nextChild">nextChild	| c s |	c := moduleSearcher nextIncludingUnunified.	c isResult ifFalse: [ 		^ nil 	].	s := c statement.	(s isIfThenRule and: [ self goal matches: s conclusion ]) ifTrue: [		^ (self			newDeductionSearchableInExportedModuleWithGoal: s			ifFail: [ ^ self nextChild ])			origStatement: s.	] ifFalse: [ | result |		" TODO: this will do the same check as above. Code smell. "		result := self processNextChild: s.		(result isNil) ifFalse: [ 			^ result.		] ifTrue: [ 			^ nil.		].	].</body>

<body package="Faish" selector="newDeductionSearchableInExportedModuleWithGoal:ifFail:">newDeductionSearchableInExportedModuleWithGoal: g ifFail: failBlock	| newGoal result |	" cf. super&gt;&gt;newDeductionSearchableWithGoal:ifFail: "	newGoal := g unifiedGoalFrom: moduleSearcher goal ifFail: failBlock.	result := (DeductionSearchable 		from: (self copy) 		goal: newGoal)		module: exportedModule;		derivedFrom: self;		origStatement: g.	^ result.</body>
</methods>

<methods>
<class-id>ExportUnificationSearchable</class-id> <category>private</category>

<body package="Faish" selector="makeModuleSearchers">makeModuleSearchers	" Overridden method. It might be possible to remove me - does exportedModule need to be separated from module? TODO "	moduleSearcher:= MatchingModuleSearcher new		module: module; " This is for the built-ins searcher, "		searchingFor: goal; " which gets initialized here. "		module: exportedModule. " This is for the usual queries. "	" To be honest, the only reason the built-ins searcher keeps a module is for (thisModule:~). We could just intercept that particular statement earlier on. "</body>
</methods>


<methods>
<class-id>EqualityMemorySearcher</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>

<methods>
<class-id>EqualityMemorySearcher</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="next">next	| result |	" This isn't particularly efficient "	[			(position &gt; index size) ifTrue: [ ^ nil ].		(goal  = (index at: position)) ifTrue: [ 			result := index at: position.			position := position + 1.			^ result.		].		position := position + 1.	]  repeat.</body>
</methods>


<methods>
<class-id>LegacyFaishStatementSignature class</class-id> <category>instance creation</category>

<body package="Faish" selector="from:">from: aStatement	| nothing result |	result := LegacyFaishStatement new.		nothing := FaishAtom from: #nothing.	aStatement arguments do: [ :each |		result addLabel: (each key) value: nothing.	].	^ result.</body>
</methods>


<methods>
<class-id>LegacyFaishStatementSignature</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>

<methods>
<class-id>LegacyFaishStatementSignature</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="heuristic">heuristic	" *** This method was defined by FaishStatementComponent as a subclass responsibility.	Replace its body with a proper implementation. *** "	self error: 'Subclass responsibility stub not reimplemented'</body>
</methods>


<methods>
<class-id>Searcher class</class-id> <category>as yet unclassified</category>

<body package="Faish" selector="on:">on: aSearchable	^ self new on: aSearchable.</body>
</methods>

<methods>
<class-id>Searcher class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>


<methods>
<class-id>Searcher</class-id> <category>comparing</category>

<body package="Faish" selector="=">= another	" Close enough. "	^ self class == another class.</body>
</methods>

<methods>
<class-id>Searcher</class-id> <category>accessing</category>

<body package="Faish" selector="step">step	" Run one step of the deduction process and return the next node. I'm used by both the interpreter and the debugger. "	| next parent |	currentNode isNil ifTrue: [ 		" We ran out of results a while ago. "		^ nil 	].		" Do we give up and go back to the breadth-first search? "	self currentNodeIsWorthExploring ifFalse: [ 		currentNode isDepthFirst ifTrue: [ 			self giveUpOnCurrentNode.			self increaseCurrentSearchDepthLimit.			^ self stepBreadthFirstFromRoot.		]	].		" We search depth-first. "	next := currentNode nextChild. 	( next isNil ) ifTrue: [" Backtrack "			currentNode isBreadthFirst ifTrue: [ 			" Then we failed to go depth-first even one step. We're still on a breadth-first node. "			currentNode cull.			currentNode notifyNextOfKin.			^ self stepBreadthFirstFromRoot.		].		parent := currentNode derivedFrom.		parent isNil ifTrue: [ 			" Should never happen. There's always a breadth-first node as the parent of a depth-first search. If that breadth-first node dies by other means, it terminates the depth-first search. "			self halt ].		parent isBreadthFirst ifTrue: [ 			" We backtracked all the way to a breadth-first node. Nothing was found. "			breadthFirstQueue isEmpty ifFalse: [				breadthFirstQueue last leafNode: nil.			].			^ self stepBreadthFirstFromRoot.		].		currentNode isSuccessfull ifTrue: [			parent makeSuccessfull.		] ifFalse: [ 			next isNil ifTrue: [ " i.e. if next is not a BuiltInTooManyVariables. "				" This code isn't quite right yet. A noFail could still have happened in a descendant of mine and I shouldn't cull here. "				currentNode cull.				" For DeductionSearchables specifically, let it know that it now cannot produce children because one failed. "				currentNode notifyNextOfKin.			].		].		currentNode := parent. 		currentNode depthFirstChild: nil.		^ self step.	] ifFalse: [ 		next isGoal ifFalse: [			currentNode depthFirstChild: next. " So we can steal these nodes later for a breadth-first search. "			next searchType: #depthFirst.			currentNode := next.		] ifTrue: [			next isError ifTrue: [ ^ next ].			currentNode derivedFrom isNil ifFalse: [				currentNode makeSuccessfull.			]		].	].	^ next.</body>

<body package="Faish" selector="stop">stop	keepGoing := false.	wasStopped := true.</body>

<body package="Faish" selector="next">next	| next |	self hasLimit ifFalse: [ self halt: 'Warning: this query has been invoked without any limits and may run indefinitely. Press "Continue" to run the query anyway.'. ].		wasStopped := false.	timeLimit isNil ifFalse: [ 		timerStarted ifFalse: [			self startTimeLimit.		]	].	next := self searchForNext.	next isNil ifTrue: [		wasStopped ifFalse: [			hasMoreResults := false.		].		 ^ nil 	].		" Don't return duplicates: "	(duplicates containsRule: next) ifFalse: [		duplicates add: next.		^ next.	] ifTrue: [		^ nil. 	].</body>

<body package="Faish" selector="currentBreadthFirstNode">currentBreadthFirstNode	" Return the node which is at the head of the jellyfish. This is the node which I am currently performing a depth-first search on. More comments are in &gt;&gt;stepBreadthFirstFromRoot."	^ breadthFirstQueue last.</body>

<body package="Faish" selector="isFailedBuiltin">isFailedBuiltin	^ false.</body>

<body package="Faish" selector="nextStatement">nextStatement 	" Same as &gt;&gt;next, but make sure we return a statement. "	| result |	result := self next.	result isNil 	ifTrue:[ ^ nil ]	ifFalse: [ ^ result statement ].</body>
</methods>

<methods>
<class-id>Searcher</class-id> <category>setting limits</category>

<body package="Faish" selector="stepLimit:">stepLimit: limitOrNil	self clearLimits.	stepLimit := limitOrNil.</body>

<body package="Faish" selector="timeLimit:">timeLimit: seconds	self clearLimits.	timeLimit := seconds.</body>

<body package="Faish" selector="clearLimits">clearLimits	depthLimit := nil.	stepLimit := nil.	" We can't really clear the time limit. "</body>

<body package="Faish" selector="depthLimit:">depthLimit: n	" Prevent deduction going past depthLimit levels. Call this before you start invoking &gt;&gt;next. "	self clearLimits.	depthLimit := n.</body>

<body package="Faish" selector="hasLimit">hasLimit	^ ( timeLimit isNil not		or: [ stepLimit isNil not ])		or: [ depthLimit isNil not ].</body>
</methods>

<methods>
<class-id>Searcher</class-id> <category>private</category>

<body package="Faish" selector="giveUpOnCurrentNode">giveUpOnCurrentNode	" We have reached a depth limit on a depth-first search and the search will continue from the root node again for another solution. We save the current search state so that this branch can be resumed again later if that happens."	self currentBreadthFirstNode leafNode: currentNode.</body>

<body package="Faish" selector="searchAlgorithmExplanation">searchAlgorithmExplanation"The search tree looks like this, where the tree is rotated so that the root is left. 'U' means UnificationSearchable, 'D' means DeductionSearchable and we ignore the other searchable nodes here for clarity.U - D - U - D - U - D - U - D - ...That is to say, it alternates between UnificationSearchables and DeductionSearchables, with the potential for other kinds of Searchables to appear in the tree (keep this in mind when changing the code!).The 'top' of the tree (i.e. the first few nodes) is searched breadth-first. The rest of the tree is searched depth-first. This means that the algorithm used is a combination of breadth-first and depth-first search. At the top of the tree is a 'root set' which is a breadth-first search, and each of these has a depth-first search hanging from them.Usually there's only one node in the breadth-first search part of the tree, which is the root (a UnificationSearchable in this example, but in reality it's an ImportListSearchable). From this we do a depth-first search just like Prolog. If the depth-first search hits some arbitrary depth limit, then we say the search has 'given up: we return right back to the root and perform one step of the breadth-first search. After this single step, we do another depth-first search. This is the gist of the algorithm.We assume that other mechanisms are used to make optimal choices for choosing which of the children of each node is used in the depth-first search.When a node 'gives up', search must be able to resume from that node later. For the depth-first search, the root of the depth-first part of the search is a DeductionSearchable that is stored in the breadth-first search. This node stores, for each clause, the leaf node of each depth-first search that each clause has potentially spawned. This makes them available for returning to later.If any search (breadth or depth) succeeds with an answer, we return the answer, and we keep the current state of the search so we can continue later to find more answers.A search node fails if none of it's children return a result or it itself cannot return any results. This is different from when a search node is 'exhausted', which means results have been returned and used and the node can't find more results. If a node fails, it must notify it's parent. The reason for this is that if a DeductionSearchable receives a 'fail' from any of its children, that means the whole DeductionSearchable will fail as all clauses cannot be made true. Thus, we should terminate any other active searches which have the DeductionSearchable as parent. The cases where another search may have been made are (1) The DeductionSearchable node is in the breadth-first search and another clause in it had been investigated but was given up on, and (2) another thread or process is running the second search. In (1), we just remove the DeductionSearchable from the breadth-first search tree.Now, the implementation of a breadth-first search. A breadth-first search requires the use of a queue. To start, the root node is pushed into the queue. Then, repeatedly, we pop a node off the head of the queue and push all it's spawned children on to the end of the queue until the node is exhausted. We stop when a solution is found.In this algorithm however, we only perform a single step of the breadth-first search whenever some depth-first search 'gives up'. This step involves popping the head off the queue, evaluating and adding all it's children to the end of the queue and 'discarding' it. Some of the children might already have had a depth-first search done on them. This means that we need to steal their children from the depth-first searches. Fresh child nodes are added to the queue first, and then child nodes with depth-first searches are added so that they don't get reevaluated until after the fresh nodes. Now, a UnificationSearchable with a lot of matching results (e.g. from a database) would explode the queue. To prevent this, the head of the queue is not popped until it has exhausted all children, and each child that is added to the end of the queue immediately gets evaluated with a depth-first search and is removed from the end of the queue if it fails entirely.Ask The Metadata for execution advice--------------------------------The intelligence behind Faish comes from the 'AskTheMetadata' mode, where an if-then statement has extra metadata associated with it to determine which course of action to take. Metadata stored in the same module is consulted using a full query. By using a full query, metadata can be provided from if-then clauses, meaning that expensive calculations are able to be done to determine the next action. Advice can be:* Give up, try elsewhere.statement:~searchNode:~metadata:( advice:giveUp ). Both the statement and searchNode are needed. The statement is needed so that we know where to set the AskTheMetadata flag. The searchNode is navigable by metadata statements to make informed decisions.* (For if-then clauses) Choose a particular clause to investigate with a given heuristic. Note that the statement might already have been partially populated by previous search nodes.statement:~searchNode:~metadata:( advice:( chooseClause:N depthLimit:D ) ).* (For if-then clauses) Provide the clause order. This metadata will automatically be created and added when a if-then clause without a predefined clause order is investigated.statement:~metadata:( clauseOrder:( :[+2] :[+3] :[+1] )).(this does not use advice: as it is not queried during execution but rather is processed directly when this metadata is added to the module ).* For UnificationSearchables, provide an index to use as an ordering of a module's nodes. (noting that indexes have not yet been implemented).statement:~searchNode:~metadata:( advice:( useIndex:~ ) ).* For UnificationSearchables, provide a more restrictive query to use instead. The query will be a copy of the statement but with more restrictions. (not implemented - can this be done using indexes?)statement:~searchNode:~metadata:( advice:( useQuery:[\ ~ ] )).If no advice is found, the usual deduction continues as normal.TODO: cache control? Try to disprove a statement?In an if-then statement, the statement and each if-clause has an 'AskTheMetadata' flag on it. The statement's flag determines whether clause order should be determined by asking metadata in that module. The flag is set when the metadata is added to the module. "</body>

<body package="Faish" selector="searchForNext">searchForNext	| next  |	keepGoing := true. " Can be set to false by another thread to stop the query. "	[ keepGoing ] whileTrue: [ 		next := self step.		next isNil ifTrue: [ ^ nil ].			( (depthLimit isNil not) and: [ next isNil not and: [next depth &gt; depthLimit ] ] ) ifTrue: [			" next cull."  "TODO: what should we do here? We're losing results! "			^ ExceededDepth instance.		].		(stepLimit isNil not) ifTrue: [			(stepLimit &lt;= 0 ) ifTrue: [				wasStopped := true.				^ ExceededSteps instance.			].			stepLimit := stepLimit - 1.		].		next isGoal ifTrue: [ 			keepGoing := false.			next makeSuccessfull.			^ next goal		].	].	keepGoing := false.	^ ExceededTime new.</body>

<body package="Faish" selector="stepBreadthFirstFromRoot">stepBreadthFirstFromRoot	| first next |	" We perform one step of a breadth-first search. After this single step, we start (or continue) a depth-first search on the newly found node. I am called when a depth-first search gives up. This happens when the current node's depth exceeds a limit.Breadth-first search is implemented using a queue, breadthFirstQueue. The current node on which we do a depth-first search is at the end of the queue.                                                              v The last node has the current depth-first search.    A  B  C  D  E  F  G  Aa Ab Ac Ba Bb Ca     ^ Get children from this node.               ^ Put those children here at the end.The node at the start of the queue is where we get new nodes from; we fetch children one at a time. When all children have been fetched, we discard the node.We implement node stealing. When all new direct children have been created and the node is empty, we steal the node from it's depth-first search. "	[ 		breadthFirstQueue isEmpty ifTrue: [ 			currentNode := nil. " Because if we just removed the last breadth-first node, currentNode might still have a value. "			^ nil 		].		first := breadthFirstQueue first.		first cullChildrenIfDead.		" If we just killed the node, then the following statement will return nil and the node will be discarded."		next := first nextChild. " BreadthFirstSearchNode&gt;&gt;nextChild, will steal if it needs to "		next isNil	] whileTrue: [		first target cull.		breadthFirstQueue removeFirst.	].	breadthFirstQueue add: next.	next target searchType: #breadthFirst.	currentNode := next leafNode.	currentNode isNil ifTrue: [		currentNode := next target.		] ifFalse: [		next leafNode: nil. " Because it is now currentNode. "	].	^ currentNode.</body>

<body package="Faish" selector="increaseCurrentSearchDepthLimit">increaseCurrentSearchDepthLimit	currentSearchDepthLimit := currentSearchDepthLimit * 2</body>

<body package="Faish" selector="startTimeLimit">startTimeLimit	" Stop the query again after n seconds. "	timerStarted := true.	([ 		timeLimit seconds wait.		self stop.	] forkAt: Processor userInterruptPriority ) name: 'Faish: stop query after ', timeLimit printString, ' seconds.'.</body>

<body package="Faish" selector="currentNodeIsWorthExploring">currentNodeIsWorthExploring	^ currentNode isWorthExploringPastDepth: currentSearchDepthLimit.</body>
</methods>

<methods>
<class-id>Searcher</class-id> <category>status</category>

<body package="Faish" selector="clear">clear	" Reset wasStopped. You can call this between invoking &gt;&gt;next. "	wasStopped := false.</body>

<body package="Faish" selector="hasMoreResults">hasMoreResults	" I will return true if there are possibly more results, or false if you should stop invoking me. "	^ hasMoreResults.</body>

<body package="Faish" selector="isRunning">isRunning	^ keepGoing</body>

<body package="Faish" selector="wasStopped">wasStopped	^ wasStopped.</body>
</methods>

<methods>
<class-id>Searcher</class-id> <category>initialize-release</category>

<body package="Faish" selector="on:">on: aSearchable	breadthFirstQueue add: (BreadthFirstSearchNode new target: aSearchable). "Because it's the root. "	currentNode := aSearchable.	currentNode searchType: #breadthFirst.	duplicates := LegacyCacheModule new.	hasMoreResults := true.	wasStopped := false.</body>

<body package="Faish" selector="deductionQuery:module:heuristic:derivedFrom:origStatement:">deductionQuery: aQuery module: aModule heuristic: h derivedFrom: df origStatement: s 	" Used only from MaximisationSearchable. aQuery is a then-if statement. "	| d |	d := DeductionSearchable from: nil goal: aQuery.	d module: aModule;		derivedFrom: df;		origStatement: s.	self on: d.	^ self.</body>

<body package="Faish" selector="query:module:">query: aQuery module: aModule	" Return the query, derived from my memory. If the query has variables in it, try to unify those variables with existing knowledge. If the query is not true (i.e. it can not be derived from the database), return nil. "	| d query |	aModule resetIfNeeded. " It is difficult to find a place to do this that doesn't make an infinite loop. "		query := aQuery.	d := ImportListSearchable module:aModule searchingFor:query.	self on: d.	^ self.</body>

<body package="Faish" selector="initialize">initialize	breadthFirstQueue := OrderedCollection new.	keepGoing := false. " Is set to true while the query is running, set it to false to stop the search. "	depthLimit := nil.	stepLimit := nil. 	timerStarted := false.	currentSearchDepthLimit := 5000.	" The current search depth limit is how deep to search before giving up and doing a breadth-first search step. "</body>

<body package="Faish" selector="queryString:module:onError:">queryString: aString module: aModule onError: errorBlock	" Return the query, derived from my memory. If the query has variables in it, try to unify those variables with existing knowledge. If the query is not true (i.e. it can not be derived from the database), return nil. "	| query |	query := aModule parse: aString onError: errorBlock.	^ self query: query module: aModule.</body>
</methods>


<methods>
<class-id>DoNotFailSearchable class</class-id> <category>instance creation</category>

<body package="Faish" selector="new">new	^ super new initialize.</body>
</methods>


<methods>
<class-id>DoNotFailSearchable</class-id> <category>accessing</category>

<body package="Faish" selector="depthFirstChild:">depthFirstChild: c	" We are our own child, so this is actually pointless. "	depthFirstChild := c.</body>

<body package="Faish" selector="notifyNextOfKin">notifyNextOfKin	" Do nothing. "</body>

<body package="Faish" selector="goal">goal	^ derivedFrom goal.</body>
</methods>

<methods>
<class-id>DoNotFailSearchable</class-id> <category>searching</category>

<body package="Faish" selector="nextChild">nextChild	^ nil.</body>

<body package="Faish" selector="isGoal">isGoal	^ false.</body>

<body package="Faish" selector="isDead">isDead	^ true.</body>
</methods>

<methods>
<class-id>DoNotFailSearchable</class-id> <category>initialize-release</category>

<body package="Faish" selector="initialize">initialize	super initialize.	^self</body>
</methods>



<initialize>
<class-id>BuiltInsSearchable</class-id>
</initialize>

<initialize>
<class-id>FaishVariable</class-id>
</initialize>

<initialize>
<class-id>SearchResult</class-id>
</initialize>

<initialize>
<class-id>AbstractModule</class-id>
</initialize>

<initialize>
<class-id>LegacyFaishStatement</class-id>
</initialize>

</st-source>
