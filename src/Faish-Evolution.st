<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® Personal Use Edition, 7.10.1 of 6 February 2014 on 21 December 2016 at 10:07:28 PM</time-stamp>


<component-created>
<name>Faish-Evolution</name> <type>package</type>
</component-created><!-- Package Faish-Evolution* -->


<component-created>
<name>Faish-Evolution</name> <type>package</type>
</component-created>

<class>
<name>EvolutionModuleChamber</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>modules current numModules sourceModules random mutateAddClauseLikelihood mutateAddLeafLikelihood mutateAdjustVariableLikelihood mutateCopyClauseLikelihood mutateRemoveConditionLikelihood mutateAddConclusionLikelihood mutateAddVariableLikelihood </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Evolution</package>
</attributes>
</class>

<comment>
<class-id>Faish.EvolutionModuleChamber</class-id>
<body>I am an Evolution chamber; I contain modules.</body>
</comment>

<class>
<name>EvolutionModule</name>
<environment>Faish</environment>
<super>CacheModule</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>reward </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Evolution</package>
</attributes>
</class>

<comment>
<class-id>Faish.EvolutionModule</class-id>
<body>I am a module that belongs in an evolution chamber. I evolve with other modules.</body>
</comment>

<methods>
<class-id>Faish.EvolutionModuleChamber class</class-id> <category>instance creation</category>

<body package="Faish-Evolution" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>Faish.EvolutionModuleChamber</class-id> <category>accessing</category>

<body package="Faish-Evolution" selector="doEvolution">doEvolution	| moduleA moduleB removeModuleIndex |	moduleA := modules at: ((numModules * self weightedNumber) + 1) asInteger.	moduleB := modules at: ((numModules * self weightedNumber) + 1) asInteger.		current := self sexualizeModule: moduleA withModule: moduleB.	modules add: current.	" Then of course we need to remove one to maintain numModules. "	removeModuleIndex := numModules - ((numModules * self weightedNumber)) asInteger.	modules removeAtIndex: removeModuleIndex.</body>

<body package="Faish-Evolution" selector="doReward">doReward	current doReward.</body>

<body package="Faish-Evolution" selector="current">current	^ current.</body>
</methods>

<methods>
<class-id>Faish.EvolutionModuleChamber</class-id> <category>private</category>

<body package="Faish-Evolution" selector="sexualizeModule:withModule:">sexualizeModule: moduleA withModule: moduleB	" Do mutations and combinations on those modules. Return a new module. "	| newModule r |	newModule := EvolutionModule new.	moduleA statements isEmpty ifTrue: [		sourceModules do: [ :eachSource |			eachSource statements do: [ :each | 				(random next &gt; 0.5) ifTrue: [ newModule add: each ].			]		].		^ newModule.	].	self sexualizeModule: moduleA withModule: moduleB result: newModule.	r := (1 + (random next * sourceModules size)) asInteger.	self sexualizeModule: moduleA withModule: (sourceModules at: r) result: newModule.	^ newModule.</body>

<body package="Faish-Evolution" selector="sexualizeModule:withModule:result:">sexualizeModule: moduleA withModule: moduleB result: newModule	" Do mutations and combinations on those modules. Return a new module. "	| r c |	moduleA statements do: [ :each |		each isNotMetadata ifTrue: [			r := random next.			c := mutateAddClauseLikelihood.			r &gt; c ifTrue: [ newModule add: each ].				c := mutateAddConclusionLikelihood.			r &gt; c ifTrue: [ newModule add: (self mutateAddConclusion: each module: moduleB) ]. 			c := mutateAddVariableLikelihood.			r &gt; c ifTrue: [ newModule add: (self mutateAddVariable: each) ].			c := c + mutateAddLeafLikelihood.			r &gt; c ifTrue: [newModule add: (self mutateAddLeafTo: each)].			c := c + mutateCopyClauseLikelihood.			r &gt; c ifTrue: [ 				newModule add: (self mutateCopyClauseFromStatement: each module: moduleB)			].			c := c + mutateAdjustVariableLikelihood.			r &gt; c ifTrue: [newModule add: (self mutateAdjustVariable: each)].			c := c + mutateRemoveConditionLikelihood.			r &gt; c ifTrue: [newModule add: (self mutateRemoveCondition: each)]		]	]</body>

<body package="Faish-Evolution" selector="weightedNumber">weightedNumber	" Return a number weighted towards 1.0. "	^ 1 - (random next * random next).</body>

