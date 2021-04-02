<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® Personal Use Edition, 8.2 of 15 July 2016 on 25 November 2019 at 9:27:33 PM</time-stamp>


<component-created>
<name>Faish-Server</name> <type>package</type>
</component-created><!-- Package Faish-Server* -->


<component-created>
<name>Faish-Server</name> <type>package</type>
</component-created>

<class>
<name>Block</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Server</package>
</attributes>
</class>

<class>
<name>ReadBlock</name>
<environment>Faish</environment>
<super>Faish.Block</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>readBlock readNumBytes readPosition socket </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Server</package>
</attributes>
</class>

<class>
<name>FaishServer</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>keepGoing </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Server</package>
</attributes>
</class>

<comment>
<class-id>Faish.FaishServer</class-id>
<body>I'm a server for Faish.TODO: I don't fully work yet. I'm going to be re-written after this code has been ported to Pharo using the ASN.1 packages from "Cryptography" and the better networking classes there.</body>
</comment>

<class>
<name>AbstractSignature</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>sid </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Server</package>
</attributes>
</class>

<comment>
<class-id>Faish.AbstractSignature</class-id>
<body>Me and my subclasses basically make a fancy switch{} statement inside FaishSession&gt;&gt;prepopulateStatements for reading statements.Our "write" versions are in FaishSession in the "writing stuff" category.</body>
</comment>

<class>
<name>ByteArraySignature</name>
<environment>Faish</environment>
<super>Faish.AbstractSignature</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Server</package>
</attributes>
</class>

<class>
<name>StatementSignature</name>
<environment>Faish</environment>
<super>Faish.AbstractSignature</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>statement arity </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Server</package>
</attributes>
</class>

<class>
<name>FaishSession</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>str workingModule currentReadBlock mappingToSignature signatureToMapping nextSid </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Server</package>
</attributes>
</class>

<comment>
<class-id>Faish.FaishSession</class-id>
<body>I handle one connection to the Faish server.I'm a bit of a funny class. Originally I was a StatementStream, but everything seems to be tightly coupled.I manage the SID mappings as well as queries and the working module. This is because comparing SIDs is easier than matching statements.</body>
</comment>

<class>
<name>IntegerSignature</name>
<environment>Faish</environment>
<super>Faish.AbstractSignature</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Server</package>
</attributes>
</class>

<class>
<name>VariableSignature</name>
<environment>Faish</environment>
<super>Faish.StatementSignature</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>pool </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Server</package>
</attributes>
</class>

<class>
<name>WriteBlock</name>
<environment>Faish</environment>
<super>Faish.Block</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>writeBlock writePosition socket </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-Server</package>
</attributes>
</class>

<shared-variable>
<name>ByteArraySid</name>
<environment>Faish.FaishSession</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-Server</package>
</attributes>
</shared-variable>


<shared-variable>
<name>CreateQuerySid</name>
<environment>Faish.FaishSession</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-Server</package>
</attributes>
</shared-variable>


<shared-variable>
<name>DeclareSignature</name>
<environment>Faish.FaishSession</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-Server</package>
</attributes>
</shared-variable>


<shared-variable>
<name>IntegerSid</name>
<environment>Faish.FaishSession</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-Server</package>
</attributes>
</shared-variable>


<shared-variable>
<name>NoMoreResultsSid</name>
<environment>Faish.FaishSession</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-Server</package>
</attributes>
</shared-variable>


<shared-variable>
<name>QueryResultSid</name>
<environment>Faish.FaishSession</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-Server</package>
</attributes>
</shared-variable>


<shared-variable>
<name>StartStatement</name>
<environment>Faish.FaishSession</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-Server</package>
</attributes>
</shared-variable>


<shared-variable>
<name>VariableSid</name>
<environment>Faish.FaishSession</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-Server</package>
</attributes>
</shared-variable>



<methods>
<class-id>Faish.AbstractSignature class</class-id> <category>instance creation</category>

<body package="Faish-Server" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>Faish.AbstractSignature</class-id> <category>initialize-release</category>

<body package="Faish-Server" selector="sid:">sid: anInteger	sid := anInteger.</body>

<body package="Faish-Server" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>

<methods>
<class-id>Faish.AbstractSignature</class-id> <category>accessing</category>

