Faish Tutorial
==============

This tutorial first describes some basic concepts of Squl, and then guides you through some of the interesting language features using the Faish implementation.

Language basics
---------------

Faish is the first implementation of the Squl programming language. The Squl programming language is designed as a basis for developing an "Artificial General Intelligence": an intelligent construct that has capabilities similar to a human. Squl is, at least hypothetically, capable of encoding any human thought, although no rigorous research has gone into attempting to prove the validity of this assertion.

Squl is a logic-based programming language. In contrast to conventional programming languages, a program written in a logic-based programming language describes the problem at hand to the computer, which then attempts to solve the problem. A program consists of a number of statements about the problem. This is an example statement::

    father:alfred of:bob.

I.e. Alfred is the father of Bob. The language syntax is entirely trivial and can be learned in a few minutes. Using it, however, is going to take some time to master.

To aid with writing larger programs, a module system has been included as part of the Squl specification (i.e. this document) and implementated as part of Faish. This allows you to modularise your applications and create re-usable modules for, potentially, sharing with other users. A module has a name, author, date and so forth, and contains a number of statements. Modules can also link to each other to re-use each other's statements.

Modules are described in their own chapter TODO.


Using Faish
-----------

You're probably keen to start writing code. Open up Faish. Faish 0.3 is distributed as a zip file that can be unpacked anywhere and used. The application itself is in a Smalltalk image file named "faish.im". To execute it under Linux, run "faish.sh". Under Windows, you can use the Smalltalk interpreter which has been renamed to "faish.exe" to execute the image file.

Most actions are done by using the context menus. Right-click on a relevant object to show the context menu.

This will show the module list:

TODO

Now create a new module (right-click or use the "new" button) and call it, for example, "Genealogy". You should see something similar to this:

TODO

This is where most of the action happens. Many of the features in the menus are not yet implemented but will be in future versions of Faish.

You will notice that there is already a statement in this module that starts with "module:... metadata:(name:...)". You can ignore these. These statements are module metadata that describe the name of the module, which other modules they import, which queries they retain and so forth. These are standard statements that you can query, write and delete if you wish, although you will experience the usual effects of deleting, for example, the module's name.

Press CTRL+n to create a new statement, enter the statement below and press CTRL+Enter to accept it::

   father:alfred of:bob.

You should now see this statement in the left pane. The left pane lists all statements in this module. 

What you have just declared is that "alfred is the father of bob". The statement's signature is "father:_ of:_.". If this were Prolog, you would have used "father(alfred, bob)". Here, "alfred" and "bob" are atoms; in other programming languages they could be known as symbols or constants.

The concept here is that you are using an editor for statements in a logical database. Faish code lives in a logic database rather than in files, although you can import and export modules to files for safe keeping. As of Faish 0.2, this "database" is actually Smalltalk image persistence. You can save the image by pressing CTRL+s, so that when you restart Faish, your modules are as you left them.

Now press CTRL+e, enter this query and press CTRL+Enter to run it::

   father:Who of:bob?

This is a query that says "Who is the father of bob?". Note that this statement ends with a question mark, which signifies to Faish that this is a query. Faish will add this to the query pane on the right hand side and then show any results of this query.

Here, "Who" is a variable. Variables always start with an upper-case character. When a query is run, the Squl interpreter tries to find values for variables. Variables have their context within a single statement; the same variable must have the same value whereever it occurs only in the same statement or if-then clause. If two separate statements share the same variable name, their variable values are completely independent from each other.

You will notice that Faish responds with new statements rather than with values for X. If you enter, for example, this query::

   father:alfred of:bob?

then Faish will just return the same statement. If you enter a statement that is not true, such as::

   father:alfred of:edward?

then Faish will simply respond with "No results".

If you close this window and then double-click on the module in the module list to re-open it, you will notice that your queries are no longer there. In order to keep a query for later re-use, you can right-click it and select "Retain query". This adds a special metadata statement to the module which is read by Faish when a module is opened to restore any retained queries.

