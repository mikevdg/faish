Examples of running programs
-----------------------------------------

-- 8
then:(
	list:(h:H t:Rest) append:A result:(h:H t:Rest2) )
if:(
	list:Rest append:A result:Rest2 ).

-- 11
list:end append:Anything result:Anything.

-- 15
list:(h:a t:(h:b t:end) append:(h:c t:end) result:X?

0 	Block header
1	Variable		H, Anything, X
2 	Variable		Rest
3 	Variable 		Rest2
4	Variable		A	
5	Definition/3	list:append:result:
6 	Definition/2	h:t:
7	Definition/0	end
8*	ThenIf/1		then: 9 if: 10  
9	Statement	5 (6 1 2) 4 (6 1 3) -- then: of 8
10	Statement	5 2 4 3			-- if: of 8
11*	Statement/0	5 7 1 1

The query is:

12 	Definition/0	a
13 	Definition/0	b
14 	Definition/0	c
15* 	Statement/0	5 (6 12 (6 13 7)) (6 14 7) 1

Unify 15 with 9 (from 8)
-- 15/17 Means clause 15, with the bindings in clause 18.
16 	Unification 	15/17 9/18
17 	[ 22 ] -- this is a list of bindings.
18	[ 23, 24, 25, 26 ]

	-- This is the working out of the unification. These two clauses are done vertically and need to match each other.
	15/17 = 
		5 = list:append:result:
			6 = h:t:
				12 = a
				6 = h:t:
					13 = b 
					7 = end
			6  = h:t:
				14 = c
				7 = end
			1 = ?

	9/18 = 
		5 = list:append:result:
			6 = h:t:
				1 = ?
				2 = ?
			4 = ?
			6 = h:t:
				1 = ?
				3 = ?

We break out a few statements:
19	Statement	6 13 7
20 	Statement	6 14 7
21	Statement	6 1 3

22	1 = 21/18 -- this is an individual variable binding.
23	1 = 12/17 -- adding /17 here. Not sure about this.
24	2 = 19/17
25	3 = ?/17
26	4 = 20/17

Unify 10 (from 8) with 9 (from 8)
-- We use the same bindings as the then: clause.
27	Unification	10/18 9/28
28	[ 29, 30, 31, 32 ]
29	1 = 13/
30	2 = 7
31 	3 = ?    	
32	4 = 26 (?)

	10/18 = 
		5	
			2 = 19/17 = 6 13 7
			4 = 26 = 20/17 = 6 14 7
			3 = ?    <----- What do we do here? It needs to be bound to 33/28, but 18 is not ours so we can't modify it?

	9/28 =
		5 = list:append:result:
			6 = h:t:
				1 = ?
				2 = ?
			4 = ?
			6 = h:t:
				1 = ?
				3 = ?
		
33 	Statement 	6 1 3

Unify 10 (from 8) with 9 (from 8)

Unify 10 (from 8) with 11



Unsolved problem: how do we link variables with each other.
Answer: we have to take them with us every time we copy. We need to traverse links and update values to point to a new variable.

E.g. we have

30 	Unification	15/31 11/32 		(ignore the fact they don't match - this is just an example)
31	[ ? ]
32 	[ ? ] 

Now, we modify those values:

31	[ 33 ]
32 	[ 34 ]
33	X = ?
34	X2 = 33

If we use copy-on-write, then the unknown value of 33 will stay unknown. We need to update X2 to another value, or find a value for 33 and fill it in to solve 34.

But then we also need to support backtracking. This is difficult.

Maybe 33 and 34 can be considered statements such that they need bindings?

30 	Unification	15/31 11/32 		(ignore the fact they don't match - this is just an example)
31	[ X->33 ]
32 	[ X2->34 ]
33	X = ?/
34	X2 = 33/