<body package="Faish-Server" selector="readFrom:">readFrom: aStatementStream	self subclassResponsibility.</body>

<body package="Faish-Server" selector="isStatement">isStatement	^ false.</body>

<body package="Faish-Server" selector="sid">sid	^ sid.</body>
</methods>


<methods>
<class-id>Faish.IntegerSignature</class-id> <category>initialize-release</category>

<body package="Faish-Server" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>

<methods>
<class-id>Faish.IntegerSignature</class-id> <category>accessing</category>

<body package="Faish-Server" selector="readFrom:">readFrom: aStatementStream	^ FaishLiteral value: (aStatementStream nextInteger).</body>
</methods>


<methods>
<class-id>Faish.StatementSignature class</class-id> <category>instance creation</category>

<body package="Faish-Server" selector="module:source:arity:">module:m source:s arity:a	^ self new		statement: (m parse: s);		arity: a.</body>

<body package="Faish-Server" selector="statement:arity:">statement: s arity: a	^ self new		statement: s;		arity: a.</body>
</methods>


<methods>
<class-id>Faish.StatementSignature</class-id> <category>comparing</category>

<body package="Faish-Server" selector="=">= another	(another isMemberOf: StatementSignature) ifFalse: [ ^ false ].	^ another statement matches: statement.</body>

<body package="Faish-Server" selector="hash">hash	^ statement signatureHash.</body>
</methods>

<methods>
<class-id>Faish.StatementSignature</class-id> <category>accessing</category>

<body package="Faish-Server" selector="arity:">arity: anObject	arity := anObject</body>

<body package="Faish-Server" selector="arity">arity	^arity</body>

<body package="Faish-Server" selector="statement">statement	^statement</body>

<body package="Faish-Server" selector="isStatement">isStatement	^ true.</body>

<body package="Faish-Server" selector="readFrom:">readFrom: aStatementStream	|  result |	(arity=0) ifTrue: [ ^ statement ].	result := statement copy.	1 to: arity do: [ :i |		result atIndex: i put: (aStatementStream nextThing)	].	^ result.</body>

<body package="Faish-Server" selector="statement:">statement: anObject	statement := anObject</body>
</methods>

<methods>
<class-id>Faish.StatementSignature</class-id> <category>printing</category>

<body package="Faish-Server" selector="printOn:">printOn: aStream	aStream nextPutAll: 'Signature['.	statement printOn: aStream.	aStream nextPutAll:']'.</body>
</methods>


<methods>
<class-id>Faish.VariableSignature</class-id> <category>initialize-release</category>

<body package="Faish-Server" selector="initialize">initialize	super initialize.	pool := Dictionary new.	1 to: 16 do: [ :i |		pool at: i put: FaishVariable new.	].	^self</body>
</methods>

<methods>
<class-id>Faish.VariableSignature</class-id> <category>accessing</category>

<body package="Faish-Server" selector="readFrom:">readFrom: aStatementStream	|  vid  |	vid := aStatementStream nextInteger.	^ pool at: vid.</body>

<body package="Faish-Server" selector="isStatement">isStatement	^ false.</body>
</methods>


<methods>
<class-id>Faish.Block</class-id> <category>initialize-release</category>

<body package="Faish-Server" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>


<methods>
<class-id>Faish.WriteBlock class</class-id> <category>instance creation</category>

<body package="Faish-Server" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>Faish.WriteBlock</class-id> <category>initialize-release</category>

<body package="Faish-Server" selector="writeBlockSize">writeBlockSize	|  anInt |	anInt := writePosition.	writeBlock at: 2 put: (anInt bitAnd: 16r000000ff).	writeBlock at: 3 put: ((anInt bitAnd: 16r0000ff00) bitShift: -8).	writeBlock at: 4 put: ((anInt bitAnd: 16r00ff0000) bitShift: -16).	writeBlock at: 5 put: ((anInt bitAnd: 16rff000000) bitShift: -24).</body>

<body package="Faish-Server" selector="nextIntegerPut:">nextIntegerPut: anInt	self nextBytePut: (anInt bitAnd: 16r000000ff).	self nextBytePut: ((anInt bitAnd: 16r0000ff00) bitShift: -8).	self nextBytePut: ((anInt bitAnd: 16r00ff0000) bitShift: -16).	self nextBytePut: ((anInt bitAnd: 16rff000000) bitShift: -24).</body>

