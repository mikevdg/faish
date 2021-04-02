<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® Personal Use Edition, 7.10.1 of 6 February 2014 on 21 December 2016 at 10:07:30 PM</time-stamp>


<component-created>
<name>Faish-Evolution-Tests</name> <type>package</type>
</component-created><!-- Package Faish-Evolution-Tests* -->


<component-created>
<name>Faish-Evolution-Tests</name> <type>package</type>
</component-created>

<class>
<name>MutationTests</name>
<environment>Smalltalk</environment>
<super>XProgramming.SUnit.TestCase</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Evolution-Tests</package>
</attributes>
</class>

<methods>
<class-id>MutationTests class</class-id> <category>instance creation</category>

<body package="Faish-Evolution-Tests" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>MutationTests</class-id> <category>initialize-release</category>

<body package="Faish-Evolution-Tests" selector="testMutateAddLeafTo1">testMutateAddLeafTo1	| s1 s2 |	s1 := (FaishModule new) parse: 'a:b c:d.'.	s2 := Faish.EvolutionModuleChamber new mutateAddLeafTo: s1.	^ s2.	" Just test that it doesn't crash. "</body>

<body package="Faish-Evolution-Tests" selector="testMutateAdjustVariable">testMutateAdjustVariable	| s1 s2 |	s1 := (FaishModule new) parse: 'a:b c:d e:(f:[+2]).'.	s2 := Faish.EvolutionModuleChamber new mutateAdjustVariable: s1.	^ s2.	" Just test that it doesn't crash. "</body>

<body package="Faish-Evolution-Tests" selector="testMutateCopyClause">testMutateCopyClause	| m s1 s2 s3 |	s1 := (FaishModule new) parse: 'a:b c:d e:(f:g).'.	m := FaishModule new.	m add: s1.	s2 := (FaishModule new) parse: 'e:f g:(h:i).'.	s3 := Faish.EvolutionModuleChamber new mutateCopyClauseFromStatement: s2 module:m.	^ s3.	" Just test that it doesn't crash. "</body>

<body package="Faish-Evolution-Tests" selector="testRemoveCondition">testRemoveCondition	| s1 s3 |	s1 := (FaishModule new) parse: 'if:(a:b) if:(c:d) then:(e:f) if:(h:g).'.	s3 := Faish.EvolutionModuleChamber new mutateRemoveCondition: s1.	^ s3.	" Just test that it doesn't crash. "</body>

<body package="Faish-Evolution-Tests" selector="testMutateAddLeafAnywhereInStatement2">testMutateAddLeafAnywhereInStatement2	| s1 s2 s3 |	s1 := (FaishModule new) parse: 'a:(b:c d:(e:f g:h)) b:(c:(d:e) f:g).'.	s2 := FaishAtom new.	s3 := Faish.EvolutionModuleChamber new addLeaf: s2 anywhereInStatement: s1.	" Just test that it doesn't crash. "</body>

<body package="Faish-Evolution-Tests" selector="testMutateAddLeafAnywhereInStatement1">testMutateAddLeafAnywhereInStatement1	| s1 s2 s3 |	s1 := (FaishModule new) parse: 'a:b c:d.'.	s2 := FaishAtom new.	s3 := Faish.EvolutionModuleChamber new addLeaf: s2 anywhereInStatement: s1.	" Just test that it doesn't crash. "</body>

<body package="Faish-Evolution-Tests" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>



</st-source>
