Patterns in Squl
===================

Declaring a statement
------------------------------

To declare a set of matching statements, we have the following format:

* Documentation
* Type declaration
* Example usage as retained queries.
* Statement implementation
* Tests

Where the statement implementations are each:

* Optional documentation
* Tags
* Statement label
* Statement


Documentation
------------------------------

Documents are naked strings. The assumption is that they refer to statements directly after them.::

     :[" This is documentation, possibly in reStructuredText format. ].

TODO:

    [" This is documentation? ].


Tags
------------------------------

Tags are naked atoms. They are used as markers in the code to find something or to add some annotation to a statement. The assumption is that they refer to statements directly after them::

    todo.
    XXX.
    deprecated.    

Tags can be used to label a statement:

    statement13.
    something:[" This is statement 13.].

If tags are used to label a statement, it should be a unique tag, and the tag would directly precede the statement. 

Tags can then be used to refer to a statement in a literal (not implemented yet):

	hint:(
		statement:[\statement13]
		node:N
		thread:Td
		relayIn:Rin
		relayOut:~
		advice:~ ).


As code modules are ordered, a tag can refer to the statement or statements immediately after it. This allows tools be to directed at particular statements.

Tests can be named::

     test45.
     test:( ~ ).

Numbers can also be used.

    13.
    a:empty.

    14.
    then:( a:Next ) if:( b:Next ).
    
    metadata:( important:[\14] ).


Ordering of arguments
------------------------------

If a statement generally generates a result, then the last argument of that statement would be (result:~).

TODO: Can we use >: instead of result:? -->:R ^:R 

then-if statements should be ordered top to bottom in the usual order they would be evaluated in.


Naming of Variables and Statements
------------------------------

Use full names in statements rather than abbreviations. Use the time you spend typing to think about your code.

Variables can have short names as their scope is only a few lines of code.

If you a constantly "mutating" a variable, number it::

    then:( in:N1 out:N4 ) 
    if:(
        n:N1 plus:[+1] result:N2 )
    if:( 
        n:N2 multiply:[+2] result:N3 )
    if:(
        n:N3 negative:N4 ).

(TODO: move the section from the main doc here).


Error handling
------------------------------

On a device, errors are a type of event. They can be handled like any other event.

In other code such as a parser, wrap a value in either (success:~) or (error:~). ::

    ~:~ result:( success:Foo ) :-
        ~.

or:: 

    ~:~ result:( error:( text:ErrorText line:N ) ).



Then-if-else
-------------------------

If you want to create an "else" clause, put the conditions in an inner clause::

ifSomething:Foo :-
    inner:Foo.

elseSomething:foo :-
    noResults:( inner:Foo ).

Implication: The :- symbol is the logical implication. If you have:

    a :- b.

If the whole statement is true (i.e. it is declared in a module), then a cannot be false if b is true. 

If the statement appears inside another, then the semantics changes. It can resolve to true or false. 
If b is true and a is false, then the result is false. When the interpreter determines if an implication 
is true or not, it can first evaluate a. If a is false, then it needs to evaluate b to determine if the 
whole statement is true or false. If a is true, b can be ignored. 

If a is true, b is ignored and the statement is true.
If a is false, b is evaluated. If b is true, the statement is false.

Recall that ( a :- b ) is ( a ; not b ).



Mutable variables
-------------------------

Mutable variables can be done like this:

    :: declare [ (type A ) -> (type A) ] (type mutable).
    ( A1 -> A2 ),

This clause can be matched with a single variable:

    addOne MutableInt :- 
        MutableInt = ( Int1 -> Int2 ), 
        Int2 = Int1 + [+1].

In a complex statement, a variable will be mutated several times, meaning that in the statement you 
have (A1 -> A2), (A2 -> A3) and so forth.

A custom literal can be created to make managing this easier: [mA] is a mutable A, with smart variable renaming 
for the entire statement.


Higher Order Functions 
----------------------

You can declare a "function" as ( Args | Impl ), e.g. ( A B | plusOne A B ). To invoke the "function":

    invoke (A B | Fn) :-
        Fn.

Here, A and B are found inside Fn somewhere.

For example, map:

    :: declare (type mutable (type collection A) (type collection  B)) 
        map (function A B)).
    ( [= H|=Emnut ] -> [=B|=Okluz] )
    map 
    ( (H->B) | Fn ) 
    :-
        Fn,
        (Emnut -> Okluz) map Fn.

Usage example:

    plusOne (X -> [=X+1]).
    X = [ 1 2 3 ] map ( (A->B) | plusOne (A->B ) ).   