<body package="Faish-Server" selector="flush">flush	self writeNextBlockOnError: [ :msg | self halt. ].</body>

<body package="Faish-Server" selector="on:">on: aSocket	socket := aSocket.</body>

<body package="Faish-Server" selector="resetBuffer">resetBuffer	writePosition := 1.</body>

<body package="Faish-Server" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	self resetBuffer.	writeBlock := ByteArray new: 256.	self nextBytePut: 16rFF.	self nextIntegerPut: 0. "This will be replaced with the block size."	^self</body>

<body package="Faish-Server" selector="writeNextBlockOnError:">writeNextBlockOnError: errorBlock	self writeBlockSize.	[ 			socket writeFrom: writeBlock startingAt: 1 for: writePosition.	] on: OsTransferFaultError do: [ 		socket close.		^ errorBlock value: 'OsTransferFaultError occured.'.	].	self resetBuffer.</body>

<body package="Faish-Server" selector="nextBytePut:">nextBytePut: aByte	" Write the byte to the stream. "	writePosition = (writeBlock size) ifTrue: [ 		self writeNextBlockOnError: [:msg | ^ self error: msg.]	].	writeBlock at: writePosition put: aByte.	writePosition := writePosition + 1.</body>
</methods>


<methods>
<class-id>Faish.ReadBlock class</class-id> <category>instance creation</category>

<body package="Faish-Server" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>Faish.ReadBlock</class-id> <category>initialize-release</category>

<body package="Faish-Server" selector="nextByte">nextByte	" Return the next byte from a socket."	|  v |	(readNumBytes = (readPosition-1)) ifTrue: [		(self readNextBlockOnError: [ :msg | Transcript show: msg. ^nil ]) 			isNil ifTrue: [ ^ nil ].	].	v := readBlock at: readPosition.	readPosition := readPosition + 1.	^ v.</body>

<body package="Faish-Server" selector="readBlockSize">readBlockSize	readNumBytes := self nextInteger.</body>

<body package="Faish-Server" selector="readNextBlockOnError:">readNextBlockOnError: errorBlock	[ 			socket readWait.		readNumBytes := socket readInto: readBlock.				readNumBytes isNil ifTrue: [ ^ nil ].		(readNumBytes&lt;1) ifTrue: [ ^ nil ].				self readStartOfBlockMarker. "1 byte"		self readBlockSize. "An integer / 4 bytes "					readPosition := 6. "After all of the above is read."	] on: OsTransferFaultError do: [ :e | 		socket close.		^ errorBlock value: e messageText.	].</body>

<body package="Faish-Server" selector="on:">on: aSocket	socket := aSocket.</body>

<body package="Faish-Server" selector="initialize">initialize	super initialize.	readBlock := ByteArray new: 256.	readNumBytes := 0.	readPosition := 1.		^self</body>

<body package="Faish-Server" selector="nextInteger">nextInteger	^ 	 (((self nextByte		 bitOr:( self nextByte bitShift: 8))		 bitOr: (self nextByte bitShift: 16))		 bitOr: (self nextByte bitShift: 24)).</body>

<body package="Faish-Server" selector="readStartOfBlockMarker">readStartOfBlockMarker	((self nextByte) = 16rFF) ifFalse: [		self error: 'Start of block marker is missing. This block should have started with 255.'	].</body>
</methods>

<methods>
<class-id>Faish.ReadBlock</class-id> <category>accessing</category>

<body package="Faish-Server" selector="readStatementMarker">readStatementMarker	(self nextByte = StartStatement) ifFalse: [ 		self error: 'Missed a statement marker.'.	].</body>
</methods>


<methods>
<class-id>Faish.ByteArraySignature class</class-id> <category>instance creation</category>

<body package="Faish-Server" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>Faish.ByteArraySignature</class-id> <category>initialize-release</category>

<body package="Faish-Server" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>

<methods>
<class-id>Faish.ByteArraySignature</class-id> <category>accessing</category>

<body package="Faish-Server" selector="readFrom:">readFrom: aStatementStream	|  size result |	size := aStatementStream nextInteger.	result := ByteArray new: size.	1 to: size do: [ :i | result at:i put: (aStatementStream nextByte)].	^ FaishLiteral new value: result.</body>
</methods>