<body package="Faish-Evolution" selector="getLeafAnywhereInStatement:">getLeafAnywhereInStatement: statement	" Return any sub-statement, with equal probability. "	| s |	s := statement flattened.	^ s at: (1 + (random next * s size) asInteger).</body>

<body package="Faish-Evolution" selector="makeLiteral">makeLiteral	| r |	" We only make number literals. "	r := random next.	(r &lt; 0.2) ifTrue: [		^ FaishLiteral new value: 1.	] ifFalse: [			(r &lt; 0.4) ifTrue: [			^ FaishLiteral new value: 2.		] ifFalse: [			(r &lt; 0.6) ifTrue: [				^ FaishLiteral new value: -1.			] ifFalse: [				^ FaishLiteral new value: (random next * 100).			]		]	].</body>

<body package="Faish-Evolution" selector="addIfLeaf:anywhereInStatement:">addIfLeaf: leaf anywhereInStatement: statement	" Add an if-clause to the statement. "	| result |	result := statement copy.	result addLabel: #if value: leaf.	^ result.</body>

<body package="Faish-Evolution" selector="addLeaf:anywhereInStatement:">addLeaf: leaf anywhereInStatement: statement	" Replace a sub-tree in the statement with leaf, with equal probability. "	| result s l args |	result := statement copy.	s := result flattened.	" l := s atRandom. Damn, doesn't exist. "	l := s at: (1 + (random next * s size) asInteger).	args := l arguments.	(args at: (1 + (random next * args size) asInteger)) value: leaf.	^ result.</body>
</methods>

<methods>
<class-id>Faish.EvolutionModuleChamber</class-id> <category>initialize-release</category>

<body package="Faish-Evolution" selector="initialize">initialize	super initialize.	self numModules: 1000.	random := Random standard.	sourceModules := OrderedCollection new.	self mutateCopyClauseLikelihood: 0.4.	self mutateAddClauseLikelihood: 0.04.	self mutateAddConclusionLikelihood: 0.04.	self mutateAddLeafLikelihood: 0.01.	self mutateAdjustVariableLikelihood: 0.01.	self mutateRemoveConditionLikelihood: 0.01.	self mutateAddVariableLikelihood: 0.02.	^self</body>

