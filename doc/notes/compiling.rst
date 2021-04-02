Compilation
===================

Terminology
-----------

A *hard statement* is a queryable statement in a module.

A *soft statement* is a data structure in a module that is passed around for manipulation during compilation. It will eventually become a *hard statement*.

*metadata* are statements about statements. There are two types:

* Any stand-alone literal or atom before a statement in a module describes the statement after it.

* All statement of the form (:: X) (i.e. it starts with two colons) are ordinary statements, but is detected early by the tokeniser step and compiled before other statements. These can be queried during compilation for, e.g. type declarations.

Soft statements also contain information about the line and column numbers each component is found in the original source code.

Compilation steps
-----------------

Compilation comes in three flavours: compiling a source file, compiling an individual statement (i.e. incremental compilation) and compiling a query.

Adding hints to aid the compiler in generating optimal code is a step that happens before compilation. Hints are statements of the form (:: (hint X)) which indicate to the compiler that particular indexes are to be used or that if-clauses are to be executed in a particular order.


Compiling a source file
~~~~~~~~~~~~~~~~~~~~~~~

This is when a source file is provided for compilation into a module. The result of compilation is a queryable module that contains hard statements.

Each individual statement is compiled as described in the next section

#. An empty module is created. This is the target for all other compilation steps.
#. Imports are processed and added to the module.
#. The parser will take source code and parse it into soft-statements. Soft-statements are stored in a module (i.e. "tokenisation"). Each soft-statement's position in the final module is added as metadata to the soft-statement. Ditto for the it's original place in the source code.
#. Soft-statements of the form (:: X) are found, compiled first and added to the module.
#. All other statements are compiled and added to the module.
#. (TODO create indexes??)


Compiling an individual statement
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. The signature for that statement is either found or created. Signatures are special objects from the VM's point of view; they are manipulated using built-ins. To find signatures, they are stored as (:: signature SourceCode Signature) where SourceCode is a string of the source code and Signature is a link to the special object. (TODO: string of source code?)
#. Literals are expanded.
#. The soft-statement is type-checked and type-annotated.
#. The soft-statement is checked for other errors and warnings.
#. The soft-statement is then hardened and added to the module in the correct location.

Compiling a query
~~~~~~~~~~~~~~~~~

Compiling a query takes a particular query and produces executable machine code that returns results for that query.

When executing as a service that responds to events, queries are normally pre-compiled to accept parameters, and then invoked for each event.

See "Generating Code", below.

TODO - In a query, variables can be either parameters (+X) or results (-X). The parameters are provided when the query is executed; the results are returned by the generated code.

Optionally, the compiler also inserts profiling code into the executables for further optimisation and recompilation. This would be analysed at a later stage to provide hints for the next round of compilation.

The compiler needs to:

* Compile queries to LLVM
* Add debugging information
* Add optional trace / profiling information.
* Have settings for optimisation levels.


Where compilation is used
-------------------------

Every device would run a continuous event loop. On initialization, the queries that can be performed are compiled. When executed, parameters (variable bindings) are passed into the queries, and results (other variable bindings) are returned.

The REPL could return a string::

    device:cli output:Out tock:To :-
        tick:Ti tock:To,
	device:cli input:In tock:Ti,
	compile:In result:Code,
        execute:Code result:R,
        statement:R source:Out.

Parameters need to be converted to structs and bound to their variables. Then, the compiled code can be executed. Alternatively, a statement can be compiled every time it is used.

It's possible for the module storage to not be used by compiled code (I think?), unless modules are created and used by the compiled code. This means that the compiler should be created before the module storage.


Re-arranging statements
-----------------------

This is an optimisation step. For each step, some original statements must be retained to preserve the semantics of the module, and statement metadata such as export declarations must also be modified.

The goal of rearranging statements is (TODO) to have as many built-ins in each then-if statement as possible.

Repeated statements can be removed::

    a:X :- b:X, b:X.
      becomes
    a:X :- b:X.

In theory, statements can be repeated (which might be useful somehow? Maybe to help generate parallel code?)::

    a:X :- b:X.
      becomes
    a:X :- b:X, b:X.

Variables can be populated::

    a:X :- b:X, c:X.
    c:a.
      becomes
    a:a :- b:a, c:a.

Given statements can be removed::

    a:X :- b:X, c:a.
    c:a.
      becomes
    a:X :- b:X.

Statements can be inlined::

    a:X :- b:X, c:X.
    b:X :- d:X, e:X.
      becomes
    a:X :- d:X, e:X, c:X.