<methods>
<class-id>Faish.FaishServer class</class-id> <category>instance creation</category>

<body package="Faish-Server" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>

<body package="Faish-Server" selector="start">start	^ self new startServing.</body>
</methods>


<methods>
<class-id>Faish.FaishServer</class-id> <category>initialize-release</category>

<body package="Faish-Server" selector="serveConnection:address:">serveConnection: newSocket address: addr	" newSocket is a SocketAccessor "		([		FaishSession new serve: newSocket.	] forkAt: (Processor userBackgroundPriority)) name: 'Squl Server serving a connection.'.</body>

<body package="Faish-Server" selector="startServing">startServing	[			| accessor addr newSocket |		accessor := SocketAccessor family: (SocketAccessor AF_INET) type: (SocketAccessor SOCK_STREAM).			[ 			addr := IPSocketAddress hostName: 'localhost'  port: 5031.			accessor 				soReuseaddr: true; "Must be done before bind."				bindTo: addr;				listenFor: 2.					[keepGoing] whileTrue: [				newSocket := accessor acceptNonBlock.				newSocket isNil ifFalse: [					self serveConnection: newSocket address: addr.					newSocket := nil.				] ifTrue: [					" Not sure how to not poll. "					(Delay forSeconds: 1) wait.					].			]  		] ifCurtailed: [ 			accessor close. 			newSocket isNil ifFalse: [ newSocket close ].		].		accessor close.	] fork name: 'Squl Server'.</body>

<body package="Faish-Server" selector="stop">stop	keepGoing := false.</body>

<body package="Faish-Server" selector="runQuery:qid:module:stream:">runQuery: q qid: qid module: m stream: str	[ 	| s |		self halt.		s := Searcher new query: q module: m. 		s timeLimit: 20.		[ s hasMoreResults ] whileTrue: [ 			"str nextStatementPut: (s next ) sid: sid."		].		s noMoreResultsForQuery: qid.	] fork.</body>

<body package="Faish-Server" selector="initialize">initialize	super initialize.	keepGoing := true.	^self</body>
</methods>


<methods>
<class-id>Faish.FaishSession class</class-id> <category>class initialization</category>

<body package="Faish-Server" selector="initialize">initialize	StartStatement := 12.	CreateQuerySid := 47.	VariableSid := 19.	IntegerSid := 20.	ByteArraySid := 28.	DeclareSignature := 56.	QueryResultSid := 57.	NoMoreResultsSid := 58.</body>
</methods>

<methods>
<class-id>Faish.FaishSession class</class-id> <category>instance creation</category>

<body package="Faish-Server" selector="new">new	^ super new initialize.</body>
</methods>


<methods>
<class-id>Faish.FaishSession</class-id> <category>reading</category>

<body package="Faish-Server" selector="nextByte">nextByte	^ currentReadBlock nextByte.</body>

<body package="Faish-Server" selector="nextStatement">nextStatement	currentReadBlock := self nextBlock.	(self readStatementMarker) isNil ifTrue: [ ^ nil ].	^ self nextThing.</body>

<body package="Faish-Server" selector="nextInteger">nextInteger	^ currentReadBlock nextInteger.</body>

<body package="Faish-Server" selector="nextThing">nextThing	| sid sig |	sid := currentReadBlock nextInteger.	sig := mappingToSignature at: sid.	^ (sig readFrom: self) sid: sid.</body>
</methods>

<methods>
<class-id>Faish.FaishSession</class-id> <category>accessing</category>

<body package="Faish-Server" selector="on:">on: aNetworkByteStream	str := aNetworkByteStream.</body>

<body package="Faish-Server" selector="readStatementMarker">readStatementMarker	| n |	n := currentReadBlock nextByte.	n isNil ifTrue: [ ^ nil ].	(n = StartStatement) ifFalse: [ 		self error: 'Missed a statement marker.'.	].</body>

<body package="Faish-Server" selector="signatureFor:ifAbsent:">signatureFor: aStatement ifAbsent: aBlock	aStatement sid isNil ifFalse: [ ^ aStatement sid ].	^ signatureToMapping at: (StatementSignature new statement: aStatement) ifAbsent: aBlock.</body>
</methods>

