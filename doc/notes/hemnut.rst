Hemnut language proposal
=========================

This document describes new syntax ideas for a similar language derived from Squl.

Hemnut is a derivative of Squl. It is basically Squl without labels.

Each statement is an ordered sequence of clauses. One or more of those clauses should be atoms. Statements end with a full-stop (period). Variables and literals are the same syntax as in Squl. For example, the Hemnut::

    cn C map (double) -Result.

has the Squl equivalent::

    cn:C map:double -:Result.

The parenthesis around the atom "double" are optional.

In the Hemnut example, "cn", "map" and "-" are atoms. They form the statement definition. They can also be unified with variables::

    ballOne is blue.
    ballTwo is blue.

    X is blue? 		
    ballOne is Colour?
    ballOne WhichRelationship blue?

Each statement is a list of statement components. At least one of these is an atom which determines the signature of the statement. For example::

    list L append E - Result.

Here, the statement signature is ( list _ append _ - _ ), where the underscores are positions free for variables, substatements, etc. The atoms are (list, append, -). This gets compiled into a statement of signature with arity 3 (where [\listappend-] is the compiled signature)::

    [\listappend-] L E Result.

 This extra clauses is also added silently to the module so that queries on the atoms of the signature are possible, but most likely will be removed during optimisation::

     list A append B - C :-
         [\listappend-] A B C.

This allows the user to do some funky higher-order logic, e.g.

    list [,1,2] Operation [+3] - [,1,2,3].

An example of what this allows can be demonstrated with the "24 game", where given four numbers, we must find operators in (*, \, +, -) that can be applied to find an answer::

    (([+6] Op1 [+8]) Op2 [+3]) Op3 [+2] = 24?

This allows for higher-order functions::

    A double B :-
        A = B*2.

    map Op (A|=Emnut) (B|=Okluz) :-
        A Op B,
        map Fn Emnut Okluz.

    map double [,5,7] X?

	
Declarations
---------------------

Statements need to be defined before we know their signature. The definition only declares one particular signature.

::
    declare [ 
        stream (type stream)
        read (type bytearray)
        numBytes (type integer)
        encoding (type encoding)
    ]
    (type o)
    leftAssociative
    precidence 1150
    description [" Read numBytes of bytes into the bytearray ].

The first argument is a soft statement literal, which is a format that the compiler uses. It uses a space as it's designating character, and it is an array containing only atoms and type declarations. 

Declarations are processed in a compiler pass just after a module has been converted to soft statements, but before the rest of the module has been compiled. 

It could be possible for a statement declaration to be a then-if clause. Perhaps values could also be made available to a type checker for, e.g., bounds checking.

Eliding Parenthesis
-------------------

This includes:

* Precidence
* Associativity
* Cuddliness

Precidence is the hierarchy given to signatures or operators. For example, in standard algebra, multiplication has precidence over addition.

Without precidence::

    declare [ (type formula) * (type formula) ] (type formula).
    declare [ (type formula) + (type formula) ] (type formula).
    ((N * 3) + 2) + 4 = 5.

With precidence::

    declare [ (type formula) * (type formula) ] (type formula).
    declare [ (type formula) + (type formula) ] (type formula).
    [ _ + _ ] < [ _ * _ ].
    (N * 3 + 2) + 4 = 5.

Prolog and some variants use integers for precidence; each operator is assigned a precidence integer. Precidence doesn't need to be an integer; any sortable object will suffice, and the signature itself could be made sortable::

Associativity is whether operators, when repeated, are parenthesised to the left or right. Associativity can be:

* leftAssociative
* rightAssociative
* nonAssociative

where nonAssociative is the default. A nonAssociative operator must always be parenthesised.

With associativity::

    declare [ (type formula) * (type formula) ] (type formula).
    declare [ (type formula) + (type formula) ] (type formula) leftAssociative.
    [ _ + _ ] < [ _ * _ ].
    N * 3 + 2 + 4 = 5.

List concatentation is rightAssociative; these are equivalent::

    one |= (two |= (three |= (four |= empty))).
    one |= two |= three |= four |= empty.

Cuddliness is whether an operator needs whitespace around it. This makes it more difficult for the parser::

    declare [ (type formula) * (type formula) ] (type formula) leftAssociative cuddly.
    declare [ (type formula) + (type formula) ] (type formula) leftAssociative cuddly.
    [ _ + _ ] < [ _ * _ ].
    N*3+2+4 = 5.

Core library
------------

::
    [" First-order Logic ].
    [" TODO: probably wrong. Read about Harrop clauses. ].
    declare [ (type o) :- (type o) ] (type o) leftAssociative cuddly.
    declare [ (type o) -: (type o) ] (type o) leftAssociative cuddly.
    declare [ (type o) , type o) ] (type o) leftAssociative cuddly.
    declare [ (type o) ; type o) ] (type o) leftAssociative cuddly.
    declare [ \= (type o) ] leftAssociative cuddly.
    [ _ ; _ ] < [ _ , _ ].
    [ |= _ ] < [ _ ; _ ].

    [" Declarations ]
    declare [ 
        declare 
        (type signatureLiteral) 
        (type type) 
        (type associativity) 
        (type cuddlyness) ].
    declare [
        declare (type signatureLiteral) (type type) ].
    declare [
        declare (type signatureLiteral) ].

    declare [ leftAssociative] (type associativity).
    declare [ rightAssociative] (type associativity).
    declare [ nonAssociative] (type associativity).
    
    declare [ cuddly ] (type cuddlyness).
    declare [ nonCuddly ] (type cuddlyness).

    (type signatureLiteral) = (type (list signatureComponent)).
    declare [ X ] (type signatureComponent) :-
        X subclassOf (type atom).
    declare [ type X ] (type signatureComponent) :-
        declare _ (type X).

    declare Declaration Type nonAssociative nonCuddly :-
        declare Declaration Type.

    declare Declaration (type o) nonAssociative nonCuddly :-
        declare Declaration.

    [" Lists ].
    declare [ (type A) |= (type (list A)) ] (type (list A)) rightAssociative cuddly.    declare [ (type (list A)) =| (type A) ] (type (list A)) leftAssociative cuddly.
    declare [ (type (list A)) =|= (type (list A)) ] (type (list A)) rightAssociative cuddly.
    declare [ (type A) | (type A)) ] (type (list A)) rightAssociative cuddly.
    declare [ empty ] (type _).

    [" Algebra ].
    [" TODO: what is (type any)? ].
    declare [ (type _) = (type _) ] (type o) nonAssociative cuddly.
    declare [ (type o) = (type o) ] (type o) leftAssociative cuddly.




Closures?
----------------

It could be possible to include some kind of brackets to give variables a context? This would be used for the equivalent of anonymous functions. An alternative to this is to use literals.::

    evenList L :-
        cn L all { E | even E }.

The variables between the curly braces are limited in scope to the braces. The '|' divides the incoming variables from their use.

    even E :-
        E divides 2.

The code that would be generated is::

    evenList:L :-
        cn:L all:a001.

    fn:a001 :E :-
        even:E.


    list L doubled LL :-
        cn L map { Each | Result = Each * 2 }.

(how is that result used? Do we assume variable names? We're trying to jam a function into a declaration. )

Variables and atoms
---------------------

Maybe...

* All variables start with "_".
* All Atoms are Uppercase.
* Operators can use any other character or symbol.

__size 