Queries will run for 30 seconds. If you want a query to run for longer, right-click on it and select "Persevere with this query...". 

There is a rudimentary debugger available by right-clicking on a query and selecting "Show deduction". 

Literals
--------

Examples of literals are integers and strings. These are the data items in a programming language that the user types in directly rather than writes code to create. In Squl, all literals are encased in square brackets. The first character of a literal defines its type:

============	================================================================
[+2]		The integer "2".
[-4]		The negative integer "-4".
["Hello, world]	The string "Hello, world".
============	================================================================

Note that strings only have the one double-quote. The square brackets delimit the string. To include a right square bracket in a literal, double it: ["A bracket: ]] ]. (This may change in a future version of Faish, as literals inside literals become exceptionally cumbersome when the brackets are doubled up).

Making a list
-------------
Lists, trees, queues and other data structures can be made using sub-statements. These are statements inside statements.

This is the list containing the atom "first", the number "2" and the string "three"::

    h:first emnut:(h:[+2] emnut:(h:["Three] emnut:end)).

A convention in Squl is to label the first element of a list "h" and the rest of the list "emnut". The last element in a list is "end".

Here, we see statements inside other statements. Embedded statements have parenthesis around them, and they share variables with their outer statements. The first statement is "h:first emnut:(...)" with the ellipses being the embedded statement "h:[+2] emnut:(...)", again with this next ellipses being the embedded statement "h:["Three] emnut:end". 

If-then rules
-------------
So far we have described a language which can store lots of interesting pieces of information, but cannot process it. In order to get interesting behaviour, we define "if-then" rules. These are statements which have any number of "if" clauses and a single "then" clause. For example::

    then:(mortal:X) if:(man:X).

This means "X is mortal if X is a man". Note that we put the "then" first.

We usually write these clauses over several lines in this format, putting the "then" clause first::

    then:(
        mortal:X )
    if:(
        man:X ).

When investigating this statement, the Squl interpreter will try to find values for X.

Now if we run the query::

    mortal:socrates?

We get no results. In the world we have defined, there are no men. We need to define a statement which can satisfy the "if" clause::

    man:socrates.

Now if we re-run the query, we find that socrates is, unfortunately for him, mortal.

When we run a query, the Squl interpreter tries to find a value for a query by examining "then" clauses. If one matches, it tries to find solutions for all of the "if" clauses in that statement, again by examining "then" clauses in other statements.

For example, if we had the following statements::

    then:(
        mortal:X )
    if:(
        man:X ).

    then:(
        man:X )
    if:(
        human:X )
    if:(
        alive:X ).

    human:socrates.
    alive:socrates.

Here, we say "if X is a man, X is mortal", and we say "if X is human, and if X is alive, then X is a man.".

Note that there are two separate variables named "X" here: one for each statement. A variable exists only within a statement. If another statement re-uses the same variable name, it is considered a completely different variable. There is no such thing as a global or shared variable in Squl.

We run this query::

    mortal:X?

Faish will try to find any statement matching "mortal:X". It finds the first statement: "then:(mortal:X) if:(man:X).".

Then it tries to satisfy each if-clause by searching for any statement that has a then-clause matching "man:X". It finds the second statement.

Then it tries again to satisfy all the if-clauses, asking whether "human:X?" (finding "human:socrates." with X=socrates) and whether "alive:X?", or actually "alive:socrates?" as it has already decided that maybe X=socrates. It indeed finds "alive:socrates." as a statement.

Then Faish heads back to the top of the proof. We find that "man:socrates.". Then we go back up a level again and find "mortal:socrates." which satisfies our original query.

Recursion
~~~~~~~~~

Recursion is used in declarative programming languages where iteration is used in conventional programming languages. It is the only mechanism available for repeating anything in Squl.

If-then rules can contain their own then-clauses as if-clauses. When Faish tries to find an answer, it will then use the same rule many times over. For example, to find the last element of a list, we could use these statements::

   list:(h:LastElement emnut:end) lastElement:LastElement.

   then:(
       list:( h:H emnut:Emnut )
       lastElement:Last )
   if:( 
       list:Emnut
       lastElement:Last ).

You might need to stare at these statements for a while until your brain stops hurting. The author certainly did, but thankfully it becomes much easier with practise.

Briefly explained, the first statement is a "base case" for recursion. It is where the recursion will stop and a result is found. This statement means "The element of a list just before 'end' is the last element of the list".

The second statement states "the last element of a list is somewhere in the tail of the list". The tail of a list is all elements of the list other than the first. Faish will keep applying this statement, skipping over all elements in the list, until the first statement can be used to find the actual result.

Don't worry if you don't understand the example above yet. Recursion is a tricky concept, but thankfully most problems have the same pattern and, over time, using recursion becomes easier to understand.

What happens if we include a nasty statement which does infinite recursion on itself, such as::

    then:(
        a:X )
    if:(
        a:X ).

In this case, nothing spectacular happens. The Faish interpreter as of version 0.3 will just run the query for a while and find nothing interesting. If any results could be found from other statements, they might be found a bit slower. Hopefully in a future version of Faish, pointless recursive loops such as this one would be automatically detected and ignored rather than waste CPU cycles. In other words, you don't need to worry about left-recursion as you do in Prolog.

Managing module imports
-----------------------

Say that you want to use a statement in another module. 

TODO

Click on "Edit", then "Add Module Import". Select a module you want to import and click "Okay". You can now use any statements in that other module which have been exported.

See chapter on Modules TODO for more information.

To make life as simple for the programmer, modules will be automatically downloaded from a module repository. TODO

Language conventions
--------------------

To help code to be as readable as possible by different programmers, several conventions are used.

In real code, statements become quite complex so it is necessary to format them over several lines. Nested statements are indented. Closing parenthesis are included at the end of a line (for vertical compactness) and parenthesis have spaces on the inside rather than the outside (e.g. "( head:X tail:end )") unless they are adjacent to another parenthesis.

The "then" clause is included first by convention. "if" and "then" clauses occur on a line by themselves.

For example::

    then:(
        sorted:(h:H emnut:(h:E emnut:Mnut))
        fn:SortFn
    if:(
        fn:SortFn
        a:H
        b:E )
    if:(
        sorted:(h:E emnut:Mnut) ).       

If your statement takes in a particular data type and does something with it, then one label should show what data type is expected, and the other label shows the result::

   list:In sorted:Out.
   tree:In balanced:Out.
   queue:In removeOverdue:Out.
   n:Number doubled:NumberDoubled.

If an operation takes in a third argument, then the result can simply be called "result"::

   list:In append:Element result:Out. 
   tree:In removeAll:Element result:Out.
   mapping:In removeKeys:KeyName result:Out.

Some common clause labels are:

============	================================================================
fn:		A function name. This is an atom.
result:         The "output" from a function or operation.
a:		The first argument of a function
b:		The second argument of a function
c:		The third argument of a function
n:		A number, usually an integer.
i:		An index corresponding to the location of an element in a list.
s:		A statement.
q:		A query.
============	================================================================

TODO: this bit needs updating.

Higher-order operations take a function name (as an atom) as a value. "fn" is used as a short label name for the function when it is defined. For example, to double all elements in a list::

   then:( list:In doubled:Out ) 
   if:( collect:double list:In result:Out ).

   then:(
       fn:double list:In result:Out )
   if:(
       n:In multiply:[+2] result:Out ).

Here, "collect" applies the named function "double" to every element of a list.

Variables can have little suffixes to add information. "Out" is added (e.g. "TailOut") to annotate that a variable is a result. Conversely, "In" is used to annotate a variable is incoming, although usually just the variable name suffices. "Inc" can be suffixed to annotate that an integer is incremented by any amount and "Dec" for when a variable is decremented by any amount, e.g. "N", "NInc" and "NDec".

For lists and binary trees, there are three very useful variable names: Hemnut, Bokluz and Dagpos. These are akin to the canonical foo, bar and baz for variable names.  Single letters denote an individual element; multiple letters denote part of a list or a tree. Hemnut, Bokluz and Dagpos are specifically formatted as they are with consonants and vowels so they can be split up as follows:
		
============	================================================================
H|Emnut		Single head element and the remaining tail of a list.
H|E|Mnut	First two elements of a list plus a tail.
Hemnu|T		Most of a list followed by a single tail element.
Hem|N|Ut	Some of a list or tree, a middle element, and the rest of the list.
He|M|N|Ut	Some of a list or tree, followed by two elements (M and N), followed by the rest.
Hem|Nut		Two branches of a binary tree.
============	================================================================

"Hemnut" is used for input, "Bokluz" is used if a list is output, and "Dagpos" is used in emergencies. Hemnut is originally derived from "H" for head, "M" and "N" from the middle two letters of the alphabet, and "T" for tail. 

Lists are made using "hemnut" as well, using "end" as the end of list or empty list marker::

    h:firstElement emnut:(h:secondElement emnut:end).

Binary trees follow the same pattern as follows::

    hem:leftBranch nut:rightBranch.

Ideally, however, a custom literal would be used, e.g. "[,firstElement, secondElement].".

Writing Tests
-------------

To open a module's test module, open a code module and use the menu item Modules → Open tests.

To run all tests, click on "Run all tests" in the test module's query pane's context menu. Note that this will clear all existing queries.

Modules containing user-written code can have its own test module. This provides the programmer with a convenient facility to write unit tests for his code. Test modules have special import rules; the usual import mechanism is bypassed in the interpreter and all statements in the code module are made available to the test module. In this way, tests can test all code defined in the code module without tests needing to be included in the code module.

When you click on "Open tests", a new test module is created if there isn't one already. If the code module already has an associated test module then it is downloaded and opened. Test modules are associated with a code module by including a statement of the form "module:_ metadata:(testModule:_ uri:_ name:_)." in the code module.

To make tests, enter statements of the form "test:X" into the test module where X is a statement. A test is assumed to pass if it returns at least one result, and assumed to fail if it returns no results.

For example, here is an example test to determine if the "n:_ plus:_ result:_." built-in statement is correctly setting the variable X::

    test:(
        and1:(
            n:[+5] plus:[+1] result:X )
        and2:(
            equal:X w:[+6] ) ).

Here is an example of a test that passes if there are no results, where the user has defined "noResults:" elsewhere::

    test:(
        noResults:(
            a:a b:b ) ).

In the code module, you can convert a query into a test by using "Add as test" in the query's context menu. This will take the query, wrap it in a "test:X" clause and add it to the associated test module.


Using the debugger
----------------------------

Perform a query, then right-click on it. In the context menu, you should see "Show Deduction" (TODO).  This opens the debugger, currently called the "Deduction Browser".  

This opens a "search tree" on your query. Faish does not linearly execute code; rather, it explores a "search tree" for solutions. This is similar to a call stack in any other programming language's debugger, but has some important differences. 

The search tree consists of search nodes. Each search node's label starts with it's type ("D", "U", "Ue", "I", "P") and the statement it is searching for.  This is described in more detail in it's own chapter (TODO).

There are several buttons in the toolbar.  As of Faish 0.3, there are no working keybindings yet. The buttons are:, from right to left

">|": Step once as Faish would.
"TODO": "Step over", meaning that Faish will continue stepping until the next sibling node is reached.
"TODO": "Return", meaning that Faish will continue stepping until it returns to the parent node.
">>": Step as Faish would, 20 times.

Now, these might have unexpected behaviour because we are searching through a search tree rather than executing using a call stack. "Sibling" and "parent" nodes may be deeper into the search tree. This is explained in the chapter on the debugger (TODO).