<methods>
<class-id>Faish.FaishSession</class-id> <category>blocks</category>

<body package="Faish-Server" selector="makeWriteBlock">makeWriteBlock		^ WriteBlock new on: str.</body>

<body package="Faish-Server" selector="nextBlock">nextBlock	^ ReadBlock new on: str.</body>
</methods>

<methods>
<class-id>Faish.FaishSession</class-id> <category>initialize-release</category>

<body package="Faish-Server" selector="addMapping:to:">addMapping: sid to: signature	signature sid: sid.	mappingToSignature at: sid put: signature.	signature isStatement ifTrue: [		signatureToMapping at: signature put: sid.	].</body>

<body package="Faish-Server" selector="initialize">initialize	workingModule := FaishModule new.	workingModule addStatement: 'code:["input] statement:input.'.	workingModule addStatement: 'code:["output] statement:output.'.		mappingToSignature := Dictionary new.	signatureToMapping := Dictionary new.	self prepopulateSignatures.		^ super initialize.</body>

<body package="Faish-Server" selector="prepopulateSignatures">prepopulateSignatures	| m tStart ts | 	"    19	Variable			&lt;VariableId integer&gt;    20	Integer				&lt;value integer&gt;    21	Big Integer			&lt;value bytes&gt;    22	32-bit float		&lt;value float&gt;    23	64-bit float		&lt;value float&gt;    24	reserved for 128-bit float.    25	reserved for bigger floats    26	reserved for even bigger floats.    27	Array of statements			&lt;size integer&gt; &lt;values...&gt;    28	Array of bytes (i.e. a String)		&lt;size integer&gt; &lt;bytes...&gt;    29	Reserved for 16-bit integer arrays    30	Array of 32-bit integers			&lt;size integer&gt; &lt;integers&gt;    31	Reserved	for 64-bit integer arrays.    32	Array of 32-bit floats    33	Array of 64-bit floats    34	Reserved for big float arrays    35	Reserved for bigger float arrays    36	Module literal.		&lt;value bytes&gt;    37  Statement literal    38  Parameter placeholder in a signature definition.    45  (addImport:+ModuleLiteral)    46  (addToWorkingModule:+Statement)    47  (createQuery:+Q qid:+Qid)    48  (qid:+Qid limitSeconds:+S)    49  (qid:+Qid limitSteps:+St)    50  (qid:+Qid limitDepth:+St)    51  (qid:+Qid limitNumResults:+N)    52  (startQuery:+Qid)    53  (stopQuery:+Qid)    54  (discardQuery:+Qid)    55  (connection:disconnect)    56  (declareSignature:+Sid arity:+N)    57  (query:-Qid result:-Result)    58  (query:-Qid status:noMoreResults)    59  (query:-Qid status:moreResults)    65  (code:C statement:S)    66  (tick:Tp tock:Tn)    67  (device:_ tock:_ event:_)    68  (device:_ tock:_ action:_)    69  (tStart)     -- the first tock."		m := workingModule.		"These could all be in a module!"	self addMapping: VariableSid to: (VariableSignature new).	self addMapping: IntegerSid to: (IntegerSignature new).	self addMapping: ByteArraySid to: (ByteArraySignature new).	self addMapping: 45 to: (StatementSignature module:m source:'addImport:_.' arity:1).	self addMapping: 46 to: (StatementSignature module:m source:'addToWorkingModule:_.' arity:1).	self addMapping: CreateQuerySid to: (StatementSignature module:m source:'createQuery:_ qid:_.' arity:2).	self addMapping: 52 to: (StatementSignature module:m source:'startQuery:_ qid:_.' arity:2).	self addMapping: 55 to: (StatementSignature module:m source:'connection:disconnect.' arity:0).	self addMapping: 56 to: (StatementSignature module:m source:'declareSignature:_ arity:_.' arity:2).	self addMapping: 57 to: (StatementSignature module:m source:'query:_ result:_.' arity:2).	self addMapping: NoMoreResultsSid to: (StatementSignature module:m source:'query:_ status:noMoreResults.' arity:1).	self addMapping: 65 to: (StatementSignature module:m source:'code:C statement:S.' arity:2).	self addMapping: 66 to: (StatementSignature module:m source:'tick:_ tock:_.' arity:2).	self addMapping: 67 to: (StatementSignature module:m source:'device:_ tock:_ event:_.' arity:3).	self addMapping: 68 to: (StatementSignature module:m source:'device:_ tock:_ action:_.' arity:3).			ts := m parse: 'a:tStart.'.	tStart := ts atIndex: 1.	self addMapping: 69 to: (StatementSignature statement:tStart arity:0).		nextSid := 70.</body>
</methods>