<body package="Faish-Evolution" selector="populateModules">populateModules	" Fill the modules up with randomly generated statements. "	| ev |	modules := SortedCollection new sortBlock: [ :a :b | a reward &lt;= b reward ].	numModules timesRepeat: [		ev := EvolutionModule new.		sourceModules do: [ :eachSource |			eachSource statements do: [ :each |				(each arguments first key = #metadata) ifFalse: [					ev add: each.				]			]		].		modules add: (EvolutionModule new).	].	current := modules first.</body>

<body package="Faish-Evolution" selector="addSourceModule:">addSourceModule: m	" The sourceModule is used as a source of new statements to mutate and abuse. It contains valid patterns. "	sourceModules add: m.</body>
</methods>

<methods>
<class-id>Faish.EvolutionModuleChamber</class-id> <category>tunable parameters</category>

<body package="Faish-Evolution" selector="mutateAddLeafLikelihood:">mutateAddLeafLikelihood: anObject	mutateAddLeafLikelihood := anObject</body>

<body package="Faish-Evolution" selector="mutateAddConclusionLikelihood:">mutateAddConclusionLikelihood: m	mutateAddConclusionLikelihood := m.</body>

<body package="Faish-Evolution" selector="mutateAddClauseLikelihood:">mutateAddClauseLikelihood: anObject	mutateAddClauseLikelihood := anObject</body>

<body package="Faish-Evolution" selector="mutateAddVariableLikelihood:">mutateAddVariableLikelihood: m	mutateAddVariableLikelihood := m.</body>

<body package="Faish-Evolution" selector="mutateCopyClauseLikelihood:">mutateCopyClauseLikelihood: anObject	mutateCopyClauseLikelihood := anObject</body>

<body package="Faish-Evolution" selector="mutateRemoveConditionLikelihood:">mutateRemoveConditionLikelihood: anObject	mutateRemoveConditionLikelihood := anObject</body>

<body package="Faish-Evolution" selector="mutateAdjustVariableLikelihood:">mutateAdjustVariableLikelihood: anObject	mutateAdjustVariableLikelihood := anObject</body>

<body package="Faish-Evolution" selector="numModules:">numModules: n	" How big the population should be. "	numModules := n.</body>
</methods>

<methods>
<class-id>Faish.EvolutionModuleChamber</class-id> <category>module api</category>

<body package="Faish-Evolution" selector="id">id	^ 0.</body>

<body package="Faish-Evolution" selector="withQuerySimply:do:ifNoResults:limitTo:">withQuerySimply: q		do: d		ifNoResults: r		limitTo: n	^ current withQuerySimply: q		do: d		ifNoResults: r		limitTo: n.</body>

<body package="Faish-Evolution" selector="handle">handle	^ ''.</body>

<body package="Faish-Evolution" selector="exports">exports	self halt.	^ current exports.</body>

<body package="Faish-Evolution" selector="statements">statements	^ current statements.</body>

<body package="Faish-Evolution" selector="name">name	^ 'Evolution Chamber'.</body>
</methods>

<methods>
<class-id>Faish.EvolutionModuleChamber</class-id> <category>mutations</category>

<body package="Faish-Evolution" selector="mutateRemoveCondition:">mutateRemoveCondition: aStatement	aStatement isIfThenRule ifTrue: [		| r result |		result := aStatement copy.		r := 1 + (random next * result premiseCount) asInteger.		result arguments removeAtIndex: r.		^ result.	].	^ aStatement.</body>

<body package="Faish-Evolution" selector="mutateAddConclusion:module:">mutateAddConclusion: statement module: module	" Convert this clause into a conclusion, using a premise from the other module. The clause could be any clause from that other statement."	| srcStatement ax result |	ax := module statements.	ax isEmpty ifTrue: [ ^ statement ].	srcStatement := ax at: (1+(random next * ax size) asInteger).	result := FaishStatement new.	result addLabel: #then value: statement.	result addLabel: #if value: srcStatement.	^ result.</body>

<body package="Faish-Evolution" selector="mutateCopyClauseFromStatement:module:">mutateCopyClauseFromStatement: statement module: module	" Add a clause from some other statement. The clause could be any clause from that other statement."	| srcStatement ax |	ax := module statements.	ax isEmpty ifTrue: [ ^ statement ].	srcStatement := ax at: (1+(random next * ax size) asInteger).	((random next &lt; 0.2) and: [statement isIfThenRule]) ifTrue: [		^ self 			addIfLeaf:(self getLeafAnywhereInStatement: srcStatement)			anywhereInStatement: statement.	].	^ self		addLeaf: (self getLeafAnywhereInStatement: srcStatement)		anywhereInStatement: statement.</body>

<body package="Faish-Evolution" selector="mutateAddVariable:">mutateAddVariable: statement	" Add a completely new variable to some places in the tree. "	| leaf result |	leaf := FaishVariable new.	result := self addLeaf: leaf anywhereInStatement: statement.	result := self addLeaf: leaf anywhereInStatement: result.	(random next &gt; 0.6) ifTrue: [ 			result := self addLeaf: leaf anywhereInStatement: result.	].	^ result.</body>

<body package="Faish-Evolution" selector="mutateAdjustVariable:">mutateAdjustVariable: statement	" Specifically for numbers, change them ever so slightly. "	| result |	result := statement copy.	result recurse: [ :each |		each isNumber ifTrue: [			| r |			r := random next.			(r &lt; 0.2) ifTrue: [				each value: (each value / 2).			] ifFalse: [				(r &lt; 0.4) ifTrue: [					each value: (each value * 2).				] ifFalse: [					(r &lt; 0.6) ifTrue: [						each value: (each value +1).					] ifFalse: [						(r &lt; 0.8) ifTrue: [							each value: (0 - each value).						] ifFalse: [							each value: (each value - 1).						]					]				]			]		]	].	^ result.</body>

<body package="Faish-Evolution" selector="mutateAddLeafTo:">mutateAddLeafTo: statement	" Add a completely new leaf - a literal or atom - to somewhere in the tree. "	| r leaf |	" For now, the leaf types are chosen using an equal likelihood. "	r := random next.	(r &lt; 0.2) ifTrue: [		leaf := FaishAtom new.	] ifFalse: [		leaf := self makeLiteral.	].	^ self addLeaf: leaf anywhereInStatement: statement.</body>
</methods>


<methods>
<class-id>Faish.EvolutionModule</class-id> <category>accessing</category>

<body package="Faish-Evolution" selector="doReward">doReward	reward := reward + 1.</body>

<body package="Faish-Evolution" selector="reward">reward	^ reward.</body>
</methods>

<methods>
<class-id>Faish.EvolutionModule</class-id> <category>initialize-release</category>

<body package="Faish-Evolution" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	reward := 0.	^self</body>
</methods>



</st-source>
