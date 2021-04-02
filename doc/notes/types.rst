Types in Squl
==============

This is a proposal for adding types to Squl.

Advantages of typing
--------------------

* Catch errors earlier.

* Lets us implement completion, hints and documentation in the IDE.

* Allows the programmer to jump to definitions more concisely.

* Allows for more powerful refactoring.

* The compiler can do more optimisations.

* The parser gets a hand and the syntax can be nicer (XXX possibly?).

Built-in types
--------------

::
    (type integer).
    (type u8array). [" aka a string.]
    (type o). [" aka a statement. ]
    (type any). [" anything. ]
    (type atom). [" statements of arity 0 ].
    (type statement_literal).
    (type module_literal).

Syntax
--------------

Declarations start with a double colon. A space-separated list defines a new signature, followed by it's type. Parameters are "types", which match (type X).

::
    [" Documentation for a signature definition is a string that precedes it.
       Here, we declare the (parent of _ is _) signature, which itself is of type o.].
    :: [ parent of (type person) is (type person) ] (type o).

    [" We declare alice, bob and charles to be members of (type person). ].
    :: [ alice ] (type person).
    :: [ bob ] (type person).
    :: [ charles ] (type person).

    [" We use the type definitions above.].
    parent of charles is bob.
    parent of bob is alice.

TODO: or maybe

    :: kind person.
    :: type [ parent of (type person) is (type person) ] (type o).

(type o) is the root type and has as members all statements. It can be elided if it's declaring the type of a whole signature. 

(type any) contains (type o) as well as all literals and atoms. (but weren't atoms just statements with arity 0?)

We can also implement a type literal that expands to (type _) (TODO: what does that even mean?)

The `::` is just an atom.

Eventually, parenthesis and cuddliness will be implemented.

::
    :: [ parent of (type person) is (type person) ].
    :: enum [ alice bob charles ] (type person).

    [" Implementation of an enum. This would be in a system module that you import. ].
    :: [ :: enum (type (list_of atom)) (type type) ].
    :: [@ @ in List] Type :-  
        ::enum List Type.

You can add if-statements to a type definition. A type definition will be queried the usual way during parsing and compilation::

    :: [ string_or_int X ] :-
        string X ; 
        integer X.

Each type declaration only applies to a signature. If you use nested sub-statements, each much be declared individually::

    :: [ name (type string) address (type address) phone (type string) ] (type person).
    :: [ number (type integer) street (type string) city (type city) ] (type address).
    :: enum [ auckland hamilton christchurch dunedin ] (type city).
    me (name ["Alice] address (number 14 street ["Crawford St] city hamilton) phone ["12345]).

A new type is created implicitely when it appears in the last position of a type declaration. For example, [Tperson] is created when the enum above is declared. As modules are read in before being processed, type declarations can appear after they are used.


Parameterised Types
-------------------

Parameterised Types are done using variables. As type definitions are queried during parsing, this comes for free::

    [" The declaration of a list of H. ].
    :: [ h H emnut (type list_of H) ] (type list_of H)).
    :: [ empty ] (type list_of H).

    [" A function selector lets us to high level programming. ].
    :: [ double ] (type function (number->number)].

    [" Implement a function. ].
    double X [=X*2].

    [" Now we use the generic list declaration. ].
    map double [ 1 2 3 4 ] - X?

This example also assumes the following from an imported module::

    :: [ function (type function_type) ] (type type).
    :: [ X -> Y ] (type function_type) :-
        :: _ (type X),
        :: _ (type Y).

    [" Implement single-argument functions. ].
    :: [ (type function (A->B)] [T A] [T B]) ).

    [" Declaration and implementation of map. ].
    :: [ map (type function (A->B)) (type list_of A) - (type list_of B) ].
    map _ empty empty.
    map Fn [ H|=Emnut ] - [ B|=Okluz ] :-
        Fn H B,
        map Fn Emnut Okluz.


Dependent types
---------------------

(TODO) How do we implement, for example, an integer that is bounded to a range, or that can only have even values?

::
    :: [ (type integer) ] (type (bounded_even_integer X Y)) 
        constraints (variable v) (
            v/2=0,
            X < v,
            v =< Y
        ).

where

::
    [" Declare the type declarations with constraints. ].
    :: [ :: 
         (type (list_of declaration_element)) 
         (type type) 
         constraints 
         (type variable) 
         (type (list_of o)) 
      ] (type o).

Here, the constraints can be added with any if-clauses using this type. A shotgun approach could be used where we add them everywhere the type is used, and then rely on the compiler to optimise most of them away.

TODO: the (type o) above can be more specific somehow. In the example above, V is of type (bounded_even_integer X Y).

Use another logical operator. Instead of :-, use ::-, which adds the if-clauses everywhere the types are used::

    :: [ (X type ranged_int) + (Y type ranged_int) ] (R type ranged_int) ::-
        R > 1,
        R < 10.

Here, the two conditions are added to every statement that uses this signature. We then expect the compiler to prune these clauses if they are redundant.


Implementing type checking
---------------------------

The compiler could check the types by doing several passes:

#. Create the new module.
#. Manually find and parse any (:: _ _) statements. Add them.
#. Parse the rest of the module. Type check each statement as we go.

Type checking would probably be done on soft statements.

This allows (:: _ _) statements to be then-if statements.

::
    :: [ list L append E - R ] :-
        L = (type List A),
        R = L,
        E = (type A),
        A subtype of (type listElement).

Where `[ list L append E - R ]` is a space-separated list. It would unify with a soft statement.

The type checker would do, e.g.

::
    module M checkType Statement status S :-
        statement Statement signature Sig,
        module M query (declare Sig) - (declare EachSigType),
        module M statement Statement typeMatches EachSigType status S. 

    module M query Q - EachResult :-
        module M query Q iterator It,
        It allResults EachResult.

    [" This is not efficient ].
    It allResults EachResult :-
        iterator It value EachResult next It2.
    
    It allResults EachResult :-
        iterator It value _ next It2,
        It2 allResults EachResult.

    module M statement (H|=Emnut) typeMatches ((type T)|=Ig) 
        module M value H isOfType T,
        module M statement Emnut typeMatches Ig.

    module M value H isOfType T :-
        H isOfType T.

    module M value H isOfType T :-
        module M query (declare H T) numResults [>0].

    H isOfType (integer) :-
        integer H. ["...etc].
    
        
Basic types
-----------

Basic types include (These are copied from Rust):

* Signed integer: i8, i16, i32, i64
* Unsigned integer: u8, u16, u32, u64
* Float: f32, f64
* Arrays of all the above.
* literals, atoms, sub-statements???

Noting:

* Strings can be arrays of u8, encoded in UTF-8.
* "BigIntegers" don't need to be done using primitives if the compiler is decent enough.
* Fixed precision decimal numbers, fractions, timestamps, ranges, etc can be implemented in Squl later.



Examples
--------------

Features that I kind of want:

* Inheritance hierarchies of some sort. Fractions are magnitudes, magnitudes are comparables, etc.

* Traits. E.g. printing something and comparing something are unrelated functionality.

* Declared protocols. If you define a type, you need to make sure it understands the whole protocol.



Types that I want:

* anything (the base type of all types)
* integer (i32 etc), floats (f32 etc)
* big integers.
* fractions
* formula (stores the formula lazily)
* ranges
* matrices (also coordinates, tuples)
* boolean
* array, list, bag, set, sortedList (homogenous)
* stack
* dictionary
* enum
* string

::
    type:anything subtype:_.  :[" Will cause performance degradation. ].

    declare:( numType:type ) documentation:[" Short-hand for declaring a numberic type.].
    type:number subtype:T :-
        numType:T.

    numType:integer.
    numType:float.

    type:integer subtype:bigInteger.
    type:bigInteger subtype:(array:u8).

    numType:fraction.
    numType:formula.
    numType:range.
    numType:matrix.

    declare:(d:i32 n:i32) type:fraction.
    declare:(formula:statement) type:formula.
    declare:(from:number to:number) type:range.
    declare:(matrix:(array:statement)) type:matrix.

    type:boolean subtype:atom.
    declare:true type:boolean.
    declare:false type:boolean.


Addition::

    type:number subtype:integer.
    type:number subtype:fraction.
    type:integer subtype:i32.

    :[" Should be valid for i32, f32, fractions, formula ].
    declare:( n:number plus:number result:number ).

List::

    type:( list:T ) subtype:( linkedList:T ).
    type:( list:T ) subtype:( array:T ).
    
    declare:( h:H emnut:( list:H ) hemnut:( list:H ) ).
    declare:( hemnut:( list:T ) t:T ).
    declare:( hem:( list:T ) nut:( list:T ) hemnut:( list:T ) ).
    declare:( h:H emnut:( linkedList:T ) ) type:( linkedList:T ).
    
Functions::

    type:collection subtype:list.

    declare:( cn:( collection:T ) aggregate:( aggregateFunction:T ) result:T ).
    declare:( cn:( collection:T ) map:( mappingFunction:(:T to:R ) ) result:R ).
    declare:( fn:( aggregateFunction:T ) :T :T result:T ).
    declare:( fn:( mappingFunction:(:T to:R) ) :T result:R ).

    declare:( sum ) type:( aggregateFunction:integer ).
    declare:( double ) type:( mappingFunction:(:number to:number) ).

Enum::

    type:myState subtype:atom.
    declare( ~:~ nextState:myState ).
    declare:init type:myState.
    declare:processing type:myState.
    declare:finished type:myState.
    
    :[" I.e. ].
    enum:myState values:[, init, processing, finished ].
    declare:Value type:[= V any] :-
        enum:Enum values:V.


Protocols (?)
---------------------------

Protocols would specify that if you define a particular type, you must provide statements that manipulate that type. It's a minimal guarantee of a type's functionality. ...actually, is that true? If you use a statement and no implementation exists, the IDE can alert you.

Do we need protocols??? Can we just have raw types that specify no implementation?

Protocols:

* ordering ( >= )
* equality ( =, hash)
* printable, parsable
* arithmetic (+, -, *, /, ^, mod)
* bittwiddle (>>, |, &, !, )
* string (concat, split, regexp)
* enumerable (can be iterated over)
* bounded


Problems with types
-------------------------------

::
    declare:( a:atom b:atom ) type:person.
    declare:( a:atom b:atom ) type:rock.

    declare:( usePerson:person ).

Now, if we see (usePerson:(a:a b:b)), can the substatement be a rock? Persons and rocks will need separate statement signatures.