<methods>
<class-id>Faish.FaishSession</class-id> <category>writing stuff</category>

<body package="Faish-Server" selector="sendDeclarationFor:">sendDeclarationFor: aStatement	|  sid |	sid := nextSid.	self addMapping: sid to: (StatementSignature statement: aStatement arity: aStatement arity).		Transcript show: 'Declaring ', sid printString, ' to be ', aStatement printString.	self makeWriteBlock		nextBytePut: StartStatement;		nextIntegerPut: DeclareSignature;		nextIntegerPut: IntegerSid;		nextIntegerPut: sid;		nextIntegerPut: IntegerSid;		nextIntegerPut: (aStatement arity);		flush.</body>

<body package="Faish-Server" selector="writeByteArray:to:">writeByteArray: s to: writeBlock	writeBlock nextIntegerPut: ByteArraySid;		nextIntegerPut: (s size).	s do: [ :each2 | writeBlock nextBytePut: each2 ].</body>

<body package="Faish-Server" selector="nextSid">nextSid	nextSid := nextSid + 1.	^ nextSid.</body>

<body package="Faish-Server" selector="writeStatement:to:">writeStatement: s to: writeBlock	" Write the statement. Do not write StartStatement because my caller has already done that. "	|  sid |	s recurse: [ :each |		(each isStatement or: [each isAtom]) ifTrue: [			sid := self signatureFor: each ifAbsent: [				self sendDeclarationFor: each.				self signatureFor: each ifAbsent: [self halt].			].			writeBlock nextIntegerPut: sid.		].		each isVariable ifTrue: [			writeBlock nextIntegerPut: VariableSid.			writeBlock nextIntegerPut: each value.		].		each isInteger ifTrue: [			writeBlock nextIntegerPut: IntegerSid.			writeBlock nextIntegerPut: each value.		].		each isString ifTrue: [			self writeByteArray:each value to: writeBlock.		].	].</body>
</methods>

<methods>
<class-id>Faish.FaishSession</class-id> <category>serving</category>

<body package="Faish-Server" selector="noMoreResultsForQuery:">noMoreResultsForQuery: qid	|  w |	w := self makeWriteBlock.	w 		nextBytePut: StartStatement;		nextIntegerPut: NoMoreResultsSid;		nextIntegerPut: qid;		flush.</body>

<body package="Faish-Server" selector="sendQueryResult:qid:">sendQueryResult: aStatement qid: qid	|  b |	Transcript show: 'Sending: '; show: aStatement printString; cr.	b := self makeWriteBlock		nextBytePut: StartStatement;		nextIntegerPut: QueryResultSid.	b nextIntegerPut: qid.	self writeStatement: aStatement to: b.	b flush.</body>

<body package="Faish-Server" selector="serve:">serve: aSocket	| s |	str := aSocket.	[		s := self nextStatement.		s isNil not	] whileTrue: [		Transcript show: 'Recieved: '; show: (s printString); cr.		self processCommand: s	].</body>

<body package="Faish-Server" selector="runQuery:qid:">runQuery: q qid: qid	[ 	| s |		s := Searcher new query: q module: workingModule. 		s timeLimit: 20.		[ s hasMoreResults ] whileTrue: [ 			| r |			r := s next.			r isNil ifFalse: [				self sendQueryResult: r qid: qid.			].		].		self noMoreResultsForQuery: qid.	] fork.</body>

<body package="Faish-Server" selector="processCommand:">processCommand: aStatement	(aStatement sid = CreateQuerySid) ifTrue: [		| query qid |		query := aStatement atIndex: 1.		qid := (aStatement atIndex: 2) value.		self runQuery: query qid: qid.	] ifFalse: [		self halt.	]</body>
</methods>



<initialize>
<class-id>Faish.FaishSession</class-id>
</initialize>

</st-source>