Statements can be extracted::

    a:X :- g:X, h:X.
    b:X :- g:X, h:X.
        becomes
    a:X :- j:X.
    b:X :- j:X.
    j:X :- g:X, h:X.


Statements can (maybe?) be moved between modules provided that import semantics are preserved.
    
The ordering of statements is decided by hints.

Arithmetic can be re-arranged::

    a:X b:Y :-
        n:X plus:[+4] result:Z,
        n:Z plus:[+2] result:Y.

    becomes

    a:X b:Y :-
        n:X plus:[+6] result:Y.

There are a large number of possible arithmetic optimisations. 


Automatic hints
---------------

TODO.

A basic automatic hint creator that can handle simple sequential code is as follows:

Then-if statements would have variable dependencies analysed. Variables would be "provided" ("+") or "returned" ("-"). A tree of if-clauses would be created based on variable dependencies. Each branch can be investigated in parallel. Each path would be investigated in sequence.

Then-if statements would be searched for recursion and put recursion last.

TODO: How would profiling statistics be used in deduction searchables.

Catalogs can be created either by:
* Ordering by most likely to defeat execution, followed by most likely to succeed execution based on profiling statistics.
* Split up to allow for parallel execution.

Deductions would first try to show that a particular branch cannot succeed before investigating it.

Automatically creating hints is an exceptionally hard problem that requires AI techniques. Any computer science problem can be expressed in statements, meaning that automatic hint creation essentially creates the algorithms to solve them.


Generating code
===============

TODO: convert all the code examples below to compilable C.

We want to generate code that the compiler can optimise as much as possible:

* Variables (e.g. X) are variables on the stack.
* Searchables are stack frames.
* "Returning" from a function generally means backtracking.
* We try not to make data structures that LLVM cannot optimise - i.e. try to avoid using the heap.

To make a child node, we do a function call.

When a result is found from a UnificationSearchable, we create another child node, which is another function call. It uses a pointer to a previous value in the call stack containing the original statement to unify with the new found result.

When a result is found for the query, the root node has just been used to have it's query unified so should still be nearby the code that found the query. The root node can contain the details of what to do with found results. At this stage, the stack has reached its maximum height, whereas most other programming languages have an empty stack on completion.

To backtrack, we return from a function. Returning is backtracking.

Built-ins are converted directly into their implementation.


TODO: How do we do Jellyfish seach? Add each new breadth-first search to the top of the call stack? Start a new thread? How would node stealing happen?

TODO: How do we persist a partial evaluation?


DeductionSearchables
--------------------

Code for handling a deduction searchable would handle each clause sequentially. The clause ordering might come from hints, which might be evaluated at compile time or runtime.

The method names here are using an invented scheme for this example. "da1" is deconstructed as follows:

* "d" means a DeductionSearchble. "u" means a UnificationSearchable.
* "m" is the method tag for (a:X)
* "1" means the first if-statement.

The example code here has tags for each statement.

::

    m. a:X :- b:X, c:X.

The first statement becomes::

    dm1() { // a:X
        um1_for_dm1(statement); // b:X
    }

and for the second clause (and so forth for the third, forth...)::

    dm2() { // after b:X has been investigated.
        um2_for_dm2(statement); // c:X.
    }

The function um1_for_dm1(...) eventually calls dm2(); however this can be a long way down the call stack and it's not efficient to carry squl variables as function parameters for that entire distance. 

UnificationSearchables
----------------------

Code for handling a unification searchable becomes either of:

* sequential code, investigating each item in a catalog.
* for huge numbers of matches, code that iterates over a catalog. 

The catalog might come from a hint. The generated code would then follow the same behaviour as the interpreter. New searchables would be created and code jumped to to handle each statement.

Each UnificationSearchable's code is generated in the context of some DeductionSearchable. It includes code to perform the next step of the DeductionSearchable as well.

Don't forget that returning from a function means backtracking.

"..." means that, potentially, more code may follow depending on what else is in the module.

Continuing from our earlier example::

    m. a:X :- b:X, c:X.
    n. b:a.              
    o. b:b.
    p. c:b.
    q. a:X?

becomes::

    // Unify q, which is the root query (a:X?).
    uq() {
        dm1();
        ...
    }

    // Find matches for if-clause 1 of m.
    um1_for_dm1(dm1) {
        fn_for_dm1(dm1); // Found n.
        fo_for_dm1(dm1); // Backtracked, Found o.
        ...
    }

    // Find matches for if-clause 2 of m.
    um2_for_dm2(dm2) {
        fp_for_dm2(dm2); // Found p
        ...
    }

