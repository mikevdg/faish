Relational Queries in Squl
==========================

Expressing data
---------------

Data can be put in a module as statements. A person with name, age and height would be stored as::

    person:P name:N age:A height:H.

where P is a unique atom that acts like a database ID.

e.g.::

    person:person1234 name:["John] age:47 height:[H 162cm].


Queries
-------

Complex queries (for now) can go in a 'working' module.

The working module could contain the data as a module in a statement. This limits us to operations on collections::

    personAndCarsData:~. :[" Where the ~ is a module containing the data ].

    numberOfCars:N :-
        personAndCarsData:CarsData,
        module:CarsData query:[\ object:_ type:car numberWheels:_ ] numResults:N.

or it could read the data from elsewhere and memoize the result:

    personAndCarsData:M :-
        readCarsFromFile:["cars.csv] result:M.

or it could just import the data module as a module import. This allows direct data queries in the working module.


Relationships
-------------

Relationships are done in the same was as other relational databases, except that IDs can be atoms rather than integers.

For example, a person owns objects::

    object:car1234 type:car numberWheels:4.

    person:person1234 owns:car1234.


Constraints
-----------

e.g. primary keys, relationship cardinalities.

Not sure. They would be useful to have.


Selecting
---------

then-if statements can be used to select particular attributes of an entity:

    person:P age:A :-
        person:P name:_ age:A height:_.


Filtering
---------

Who owns three-wheeled cars?::

    threeWheelCarOwner:P :-
        person:P owns:C,
        object:C type:car numberWheels:3.


Ordering
--------

Use maximise.

Who owns cars, ordered by the number of wheels ascending:

    carOwnersOrderedByWheels:P :-
        person:P owns:C,
        object:C type:car numberWheels:W,
        maximize:W.


Aggregating
-----------

Aggregating includes counting, summing, min/max, statistical analyses (averages, standard deviations), etc.

You need to turn the results into a collection and then aggregate the old fashioned way::


    :[" Ignore the built-in module:query:numResults:stepLimit: for now. Assume query:result: has been implemented. ].
    numberOfCarOwners:N :-
        query:[\ carOwner:C ] result:CarOwners,
        cn:CarOwners aggregate:sum result:N.

This allows you to also do other collection operations, such as combining collections (union), sorting, filtering, mapping, etc.


Grouping
--------

A grouped collection is a special kind of collection. It is similar to a dictionary, mapping group identifiers to collections.

Example: how many car owners are there for each number of wheels?::

    carOwner:P wheels:W :-
        person:P owns:Car,
        object:Car type:car numberWheels:W.

    fn:numWheels :(carOwner:C wheels:W) :(carOwner:C2 wheels:W2) result:(W+W2).

    carOwnersByNumWheels:R :-
        query:[\ carOwner:C wheels:W ] result:CW,
        cn:CW groupBy:[\ carOwner:_ wheels:@ ] result:GroupedCollection,
        cn:GroupedCollection sum:numWheels result:R.

(maybe?)

A grouped collection is like a dictionary. It maps the group identifiers to collections. The group identifier is what you used to group by, in this case the number of wheels.

Most operations on a grouped collection will apply that operation to each group. A separate protocol would be needed to access the group identifiers and contents, such as for example::

    cn:GroupedCollection groupIdentifiers:G.
    cn:GroupedCollection groupIdentifier:I groupContents:C.

An aggregation over a grouped collection applies each aggregation to each group separately. The result is a mapping of group 'names' to each aggregated result.

A grouped collection could maybe be a tree if some tree structure is available to exploit? The aggregation would produce a tree with a result for each node. Or perhaps this is another separate concept?


