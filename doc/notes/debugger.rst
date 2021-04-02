Using the Faish Deduction navigator
==========================

TODO: In the debugger, I want to be able to:
* step into (DONE)
* step over: 
	- Go to a descendant node which is the next DeductionSearchable child. (DONE)
	- Try the next UnificationSearchable match instead.
* See which branches would have failed.
	- by returning to a parent node.

This chapter describes the behaviour of Faish 0.3 when searching for an answer to a query.

To debug a query, right-click on it and select "Show deduction". This will let you see how Faish is attempting to answer your query.

In order to debug a query, you will need to know how Faish answers a query. 

The behaviour as of Faish 0.3 is not yet well defined and is work in progress. It may or may not eventually become a standard for VM implementations to ensure that behaviour across different Squl VM implementations is consistent. Currently there is no guarantee that a particular query will ever be answered.

In the Faish Deduction navigator, there is a tree structure representing the search tree navigated by Faish. You can manually explore the search tree by expanding nodes; the easiest way to do this is with the cursor keys on your keyboard.

The ">|" button at the top of the screen will step through the search tree in the same manner that Faish will explore the tree.

An important concept to know about is that the search tree is just that, a search tree. The query is the root node of the tree. The answers to that query are leaf nodes of that tree. The tree might have infinitely deep branches and infinitely broad branches. Once an answer is found, the interpreter can continue finding more answers.

TODO: concurrency?

Limitations of the debugger
---------------------------------------

It should be noted that the deduction browser is still work in progress. The tree widget that it is based on will spawn all children for a node before they are visible, which might unfortunately alter the behaviour of the search tree.

Node types
------------------

In the deduction navigator, there are several kinds of nodes visible:

* ImportListSearchables. These will spawn a child node for every imported module.
* DeductionSearchables. These will spawn a child node for every if-clause in a then-if statement.
* UnificationSearchables. These will spawn a child node for every match found in the currently searched module.

These nodes are directly from the inner workings of the VM.

A simplified view of the search tree is that it is made of alternating UnificationSearchable and DeductionSearchable nodes. Each UnificationSearchable has DeductionSearchables as its children. Each DeductionSearchable has UnificationSearchables as its children.

A DeductionSearchable is made on a then-if clause. It will spawn a child for every if-clause. 

A UnificationSearchable has a statement that it is searching for. It will spawn a new child for every match it finds in the module. When it finds a match, it will make a new child which will probably (but not always) be a DeductionSearchable made from a parent DeducationSearchable with a new unified clause filled in to it. The search will continue until all the parent DeductionSearchables have matches for all of their clauses, at which stage a result is found for the query.

However, there are ImportListSearchables inserted between this chain of DeductionSearchable/UnificationSearchable nodes. These ImportListSearchable nodes exist so that imported modules are also searched. Each UnificationSearchable is searching within a particular module and with behaviour specified by Squl's module importing mechanism; a parent ImportListSearchable node specifies the module and behaviour of that UnificationSearchable. 

Occasionally you will see a "thus..." node. These are DeductionSearchable nodes where one of the clauses has found a match. This child node is a copy of the grandparent DeductionSearchable node with that clause unified. This can be confusing to look at; the interpreter will skip over several steps and only show you the result. It may seem that a "thus..." child node has no bearing to its parent; this is because of the steps that are not shown.

If a single clause of a DeductionSearchable has failed, the other clauses will never be able to find results. Because of this, when Faish detects that one of the children of a DeductionSearchable (representing one of the then-if clauses) has entirely failed, that is to say that zero results have been found after an exhaustive search of that branch, then the entire DeductionSearchable is marked as "dead" and no more children will be generated from that search tree.

Note that sometimes you get an unexpected node as a result. Faish might perform multiple operations without putting them on the search tree when it can easily find a result.

Searching behaviour
----------------------------

Faish implements Octopus searching. The head of the search is a breadth-first search, off which comes several tenticular depth-first searches.

Clicking on the ">|" button will step through the search tree in the same manner as the interpreter would. The behaviour is as follows:

The interpreter starts in a "Breadth-first" search mode. It will explore the tree breadth first but only for a single step.

After the initial breadth-first step, the interpreter then starts a depth-first search. 

The depth-first mode has a depth limit placed on it, currently set to a depth of 500 (which will certainly change with later releases of Faish). After going 500 levels deep, the depth-first search fails. The depth-first search is then stored so that it can potentially be recommenced later. The search then does one step of a breadth-first search from the root to gain another start node to do another depth-first search from. Note that only one step of the breadth first search is done before attempting another depth-first search.

Sometimes Faish can determine that nodes are no longer worth searching, such as when a single child of a DeductionSearchable fails. You will see nodes "die" when this happens.

All fo this behaviour is visible in the deduction browser. After going 500 nodes deep, search will recommence from the root. The nodes appear as follows:(TODO: pictures)

* Breath-first search nodes are green with <-> arrows.
* Depth-first search nodes are blue.
* Dead nodes are grey.

Node Pruning
----------------------------

Some definitions:

* A node is *exhausted* if it has already spawned all children it can spawn. Results may have been found.
* A node *fails* if none of it's descendants could find any results. 
* A node is *dead* if it has failed.
* A *result* is a solution to a query. It will always be a leaf node.

If a child of a DeductionSearchable *fails*, then the whole DeductionSearchable fails and it becomes *dead*. Recall that a DeductionSearchable spawns one child node for each clause of a then-if statement. If any of these clauses fails, it becomes impossible for the DeductionSearchable to find any results. The DeductionSearchable can then be pruned from the search tree.

You will notice this behaviour when using the deduction browser. If a child of a DeductionSearchable finds absolutely no results, then the search will ignore that DeductionSearchable and backtrack to that DeductionSearchable's parents.

TODO: find some way of explaining this in the deduction browser.


Cached results ("memoisation")
-------------------------

This has not yet been implemented in Faish 0.3.

Partial or full results from particular queries or deduction steps can be cached by the Faish interpreter to avoid lengthy recalculation. For example, Faish would automatically store results from a prime number generator to speed up calculations.

Statements are cached when TODO.

When a cached result is being used, something something TODO will appear in the deduction browser.