or, if the catalog is large (or use binary search, etc)::

    um1_for_dm1(dm1) {
        for( each in catalog_bX ) {
            process that statement (TODO)
        }
    }

Where (these can be inlined. They're part of the UnificationSearchables)::

    // Found n for m's 1st clause
    fn_for_dm1(dm1) {
        //Use a provided pointer *dm1 to unify that with n.
        result = unify(dm1, n);
        dm2(result); // This is why we're in the context of dm1.
    }

    // Found o for m's 1st clause
    fo_for_dm1(dm1) {
        result = unify(dm1, o);
        dm2(result);
    }

    // Found p for m's 2nd clause.
    fp_for_dm2(dm2) {
        // dm2 is dm1 but with the first clause now found.
        result = unify(dm2, p);

        // This is how results are returned to the query originator.
        // The compiler should know, based on variable tracing, whether it's 
        // possible for this to happen here:
        if( is_fully_unified(result) ) {
            return_result(dm2, result); // dm2 must somehow contain a pointer to the query originator.
	}
        // Otherwise just return/backtrack.
    }

Each function's arguments might include:

* The depth of that invocation.
* ...variables???
* TODO - look at Faish's current implementation


Recursion
---------

Each searchable is compiled into a function that is created to be aware of everything on the call stack below it. The top half of the call stack mirrors the bottom half: when a result is found for a UnificationSearchable, the stack frame which is created is made specifically to resolve a stack frame further down the call stack. I.e. a call stack could look like this (where the last line is the bottom of the call stack)::

    11 Send a:a to the user.
    10 therefore a:a.       // resolve 2
    9 found c:a.            // resolve 8
    8 U c:X?                // continue with 2
    7 therefore b:a.        // resolve 4
    6 found d:a.            // resolve 5
    5 U d:X.
    4 D b:X :- d:X.
    3 U b:X.
    2 D a:X :- b:X, c:X.
    1 U a:X? 

The top half of the call stack (more or less) resolves the bottom half of the call stack. The top half is basically a mirror of the bottom half.

This means that as Searchables are compiled to functions, they need to be compiled in the context of everything below them, and include code to resolve anything below then right down to the bottom of the call stack.

For a finite call stack, this works fine.

This obviously doesn't support recursion. Compilation of a recursive program would make an infinite amount of code.

Thus, there needs to be some way to detect loops and recursion. Recursion might form a non-trivial loop where multiple statements form a recursive loop together, i.e. (a:-b, b:-c, c:-a).

Each statement would become a different compiled function depending on the entire call stack below it. This works fine for finite call stacks.

Each statement which could be investigated recursively must become a function that could be called from two places, one of which is recursive.

Usually, we would make a separate function from a statement for each context, e.g.::

    r. a:X :- b:X.
    s. c:X :- b:X.

Here, two different functions would be made for (b:X); the first would create a new stack frame to process a result for (a:X), the other would create a new stack frame to process a result found for (c:X).

However, doing so with a recursive function would create infinite functions, so we need to create one function that can be called from two places (here, t and u)::

    t. a:X :- b:X.
    u. b:X :- b:X.
    v. b:a.
    w. a:X?

::

    u_w() { // The root query.
        d_t_from_w();
        // Add more unification possibilities here.
    }

    d_t_from_w() {     // DeductionSearchable on t.
        u_t1_from_w(); // UnificationSearachable on t1 (b:X).
    }

    u_t1_from_w() {
	d_u_recursively(from_t);    // Special handling for a unification_clause.
        u_v_from_u_t1_from_w();  // Try UnificationSearchable on v.
        // add more unification possibilities here.
    }

    d_u_recursively(var from) {
        // We can be called from two contexts.
        // Our behaviour changes depends on where we were called from.
	if (from==from_t) {
            u_u1_from_t1_from_w();
	} else if (from==from_u) {
            u_u1_from_d_u_from_u_t1_from_w();
	}
    }

    u_u1_from_d_u_from_u_t1_from_w() {
	// Here we need to change the rules because of recursion.
        d_u_recursively(from_u);

	u_v_from_u_u1_from_d_u_from_u_t1_from_w();
        // add more unification possibilities here.
    }
    
    u_u1_from_t1_from_w() {
        // If u had more if-clauses, they would go here.
        resolve_u_from_t1_from_w(); // "resolve" means unification.
    }

    resolve_u_from_t1_from_w() {
        resolve_t1_from_w();
    }

    u_v_from_u_t1_from_w() {
        resolve_t1_from_w();
    }

    resolve_t1_from_w() {
	resolve_w();
    }

    resolve_w() {
        // Show the result to the user.
        // Return from this function so that more results might be found.
    }

It is readily apparent that a lot of inlining would occur and the code would be reduced down by an optimising compiler.


UnificationSearchables iterating over a catalog
----------------------

If a Unification Searchable iterates over a catalog, each entry in that catalog will be an uncompiled statement. 

Perhaps everything could be compiled.

Otherwise  code would need to manually read in and unify statements. The number of variables is not known beforehand.

Unification
-----------

Unification is the process of finding values for variables.

Each statement would have a `struct` made to store variables relevant to that stack frame. E.g.::

    n. a X Z :- b X Y, c Y Z.

becomes::

    struct n {
        struct m *previous;
        var X;
        var Y;
        var Z;
    }

The pointer called "previous" is a pointer to the previous structure on the preceeding stack frame. When the "resolve" functions are called, this pointer is used to find variables further back in the call stack.

This struct would be stored on the stack as a local variable. When another function is called, a pointer to it is passed as an argument to the next function for storage in the *previous pointer.

(side note: if we were getting funky with code generation, we wouldn't need these pointers as we know the nature of the stack and where the previous structure would be.)

Ideally, the variables in the struct would be of their native types: uint8_t[], int32_t, etc, to allow LLVM to optimise as much as possible.

TODO: what would atoms and statements be? Identifiers? Pointers into a database?

TODO: variable direction suddenly becomes important for code generation. I wonder if we can stick all the code in and let LLVM work it out?

A compilation example::

    m. a X?
    n. a X :- b X.
    o. b X :- c X, d X Y.
    p. c a.
    q. d a b.

::
    struct m { var *prev; var X };
    fn m(*user) {
        struct m this;
        m->prev = user;
        n(&this);
    }

    struct n { var *prev; var X };
    fn n(*prev) {
        struct n this;
        this->prev = prev;
        o(&this);
    }

    struct o { var *prev; var X; var Y };
    fn o(*prev) {
        struct o this;
        this->prev=prev;
        o1(&this);
    }

    fn o1(*prev) {
        // I'm part of a deduction, I share o's variables.
        p(prev);
    }

    // This is used to keep code regular. In theory it can be 
    // optimised awa.
    struct no_variables { var *prev; };

    fn p(*prev) {
        struct no_variables this;
        this->prev = prev;
        if (null==prev->X) { // If unbound.
            prev->X = a;
            o2(this);
        }
    }

    fn o2(*prev) {
        q(prev);
    }

    fn q(*prev) {
        struct no_variables this;
        this->prev = prev;
        // We need to check whether we might backtrack before we
        // alter any variables.
        if (null!=prev->X && prev->X != a) {
            return;
        }
        if (null!=prev->Y && prev->Y != a) {
            return;
        }
        prev->X = a;
        prev->Y = b;
        resolve_o(prev);
    }

    fn resolve_o(*prev) {
        // Set my parent's X to my X.
        if (null==prev->prev->X) {
            prev->prev->X = prev->X;
            resolve_n(prev->prev);
        } else if (prev->prev->X == prev->X) {
            resolve_n(prev->prev);
        }
    }

    fn resolve_n(*prev) {
        // Set my parent's X to my X.
        if (null==prev->prev->X) {
            prev->prev->X = prev->X;
            resolve_m(prev->prev);
        } else if (prev->prev->X == prev->X) {
            resolve_m(prev->prev);
        }
    }

    fn resolve_m(*prev) {
        // tell the user. prev should contain a value for X now.
    }
            

The compilation example above is a bit lazy with variable unification. When unifying variables, there are different possibilities:

* A variable might be unbound, in which case it can be given a new value.
* A variable might already have a value, in which case it needs to be compared to the new value.
* It might be bound to another variable.
* It might be unbound, and we are binding it to another variable.

TODO: it seems like variables should be pointers?

TODO: try manually compiling all those tricky examples in the tests.

TODO: special rules are needed to handle recursion. We only know the type of the previous stack pointer when we don't have recursion. With recursion, the type could be one of multiple options.

Imports
-------

TODO


Evaluting Hints at Runtime
--------------------------

Hints can be evaluated at runtime by making a query and using the results of that query to determine what to do next.

Debugging information needs to accompany the hint evaluation code.


Forking Processes
-----------------

The forking hint can be implemented by implementing the next step of deduction as a new query.

For a DeductionSearchable, this means forking a process for the if-clauses specified in the hint. For a UnificationSearchable, this means creating a process on each of the provided indexes.

::

    // Forking example.
    fn ~(~) {
        SharedQueue q; // This is the "user" of the queries below.
        fork {
            unify the first clause group as a new query(q);
        }
        fork {
            unify the second clause group as a new query(q);
        }
        while (~) {
            wait(q);
            fill in any newly unified variables.
            if fully unified, continue with the "resolve" steps.
        }
    }

One cool feature would be to be able to fork a process to another machine on the network.


Memoization
-----------

Memoization can be done by doing a slow iteration over a mutable module instead of compiling a UnificationSearchable to be fast inline code.

At the generating end, we take the result of deduction and add it to the cache module. We need to be able to distinguish unified from ununified variables.

At the consuming end, we replace a UnificationSearchable with an iteration over a mutable module.


Negation
--------

::
    a X :- b X.
    not b X :- ~.

This is a (potential) feature of the VM where a (not X) will stop a deduction in it's tracks.

You add a search for (not X) before the search for X. If (not X) succeeds, we backtrack immediately.


Debugging
---------

Debugging information can be included as LLVM metadata.


Profiling
----------

Code for adding profiling information to a globally accessable module can be inserted around the normally generated code. More discussion is found in profiling.rst.


Depth, Step, Time limits
------------------------

Depth and step limits can be implemented by passing counters around.

A time limit can be implemented by killing a process. This implies that all things a process done can be safely interrupted.


Special Modules
---------------

Modules can potentially be::

* Mutable or non-mutable.
* In-memory only or persisted to disk.
* Distributed across a network.
* Loaded dynamically.
* A fast cache, e.g. for a working module. They will forget unused statements.


Event Loops
-----------

(TODO: hypothetical)

Usually when Squl controls a device, an external event loop is sending events and performing queries. If an application was written directly in another programming language, it woudl directly read from a device and perform the appropriate action. Squl instead has a convoluted mechanism of inserting an event into a working module, then querying that working module for the appropriate action on each iteration of the event loop.

This event loop can be the top level of compiled code. The event loop itself can be a top-level while() loop or equivalent code::

    fn main() {
        while(true) {
            event e = read from device.
            add e to the working module.
            query for action.
            switch(action) {
                ~
            }
        }
    }

The "query for action" would be the generated code for a query. 

An optimisation would be to avoid using a working module. There is no way for LLVM to optimise a module away, so this optimisation would need to be implemented by the Squl compiler. The optimisation is as follows. When a statement is added to a module and then later queried for, the Squl compiler can inline the code so that code to maintain a mutable module does not need to be generated and the query still produces the correct result.::

    m. a X :- 
        create module M,
        M add (hello world),
        M query ( hello [\X] ) Iterator,
        Iterator next (hello X).

This would be (somehow) optimised to::

    m a (hello world).

With the event handling loop, the code for inserting statements into a working module is not generated from Squl code but rather part of the top-level template for handling that particular device. After optimisation, the code that reads directly from the device should be migrated to where the query would occur.

TODO: perhaps we could implement the event loop in Squl by using statements with side effects (here, (system A B))?::

    init :- 
        create module Working_Module,
        event loop Working_Module t0.

    event loop Working_Module Tp :-
         system fgets Input,
         create atom Tn,
         Working_Module add (tick Tp tock Tn) WM2,
         WM2 add (device cli tock Tn event:(input Input) WM3,
         WM3 query (device cli tock Tn action:[\A]) Iterator,
         Iterator next (device cli tock Tn action (output Output)),
         system printf Output,
         event loop WM3 Tn.
         


Example
-----------

(this example will have bugs)

::
    [" Find the length of a list. ].
    m. list:empty length:[+0].
    n. then:( list:( h:_ emnut:Emnut ) length:N2 )
           if:( list:Emnut length:N1 )
           if:( n:N1 plus:[+1] result:N2 ).
    o. list:L length:N?
    

The execution order for a three-element list would be::

    U o
      U m (assume non-empty list)
      D n
        U n1
          D n
            U n1
              D n
                U n1
                  U m
                    P n2
                      thus n
                        P n2
                          thus n
                            P n2
                              Found N=3


In a library, we already have::
   
    typedef struct Statement {
        int type;
        Statement* parent;
    }
        

    /* Not sure how to do this; TODO */
    typedef struct Statement_list {
        Statement super;
    }

    typedef struct Statement_list_element {
        Statement_list super;
        Anything H;
        Statement_listElement Emnut;
    }

    /* An empty list. */
    typedef struct Statement_listElement_empty {
        Statement_list super;
    }

The compiler would start by declaring structures to hold the variable bindings. We can usually determine the statement that the variables belong to implicitely based on position in the code::

    typedef struct Statement_o {
        Statement super;
        Statement_listElement L;
        int N;
    }
 
    typedef struct Statement_m {
        Statement super;
        // Has no variables, will be optimised away.
    }

    typedef struct Statement_n {
        Statement super;
        Statement_listElement Emnut;
        int N2;
        int N1;
    } 

(The structs could also be pointers into module storage, which prevents the need to copy out the results after they're found. On the other hand, structs let LLVM do more fancy tricks and the result would be faster.)

The code is now generated:

* Returning is backtracking. The result will be found at the top of a large call stack.
* Results need to be copied out of the call stack immediately when found; otherwise they'll be lost.
* UnificationSearchables become sequences of unifyable statements. 
* DeductionSearchables become function calls (below, u_n1(), u_n2()).
* Each unify_*() method introduces a new statement, which is stored as a struct on the call stack.
* We need to store the parent statement and which parent clause if-statements should unify with.


    // The query is o; ~ is a parameter that we don't yet know the value for.
    void query_o(Statement_o *r) {
        // r.L has already been populated by the user.
        u_o(r);
    } 
        
    // UnificationSearchable, goal is o.
    void u_o(Statement_o *r) { // +L, -N
        unify_m(r);ion succeeds, it must itself call a DeductionSearc
        unify_n(r);
    }

    void unify_m(Statement_o *r) {
        Statement_m me; // will be optimised away.
        me.super.type=m;
        me.super.parent=r;

        if (r[0]==empty) {
            if (r[1]==0) {
                found(r); // TODO
            }
        }
    }

    void unify_n(Statement_o *r) {
        Statement_n me;
        me.super.type=n;
        me.super.parent=r;

        if(r.Emnut == h:emnut:) {
            me.Emnut = r.Emnut.Emnut
            u_n1(me);
        }
    }

    void u_n1(Statement_n *r) {
        unify_m(r);
        unify_n(r);
    }

    // Note the function overloading that happens here.
    void unify_m(Statement_n *r) {
        Statement_m me; // will be optimised away.
        me.super.type=m;
        me.super.parent=r;

        if (r[0]==empty) { // We need to refer to the statement's structure here.
            r.N1 = 0;
            p_n2(r.super.parent);
        }
    }

    void unify_n(Statement_n *r) {
        Statement_n me;
        me.super.type=n;
        me.super.parent=r;

        if(r.Emnut == h:emnut:) { // Where h:emnut: is a const.
            me.Emnut = r.Emnut.Emnut;
            u_n1(me);
        }
    }


    // Built-in implementation
    void p_n2(Statement_n *r) { // +N1, -N2
        r.N2 = r.N1 + 1;
        thus_n(r);
    }
    
    void thus_n(Statement_n *r) {
	Statement_n *parent = r.parent;

	// Eventually the parent will be a Statement_o.
	if (parent.super.type == o) {
            found(r);
        } else if (parent.super.type == n) {
            parent.N1 = r.N2;
            p_n2(parent);
        } 
    }



Linking
------------

Faish would be used from an external shell that interacts with it using queries::

    while(...) {
        insert_events(); // into the working module.
        action = query( device:me tock:tn action:X );
        switch(action) {
            ...
        }
    }

(or similar code)

The query can be compiled into a linkable object using the Squl compiler and LLVM. It can then be linked with the result of compiling the above code, and final LLVM optimisation passes can do their magic on it.

One difficult optimisation is to be aware of what the working module would contain before the compiler optimisation passes. I don't know how you would achieve this.


Special cases
-----------------------

then:(~)
if:(~A~)
if:A.

Occurs check, infinite statements?

Jellyfish search.

Reflection, creating and querying modules at runtime.

Limits: step, depth, time.

Persistence of queries.
 


-----------------------------
Other optimisations could include:

* Using SIMD instructions. Perhaps LLVM would do this for us?

* Determine when statements are not used by anybody else (they're "disposable") and just mutate them rather than copy them.

* Being able to compile to VHDL for FPGAs.


