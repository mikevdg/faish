<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® Personal Use Edition, 8.2 of 15 July 2016 on 15 January 2019 at 9:57:15 PM</time-stamp>


<component-created>
<name>Faish-UserInterface</name> <type>package</type>
</component-created><!-- Package Faish-UserInterface* -->


<component-created>
<name>Faish-UserInterface</name> <type>package</type>
</component-created>

<class>
<name>FaishModuleUI</name>
<environment>Faish</environment>
<super>UI.ApplicationModel</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>selectionInModuleContentsTree module editedStatementHolder editedStatementOrig queryTree queryResults ignoreCallbacks filterField newStatementIndex selectionType watchingQueries </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>Faish.FaishModuleUI</class-id>
<body>I am a editor of a particular module.editedStatementOrig is a bit of a hack to determine if the user has edited the text in the statement field.newStatementIndex is:	- nil if there is no "new statement" node.	- the index (1..module size) of the statement after which the "new statement" node appears.</body>
</comment>

<class>
<name>FaishImportUI</name>
<environment>Faish</environment>
<super>UI.ApplicationModel</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>selectedSearchField tableAdaptor tableSelection tableInterface target searchText resultsList title showImportedModules </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishTreeModel</name>
<environment>Smalltalk</environment>
<super>UI.TreeModel</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>FaishTreeModel</class-id>
<body>I only override TreeModel to add the methods you see.</body>
</comment>

<class>
<name>SelectRepositoryDialog</name>
<environment>Faish</environment>
<super>UI.SimpleDialog</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>repositories selectedRepository </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>Faish.SelectRepositoryDialog</class-id>
<body>I allow the user to select a repository.Ideally I would like to use a ComboBox, but their implementation seems to be stupid and retarded.</body>
</comment>

<class>
<name>FaishDeductionBrowser</name>
<environment>Smalltalk</environment>
<super>UI.ApplicationModel</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>rootSearchable selectionInTree editedStatementHolder beam </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishFishCanvasModel</name>
<environment>Faish</environment>
<super>UI.Model</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>food fishLocation fishDirection numberFoodEaten </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishCanvasUI</name>
<environment>Faish</environment>
<super>UI.ApplicationModel</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>module title workingModule </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishFishCanvasView</name>
<environment>Faish</environment>
<super>UI.View</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>tock </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishCommandLineUI</name>
<environment>Faish</environment>
<super>UI.ApplicationModel</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>editHolder module workingModule tockNum title output </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishRepository</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>indexModule </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishHttpRepository</name>
<environment>Smalltalk</environment>
<super>FaishRepository</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>url </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishStatementNode</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>target </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>Faish.FaishStatementNode</class-id>
<body>I am the visible tree node representing a statement.</body>
</comment>

<class>
<name>FaishStatementNewNode</name>
<environment>Faish</environment>
<super>Faish.FaishStatementNode</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>DeductionTreeNode</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>searchable children searcher actualSearchable </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishCanvasView</name>
<environment>Faish</environment>
<super>UI.View</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>tock </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishCanvasController</name>
<environment>Faish</environment>
<super>UI.Controller</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>tock </inst-vars>
<class-inst-vars>tock </class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishRepositoriesHolder</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>FaishRepositoriesHolder</class-id>
<body>I hold all the currently known repositories. See my class methods.</body>
</comment>

<class>
<name>QueryTreeRoot</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>queries queriesMutex </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>Faish.QueryTreeRoot</class-id>
<body>I'm the placeholder for the root of the query tree. I serve no purpose other than to look pretty on screen.</body>
</comment>

<class>
<name>QueryResultNode</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>result </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>Faish.QueryResultNode</class-id>
<body>I store a single result of a query.</body>
</comment>

<class>
<name>FaishFishCanvasUI</name>
<environment>Faish</environment>
<super>UI.ApplicationModel</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>model module title workingModule keepGoing tock queryAction queryInput tockInput </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishStatementNodeInfo</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>target </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>Faish.FaishStatementNodeInfo</class-id>
<body>I am the visible tree node representing a statement's metadata.</body>
</comment>

<class>
<name>FaishFileRepository</name>
<environment>Smalltalk</environment>
<super>FaishRepository</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>path </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishModuleListUI</name>
<environment>Faish</environment>
<super>UI.ApplicationModel</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>moduleList moduleListSelection </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>Faish.FaishModuleListUI</class-id>
<body>I show all modules currently available for editing by the user.</body>
</comment>

<class>
<name>QueryNode</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>results queryString module query pass queryStatement resultsMutex isRunning queryTree </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>Faish.QueryNode</class-id>
<body>I am a node in the query results tree. I show a query, and I can be expanded to show its results.Currently only 20 results are shown, and results are calculated in a separate process.</body>
</comment>

<class>
<name>QueryPersevereDialog</name>
<environment>Faish</environment>
<super>UI.SimpleDialog</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>searchLimitType numberOfSeconds numberOfSteps searchDepth </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishFishCanvasController</name>
<environment>Faish</environment>
<super>UI.Controller</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<class>
<name>FaishModuleKeeper</name>
<environment>Faish</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars>modules </class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</class>

<comment>
<class-id>Faish.FaishModuleKeeper</class-id>
<body>I store the user's modules. My class methods are just accessors of a list of the user's modules. These get stored in the image in me.</body>
</comment>

<shared-variable>
<name>LocalRepositories</name>
<environment>FaishRepositoriesHolder</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</shared-variable>


<shared-variable>
<name>RemoteRepositories</name>
<environment>FaishRepositoriesHolder</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</shared-variable>


<shared-variable>
<name>Repositories</name>
<environment>FaishRepositoriesHolder</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</shared-variable>



<shared-variable>
<name>VisualDistance</name>
<environment>Faish.FaishFishCanvasUI</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</shared-variable>



<shared-variable>
<name>RetainModuleStatement</name>
<environment>Faish.FaishModuleUI</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>Faish-UserInterface</package>
</attributes>
</shared-variable>



<methods>
<class-id>Faish.FaishImportUI class</class-id> <category>interface specs</category>

<body package="Faish-UserInterface" selector="windowSpec">windowSpec	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"	&lt;resource: #canvas&gt;	^#(#{UI.FullSpec} 		#window: 		#(#{UI.WindowSpec} 			#properties: #(#{UI.PropertyListDictionary} #labelFromApplication true ) 			#label: #title 			#bounds: #(#{Graphics.Rectangle} 1701 407 2267 874 ) ) 		#component: 		#(#{UI.SpecCollection} 			#collection: #(				#(#{UI.LabelSpec} 					#layout: #(#{Core.Point} 13 9 ) 					#name: #Label1 					#label: 'Search for:' ) 				#(#{UI.TableViewSpec} 					#layout: #(#{Graphics.LayoutFrame} 4 0 42 0 -4 1 -40 1 ) 					#name: #searchResults 					#model: #tableInterface 					#callbacksSpec: 					#(#{UI.UIEventCallbackSubSpec} 						#doubleClickSelector: #actionLoadModule ) 					#selectionStyle: #row ) 				#(#{UI.ComboBoxSpec} 					#layout: #(#{Graphics.LayoutFrame} 48 0.5 8 0 -92 1 31 0 ) 					#name: #SearchField 					#model: #selectedSearchField 					#helpText: 'Select what you''d like to search for.' 					#comboList: #selectableSearchFields ) 				#(#{UI.InputFieldSpec} 					#layout: #(#{Graphics.LayoutFrame} 80 0 8 0 46 0.5 31 0 ) 					#name: #searchText 					#model: #searchText 					#helpText: 'Enter search text here.' ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutFrame} -90 1 8 0 -8 1 31 0 ) 					#name: #SearchButton 					#model: #actionSearch 					#label: 'Search' 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutFrame} 8 0 -31 1 90 0 -8 1 ) 					#name: #OpenButton 					#model: #actionOpen 					#label: 'Open Info' 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#properties: #(#{UI.PropertyListDictionary} #labelFromApplication true ) 					#layout: #(#{Graphics.LayoutFrame} -90 1 -31 1 -8 1 -8 1 ) 					#name: #AddImportButton 					#model: #actionLoadModule 					#label: #title 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutFrame} -180 1 -31 1 -98 1 -8 1 ) 					#name: #CancelButton 					#model: #actionCancel 					#label: 'Close' 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} 232 0 -31 1.0 81 23 ) 					#name: #ActionButton2 					#model: #actionReloadIndexes 					#label: 'Reload' 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} 98 0 -31 1.0 124 23 ) 					#name: #ActionButton1 					#model: #actionEditRepositories 					#label: 'Edit Repositories...' 					#defaultable: true ) ) ) )</body>
</methods>


<methods>
<class-id>Faish.FaishImportUI</class-id> <category>model</category>

<body package="Faish-UserInterface" selector="searchResults">searchResults	^ 'Enter search terms here.' asValue.</body>

<body package="Faish-UserInterface" selector="showImportedModules:">showImportedModules: bool	showImportedModules := bool.	self refreshSearchResultsList.</body>

<body package="Faish-UserInterface" selector="refreshSearchResultsList">refreshSearchResultsList	" Search through loaded modules and available modules. "	| result st |	resultsList removeAll.	result := OrderedCollection new.		showImportedModules ifTrue: [ 		resultsList addAll: (FaishModuleKeeper modules). "meh. TODO: search them. "	].	(selectedSearchField value = 'Name') ifFalse: [ ^ result ].	st := searchText value.	((st isNil) or: [ st isEmpty] ) ifFalse: [		resultsList addAll: (FaishRepositoriesHolder findModulesByName: (searchText value)).	] ifTrue: [ 		resultsList addAll: (FaishRepositoriesHolder allModules).	].</body>

<body package="Faish-UserInterface" selector="selectionInTable">selectionInTable	^ SelectionInTable new.</body>
</methods>

<methods>
<class-id>Faish.FaishImportUI</class-id> <category>GUI callbacks</category>

<body package="Faish-UserInterface" selector="searchText">searchText	^ searchText.</body>

<body package="Faish-UserInterface" selector="tableInterface">tableInterface	^ tableInterface.</body>

<body package="Faish-UserInterface" selector="selectedSearchField">selectedSearchField	^ selectedSearchField.</body>

<body package="Faish-UserInterface" selector="selectableSearchFields">selectableSearchFields 	^ #('Name' 'Description' 'UID') asValue.</body>
</methods>

<methods>
<class-id>Faish.FaishImportUI</class-id> <category>actions</category>

<body package="Faish-UserInterface" selector="actionOpen">actionOpen	Dialog warn: 'Not implemented'.</body>

<body package="Faish-UserInterface" selector="actionEditRepositories">actionEditRepositories	SelectRepositoryDialog new open.</body>

<body package="Faish-UserInterface" selector="title:">title: aName	title := aName.</body>

<body package="Faish-UserInterface" selector="actionSearch">actionSearch	self refreshSearchResultsList.	tableSelection tableHolder changed: #value.</body>

<body package="Faish-UserInterface" selector="actionCancel">actionCancel	self closeRequest.</body>

<body package="Faish-UserInterface" selector="actionReloadIndexes">actionReloadIndexes	FaishRepositoriesHolder reloadIndexesOnError: [ :e :pos | Dialog warn: 'Could not reload index.squl: ', e. ^ nil. ].</body>

<body package="Faish-UserInterface" selector="actionLoadModule">actionLoadModule	| importMe module |	((tableSelection selectionIndex y) = 0) ifTrue: [ ^ nil ].	importMe := resultsList at: (tableSelection selectionIndex y).	(importMe isModuleImport) 	ifTrue: [ 		module := importMe importOnError: [ :message :pos | ^ Dialog warn: message ].	] ifFalse: [ 		module := importMe.	].	target callbackAddImport: module.</body>

<body package="Faish-UserInterface" selector="title">title	title isNil ifTrue: [ ^ 'Unnamed dialog!' ].	^ title.</body>
</methods>

<methods>
<class-id>Faish.FaishImportUI</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	| rowAdaptor |	super initialize.	selectedSearchField := 'Name' asValue.	showImportedModules := false.	resultsList := OrderedCollection new.	self refreshSearchResultsList.	rowAdaptor := RowAdaptor adaptForAspects: #(#name #description #repository #uuid ). "#status #author"	" TODO: download an index of available modules into its own module. "	tableAdaptor := TableAdaptor on: resultsList adaptors: rowAdaptor.	tableSelection := SelectionInTable with: tableAdaptor.	tableInterface := TableInterface new selectionInTable: tableSelection;		columnLabelsArray: #('Name' 'Description' 'Repository' 'ID' );		columnLabelsFormats: #(#left #left #left #left).	searchText := '' asValue.	^self</body>

<body package="Faish-UserInterface" selector="callbackTo:">callbackTo: aFaishModuleUI	target := aFaishModuleUI.</body>
</methods>


<methods>
<class-id>FaishTreeModel</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="depthAtIndex:">depthAtIndex: index	^ (super privateAt: index) levelDescription size.	" I'm being naughty. "</body>
</methods>

<methods>
<class-id>FaishTreeModel</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	super initialize.	^self</body>
</methods>


<methods>
<class-id>Faish.SelectRepositoryDialog class</class-id> <category>interface specs</category>

<body package="Faish-UserInterface" selector="windowSpec">windowSpec	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"	&lt;resource: #canvas&gt;	^#(#{UI.FullSpec} 		#window: 		#(#{UI.WindowSpec} 			#properties: #(#{UI.PropertyListDictionary} #sizeType #specifiedSize #positionType #positionSystemDefault #openType #advanced ) 			#label: 'Select repository' 			#min: #(#{Core.Point} 460 98 ) 			#max: #(#{Core.Point} 0 0 ) 			#bounds: #(#{Graphics.Rectangle} 723 527 1197 674 ) ) 		#component: 		#(#{UI.SpecCollection} 			#collection: #(				#(#{UI.LabelSpec} 					#layout: #(#{Core.Point} 10 6 ) 					#name: #Label1 					#label: 'Select Repository:' 					#style: #large ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} -80 1.0 -29 1.0 68 23 ) 					#name: #ActionButton2 					#model: #accept 					#label: 'Select' 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} -140 1 -29 1.0 54 23 ) 					#name: #ActionButton3 					#model: #cancel 					#label: 'Cancel' 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} 8 0.0 -29 1.0 132 23 ) 					#name: #ActionButton1 					#model: #actionNewFileRepository 					#label: 'New file repository...' 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} 146 0 -29 1.0 81 23 ) 					#name: #ActionButton4 					#model: #actionNewURLRepository 					#label: 'New URL...' 					#defaultable: true ) 				#(#{UI.SequenceViewSpec} 					#layout: #(#{Graphics.LayoutFrame} 9 0 29 0 -10 1 -34 1 ) 					#name: #List1 					#model: #repositories 					#useModifierKeys: true 					#selectionType: #highlight ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} 232 0 -29 1.0 81 23 ) 					#name: #ActionButton5 					#model: #actionRemoveRepository 					#label: 'Remove' 					#defaultable: true ) ) ) )</body>
</methods>


<methods>
<class-id>Faish.SelectRepositoryDialog</class-id> <category>actions</category>

<body package="Faish-UserInterface" selector="actionRemoveRepository">actionRemoveRepository	repositories selection isNil ifTrue: [ ^ nil. ].	repositories list remove: (repositories selection).	repositories setList: (repositories list) selecting: nil.</body>

<body package="Faish-UserInterface" selector="actionNewURLRepository">actionNewURLRepository	| url repo |	url := Dialog request: 'Repository URL:' initialAnswer: 'http://www.squl.org/repo/'.	url isEmpty ifTrue: [ ^ self ].	repo := FaishHttpRepository new url: url.	repo loadIndexOnError: [ :e :i | ^ Dialog warn: e ].	FaishRepositoriesHolder addRepository: repo.	repositories setList: (repositories list) selecting: repo.</body>

<body package="Faish-UserInterface" selector="changedSelectedRepository">changedSelectedRepository</body>

<body package="Faish-UserInterface" selector="actionNewFileRepository">actionNewFileRepository	| repoDir repoDirFile repo |	repoDir := Dialog requestNewDirectoryName: 'Create new file-based repository:' default: 'faish-repo'.	repoDir isEmpty ifTrue: [ ^ self ].	repoDirFile := repoDir asFilename.	repoDirFile exists ifTrue: [ 		( repoDirFile filesMatching: 'index.squl') isEmpty ifTrue: [			Dialog warn: 'This directory is not a Squl repository! It needs to contain index.squl.'.			^ self.		].		repo := FaishFileRepository new path: repoDirFile.		FaishRepositoriesHolder addRepository: repo.		repo loadIndexOnError: [ :e :i | Dialog warn: e]. " TODO: show a progress bar. "		repositories setList: (repositories list) selecting: repo.		^ self 	] ifFalse: [		[repoDirFile makeDirectory]			on: OsError			do: 				[:ex |				Dialog warn:	(#ErrorCreatingDirectory1S1S &lt;&lt; #dialogs &gt;&gt; 'Error creating directory &lt;1s&gt;.&lt;n&gt;&lt;2s&gt;'					expandMacrosWith: repoDirFile asString					with: ex description)].		repo := FaishFileRepository new path: repoDir.		FaishRepositoriesHolder addRepository: repo.		repositories setList: (repositories list) selecting: repo.		repo writeIndex.		^ self 	].</body>
</methods>

<methods>
<class-id>Faish.SelectRepositoryDialog</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="repository">repository	^ repositories selection.</body>

<body package="Faish-UserInterface" selector="initialize">initialize	| ms |	super initialize.	ms := FaishRepositoriesHolder repositories.	repositories := SelectionInList with: (ms).	ms isEmpty ifFalse: [ repositories selectionIndex: 0 ].	^self</body>

<body package="Faish-UserInterface" selector="printString:">printString: aRepo	^ aRepo printString.</body>

<body package="Faish-UserInterface" selector="repositories">repositories	^ repositories.</body>
</methods>


<methods>
<class-id>FaishDeductionBrowser class</class-id> <category>interface specs</category>

<body package="Faish-UserInterface" selector="windowSpec">windowSpec	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"	&lt;resource: #canvas&gt;	^#(#{UI.FullSpec} 		#window: 		#(#{UI.WindowSpec} 			#label: 'Deduction tree' 			#bounds: #(#{Graphics.Rectangle} 1658 379 2310 902 ) 			#toolBar: #deductionToolbar ) 		#component: 		#(#{UI.SpecCollection} 			#collection: #(				#(#{UI.TreeViewSpec} 					#properties: #(#{UI.PropertyListDictionary} #fullLineSelect true ) 					#layout: #(#{Graphics.LayoutFrame} 0 0 0 0 0 1 407 0 ) 					#name: #DeductionTree 					#flags: 15 					#model: #deductionTree 					#useModifierKeys: true 					#selectionType: #highlight 					#useIcons: #other 					#iconSelectors: #(#icon ) 					#rootExpander: true ) 				#(#{UI.TextEditorSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0 409 0 0 1 0 1 ) 					#name: #CurrentStatement 					#model: #editedStatementHolder 					#isReadOnly: false 					#tabRequiresControl: true ) 				#(#{UI.ResizingSplitterSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0 407 0 0 1 411 0 ) 					#name: #ResizingSplitter1 					#flags: 8 					#horizontal: true 					#minAboveSize: 30 					#minBelowSize: 30 					#aboveWidgets: 'DeductionTree' 					#belowWidgets: 'CurrentStatement' ) ) ) )</body>
</methods>

<methods>
<class-id>FaishDeductionBrowser class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="stepOverIcon">stepOverIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #stepOverIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 32@32 depth: 1 bitsPerPixel: 1 palette: MonoMappedPalette whiteBlack usingBits: #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 224 0 0 1 240 0 0 1 240 124 0 1 240 6 0 0 240 2 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 3 0 0 0 10 0 0 88 26 0 0 252 54 0 0 252 124 0 0 248 48 0 0 224 24 0 0 96 24 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])</body>

<body package="Faish-UserInterface" selector="stepIcon">stepIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #stepIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 32@32 depth: 1 bitsPerPixel: 1 palette: MonoMappedPalette whiteBlack usingBits: #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 192 0 224 0 192 1 240 0 96 1 241 252 48 1 240 7 240 0 240 0 48 0 0 0 112 0 0 0 192 0 0 1 128 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 88 0 0 0 252 0 0 0 252 0 0 0 248 0 0 0 224 0 0 0 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])</body>

<body package="Faish-UserInterface" selector="openIcon">openIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #openIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 32@32 depth: 1 bitsPerPixel: 1 palette: MonoMappedPalette whiteBlack usingBits: #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 192 0 0 192 32 0 0 128 16 15 255 128 24 24 7 0 12 48 4 0 4 32 0 0 15 32 255 255 251 33 128 0 3 35 0 0 3 34 0 0 3 34 0 0 3 50 0 0 3 18 0 0 3 20 0 0 3 28 0 0 3 28 0 0 3 16 0 0 3 16 0 0 3 16 0 0 3 24 0 0 2 15 192 0 2 0 63 159 30 0 0 240 240 0 0 0 0 0 0 0 0])</body>

<body package="Faish-UserInterface" selector="deductionToolbar">deductionToolbar	"Tools.MenuEditor new openOnClass: self andSelector: #deductionToolbar"	&lt;resource: #menu&gt;	^#(#{UI.Menu} #(			#(#{UI.MenuItem} 				#rawLabel: 'Open cause' 				#value: #actionOpenClause 				#labelImage: #(#{UI.ResourceRetriever} #{FaishDeductionBrowser} #openIcon ) 				#helpText: 'Open the original rule that generated this statement.' ) 			#(#{UI.MenuItem} 				#rawLabel: 'Find parent' 				#value: #actionFindParent 				#labelImage: #(#{UI.ResourceRetriever} #{FaishDeductionBrowser} #findParentIcon ) 				#helpText: 'Find the parent clause of this deduction.' ) 			#(#{UI.MenuItem} 				#rawLabel: 'Find Solution' 				#value: #actionFindSolution 				#labelImage: #(#{UI.ResourceRetriever} #{FaishDeductionBrowser} #findSolutionIcon ) 				#helpText: 'Find the next solution.' ) 			#(#{UI.MenuItem} 				#rawLabel: 'Return (F6)' 				#value: #actionReturn 				#shortcutKeyCharacter: #F6 				#shortcutModifiers: 0 				#labelImage: #(#{UI.ResourceRetriever} #{FaishDeductionBrowser} #returnIcon ) 				#helpText: 'Return to the parent of the current node' ) 			#(#{UI.MenuItem} 				#rawLabel: 'Step Over (F7)' 				#value: #actionStepOver 				#shortcutKeyCharacter: #F7 				#shortcutModifiers: 0 				#labelImage: #(#{UI.ResourceRetriever} #{FaishDeductionBrowser} #stepOverIcon ) 				#helpText: 'Step over the current node.' ) 			#(#{UI.MenuItem} 				#rawLabel: 'Step Into (F8)' 				#value: #actionStep 				#shortcutKeyCharacter: #F8 				#shortcutModifiers: 0 				#labelImage: #(#{UI.ResourceRetriever} #{FaishDeductionBrowser} #stepIcon ) 				#helpText: 'Step into the current node as Faish would' ) ) #(6 ) nil ) decodeAsLiteralArray</body>

<body package="Faish-UserInterface" selector="findSolutionIcon">findSolutionIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #findSolutionIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 32@32 depth: 1 bitsPerPixel: 1 palette: MonoMappedPalette whiteBlack usingBits: #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 1 192 0 7 193 224 0 7 192 240 0 3 224 208 0 1 240 248 0 0 240 108 0 0 120 108 0 0 124 54 0 0 62 26 0 0 62 31 0 0 28 63 0 0 60 62 0 0 56 126 0 0 120 124 0 0 112 120 0 0 240 176 0 1 224 240 0 3 225 224 0 7 193 224 0 7 193 192 0 3 128 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])</body>

<body package="Faish-UserInterface" selector="findParentIcon">findParentIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #findParentIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 32@32 depth: 1 bitsPerPixel: 1 palette: MonoMappedPalette whiteBlack usingBits: #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3 192 0 0 7 112 0 0 5 28 0 0 9 6 0 0 59 0 0 0 39 192 0 0 13 96 0 0 9 48 0 0 25 24 0 0 17 0 0 0 3 0 0 0 3 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 128 0 1 0 128 0 1 128 128 0 0 129 128 0 0 65 0 0 0 127 0 0 0 24 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])</body>

<body package="Faish-UserInterface" selector="returnIcon">returnIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #returnIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 32@32 depth: 1 bitsPerPixel: 1 palette: MonoMappedPalette whiteBlack usingBits: #[0 0 0 0 0 24 0 0 0 16 252 0 0 49 135 0 0 103 1 128 0 252 0 64 0 48 0 96 0 24 0 32 0 8 28 96 0 0 28 192 0 0 60 0 0 0 60 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 28 0 0 0 60 0 0 0 60 0 0 0 28 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])</body>
</methods>

<methods>
<class-id>FaishDeductionBrowser class</class-id> <category>interface opening</category>

<body package="Faish-UserInterface" selector="openOn:">openOn: aQuery	| u |	u := self new searchable: aQuery.	u open.</body>
</methods>


<methods>
<class-id>FaishDeductionBrowser</class-id> <category>event handling</category>

<body package="Faish-UserInterface" selector="editedStatementHolder">editedStatementHolder	^ editedStatementHolder</body>

<body package="Faish-UserInterface" selector="selectedStatementChanged">selectedStatementChanged	selectionInTree selection isNil ifTrue: [ ^ self ].	editedStatementHolder value: (selectionInTree selection sourceString).</body>

<body package="Faish-UserInterface" selector="selectionInTree">selectionInTree	^ selectionInTree.</body>
</methods>

<methods>
<class-id>FaishDeductionBrowser</class-id> <category>private</category>

<body package="Faish-UserInterface" selector="goToSearchable:">goToSearchable: searchable	" Find that searchable and select it. "	| path current treeModel i previousI |	searchable isNil ifTrue: [ selectionInTree selectionIndex: 0 ].	" Navigate back to the root using the parents making a path as we go, then use that to expand and select the right node. "	path := OrderedCollection new.	current := searchable.	[ current isNil ] whileFalse: [ 		path add: current.		current := current derivedFrom.	].	path := path reverse.	treeModel := selectionInTree tree.	i := 0.	path do: [ :each |		i := i + 1.		previousI := i. " For debugging. It should point to the last known tree branch.  "		[(treeModel at: i) searchable mostlyEquals: each] whileFalse: [			i := i + 1.			(i &gt; treeModel size) ifTrue: [ 				^ self halt: 'There''s a difficult bug here somewhere. Continue if you want.'.			 ].			" The bug is probaby a failure to compare two equal statements, usually due to a funny literal. Set i to the matching index and debug the comparison above. "		].		(treeModel at: i) actualSearchable: each.		self expandAllTreeNodesMatching: each startingAt: i.	].	selectionInTree selectionIndex: i.</body>

<body package="Faish-UserInterface" selector="step">step	| next |	next := beam step.	self goToSearchable: next.</body>

<body package="Faish-UserInterface" selector="expandAllTreeNodesMatching:startingAt:">expandAllTreeNodesMatching: aNode startingAt: here	| i treeModel |	treeModel := selectionInTree tree.		i := here.	[ i &gt; treeModel size] whileFalse: [		( (treeModel at: i) searchable mostlyEquals:aNode ) ifTrue: [			treeModel expand: i.		].		i := i + 1.	].</body>
</methods>

<methods>
<class-id>FaishDeductionBrowser</class-id> <category>actions</category>

<body package="Faish-UserInterface" selector="actionStep">actionStep	self step.</body>

<body package="Faish-UserInterface" selector="actionFindParent">actionFindParent	( selectionInTree selection) isNil ifTrue: [ ^ self ].	self goToSearchable: selectionInTree selection searchable parent.</body>

<body package="Faish-UserInterface" selector="actionStepOver">actionStepOver	|  currant next  |	selectionInTree selection isNil ifTrue: [ ^ self ].	currant := selectionInTree selection searchable.		500 timesRepeat: [ 		next := beam step.		( next depth &lt; currant depth ) ifTrue: [			^ self goToSearchable: next		].				next isNil ifTrue: [ 			Dialog warn: 'Search exhausted; no results found.'.			^ self goToSearchable: currant ].		next isGoal ifTrue: [ 			Dialog warn: 'Result found.'.			^ self goToSearchable: next ].		( currant isSiblingOf: next ) ifTrue: [			self goToSearchable: next.			^ self.		].	].	Dialog warn: '500 steps done. Next sibling not found yet.'.	self goToSearchable: next. "Open the tree up."	self goToSearchable: currant.</body>

<body package="Faish-UserInterface" selector="actionFindSolution">actionFindSolution	| |	19 timesRepeat: [ 		beam step.	].	self goToSearchable: beam step.</body>

<body package="Faish-UserInterface" selector="actionReturn">actionReturn	|  currant currantDepth next  |	selectionInTree selection isNil ifTrue: [ ^ self ].	currant := selectionInTree selection searchable.	currantDepth := currant depth.	currant isNil ifTrue: [ ^ nil ].	currant := currant parentWhatIsDeductionSearchable.	currant isNil ifTrue: [ ^ nil ].		500 timesRepeat: [ 		next := beam step.		next isNil ifTrue: [ ^ self goToSearchable: currant ].		next isGoal ifTrue: [ ^ self goToSearchable: next ].		(next depth &lt; currantDepth ) ifTrue: [			self goToSearchable: next.						^ self		].				 (next wasOriginallyParentOf: currant) ifTrue: [			self goToSearchable: next.			^ self.		].	].	Dialog warn: 'Couldn''t find parent in 500 steps.'.	self goToSearchable: next. " Open up the tree "	self goToSearchable: currant.</body>

<body package="Faish-UserInterface" selector="actionOpenClause">actionOpenClause	beam inspect.</body>
</methods>

<methods>
<class-id>FaishDeductionBrowser</class-id> <category>interface opening</category>

<body package="Faish-UserInterface" selector="postBuildWith:">postBuildWith: aBuilder	self widget: #DeductionTree when: #selectionChanged send: #selectedStatementChanged to: self.</body>
</methods>

<methods>
<class-id>FaishDeductionBrowser</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="deductionTree">deductionTree	^ selectionInTree.</body>

<body package="Faish-UserInterface" selector="searchable:">searchable: aSearchable	rootSearchable := aSearchable.	beam := Searcher on: aSearchable copy.	" When the tree initalizes, it will exhaust aSearchable. That's why we copy it. "	selectionInTree := SelectionInTree new list: (FaishTreeModel on: (DeductionTreeNode new searchable: rootSearchable; searcher: beam)).</body>

<body package="Faish-UserInterface" selector="initialize">initialize	super initialize.	selectionInTree := SelectionInTree new. " Initialized better in &gt;&gt;searchable: "	editedStatementHolder := ValueHolder new.	^self</body>
</methods>


<methods>
<class-id>Faish.FaishFishCanvasModel class</class-id> <category>instance creation</category>

<body package="Faish-UserInterface" selector="new">new	^ super new initialize</body>
</methods>


<methods>
<class-id>Faish.FaishFishCanvasModel</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="fishLocation">fishLocation	^fishLocation</body>

<body package="Faish-UserInterface" selector="numberFoodEaten">numberFoodEaten	^ numberFoodEaten.</body>

<body package="Faish-UserInterface" selector="reset">reset	self initialize.</body>

<body package="Faish-UserInterface" selector="food">food	^ food.</body>

<body package="Faish-UserInterface" selector="changeFishDirection:">changeFishDirection: d	fishDirection := (fishDirection + d) \\ (2*Float pi).</body>

<body package="Faish-UserInterface" selector="fishDirection">fishDirection	^fishDirection</body>

<body package="Faish-UserInterface" selector="fishDirection:">fishDirection: d	fishDirection := d.</body>

<body package="Faish-UserInterface" selector="doOneStep">doOneStep	| vector |	fishDirection isNil ifFalse: [		vector := (3 * fishDirection cos) @ (3 * fishDirection sin).		fishLocation := fishLocation + vector.		(fishLocation x &gt; 640) ifTrue: [ self reset ].		(fishLocation x &lt; 0) ifTrue: [ self reset ].		(fishLocation y &gt; 480) ifTrue: [ self reset ].		(fishLocation y &lt; 0) ifTrue: [ self reset ].			self checkFoodCollision.		self changed: #fishLocation with: fishLocation.	].</body>

<body package="Faish-UserInterface" selector="checkFoodCollision">checkFoodCollision	| toRemove |	" TODO: use binary search "	toRemove := Bag new.	food do: [ :each |		(self doesFoodCollide: each) ifTrue: [			toRemove add: each		]	].	toRemove do: [ :each |		food remove: each.	].	numberFoodEaten := toRemove size.</body>

<body package="Faish-UserInterface" selector="doesFoodCollide:">doesFoodCollide: aPoint	| delta |	delta := (aPoint - fishLocation) abs.	^ (delta x &lt; 16) and: [ delta y &lt; 16 ].</body>
</methods>

<methods>
<class-id>Faish.FaishFishCanvasModel</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	| random |	food := SortedCollection new sortBlock: [ :a :b |		(a x) = (b x) 			ifTrue: [ (a y) &lt;= (b y) ]			ifFalse: [ (a x) &lt;= (b x) ]	].	random := Random standard.	40 timesRepeat: [ | x y |		x := 640 * random next.		y := 480 * random next.		food add: (x@y).	].	fishLocation := 320@220.	fishDirection := 0.</body>
</methods>


<methods>
<class-id>Faish.FaishCanvasUI class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="mainMenu">mainMenu	"Tools.MenuEditor new openOnClass: self andSelector: #mainMenu"	&lt;resource: #menu&gt;	^#(#{UI.Menu} #(			#(#{UI.MenuItem} 				#rawLabel: 'View' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'Show source module' 							#value: #showSourceModuleAction ) 						#(#{UI.MenuItem} 							#rawLabel: 'Show working module' 							#value: #showWorkingModuleAction ) ) #(2 ) nil ) ) ) #(1 ) nil ) decodeAsLiteralArray</body>
</methods>

<methods>
<class-id>Faish.FaishCanvasUI class</class-id> <category>interface specs</category>

<body package="Faish-UserInterface" selector="windowSpec">windowSpec	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"	&lt;resource: #canvas&gt;	^#(#{UI.FullSpec} 		#window: 		#(#{UI.WindowSpec} 			#properties: #(#{UI.PropertyListDictionary} #labelFromApplication true ) 			#label: #title 			#min: #(#{Core.Point} 20 20 ) 			#max: #(#{Core.Point} 0 0 ) 			#bounds: #(#{Graphics.Rectangle} 640 360 1280 840 ) 			#flags: 4 			#menu: #mainMenu ) 		#component: 		#(#{UI.SpecCollection} 			#collection: #(				#(#{UI.ArbitraryComponentSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0 0 0 0 1 0 1 ) 					#name: #canvasView 					#component: #canvasView ) ) ) )</body>
</methods>


<methods>
<class-id>Faish.FaishCanvasUI</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="title">title	^ title.</body>

<body package="Faish-UserInterface" selector="module:">module: aModule	module := aModule.	workingModule := CacheModule new.	workingModule addImport: module.	self queryTitle.</body>

<body package="Faish-UserInterface" selector="queryTitle">queryTitle	| q r |	q := module queryString: 'device:canvas title:X?' onError: [ :e :i |  Dialog show: e. ^ nil  ].	q timeLimit: 5.	r := q next.	r isNil ifTrue: [		title := module name.	] ifFalse: [		title := (r at: #title) value.	].</body>
</methods>

<methods>
<class-id>Faish.FaishCanvasUI</class-id> <category>UI callbacks</category>

<body package="Faish-UserInterface" selector="canvasView">canvasView	| v |	v := FaishCanvasView new model: workingModule.	v controller: (FaishCanvasController new).	^ v</body>
</methods>

<methods>
<class-id>Faish.FaishCanvasUI</class-id> <category>actions</category>

<body package="Faish-UserInterface" selector="showSourceModuleAction">showSourceModuleAction	(FaishModuleUI module: module) open.</body>

<body package="Faish-UserInterface" selector="showWorkingModuleAction">showWorkingModuleAction	(FaishModuleUI module: workingModule) open.</body>
</methods>


<methods>
<class-id>Faish.FaishFishCanvasView class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="food">food	"Tools.UIMaskEditor new openOnClass: self andSelector: #food"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 2 bitsPerPixel: 2 palette: (Graphics.MappedPalette withColors: (#(#(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(4111 4111 0)) ) collect: [:each | (each at: 1) value perform: (each at: 2) withArguments: (each at: 3)])) usingBits: #[85 85 85 85 85 85 85 85 85 80 21 85 85 74 33 85 85 42 161 85 84 170 161 85 84 170 161 85 85 170 161 85 85 42 168 85 85 42 168 85 85 73 81 85 85 85 85 85 85 85 85 85 85 85 85 85 85 85 85 85 85 85 85 85])</body>
</methods>


<methods>
<class-id>Faish.FaishFishCanvasView</class-id> <category>updating</category>

<body package="Faish-UserInterface" selector="update:with:">update:anAspect with:anObject	self displayOn: self graphicsContext.</body>
</methods>

<methods>
<class-id>Faish.FaishFishCanvasView</class-id> <category>displaying</category>

<body package="Faish-UserInterface" selector="displayOn:">displayOn: gc	| line pi6 pi2 pi8 |	pi8 := Float pi / 8.	pi6 := Float pi / 6.	pi2 := Float pi / 2.	[		gc paint: (ColorValue lightCyan).		gc displayRectangle: (self bounds).		gc paint: (ColorValue black).		model food do: [ :each | 			gc displayPixelArray: (self class food) at: each.		].		" 0 radians means the fish is pointing right. "		gc paint: (ColorValue darkRed).		gc displayWedgeBBoxOrigin: (model fishLocation - (20@20))			extent: (40@40)			startAngle: (model fishDirection + (Float pi) - pi8) radiansToDegrees			sweepAngle: (pi8 * 2) radiansToDegrees.		gc paint: (ColorValue yellow).		line := Point r:(FaishFishCanvasUI visualDistance) theta:(model fishDirection + pi6).		gc displayLineFrom: (model fishLocation) to: (model fishLocation + line).			line := Point r:(FaishFishCanvasUI visualDistance) theta:(model fishDirection - pi6).		gc displayLineFrom: (model fishLocation) to: (model fishLocation + line).		line := Point r:(FaishFishCanvasUI visualDistance) theta:(model fishDirection - pi2).		gc displayLineFrom: (model fishLocation) to: (model fishLocation + line).		line := Point r:(FaishFishCanvasUI visualDistance) theta:(model fishDirection + pi2).		gc displayLineFrom: (model fishLocation) to: (model fishLocation + line).	] on: Exception do: [		" The UI doesn't appear to be multi-threaded. "	]</body>
</methods>


<methods>
<class-id>Faish.FaishCommandLineUI class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="mainMenu">mainMenu	"Tools.MenuEditor new openOnClass: self andSelector: #mainMenu"	&lt;resource: #menu&gt;	^#(#{UI.Menu} #(			#(#{UI.MenuItem} 				#rawLabel: 'File' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'Save transcript...' 							#value: #saveTranscriptAction ) ) #(1 ) nil ) ) 			#(#{UI.MenuItem} 				#rawLabel: 'View' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'Show source module' 							#value: #showSourceModuleAction ) 						#(#{UI.MenuItem} 							#rawLabel: 'Show working module' 							#value: #showWorkingModuleAction ) ) #(2 ) nil ) ) ) #(2 ) nil ) decodeAsLiteralArray</body>
</methods>

<methods>
<class-id>Faish.FaishCommandLineUI class</class-id> <category>interface specs</category>

<body package="Faish-UserInterface" selector="windowSpec">windowSpec	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"	&lt;resource: #canvas&gt;	^#(#{UI.FullSpec} 		#window: 		#(#{UI.WindowSpec} 			#properties: #(#{UI.PropertyListDictionary} #labelFromApplication true ) 			#label: #title 			#bounds: #(#{Graphics.Rectangle} 743 428 1178 772 ) 			#flags: 4 			#menu: #mainMenu ) 		#component: 		#(#{UI.SpecCollection} 			#collection: #(				#(#{UI.TextEditorSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0 -61 1 0 1 0 1 ) 					#name: #inputTextEditor 					#model: #editHolder 					#helpText: 'Enter text here and press CTRL-Enter.' 					#tabRequiresControl: true ) 				#(#{UI.ResizingSplitterSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0 -66 1 0 1 -62 1 ) 					#name: #ResizingSplitter1 					#flags: 8 					#horizontal: true 					#minAboveSize: 30 					#minBelowSize: 30 					#aboveWidgets: 'outputTextEditor' 					#belowWidgets: 'inputTextEditor ' ) 				#(#{UI.ArbitraryComponentSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0 0 0 0 0.997706 -68 1 ) 					#name: #outputTextEditor 					#flags: 9 					#colors: 					#(#{UI.LookPreferences} 						#setBackgroundColor: #(#{Graphics.ColorValue} 8191 8191 7167 ) ) 					#component: #outputTextView ) ) ) )</body>
</methods>


<methods>
<class-id>Faish.FaishCommandLineUI</class-id> <category>key events</category>

<body package="Faish-UserInterface" selector="keyPress:">keyPress: ev	| char |	char := ev keyValue.	((char = Character cr or: [ char = Character lf ]) and: [ev hasCtrl]) ifTrue: [ 		(self widgetAt: #inputTextEditor) controller accept.		self processCommand. ^ nil ].				^ ev.</body>
</methods>

<methods>
<class-id>Faish.FaishCommandLineUI</class-id> <category>doing stuff</category>

<body package="Faish-UserInterface" selector="processCommand">processCommand	| input outputStatement tick tock outputResult |	input := editHolder value.	tick := self currentTock.	tockNum := tockNum + 1.	tock := self currentTock.	workingModule addStatement: (self inputStatementFor: input tock:tick).	workingModule addStatement: 'tick:', tick, ' tock:', tock, '.'.	outputStatement := workingModule queryString: 'device:cli output:X tock:', tock, '.' onError: [ :e :i | Dialog show: e. ^ nil  ].	outputStatement timeLimit: 5.	outputResult := outputStatement next.	output cr;		nextPutAll: '________________________________';		cr;		nextPutAll: '&gt; ';		nextPutAll: input;		cr.	outputResult isNil ifFalse: [		output cr;			nextPutAll: (outputResult at: #output) value.	].	(self widgetAt: #inputTextEditor) controller selectEntireText.</body>

<body package="Faish-UserInterface" selector="inputStatementFor:tock:">inputStatementFor: input tock: tock	| str |	str := WriteStream on: (String new).	str nextPutAll: 'device:cli input:["';		nextPutAll: input;		nextPutAll: '] tock:';		nextPutAll: tock;		nextPutAll: '.'.	^ str contents.</body>
</methods>

<methods>
<class-id>Faish.FaishCommandLineUI</class-id> <category>private</category>

<body package="Faish-UserInterface" selector="currentTock">currentTock	^ 't', tockNum printString.</body>
</methods>

<methods>
<class-id>Faish.FaishCommandLineUI</class-id> <category>actions</category>

<body package="Faish-UserInterface" selector="showWorkingModuleAction">showWorkingModuleAction	(FaishModuleUI module: workingModule) open.</body>

<body package="Faish-UserInterface" selector="showSourceModuleAction">showSourceModuleAction	(FaishModuleUI module: module) open.</body>

<body package="Faish-UserInterface" selector="saveTranscriptAction">saveTranscriptAction	| filename str |	filename := Dialog requestNewFileName: 'Export to file' default: (module name, '-transcript.txt').	filename isNil ifTrue: [ ^ self ].	filename isEmpty ifTrue: [ ^ self ].	filename := filename asFilename.	filename exists ifTrue: [ | choice |		choice := Dialog		choose: filename, ' exists. Should this be overwritten?'		labels: (Array with: 'Cancel' with: 'Overwrite')		values: #(#cancel #overwrite)		default: #cancel.		choice = #cancel ifTrue: [ ^ self ].	].	str := filename writeStream.	str nextPutAll: (output value).	str close.</body>
</methods>

<methods>
<class-id>Faish.FaishCommandLineUI</class-id> <category>interface opening</category>

<body package="Faish-UserInterface" selector="postBuildWith:">postBuildWith: aBuilder	| ctrlr |	ctrlr := (aBuilder componentAt: #inputTextEditor) widget controller.	ctrlr keyboardHook: [ :ev :c | 			self keyPress: ev].	ctrlr autoAccept: true.</body>
</methods>

<methods>
<class-id>Faish.FaishCommandLineUI</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	tockNum := 0.	editHolder := ValueHolder new.	editHolder value: (String new).	output := TextCollector new.	^self</body>

<body package="Faish-UserInterface" selector="queryTitle">queryTitle	module 		withQuerySimply: 'device:cli title:X?' 		do: [ :r | title := (r at: #title) value asString ]		ifNoResults: [ title := module name asString ]		limitTo: 1.</body>

<body package="Faish-UserInterface" selector="module:">module: aModule	module := aModule. 	workingModule := CacheModule new.	workingModule addImport: module.	self queryTitle.</body>
</methods>

<methods>
<class-id>Faish.FaishCommandLineUI</class-id> <category>UI callbacks</category>

<body package="Faish-UserInterface" selector="title">title	^ title.</body>

<body package="Faish-UserInterface" selector="outputTextView">outputTextView	| tcv |	tcv := TextCollectorView new model: output.	tcv controller: TextEditorController new.	tcv controller initializeMenuForText.	^tcv</body>

<body package="Faish-UserInterface" selector="editHolder">editHolder	^ editHolder.</body>
</methods>


<methods>
<class-id>FaishRepository class</class-id> <category>instance creation</category>

<body package="Faish-UserInterface" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>FaishRepository</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="findModulesByName:">findModulesByName: aName	" Return a collection of ModuleImports which have the given name. "	| result |	result := OrderedCollection new.	indexModule 		withQuerySimply: 'moduleId:X name:["', aName, ']?'		do: [ :each | result add: (self moduleImportForID: (each at: #moduleId) value) ]		ifNoResults: []		limitTo: 1000.	^ result.</body>

<body package="Faish-UserInterface" selector="findModuleById:onError:">findModuleById: anId onError: errorBlock	self subclassResponsibility</body>

<body package="Faish-UserInterface" selector="importModuleById:onError:">importModuleById: moduleId onError: errorBlock	self subclassResponsibility.</body>

<body package="Faish-UserInterface" selector="addModuleToIndex:">addModuleToIndex: aModule	| id template |	id := aModule id.	template := 'moduleId:["', id, '] '.	aModule 		withQuerySimply: 'module:X metadata:(name:Name)?'		do: [ :r | 			indexModule add: (				aModule parse: (template, 'name: ["', (					((r at: #metadata) at: #name) value), '].'))		]		ifNoResults: [] 		limitTo: 1.	aModule 		withQuerySimply: 'module:X metadata:(description:D)?'		do: [ :r | 			indexModule add: (				aModule parse: (template, 'description: ["', (					((r at: #metadata) at: #description) value), '].'))		]		ifNoResults: [] 		limitTo: 1.	aModule 		withQuerySimply: 'module:X metadata:(author:D)?'		do: [ :r |			indexModule add: (				aModule parse: (template, 'author: ["', (					((r at: #metadata) at: #author) value), '].'))		]		ifNoResults: [] 		limitTo: 1.	aModule 		withQuerySimply: 'module:X metadata:(license:D)?'		do: [ :r |			indexModule add: (				aModule parse: (template, 'license: ["', (					((r at: #metadata) at: #license) value), '].'))		]		ifNoResults: [] 		limitTo: 1.	aModule 		withQuerySimply: 'module:X metadata:(importModule:M name:N uri:U)?'		do: [ :r | 			indexModule add: (				aModule parse: (template, 					'imports: ["', (						((r at: #metadata) at: #importModule) value id), ']', 					' name: ["', (						((r at: #metadata) at: #name) value), ']', 					' uri: ["', (						((r at: #metadata) at: #uri) value), '].'))		]		ifNoResults: [] 		limitTo: 1.	self writeIndex.</body>

<body package="Faish-UserInterface" selector="writeIndex">writeIndex	self subclassResponsibility.</body>

<body package="Faish-UserInterface" selector="allModules">allModules	" Return all known modules. "	| result |	result := OrderedCollection new.	indexModule 		withQuerySimply: 'moduleId:X name:Y?'		do: [ :each | result add: (self moduleImportForID: (each at: #moduleId) value) ]		ifNoResults: []		limitTo: 1000.	^ result.</body>

<body package="Faish-UserInterface" selector="moduleImportForID:">moduleImportForID: id	| name description |		indexModule 		withQuerySimply: 'moduleId:["', id asString, '] name:X?'		do: [ :each | name := (each at: #name) value ]		ifNoResults: []		limitTo: 1.	indexModule 		withQuerySimply: 'moduleId:["', id asString, '] description:X?'		do: [ :each | description := (each at: #description) value ]		ifNoResults: []		limitTo: 1.	^ (ModuleImport new)		id: id;		name: name;		description: description;		repository: self.</body>

<body package="Faish-UserInterface" selector="findModuleById:">findModuleById: anId	self subclassResponsibility</body>

<body package="Faish-UserInterface" selector="loadIndexOnError:">loadIndexOnError: errorBlock	self subclassResponsibility.</body>
</methods>

<methods>
<class-id>FaishRepository</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="asText">asText	^ self printString.</body>

<body package="Faish-UserInterface" selector="asString">asString	^ self printString.</body>
</methods>

<methods>
<class-id>FaishRepository</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	indexModule := FaishModule new.	^self</body>

<body package="Faish-UserInterface" selector="exportModule:onError:">exportModule: aModule onError: errorBlock	self exportModuleImpl: aModule onError: errorBlock.	aModule imports do: [ :each | self exportModuleImpl: each onError: errorBlock ].</body>
</methods>


<methods>
<class-id>FaishHttpRepository</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="exportModuleImpl:onError:">exportModuleImpl: aModule onError: errorBlock	| request str result |	str := EncodedStream 		on: (ReadWriteStream on: (ByteArray new: 32)) 		encodedBy: (UTF8StreamEncoder new).	str lineEndCRLF.	aModule writeOn: str.	str reset.	request := Net.HttpRequest post: url, '/upload.php'.	request beMultipart.	request addFormKey: 'userfile' filename: 'upload.squl' source: str.	result := BetterHttpClient executeRequest: request onError: errorBlock.	(result code = '200') ifFalse: [		errorBlock value: (result body).	].</body>

<body package="Faish-UserInterface" selector="writeIndex">writeIndex	Dialog warn: 'For now, write to a file repository and copy to a HTTP server. '.</body>

<body package="Faish-UserInterface" selector="importModuleById:onError:">importModuleById: id onError: errorBlock	| str newModule | 	str := BetterHttpClient getStream: (url, '/', (id asString, '.squl')) onError: [ :message | errorBlock value:message value:nil ] .	newModule := CodeModule new readFrom: str onError: errorBlock.	str close.	^ newModule.</body>

<body package="Faish-UserInterface" selector="loadIndexOnError:">loadIndexOnError: errorBlock	indexModule := FaishModule new 		readFrom: (BetterHttpClient getStream: (url, '/', 'index.squl') onError: errorBlock)		onError: errorBlock.</body>
</methods>

<methods>
<class-id>FaishHttpRepository</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="printString">printString	^ url asString.</body>
</methods>

<methods>
<class-id>FaishHttpRepository</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="url:">url: aURL	url := aURL.</body>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>


<methods>
<class-id>Faish.FaishStatementNode class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="errorImage">errorImage	"Tools.UIMaskEditor new openOnClass: self andSelector: #errorImage"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 2 bitsPerPixel: 2 palette: (Graphics.MappedPalette withColors: (#(#(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(4096 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) ) collect: [:each | (each at: 1) value perform: (each at: 2) withArguments: (each at: 3)])) usingBits: #[170 170 170 170 168 42 170 170 160 10 149 170 160 10 165 106 168 42 169 90 168 42 170 86 168 41 85 85 168 41 85 85 170 170 170 86 170 170 169 90 168 42 165 106 168 42 149 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170])</body>

<body package="Faish-UserInterface" selector="statementImage">statementImage	"Tools.UIMaskEditor new openOnClass: self andSelector: #statementImage"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 2 bitsPerPixel: 2 palette: (Graphics.MappedPalette withColors: (#(#(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(3083 3083 3083)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) ) collect: [:each | (each at: 1) value perform: (each at: 2) withArguments: (each at: 3)])) usingBits: #[170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 168 42 170 170 161 74 170 170 133 82 170 170 133 82 170 170 161 74 170 170 168 42 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170])</body>
</methods>

<methods>
<class-id>Faish.FaishStatementNode class</class-id> <category>instance creation</category>

<body package="Faish-UserInterface" selector="on:">on: aFaishStatement	^ self new on: aFaishStatement.</body>
</methods>


<methods>
<class-id>Faish.FaishStatementNode</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="isStatementNode">isStatementNode 	^ true.</body>

<body package="Faish-UserInterface" selector="target">target	^ target</body>
</methods>

<methods>
<class-id>Faish.FaishStatementNode</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="mayEditedDisplayString">mayEditedDisplayString	^ false.</body>

<body package="Faish-UserInterface" selector="editString">editString	^ target editString</body>

<body package="Faish-UserInterface" selector="displayString">displayString	^ target displayString.</body>

<body package="Faish-UserInterface" selector="isNew">isNew	^ false.</body>

<body package="Faish-UserInterface" selector="sourceString">sourceString	^ target sourceCode</body>

<body package="Faish-UserInterface" selector="inPlaceEdited:">inPlaceEdited: string</body>
</methods>

<methods>
<class-id>Faish.FaishStatementNode</class-id> <category>treeNode</category>

<body package="Faish-UserInterface" selector="children">children	^ #(). "Array with: (FaishStatementNodeInfo on: target)."</body>

<body package="Faish-UserInterface" selector="icon">icon	target isSyntaxError ifTrue: [		^ self class errorImage	] ifFalse: [ 		^ nil. 	].</body>
</methods>

<methods>
<class-id>Faish.FaishStatementNode</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="on:">on: aStatement	target := aStatement.</body>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>


<methods>
<class-id>Faish.FaishStatementNewNode</class-id> <category>treeNode</category>

<body package="Faish-UserInterface" selector="children">children 	^ #().</body>

<body package="Faish-UserInterface" selector="icon">icon	^ nil.</body>
</methods>

<methods>
<class-id>Faish.FaishStatementNewNode</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="isNew">isNew	^ true.</body>

<body package="Faish-UserInterface" selector="sourceString">sourceString	^ 'instructions:["Edit me and press CTRL-Enter].'.</body>

<body package="Faish-UserInterface" selector="editString">editString	^ ''.</body>

<body package="Faish-UserInterface" selector="displayString">displayString	^ '...new statement'.</body>
</methods>


<methods>
<class-id>DeductionTreeNode class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="breadthFirstSearchIcon">breadthFirstSearchIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #breadthFirstSearchIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 2 bitsPerPixel: 2 palette: (Graphics.MappedPalette withColors: (#(#(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) ) collect: [:each | (each at: 1) value perform: (each at: 2) withArguments: (each at: 3)])) usingBits: #[170 170 170 170 170 170 170 170 170 128 10 170 170 21 82 170 168 85 84 170 161 81 21 42 161 69 69 42 161 0 1 42 161 69 69 42 161 81 21 42 168 85 84 170 170 21 82 170 170 128 10 170 170 170 170 170 170 170 170 170 170 170 170 170])</body>

<body package="Faish-UserInterface" selector="unremarkableIcon">unremarkableIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #unremarkableIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 1 bitsPerPixel: 1 palette: MonoMappedPalette whiteBlack usingBits: #[0 0 0 0 0 0 0 0 7 192 0 0 8 32 0 0 16 16 0 0 32 8 0 0 32 8 0 0 32 8 0 0 32 8 0 0 32 8 0 0 16 16 0 0 8 32 0 0 7 192 0 0 0 0 0 0 0 0 0 0 0 0 0 0])</body>

<body package="Faish-UserInterface" selector="successfullIcon">successfullIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #successfullIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 2 bitsPerPixel: 2 palette: (Graphics.MappedPalette withColors: (#(#(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 8191 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) ) collect: [:each | (each at: 1) value perform: (each at: 2) withArguments: (each at: 3)])) usingBits: #[170 170 170 170 170 170 170 170 170 128 10 170 170 21 82 170 168 85 84 170 161 85 69 42 161 85 69 42 161 85 21 42 161 69 21 42 161 80 85 42 168 84 84 170 170 21 82 170 170 128 10 170 170 170 170 170 170 170 170 170 170 170 170 170])</body>

<body package="Faish-UserInterface" selector="noSearchIcon">noSearchIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #noSearchIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 2 bitsPerPixel: 2 palette: (Graphics.MappedPalette withColors: (#(#(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(5461 5461 5461)) ) collect: [:each | (each at: 1) value perform: (each at: 2) withArguments: (each at: 3)])) usingBits: #[85 85 85 85 85 85 85 85 85 64 5 85 85 42 161 85 84 170 168 85 82 138 138 21 82 162 42 21 82 168 170 21 82 162 42 21 82 138 138 21 84 170 168 85 85 42 161 85 85 64 5 85 85 85 85 85 85 85 85 85 85 85 85 85])</body>

<body package="Faish-UserInterface" selector="depthFirstSearchIcon">depthFirstSearchIcon	"Tools.UIMaskEditor new openOnClass: self andSelector: #depthFirstSearchIcon"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 2 bitsPerPixel: 2 palette: (Graphics.MappedPalette withColors: (#(#(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 8191 8191)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) ) collect: [:each | (each at: 1) value perform: (each at: 2) withArguments: (each at: 3)])) usingBits: #[170 170 170 170 170 170 170 170 170 128 10 170 170 21 82 170 168 84 84 170 161 84 85 42 161 84 85 42 161 20 81 42 161 68 69 42 161 80 21 42 168 84 84 170 170 21 82 170 170 128 10 170 170 170 170 170 170 170 170 170 170 170 170 170])</body>
</methods>

<methods>
<class-id>DeductionTreeNode class</class-id> <category>instance creation</category>

<body package="Faish-UserInterface" selector="new">new	^super new initialize</body>
</methods>


<methods>
<class-id>DeductionTreeNode</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="searchable:">searchable: aSearchable	| |	searchable := aSearchable.</body>

<body package="Faish-UserInterface" selector="searcher:">searcher: aSearcher	searcher := aSearcher.</body>

<body package="Faish-UserInterface" selector="childrenImage">childrenImage	^ nil.</body>

<body package="Faish-UserInterface" selector="children">children	| i newSearchable newSearchableModel |	children isNil ifTrue: [		children := Array new: 21.		i := 1.		[ i &lt; 21 ] whileTrue: [			newSearchable := searchable nextChild. 			newSearchable isNil ifTrue: [				(i = 1) ifTrue: [ children := #(). ^ children. ].				children := children copyFrom: 1 to: i-1.				^ children.			].			newSearchableModel := DeductionTreeNode new searchable: newSearchable; searcher: searcher.			children at: i put: newSearchableModel.			i := i + 1.		].		" children at: 21 put: (DeductionMoreNode new) "	]. 	^ children.</body>

<body package="Faish-UserInterface" selector="displayString">displayString	^ searchable displayString.</body>

<body package="Faish-UserInterface" selector="actualSearchable:">actualSearchable: aSearchable	" The given searchable is part of a debugged deduction, rather than the user poking around. "	actualSearchable := aSearchable.</body>

<body package="Faish-UserInterface" selector="searchable">searchable	^ searchable.</body>

<body package="Faish-UserInterface" selector="sourceString">sourceString	actualSearchable isNil ifFalse: [ 		^ actualSearchable printDebugString.	].	^ searchable printDebugString.</body>

<body package="Faish-UserInterface" selector="icon">icon	searcher isNil ifTrue: [ ^ nil ].	actualSearchable isNil ifTrue: [ ^ self class unremarkableIcon ].	actualSearchable isDead ifTrue: [ ^ self class noSearchIcon ].		(actualSearchable isBreadthFirst) ifTrue: [ 		^ self class breadthFirstSearchIcon.	] ifFalse: [ 		actualSearchable isSuccessfull ifTrue: [ 			^ self class successfullIcon.		] ifFalse: [			^ self class depthFirstSearchIcon.			].	].</body>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	children := nil.	actualSearchable := nil. " If I'm actually part of the search rather than the user expanding things."	^self</body>
</methods>

<methods>
<class-id>DeductionTreeNode</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="printOn:">printOn: str	str nextPutAll: 'a DeductionTreeNode ('.	str nextPutAll: self displayString.	str nextPutAll: ')'.</body>
</methods>


<methods>
<class-id>Faish.FaishCanvasView class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="fish">fish	"Tools.UIMaskEditor new openOnClass: self andSelector: #fish"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 2 bitsPerPixel: 2 palette: (Graphics.MappedPalette withColors: (#(#(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 0 8191)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) ) collect: [:each | (each at: 1) value perform: (each at: 2) withArguments: (each at: 3)])) usingBits: #[170 168 138 170 170 1 18 170 168 85 84 168 161 85 21 33 133 65 69 4 133 65 69 85 128 85 21 4 168 85 84 161 168 85 66 168 170 0 42 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170 170])</body>
</methods>


<methods>
<class-id>Faish.FaishCanvasView</class-id> <category>displaying</category>

<body package="Faish-UserInterface" selector="pointFrom:ifBroken:">pointFrom: aStatement ifBroken: errorBlock	| x y |	x := (aStatement at: #x ifAbsent: errorBlock) value.	y := (aStatement at: #y ifAbsent: errorBlock) value.	x isInteger ifFalse: errorBlock.	y isInteger ifFalse: errorBlock.	^ x @ y.</body>

<body package="Faish-UserInterface" selector="displayOn:">displayOn: gc	| renderStatement searcher next renderLimit |	gc paint: (ColorValue lightCyan).	gc displayRectangle: (self bounds).	gc paint: (ColorValue black). 	renderStatement := self makeQuery.	searcher := model queryString: renderStatement onError: [ :e :i | Dialog show: e. ^ nil  ].	searcher timeLimit: 5.	renderLimit := 100. 	[ searcher hasMoreResults ] whileTrue: [		next := searcher next. 		renderLimit := renderLimit - 1.		(renderLimit &lt; 1) ifTrue: [			gc displayString: 'Too many things to render.' at: (20@20).			^ self.		].		next isNil ifFalse: [			self displayFromStatement: next on: gc.		].	].</body>

<body package="Faish-UserInterface" selector="displayFromStatement:on:">displayFromStatement: statement on: gc	" Take a statement, such as (device:canvas tock:Tock render:(shape:line topLeft:(x:X1 y:Y1) bottomRight:(x:X2 y:Y2))) and render it. "	| shapeStatement shapeType topLeft bottomRight text |	" TODO: Make this a better canvas implementation. It is currently naive. "	" TODO: somehow send errors back. Add an error argument to the statement? "	shapeStatement := statement at: #render ifAbsent: [ ^ nil ].	shapeType := (shapeStatement at: #shape ifAbsent: [ ^ nil ]) value.	topLeft := self pointFrom: (shapeStatement at: #topLeft ifAbsent: [ ^ nil ])		ifBroken: [ ^ nil ].	(shapeType = #text) ifTrue: [		text := (shapeStatement at: #text ifAbsent: [ ^ nil ]) value. 		text isString ifFalse: [ ^ nil ].		gc displayString: text at: topLeft.		^ self.	].	" TODO: implement bitmaps in Squl. "	(shapeType = #fish) ifTrue: [		gc displayPixelArray: (self class fish) at: topLeft.		^ self.	].	bottomRight := self pointFrom: (shapeStatement at: #bottomRight ifAbsent: [ ^ nil ])		ifBroken: [ ^ nil ].	(shapeType = #line) ifTrue: [		gc displayLineFrom: topLeft to: bottomRight.		^ self. 	].		(shapeType = #rectangle) ifTrue: [		gc displayRectangle: (topLeft corner: bottomRight).		^ self.	]</body>
</methods>

<methods>
<class-id>Faish.FaishCanvasView</class-id> <category>doing stuff</category>

<body package="Faish-UserInterface" selector="makeQuery">makeQuery	^ 'device:canvas tock:', controller currentTockStr, ' render:Render.'.</body>
</methods>

<methods>
<class-id>Faish.FaishCanvasView</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	^self</body>
</methods>


<methods>
<class-id>Faish.FaishCanvasController</class-id> <category>events</category>

<body package="Faish-UserInterface" selector="exitEvent:">exitEvent: event	" Mouse leaves window "	^ super exitEvent: event.</body>

<body package="Faish-UserInterface" selector="keyReleasedEvent:">keyReleasedEvent: event	^ super keyReleasedEvent: event</body>

<body package="Faish-UserInterface" selector="yellowButtonPressedEvent:">yellowButtonPressedEvent: event	" Right mouse button "	model addStatement: 'device:canvas tock:', self currentTockStr, ' event:(event:rightMouseButtonPressed x:[+', (event point x printString), '] y:[+', (event point y printString), ']).'.	self nextTock. 	model changed.	^ super yellowButtonPressedEvent: event.</body>

<body package="Faish-UserInterface" selector="closeEvent:">closeEvent: event	^ super closeEvent: event.</body>

<body package="Faish-UserInterface" selector="keyPressedEvent:">keyPressedEvent: event	self halt. " Why can't I get keyboard events? Giving up for now. "	model addStatement: 'device:canvas tock:', self currentTockStr, ' event:(event:key char:', event character, ']).'.	self nextTock. 	model changed.	^ super keyPressedEvent: event.</body>

<body package="Faish-UserInterface" selector="mouseWheelEvent:">mouseWheelEvent: event	^ super mouseWheelEvent: event.</body>

<body package="Faish-UserInterface" selector="yellowButtonReleasedEvent:">yellowButtonReleasedEvent: event	" Right mouse button "	model addStatement: 'device:canvas tock:', self currentTockStr, ' event:(event:rightMouseButtonReleased x:[+', (event point x printString), '] y:[+', (event point y printString), ']).'.	self nextTock. 	model changed.	^ super yellowButtonReleasedEvent: event.</body>

<body package="Faish-UserInterface" selector="redButtonReleasedEvent:">redButtonReleasedEvent: event	" Left mouse button "	model addStatement: 'device:canvas tock:', self currentTockStr, ' event:(event:leftMouseButtonReleased x:[+', (event point x printString), '] y:[+', (event point y printString), ']).'.	self nextTock.	model changed.	^ super redButtonReleasedEvent: event</body>

<body package="Faish-UserInterface" selector="mouseMovedEvent:">mouseMovedEvent: event	"^ super mouseMovedEvent: event."</body>

<body package="Faish-UserInterface" selector="enterEvent:">enterEvent: event	" Mouse enters window "	^ super enterEvent: event.</body>

<body package="Faish-UserInterface" selector="redButtonPressedEvent:">redButtonPressedEvent: event	" Left mouse button "	model addStatement: 'device:canvas tock:', self currentTockStr, ' event:(event:leftMouseButtonPressed x:[+', (event point x printString), '] y:[+', (event point y printString), ']).'.	self nextTock. 	model changed.	^ super redButtonPressedEvent: event.</body>

<body package="Faish-UserInterface" selector="processKeyboardEvent:">processKeyboardEvent: ev	self halt.</body>
</methods>

<methods>
<class-id>Faish.FaishCanvasController</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	tock := 1.	^self</body>
</methods>

<methods>
<class-id>Faish.FaishCanvasController</class-id> <category>view access</category>

<body package="Faish-UserInterface" selector="deactivate">deactivate	"Make this text field not be the keyboard focus"	view loseFocus.	self focusOut.	super deactivate</body>

<body package="Faish-UserInterface" selector="activate">activate	"Make this text field be the keyboard focus"	view takeFocus.	self hasControl.	self focusIn.	super activate</body>
</methods>

<methods>
<class-id>Faish.FaishCanvasController</class-id> <category>doing stuff</category>

<body package="Faish-UserInterface" selector="currentTockStr">currentTockStr	^ 't', tock printString.</body>

<body package="Faish-UserInterface" selector="nextTock">nextTock	| before |	before := self currentTockStr.	tock := tock + 1.	model addStatement: 'tick:', before, ' tock:', self currentTockStr, '.'.</body>
</methods>

<methods>
<class-id>Faish.FaishCanvasController</class-id> <category>event driven</category>

<body package="Faish-UserInterface" selector="desiresFocus">desiresFocus	^ true.</body>
</methods>


<methods>
<class-id>FaishRepositoriesHolder class</class-id> <category>class initialization</category>

<body package="Faish-UserInterface" selector="addRepository:">addRepository: repo	Repositories add: repo.</body>

<body package="Faish-UserInterface" selector="initialize">initialize	Repositories := OrderedCollection new.</body>

<body package="Faish-UserInterface" selector="repositories">repositories 	^ Repositories</body>
</methods>

<methods>
<class-id>FaishRepositoriesHolder class</class-id> <category>searching</category>

<body package="Faish-UserInterface" selector="allModules">allModules	" Return all available modules. "	| result |	result := OrderedCollection new.	Repositories do: [ :eachRepo | 		result addAll: ( eachRepo allModules ).	].	^ result.</body>

<body package="Faish-UserInterface" selector="findModuleById:onError:">findModuleById: id onError: errorBlock	" Retrieve and return that module. "	Repositories do: [ :eachRepo |  | result |		result := eachRepo importModuleById: id onError: errorBlock.		result isNil ifFalse: [ ^ result ].	].	^ errorBlock value: 'I tried to find a module, but there are no repositories to search.' value:0.</body>

<body package="Faish-UserInterface" selector="findModulesByName:">findModulesByName: aName	" Return a list of modules matching aName or containing aName in their name. "	| result |	" TODO: stream this or something. "	result := OrderedCollection new.	Repositories do: [ :eachRepo | 		result addAll: ( eachRepo findModulesByName: aName).	].	^ result.</body>
</methods>

<methods>
<class-id>FaishRepositoriesHolder class</class-id> <category>As yet unclassified</category>

<body package="Faish-UserInterface" selector="reloadIndexesOnError:">reloadIndexesOnError: errorBlock	Repositories do: [ :eachRepo | 		eachRepo loadIndexOnError: errorBlock.		" or: [ eachRepo loadIndex ] fork. "	].</body>
</methods>


<methods>
<class-id>FaishRepositoriesHolder</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>


<methods>
<class-id>Faish.QueryTreeRoot class</class-id> <category>instance creation</category>

<body package="Faish-UserInterface" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>Faish.QueryTreeRoot</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="remove:">remove: q	queriesMutex critical: [ queries remove: q ].</body>

<body package="Faish-UserInterface" selector="children">children	|  r |	queriesMutex critical: [ r := queries copy ].	^ r.</body>

<body package="Faish-UserInterface" selector="icon">icon	^ nil.</body>

<body package="Faish-UserInterface" selector="mayEditedDisplayString">mayEditedDisplayString	^ false.</body>

<body package="Faish-UserInterface" selector="editString">editString	^ ''.</body>

<body package="Faish-UserInterface" selector="isQueryNode">isQueryNode	^ false.</body>
</methods>

<methods>
<class-id>Faish.QueryTreeRoot</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="displayString">displayString	^ 'Queries'</body>
</methods>

<methods>
<class-id>Faish.QueryTreeRoot</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	super initialize.	queries := OrderedCollection new.	queriesMutex := Semaphore forMutualExclusion.	^self</body>

<body package="Faish-UserInterface" selector="addQuery:">addQuery: q	queriesMutex critical: [queries add: q].</body>
</methods>


<methods>
<class-id>Faish.QueryResultNode class</class-id> <category>instance creation</category>

<body package="Faish-UserInterface" selector="on:">on: aFaishStatement	^ self new result: aFaishStatement</body>

<body package="Faish-UserInterface" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>

<body package="Faish-UserInterface" selector="noResult">noResult	^ self new.</body>
</methods>


<methods>
<class-id>Faish.QueryResultNode</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="icon">icon	^ nil.</body>

<body package="Faish-UserInterface" selector="editString">editString	result isNil ifTrue: [ ^ '' ].	^ result editString.</body>

<body package="Faish-UserInterface" selector="isQueryNode">isQueryNode 	^ false.</body>
</methods>

<methods>
<class-id>Faish.QueryResultNode</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="displayString">displayString	result isNil ifTrue: [ ^ 'No results' ].	^ result displayString.</body>
</methods>

<methods>
<class-id>Faish.QueryResultNode</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="children">children 	^ #().</body>

<body package="Faish-UserInterface" selector="result:">result: aFaishStatement	result := aFaishStatement.</body>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>


<methods>
<class-id>Faish.FaishFishCanvasUI class</class-id> <category>interface specs</category>

<body package="Faish-UserInterface" selector="windowSpec">windowSpec	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"	&lt;resource: #canvas&gt;	^#(#{UI.FullSpec} 		#window: 		#(#{UI.WindowSpec} 			#properties: #(#{UI.PropertyListDictionary} #labelFromApplication true ) 			#label: #title 			#min: #(#{Core.Point} 20 20 ) 			#max: #(#{Core.Point} 0 0 ) 			#bounds: #(#{Graphics.Rectangle} 640 300 1280 780 ) 			#flags: 4 			#menu: #mainMenu ) 		#component: 		#(#{UI.SpecCollection} 			#collection: #(				#(#{UI.ArbitraryComponentSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0 0 0 0 1 0 1 ) 					#name: #canvasView 					#component: #canvasView ) ) ) )</body>
</methods>

<methods>
<class-id>Faish.FaishFishCanvasUI class</class-id> <category>class initialization</category>

<body package="Faish-UserInterface" selector="showTheFish">showTheFish	| f ev m |	f := FaishFishCanvasUI new.	ev := EvolutionModuleChamber new.	f module: ev.	ev addSourceModule: f workingModule.	m := FaishModule new.	m addStatement: 'device:fish tock:X direction:D.'.	ev addSourceModule: m.	ev populateModules.	f open.</body>

<body package="Faish-UserInterface" selector="visualDistance">visualDistance	^ VisualDistance.</body>

<body package="Faish-UserInterface" selector="initialize">initialize	VisualDistance := 50.</body>
</methods>

<methods>
<class-id>Faish.FaishFishCanvasUI class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="mainMenu">mainMenu	"Tools.MenuEditor new openOnClass: self andSelector: #mainMenu"	&lt;resource: #menu&gt;	^#(#{UI.Menu} #(			#(#{UI.MenuItem} 				#rawLabel: 'View' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'Show source module' 							#value: #showSourceModuleAction ) 						#(#{UI.MenuItem} 							#rawLabel: 'Show working module' 							#value: #showWorkingModuleAction ) ) #(2 ) nil ) ) ) #(1 ) nil ) decodeAsLiteralArray</body>
</methods>


<methods>
<class-id>Faish.FaishFishCanvasUI</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="canvasView">canvasView	| v |	v := FaishFishCanvasView new model: model.	v controller: (FaishFishCanvasController new).	self startAnimation.	^ v</body>

<body package="Faish-UserInterface" selector="queryTitle">queryTitle	| q r |	q := module queryString: 'device:fish title:X?' onError: [ :e :i |  Dialog show: e. ^ nil  ].	r := q next.	r isNil ifTrue: [		title := module name.	] ifFalse: [		title := (r at: #title) value.	].</body>

<body package="Faish-UserInterface" selector="title">title	^ title.</body>

<body package="Faish-UserInterface" selector="showSourceModuleAction">showSourceModuleAction	(FaishModuleUI module: module) open.</body>

<body package="Faish-UserInterface" selector="showWorkingModuleAction">showWorkingModuleAction	(FaishModuleUI module: workingModule) open.</body>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	model := FaishFishCanvasModel new.	title := 'Feed the fish!'.	keepGoing := true.	tock := 1.	^self</body>

<body package="Faish-UserInterface" selector="module:">module: m	module := m.	workingModule := CacheModule new.	workingModule addImport: module.	queryAction := workingModule parse: 'device:fish tock:X direction:D.'.	queryInput := workingModule parse: 'device:fish tock:X sensor:a value:V.'.	tockInput := workingModule parse: 'tick:X tock:Y.'.</body>
</methods>

<methods>
<class-id>Faish.FaishFishCanvasUI</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="workingModule">workingModule	^ workingModule.</body>

<body package="Faish-UserInterface" selector="startAnimation">startAnimation	| delay p reward |	delay := 0.1 seconds.	p := [		[keepGoing] whileTrue: [			self queryForAction.			model doOneStep.				self insertSensoryData.			tock := tock + 1.			reward := model numberFoodEaten.			reward timesRepeat: [ module doReward ].			module doEvolution.			delay wait.		].	] forkAt: Processor userBackgroundPriority.	p name: 'A fish'.</body>
</methods>

<methods>
<class-id>Faish.FaishFishCanvasUI</class-id> <category>changing</category>

<body package="Faish-UserInterface" selector="changeRequest">changeRequest	keepGoing := false.	^ super changeRequest.</body>
</methods>

<methods>
<class-id>Faish.FaishFishCanvasUI</class-id> <category>private</category>

<body package="Faish-UserInterface" selector="queryForAction">queryForAction	| q s n d |	q := queryAction copy.	q at: #tock put: (FaishAtom from: ('t', tock printString)).	s := Searcher new query: q module: workingModule.	s stepLimit: 1000.	n := s next.	n isNil ifFalse: [ 		d := n at: #direction ifAbsent: [ nil ].		(d isNil not and: [d isLiteral and: [d isNumber]]) ifTrue: [ 			model changeFishDirection: d value.		].	].</body>

<body package="Faish-UserInterface" selector="foodAngle:">foodAngle: food	| p |	" All angles in radians. "	p := food - model fishLocation.	p := (p x) @ (0 - p y).	^ p theta.</body>

<body package="Faish-UserInterface" selector="insertSensoryData">insertSensoryData	| aValue bValue cValue q distance angle pi2 pi6 currentTock previousTock |	aValue := bValue := cValue := 0.	pi2 := Float pi / 2.	pi6 := Float pi / 6.	model food do: [ :eachFood | 		distance := self foodDistance: eachFood.		(distance &lt; VisualDistance) ifTrue: [			angle := self foodAngle: eachFood.			" We have three sensors. "			((angle &gt;= (0-pi2)) and: [angle &lt;(0-pi6) ]) ifTrue: [				aValue := aValue + (1-(distance/VisualDistance)).			] ifFalse: [				((angle &gt;= (0-pi6)) and: [angle &lt; pi6]) ifTrue: [					bValue := bValue + (1-(distance/VisualDistance)).				]  ifFalse: [					((angle &gt; pi6) and: [angle &lt;= pi2]) ifTrue: [						cValue := cValue + (1-(distance/VisualDistance)).					]				]			]		]	].	currentTock := FaishAtom new value: ('t', tock printString).	previousTock := FaishAtom new value: ('t', (tock-1) printString).	q := tockInput copy.	q at: #tick put: previousTock.	q at: #tock put: currentTock.	workingModule add: q.	(aValue &gt; 0) ifTrue: [		q := queryInput copy.		q at: #sensor put: (FaishAtom new value: #a).		q at: #value put: (FaishLiteral new value: aValue).		q at: #tock put: currentTock.		workingModule add: q.	].		(bValue &gt; 0) ifTrue: [		q := queryInput copy.		q at: #sensor put: (FaishAtom new value: #b).		q at: #value put: (FaishLiteral new value: bValue).		q at: #tock put: currentTock.			workingModule add: q.	].	(cValue &gt; 0) ifTrue: [		q := queryInput copy.		q at: #sensor put: (FaishAtom new value: #c).		q at: #value put: (FaishLiteral new value: cValue).		q at: #tock put: currentTock.		workingModule add: q.	].</body>

<body package="Faish-UserInterface" selector="foodDistance:">foodDistance: food	^ model fishLocation dist: food.</body>
</methods>


<methods>
<class-id>Faish.FaishStatementNodeInfo class</class-id> <category>instance creation</category>

<body package="Faish-UserInterface" selector="on:">on: aStatement	^ self new on: aStatement</body>

<body package="Faish-UserInterface" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>
</methods>


<methods>
<class-id>Faish.FaishStatementNodeInfo</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="isStatementNode">isStatementNode	^ false.</body>

<body package="Faish-UserInterface" selector="icon">icon	^ nil.</body>
</methods>

<methods>
<class-id>Faish.FaishStatementNodeInfo</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="displayString">displayString	^ 'Metadata not implemented yet'.</body>

<body package="Faish-UserInterface" selector="sourceString">sourceString	^ ''.</body>
</methods>

<methods>
<class-id>Faish.FaishStatementNodeInfo</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="children">children	^ #().</body>

<body package="Faish-UserInterface" selector="target">target	^ target</body>

<body package="Faish-UserInterface" selector="inPlaceEdited:">inPlaceEdited: aString</body>

<body package="Faish-UserInterface" selector="on:">on: aStatement	target := aStatement</body>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>

<body package="Faish-UserInterface" selector="mayEditedDisplayString">mayEditedDisplayString	^ false.</body>

<body package="Faish-UserInterface" selector="editString">editString	^ 'Not implemented yet.'</body>
</methods>


<methods>
<class-id>FaishFileRepository</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="writeIndex">writeIndex	| filename str |	filename := path / 'index.squl'.	str := filename writeStream.	indexModule writeOn: str.	str close.</body>

<body package="Faish-UserInterface" selector="importModuleById:onError:">importModuleById: id onError: errorBlock	| filename readStream newModule |	filename := path / (id, '.squl').	filename isReadable ifFalse: [ ^ errorBlock value: 'Could not read file ', filename asString value: 0]. 	readStream := filename readStream.	newModule := CodeModule new readFrom: readStream onError: errorBlock.	readStream close.	^ newModule.</body>

<body package="Faish-UserInterface" selector="exportModuleImpl:onError:">exportModuleImpl: aModule onError: errorBlock	| filename str |	filename := path / aModule repositoryFilename.	str := filename writeStream.	aModule writeOn: str.	str close.	self addModuleToIndex: aModule.</body>

<body package="Faish-UserInterface" selector="loadIndexOnError:">loadIndexOnError: errorBlock	| filename readStream |	filename := path / 'index.squl'.	filename isReadable ifFalse: [ ^ errorBlock value: 'Cannot read file ', filename asString value: 0 ].	readStream := filename readStream.	indexModule := FaishModule new readFrom: readStream onError: errorBlock.	readStream close.</body>
</methods>

<methods>
<class-id>FaishFileRepository</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="printString">printString	^ path asString.</body>
</methods>

<methods>
<class-id>FaishFileRepository</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="path:">path: aPath	path := aPath</body>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>


<methods>
<class-id>Faish.FaishModuleListUI class</class-id> <category>interface specs</category>

<body package="Faish-UserInterface" selector="windowSpec">windowSpec	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"	&lt;resource: #canvas&gt;	^#(#{UI.FullSpec} 		#window: 		#(#{UI.WindowSpec} 			#label: 'Faish - Your Modules' 			#min: #(#{Core.Point} 262 20 ) 			#max: #(#{Core.Point} 0 0 ) 			#bounds: #(#{Graphics.Rectangle} 829 440 1091 760 ) 			#flags: 4 			#menu: #mainMenu ) 		#component: 		#(#{UI.SpecCollection} 			#collection: #(				#(#{UI.SequenceViewSpec} 					#layout: #(#{Graphics.LayoutFrame} 4 0 4 0 -4 1 -40 1 ) 					#name: #moduleList 					#model: #moduleList 					#callbacksSpec: 					#(#{UI.UIEventCallbackSubSpec} 						#doubleClickSelector: #openAction ) 					#helpText: #currentModuleInfo 					#menu: #moduleMenu 					#style: #large 					#useModifierKeys: true 					#selectionType: #highlight ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} -88 1 -32 1 80 24 ) 					#name: #ActionButton1 					#model: #createNewAction 					#label: 'New' 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} -172 1 -32 1 81 24 ) 					#name: #ActionButton2 					#model: #importFromRepositoryAction 					#helpText: 'Load new modules from the central server' 					#label: 'Load...' 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} -256 1 -32 1 80 24 ) 					#name: #ActionButton3 					#model: #deleteAction 					#label: 'Delete...' 					#defaultable: true ) ) ) )</body>
</methods>

<methods>
<class-id>Faish.FaishModuleListUI class</class-id> <category>shared actions</category>

<body package="Faish-UserInterface" selector="importModuleFromFile">importModuleFromFile	| filename readStream newModule |	filename := Dialog requestFileName: 'Import from file' default: ('module.squl') version: #multipleOld.	filename isEmpty ifTrue: [ ^ nil ].	filename := filename asFilename.	filename isReadable ifFalse: [ Dialog warn: 'File ', filename, ' cannot be read.'. ^ nil. ].	readStream := filename readStream lineEndTransparent. " lineEndTransparent means 'Don't fuck with the line endings.'"	newModule := CodeModule new readFrom: readStream onError: [ :errorString :i | Dialog warn: errorString. ^ nil. ] .	readStream close.	^ newModule.</body>

<body package="Faish-UserInterface" selector="importModuleFromFiles">importModuleFromFiles	| filenames readStream newModule dialog result |	dialog := MultiOpenFileDialog new.	dialog		windowTitle: 'Import from file...';		acceptButtonLabel: 'Import';		defaultFilename: 'module.squl';		addFileFilter: 'Squl file (*.squl)' pattern: '*.squl';		addFilterForAllFiles;		fileCondition: #mustBeOld.	filenames := dialog select.	filenames isNil ifTrue: [ ^ self ].		result := Bag new.	(filenames isKindOf: Collection) ifTrue: [		filenames do: [ :each |  |filename|			filename := each asFilename.			filename isReadable ifFalse: [ 				Dialog warn: 'File ', filename, ' cannot be read.'. 				^ #().			].			readStream := filename readStream lineEndTransparent " don't fuck with the line endings. ".			newModule := CodeModule new readFrom: readStream 				onError: [ :errorString :i | Dialog warn: errorString.					readStream close.				^ #().			] .			readStream close.			result add: newModule.		].	] ifFalse: [ |  filename |		filename := filenames asFilename.		filename isReadable ifFalse: [ Dialog warn: 'File ', filename, ' cannot be read.'.				readStream close.				^ #().			].		readStream := filename readStream.		newModule := CodeModule new readFrom: readStream 			onError: [ :errorString :i | Dialog warn: errorString.				readStream close.				^ #().			] .		readStream close.		result add: newModule.	].	^ result.</body>

<body package="Faish-UserInterface" selector="exportModuleToFile:">exportModuleToFile: aModule	| filename str |	filename := Dialog requestNewFileName: 'Export to file' default: (aModule name, '.squl').	filename isEmpty ifTrue: [ ^ self ].	filename := filename asFilename.	str := filename writeStream.	aModule writeOn: str.	str close.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleListUI class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="mainMenu">mainMenu	"Tools.MenuEditor new openOnClass: self andSelector: #mainMenu"	&lt;resource: #menu&gt;	^#(#{UI.Menu} #(			#(#{UI.MenuItem} 				#rawLabel: '&amp;File' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'Load from server...' 							#value: #importFromRepositoryAction 							#shortcutKeyCharacter: $l 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Import from file(s)...' 							#value: #loadFromFileAction 							#shortcutKeyCharacter: $i 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Export to file...' 							#value: #saveToFileAction 							#shortcutKeyCharacter: $e 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Commit' 							#value: #commitAction 							#helpText: 'Save changes to database' ) 						#(#{UI.MenuItem} 							#rawLabel: 'Quit' 							#value: #quitAction ) ) #(3 2 ) nil ) ) 			#(#{UI.MenuItem} 				#rawLabel: '&amp;Edit' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'Open' 							#value: #openAction 							#shortcutKeyCharacter: #Enter 							#shortcutModifiers: 0 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Create new module...' 							#value: #createNewAction 							#shortcutKeyCharacter: $n 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Rename...' 							#value: #renameAction 							#shortcutKeyCharacter: $r 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Delete...' 							#value: #deleteAction 							#shortcutKeyCharacter: #Delete 							#shortcutModifiers: 0 ) ) #(4 ) nil ) ) 			#(#{UI.MenuItem} 				#rawLabel: '&amp;Help' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'Help...' 							#value: #helpAction 							#shortcutKeyCharacter: #F1 							#shortcutModifiers: 0 ) 						#(#{UI.MenuItem} 							#rawLabel: 'License...' 							#value: #licenseAction ) 						#(#{UI.MenuItem} 							#rawLabel: 'About...' 							#value: #aboutAction ) ) #(3 ) nil ) ) ) #(3 ) nil ) decodeAsLiteralArray</body>

<body package="Faish-UserInterface" selector="moduleMenu">moduleMenu	"Tools.MenuEditor new openOnClass: self andSelector: #moduleMenu"	&lt;resource: #menu&gt;	^#(#{UI.Menu} #(			#(#{UI.MenuItem} 				#rawLabel: 'Open' 				#value: #openAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Open source' 				#value: #openSourceAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Import from file...' 				#value: #loadFromFileAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Export to file...' 				#value: #saveToFileAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Import from repository...' 				#value: #importFromRepositoryAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Export to repository...' 				#value: #exportToRepositoryAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Rename...' 				#value: #renameAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Delete...' 				#value: #deleteAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Create new...' 				#value: #createNewAction ) ) #(2 2 2 2 1 ) nil ) decodeAsLiteralArray</body>
</methods>

<methods>
<class-id>Faish.FaishModuleListUI class</class-id> <category>opening</category>

<body package="Faish-UserInterface" selector="openSingleton">openSingleton	(self raiseSingleInstance)		isNil ifTrue: [ self open ].</body>
</methods>


<methods>
<class-id>Faish.FaishModuleListUI</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="selectedModule">selectedModule	^ moduleListSelection selection</body>

<body package="Faish-UserInterface" selector="moduleList">moduleList	^ moduleListSelection.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleListUI</class-id> <category>interface closing</category>

<body package="Faish-UserInterface" selector="requestForWindowClose">requestForWindowClose	| result |	result := Dialog		choose: 'Save changes and exit?'		labels: (Array with: 'Wait, what? No, go back!' with: 'Discard' with: 'Save')		values: #(#cancel #discard #save)		default: #save.	(result = #save) ifTrue: [ 		self commitAction.		^ true.	].	(result = #discard) ifTrue: [		^ true.	].	^ false.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleListUI</class-id> <category>actions</category>

<body package="Faish-UserInterface" selector="aboutAction">aboutAction	Dialog warn: 'Faish version 0.2, released August 2014.'.</body>

<body package="Faish-UserInterface" selector="deleteAction">deleteAction	| result |	self selectedModule isNil ifTrue: [ ^ self ].	result := Dialog		choose: 'Delete this module?'		labels: (Array with: 'Cancel' with: 'Delete')		values: #(#cancel #delete)		default: #delete.	(result = #delete) ifTrue: [		moduleList remove: (self selectedModule) ifAbsent: [ ^ nil ].		moduleListSelection listHolder changed: #value.		].</body>

<body package="Faish-UserInterface" selector="quitAction">quitAction	ObjectMemory quitDialog.</body>

<body package="Faish-UserInterface" selector="licenseAction">licenseAction	Dialog warn: 'Probably Copywrite 2011 by Michael van der Gulik.		Released under the MIT license.'.</body>

<body package="Faish-UserInterface" selector="importFromRepositoryAction">importFromRepositoryAction	FaishImportUI new callbackTo: self; title: 'Import'; open.</body>

<body package="Faish-UserInterface" selector="loadFromFileAction">loadFromFileAction	| newModules |	newModules := FaishModuleListUI importModuleFromFiles.	newModules do: [ :each |		FaishModuleKeeper addModule: each.	].	moduleListSelection listHolder changed: #value.	Dialog warn: 'Module(s) loaded.' for: builder window.</body>

<body package="Faish-UserInterface" selector="createNewAction">createNewAction	| name newModule |	[ 	name := Dialog 			request: 'New module''s name: '			initialAnswer: 'NewModule'			onCancel: [ ^ self ].		FaishModuleKeeper existsModuleNamed: name	] whileTrue: [		Dialog warn: 'A module by that name exists'	].			newModule := CodeModule new name: name.	FaishModuleKeeper addModule: newModule.	moduleListSelection listHolder changed: #value.	moduleListSelection selection: newModule.	self openAction.</body>

<body package="Faish-UserInterface" selector="exportToRepositoryAction">exportToRepositoryAction	| d | 	d := SelectRepositoryDialog new.	d open.		(d cancel value) ifTrue: [ ^ self ].	d repository isNil ifTrue: [ 		Dialog warn: 'Never mind then.'.		^ self 	].	d repository exportModule: (self selectedModule) onError: [ :error :pos | ^ Dialog warn: error ].	Dialog warn: 'Successfully exported.'.</body>

<body package="Faish-UserInterface" selector="helpAction">helpAction	ExternalWebBrowser open: 'http://www.squl.org/documentation/'.</body>

<body package="Faish-UserInterface" selector="openAction">openAction	| openMe module q r | 	module := self selectedModule.	module isNil ifTrue: [ ^ self ].	q := module querySimply: 'device:cli title:Y?'.	r := q next.	r isResult ifTrue: [		openMe := FaishCommandLineUI new.		openMe module: module.		openMe open.		^ self.	].	q := module querySimply: 'device:canvas title:Y?'.	r := q next.	r isResult ifTrue: [		openMe := FaishCanvasUI new.		openMe module: module.		openMe open.		^ self.	].	self openSourceAction.</body>

<body package="Faish-UserInterface" selector="openSourceAction">openSourceAction	| openMe | 	openMe := FaishModuleUI module: (self selectedModule).	openMe open.</body>

<body package="Faish-UserInterface" selector="commitAction">commitAction	ObjectMemory snapshot.	" TODO: In future, this would be commiting a remote database. "</body>

<body package="Faish-UserInterface" selector="saveToFileAction">saveToFileAction	FaishModuleListUI exportModuleToFile: self selectedModule.</body>

<body package="Faish-UserInterface" selector="renameAction">renameAction	| newName oldName |	(self selectedModule isNil) ifTrue: [ ^ self ].	self selectedModule name isNil 		ifFalse: 	[ oldName := self selectedModule name ]		ifTrue: [ oldName := '' ].	newName := Dialog		request: 'Rename module to:'		initialAnswer: oldName		onCancel: [ ^ nil ]		windowLabel: 'Rename module'		for: Dialog defaultParentWindow.	self selectedModule name: newName.	moduleListSelection listHolder changed: #value.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleListUI</class-id> <category>interface opening</category>

<body package="Faish-UserInterface" selector="postBuildWith:">postBuildWith: aBuilder	| ctrlr |	ctrlr := (aBuilder componentAt: #moduleList) widget controller.	ctrlr keyboardHook: [ :ev :c | 			self keyPress: ev].</body>
</methods>

<methods>
<class-id>Faish.FaishModuleListUI</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	moduleList := FaishModuleKeeper modules.	moduleListSelection := SelectionInList new.	moduleListSelection listHolder: moduleList asValue.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleListUI</class-id> <category>user interface</category>

<body package="Faish-UserInterface" selector="keyPress:">keyPress: ev	| char |	char := ev keyValue.	(char = Character cr) 		ifTrue: [ self openAction. ^ nil. ].				^ ev.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleListUI</class-id> <category>callbacks</category>

<body package="Faish-UserInterface" selector="currentModuleInfo">currentModuleInfo	| s |	s := self selectedModule.	s isNil ifTrue: [		^ ''	] ifFalse: [		^ s description.	].</body>

<body package="Faish-UserInterface" selector="callbackAddImport:">callbackAddImport: aModule	" Badly named. I actually add a newly imported module. "	FaishModuleKeeper addModule: aModule.	moduleListSelection listHolder changed: #value.	moduleListSelection selection: aModule.	Dialog warn: 'Module imported.'.</body>
</methods>


<methods>
<class-id>Faish.QueryNode class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="noStatus">noStatus	"Tools.UIMaskEditor new openOnClass: self andSelector: #noStatus"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 1 bitsPerPixel: 1 palette: MonoMappedPalette whiteBlack usingBits: #[15 240 0 0 24 24 0 0 48 12 0 0 32 2 0 0 96 3 0 0 64 1 0 0 64 1 0 0 192 1 0 0 128 1 0 0 128 1 0 0 192 3 0 0 96 2 0 0 48 14 0 0 24 24 0 0 15 112 0 0 1 192 0 0])</body>

<body package="Faish-UserInterface" selector="failStatus">failStatus	"Tools.UIMaskEditor new openOnClass: self andSelector: #failStatus"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 2 bitsPerPixel: 2 palette: (Graphics.MappedPalette withColors: (#(#(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(4111 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) ) collect: [:each | (each at: 1) value perform: (each at: 2) withArguments: (each at: 3)])) usingBits: #[170 0 0 170 168 5 84 42 160 21 80 2 160 85 85 2 128 65 80 16 129 72 82 20 129 64 80 21 21 85 85 84 21 85 85 84 21 85 5 84 21 80 0 80 129 81 84 82 161 85 85 66 168 21 84 10 170 0 80 170 170 168 10 170])</body>

<body package="Faish-UserInterface" selector="passStatus">passStatus	"Tools.UIMaskEditor new openOnClass: self andSelector: #passStatus"	&lt;resource: #image&gt;	^CachedImage on: (Image extent: 16@16 depth: 2 bitsPerPixel: 2 palette: (Graphics.MappedPalette withColors: (#(#(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(0 4111 0)) #(#{Graphics.ColorValue} #scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) ) collect: [:each | (each at: 1) value perform: (each at: 2) withArguments: (each at: 3)])) usingBits: #[170 0 0 170 168 21 84 42 160 85 85 74 161 85 85 82 133 65 80 84 133 72 82 20 133 80 84 20 21 85 85 84 20 21 84 20 21 5 80 20 21 64 0 84 129 64 5 82 160 85 85 2 168 21 84 42 170 0 64 170 170 168 10 170])</body>
</methods>

<methods>
<class-id>Faish.QueryNode class</class-id> <category>instance creation</category>

<body package="Faish-UserInterface" selector="on:module:selectionInTreeToUpdate:">on: queryString 	module: module	selectionInTreeToUpdate: queryTree	^ super new queryString: queryString; 		module: module; 		updating: queryTree;		initialize.</body>

<body package="Faish-UserInterface" selector="new">new	"Answer a newly created and initialized instance."	^super new initialize</body>

<body package="Faish-UserInterface" selector="onQuery:module:selectionInTreeToUpdate:">onQuery: query	module: module	selectionInTreeToUpdate: queryTree	^ super new queryStatement: query;		module: module;		updating: queryTree;		initialize.</body>

<body package="Faish-UserInterface" selector="on:">on: aFaishStatement	^ self new queryString: aFaishStatement.</body>
</methods>


<methods>
<class-id>Faish.QueryNode</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="isQueryNode">isQueryNode	^ true.</body>

<body package="Faish-UserInterface" selector="timeLimit:">timeLimit: seconds	self makeQuery.	query timeLimit: seconds.</body>

<body package="Faish-UserInterface" selector="icon">icon	pass isNil ifTrue: [		^ self class noStatus	].	pass ifFalse: [		^ self class failStatus	].	 ^ self class passStatus.</body>

<body package="Faish-UserInterface" selector="isStatementNode">isStatementNode	^ true.</body>

<body package="Faish-UserInterface" selector="stop">stop	query isNil ifFalse: [		query stop.	].</body>

<body package="Faish-UserInterface" selector="depthLimit:">depthLimit: depth	self makeQuery.	query depthLimit: depth.</body>

<body package="Faish-UserInterface" selector="startSimply">startSimply		query := module querySimply: queryString.	([ self runQuery ] forkAt: Processor userBackgroundPriority) name: 'Faish: ', queryString.</body>

<body package="Faish-UserInterface" selector="stepLimit:">stepLimit: steps	self makeQuery.	query stepLimit: steps.</body>

<body package="Faish-UserInterface" selector="makeQuery">makeQuery	query isNil ifTrue: [		queryStatement isNil ifTrue: [			query := module queryString: queryString onError: [ :e :i | Dialog warn: e. ^ nil ].		] ifFalse: [			query := module query: queryStatement onError: [ :e :i | Dialog warn: e. ^ nil ].		]	].</body>

<body package="Faish-UserInterface" selector="isRunning">isRunning	^ isRunning.</body>

<body package="Faish-UserInterface" selector="addResult:">addResult: aQueryResultNode	resultsMutex critical: [		results add: aQueryResultNode.	].	queryTree tree refreshRoot.</body>

<body package="Faish-UserInterface" selector="continue">continue	query isRunning ifFalse: [		([ self runQuery ] forkAt: Processor userBackgroundPriority) name: 'Faish: ', queryString.	].</body>

<body package="Faish-UserInterface" selector="start">start	self makeQuery.	query isNil ifTrue: [ ^ self ].	([ query timeLimit: 10. self runQuery ] forkAt: Processor userBackgroundPriority) name: 'Faish: ', queryString.</body>
</methods>

<methods>
<class-id>Faish.QueryNode</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="displayString">displayString	| r |	r := queryString copy.	1 to: (queryString size) do: [ :i |		((r at: i) == Character cr) ifTrue: [ 			r at: i put: $ .		]	].	isRunning ifTrue: [ ^ r, ' (running)' ].	^ r.</body>

<body package="Faish-UserInterface" selector="module:">module: aModule	module := aModule</body>

<body package="Faish-UserInterface" selector="editString">editString	^ queryStatement printQueryString.</body>
</methods>

<methods>
<class-id>Faish.QueryNode</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="queryStatement:">queryStatement: q	queryStatement := q.	queryString := q printString.</body>

<body package="Faish-UserInterface" selector="noResults">noResults	pass := false.	resultsMutex critical: [		results add: (QueryResultNode noResult).	].	queryTree tree refreshRoot.</body>

<body package="Faish-UserInterface" selector="children">children	| c |	resultsMutex critical: [		c := results copy.	].	^ c.</body>

<body package="Faish-UserInterface" selector="queryString:">queryString: aQuery	(queryString isKindOf: String) ifFalse: [ self halt ].	queryString := aQuery</body>

<body package="Faish-UserInterface" selector="target">target 	^ queryStatement.</body>

<body package="Faish-UserInterface" selector="query">query	" In the future, I might keep the actual FaishStatement. "	queryStatement isNil ifTrue: [		^ module parse: queryString	] ifFalse: [		^ queryStatement.	].</body>

<body package="Faish-UserInterface" selector="runQuery">runQuery	" I'm usually invoked in a separate thread. "	| next noResults limit |	isRunning := true.	query clear. " Reset wasStopped. "	noResults := true.	limit := 1. "TODO: allow the user to choose this."	[		(query hasMoreResults and: [ query wasStopped not ]) and: [limit &gt; 0] 	] whileTrue: [		next := query next.		next isNil ifFalse: [			next isStatement ifTrue: [				noResults := false.			].			self addResult: (QueryResultNode on: next).			limit := limit - 1.		].	].	noResults ifTrue: [		self noResults.		] ifFalse: [		pass := true	].	isRunning := false.</body>

<body package="Faish-UserInterface" selector="initialize">initialize	super initialize.	" We assume that some instance variables are set before I'm invoked. "	results := OrderedCollection new.	resultsMutex := Semaphore forMutualExclusion.	isRunning := true.	^self</body>

<body package="Faish-UserInterface" selector="updating:">updating: qt	queryTree := qt.</body>
</methods>


<methods>
<class-id>Faish.QueryPersevereDialog class</class-id> <category>interface specs</category>

<body package="Faish-UserInterface" selector="windowSpec">windowSpec	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"	&lt;resource: #canvas&gt;	^#(#{UI.FullSpec} 		#window: 		#(#{UI.WindowSpec} 			#label: 'Unlabeled Canvas' 			#bounds: #(#{Graphics.Rectangle} 365 734 630 893 ) ) 		#component: 		#(#{UI.SpecCollection} 			#collection: #(				#(#{UI.LabelSpec} 					#properties: #(#{UI.PropertyListDictionary} #labelFromApplication false ) 					#layout: #(#{Core.Point} 22 15 ) 					#name: #Label1 					#label: 'Run query for:' ) 				#(#{UI.RadioButtonSpec} 					#layout: #(#{Core.Point} 25 42 ) 					#name: #RadioButton1 					#model: #searchLimitType 					#label: 'Number of seconds:' 					#select: #numberOfSeconds ) 				#(#{UI.RadioButtonSpec} 					#layout: #(#{Core.Point} 25 69 ) 					#name: #RadioButton2 					#model: #searchLimitType 					#label: 'Number of steps:' 					#select: #numberOfSteps ) 				#(#{UI.RadioButtonSpec} 					#layout: #(#{Core.Point} 25 96 ) 					#name: #RadioButton3 					#model: #searchLimitType 					#label: 'To a search depth of:' 					#select: #searchDepth ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.Rectangle} 175 127 256 150 ) 					#name: #ActionButton1 					#model: #accept 					#label: 'Run query' 					#defaultable: true ) 				#(#{UI.ActionButtonSpec} 					#layout: #(#{Graphics.Rectangle} 91 127 172 150 ) 					#name: #ActionButton2 					#model: #cancel 					#label: 'Cancel' 					#defaultable: true ) 				#(#{UI.InputFieldSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} 156 0 66 0 100 23 ) 					#name: #txtNumberSteps 					#model: #numberOfSteps 					#helpText: 'Run the query for the given number of steps before stopping.' 					#type: #number ) 				#(#{UI.InputFieldSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} 156 0 39 0 100 23 ) 					#name: #txtNumberSeconds 					#model: #numberOfSeconds 					#helpText: 'Run the query for the given number of seconds before stopping.' 					#type: #number ) 				#(#{UI.InputFieldSpec} 					#layout: #(#{Graphics.LayoutSizedOrigin} 156 0 93 0 100 23 ) 					#name: #txtSearchDepth 					#model: #searchDepth 					#helpText: 'Run the query exhaustively searching to a depth of the given number.' 					#type: #number ) ) ) )</body>
</methods>


<methods>
<class-id>Faish.QueryPersevereDialog</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	searchLimitType := #numberOfSeconds asValue.	numberOfSeconds := 5 asValue.	numberOfSteps := 1000 asValue.	searchDepth := 100 asValue.	^self</body>
</methods>

<methods>
<class-id>Faish.QueryPersevereDialog</class-id> <category>UI callbacks</category>

<body package="Faish-UserInterface" selector="searchLimitType">searchLimitType	^ searchLimitType.</body>

<body package="Faish-UserInterface" selector="searchDepth">searchDepth	^ searchDepth</body>

<body package="Faish-UserInterface" selector="numberOfSeconds">numberOfSeconds 	^ numberOfSeconds</body>

<body package="Faish-UserInterface" selector="numberOfSteps">numberOfSteps	^ numberOfSteps</body>
</methods>


<methods>
<class-id>Faish.FaishFishCanvasController</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="initialize">initialize	"Initialize a newly created instance. This method must answer the receiver."	super initialize.	" *** Replace this comment with the appropriate initialization code *** "	^self</body>
</methods>


<methods>
<class-id>Faish.FaishModuleKeeper class</class-id> <category>class initialization</category>

<body package="Faish-UserInterface" selector="addModule:">addModule: aModule	(aModule isKindOf: FaishModule) ifFalse: [ Error raiseErrorString: 'Tried to add non-module to module keeper.' ].	modules add: aModule</body>

<body package="Faish-UserInterface" selector="removeModule:">removeModule: aModule	modules remove: aModule</body>

<body package="Faish-UserInterface" selector="modules">modules	^ modules</body>

<body package="Faish-UserInterface" selector="findModuleById:">findModuleById: id	^ modules detect: [ :each | each uuid = id ] ifNone: [ nil ].</body>

<body package="Faish-UserInterface" selector="existsModuleNamed:">existsModuleNamed: aName	modules do: [ :each | (each name = aName) ifTrue: [^ true] ].	^ false.</body>

<body package="Faish-UserInterface" selector="initialize">initialize	modules := OrderedCollection new.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleKeeper class</class-id> <category>instance creation</category>

<body package="Faish-UserInterface" selector="new">new	^ super new initialize.</body>
</methods>


<methods>
<class-id>Faish.FaishModuleUI class</class-id> <category>interface specs</category>

<body package="Faish-UserInterface" selector="windowSpec">windowSpec	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"	&lt;resource: #canvas&gt;	^#(#{UI.FullSpec} 		#window: 		#(#{UI.WindowSpec} 			#properties: #(#{UI.PropertyListDictionary} #labelFromApplication true ) 			#label: #moduleName 			#bounds: #(#{Graphics.Rectangle} 1615 354 2353 926 ) 			#flags: 4 			#menu: #mainMenu ) 		#component: 		#(#{UI.SpecCollection} 			#collection: #(				#(#{UI.TreeViewSpec} 					#properties: #(#{UI.PropertyListDictionary} #fullLineSelect true ) 					#layout: #(#{Graphics.LayoutFrame} 0 0 23 0 0 0.5 -105 1 ) 					#name: #moduleContentsTree 					#flags: 15 					#model: #moduleContentsTree 					#menu: #moduleMenu 					#useModifierKeys: true 					#selectionType: #highlight 					#useIcons: #other 					#iconSelectors: #(#icon ) 					#rootExpander: true ) 				#(#{UI.TextEditorSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0 -100 1 0 1 0 1 ) 					#name: #editedStatement 					#model: #editedStatement 					#helpText: 'Enter text here and press CTRL-Enter to add it.' 					#tabRequiresControl: true ) 				#(#{UI.TreeViewSpec} 					#properties: #(#{UI.PropertyListDictionary} #fullLineSelect true ) 					#layout: #(#{Graphics.LayoutFrame} 5 0.5 0 0 0 1 -105 1 ) 					#name: #queryTree 					#flags: 15 					#model: #queryTree 					#helpText: 'These are the currently running queries.' 					#menu: #queryMenu 					#useModifierKeys: true 					#selectionType: #highlight 					#useIcons: #other 					#iconSelectors: #(#icon ) 					#rootExpander: true ) 				#(#{UI.ResizingSplitterSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0 -105 1 0 1 -100 1 ) 					#name: #bottomSplitter 					#flags: 8 					#horizontal: true 					#minAboveSize: 30 					#minBelowSize: 30 					#aboveWidgets: 'moduleContentsTree queryTree middleSplitter' 					#belowWidgets: 'editedStatement' ) 				#(#{UI.ResizingSplitterSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0.5 0 0 5 0.5 -105 1 ) 					#name: #middleSplitter 					#flags: 8 					#horizontal: false 					#minAboveSize: 30 					#minBelowSize: 30 					#aboveWidgets: 'moduleContentsTree filterField' 					#belowWidgets: 'queryTree' ) 				#(#{UI.InputFieldSpec} 					#layout: #(#{Graphics.LayoutFrame} 0 0 0 0 0 0.5 23 0 ) 					#name: #filterField 					#model: #filterField 					#helpText: 'Not implemented. This is going to be an area to search and filter in the module.' 					#menu: #filterMenu ) ) ) )</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI class</class-id> <category>class initialization</category>

<body package="Faish-UserInterface" selector="initialize">initialize	RetainModuleStatement := (FaishModule new) parse: 'module:thisModule metadata:(retainQuery:X).'.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI class</class-id> <category>resources</category>

<body package="Faish-UserInterface" selector="moduleMenu">moduleMenu	"Tools.MenuEditor new openOnClass: self andSelector: #moduleMenu"	&lt;resource: #menu&gt;	^#(#{UI.Menu} #(			#(#{UI.MenuItem} 				#rawLabel: 'Only show similar...' 				#value: #statementAsFilterAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Show errors...' 				#value: #actionShowErrors ) 			#(#{UI.MenuItem} 				#rawLabel: 'Export statement...' ) 			#(#{UI.MenuItem} 				#rawLabel: 'Examine statement...' 				#value: #actionExamineStatement ) 			#(#{UI.MenuItem} 				#rawLabel: 'Cut' 				#value: #actionCutStatement ) 			#(#{UI.MenuItem} 				#rawLabel: 'Copy' 				#value: #actionCopyStatement ) 			#(#{UI.MenuItem} 				#rawLabel: 'Paste' 				#value: #actionPasteStatement ) 			#(#{UI.MenuItem} 				#rawLabel: 'Delete...' 				#value: #actionDeleteStatement ) ) #(4 3 1 ) nil ) decodeAsLiteralArray</body>

<body package="Faish-UserInterface" selector="mainMenu">mainMenu	"Tools.MenuEditor new openOnClass: self andSelector: #mainMenu"	&lt;resource: #menu&gt;	^#(#{UI.Menu} #(			#(#{UI.MenuItem} 				#rawLabel: 'Module' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'Commit changes' 							#value: #actionCommitChanges 							#shortcutKeyCharacter: $s 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Reload imports' 							#value: #actionReloadImports ) 						#(#{UI.MenuItem} 							#rawLabel: 'Show errors...' 							#value: #actionShowErrors ) 						#(#{UI.MenuItem} 							#rawLabel: 'Export to file...' 							#value: #exportToFileAction ) 						#(#{UI.MenuItem} 							#rawLabel: 'Run tests...' 							#value: #actionRunTests 							#shortcutKeyCharacter: $t 							#shortcutModifiers: 2 ) ) #(5 ) nil ) ) 			#(#{UI.MenuItem} 				#rawLabel: 'Edit' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'New statement' 							#value: #actionNewStatement 							#shortcutKeyCharacter: $n 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Delete statement' 							#value: #actionDeleteStatement 							#shortcutKeyCharacter: $d 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Add module import...' 							#value: #actionAddModuleImport 							#shortcutKeyCharacter: $i 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Focus on filter field' 							#value: #actionFocusOnFilter 							#shortcutKeyCharacter: $q 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Focus on statements' 							#value: #actionFocusOnStatements 							#shortcutKeyCharacter: $w 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Focus on queries' 							#value: #actionFocusOnQueries 							#shortcutKeyCharacter: $r 							#shortcutModifiers: 2 ) 						#(#{UI.MenuItem} 							#rawLabel: 'Focus on edited statement' 							#value: #actionFocusOnEditedStatement 							#shortcutKeyCharacter: $e 							#shortcutModifiers: 2 ) ) #(2 1 4 ) nil ) ) 			#(#{UI.MenuItem} 				#rawLabel: 'Execute' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'Open command line...' 							#value: #actionOpenCLI ) 						#(#{UI.MenuItem} 							#rawLabel: 'Open canvas...' 							#value: #actionOpenCanvas ) 						#(#{UI.MenuItem} 							#rawLabel: 'Open fish...' 							#value: #actionOpenFish ) ) #(3 ) nil ) ) 			#(#{UI.MenuItem} 				#rawLabel: 'Help' 				#submenu: #(#{UI.Menu} #(						#(#{UI.MenuItem} 							#rawLabel: 'Syntax help' 							#value: #helpSyntaxAction 							#shortcutKeyCharacter: #F1 							#shortcutModifiers: 0 ) ) #(1 ) nil ) ) ) #(4 ) nil ) decodeAsLiteralArray</body>

<body package="Faish-UserInterface" selector="queryMenu">queryMenu	"Tools.MenuEditor new openOnClass: self andSelector: #queryMenu"	&lt;resource: #menu&gt;	^#(#{UI.Menu} #(			#(#{UI.MenuItem} 				#rawLabel: 'Run again' 				#value: #queryRerunAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Persevere with this query...' 				#value: #queryPersevereAction 				#helpText: 'Open this query in another window for further execution.' ) 			#(#{UI.MenuItem} 				#rawLabel: 'Halt execution' 				#value: #queryHaltAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Run all tests' 				#value: #actionRunTests ) 			#(#{UI.MenuItem} 				#rawLabel: 'Show deduction' 				#value: #queryShowDeductionAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Retain this query' 				#value: #queryRetainAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Add as test...' 				#value: #actionAddAsTest ) 			#(#{UI.MenuItem} 				#rawLabel: 'Clear this query' 				#value: #queryDeleteAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Clear all queries' 				#value: #queryDeleteAllAction ) ) #(3 1 1 4 ) nil ) decodeAsLiteralArray</body>

<body package="Faish-UserInterface" selector="filterMenu">filterMenu	"Tools.MenuEditor new openOnClass: self andSelector: #filterMenu"	&lt;resource: #menu&gt;	^#(#{UI.Menu} #(			#(#{UI.MenuItem} 				#rawLabel: 'Clear filter' 				#value: #filterClearAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Cut' 				#value: #filterCutAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Copy' 				#value: #filterCopyAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Paste' 				#value: #filterPasteAction ) 			#(#{UI.MenuItem} 				#rawLabel: 'Filter help...' 				#value: #filterHelpAction 				#shortcutKeyCharacter: #F1 				#shortcutModifiers: 0 ) ) #(1 3 1 ) nil ) decodeAsLiteralArray</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI class</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="module:">module: someModule 		^ self new module: someModule.</body>
</methods>


<methods>
<class-id>Faish.FaishModuleUI</class-id> <category>Statement tree</category>

<body package="Faish-UserInterface" selector="moduleContentsTree">moduleContentsTree	^ selectionInModuleContentsTree</body>

<body package="Faish-UserInterface" selector="selectedStatement">selectedStatement	selectionInModuleContentsTree selection isNil ifTrue: [ ^ self ].	 (selectionInModuleContentsTree selection isStatementNode) ifTrue: [		^ selectionInModuleContentsTree selection target.	] ifFalse: [		self selectNoStatement.	].	^ nil.</body>

<body package="Faish-UserInterface" selector="isStatementNode">isStatementNode 	^ false.</body>

<body package="Faish-UserInterface" selector="selectedStatementChanged">selectedStatementChanged	| statement |	selectionType := #statement.	ignoreCallbacks ifFalse: [		selectionInModuleContentsTree selection isNil ifTrue: [ ^ self selectNoStatement ].		selectionInModuleContentsTree selection isStatementNode ifFalse: [ ^ self selectNoStatement ].				statement := selectionInModuleContentsTree selection target.		statement isNil ifTrue: [ 			self setEditedStatement: ''.			^ self.		].		(statement isSyntaxError) ifTrue: [ 			| source position wrapper |			source := (statement at: #source) value.			(source isKindOf: String) ifFalse: [ 				self setEditedStatement: (selectionInModuleContentsTree selection sourceString)			].			position := (statement at: #position) value.			(position isKindOf: Integer) ifFalse: [ position := 0 ].			self setEditedStatement: source asString.						wrapper := self wrapperAt: #editedStatement.			( ( position &gt; 0 ) and: [ position &lt;= source size ] ) ifTrue: [ 				wrapper takeKeyboardFocus.				wrapper widget controller selectAt: position+1.			].		] ifFalse: [			self setEditedStatement: (selectionInModuleContentsTree selection sourceString) ].		].</body>

<body package="Faish-UserInterface" selector="children">children	" Needs refactoring: don't return all statements!!! There might be millions of them. "	| result i |	result := OrderedCollection new.	i := 1. " The root node is the first node, so we start on node 2. "	module statements do: [ :each |		result add: (FaishStatementNode on: each).		( i = newStatementIndex) ifTrue: [ 			result add: FaishStatementNewNode new.		].		i := i + 1.	].	^ result.</body>

<body package="Faish-UserInterface" selector="postOpenWith:">postOpenWith: aBuilder	| treeWidget |	" Automatically expand the tree one level. "	treeWidget := self widgetAt: #moduleContentsTree.	treeWidget selectionIndex: 1.	treeWidget controller expand.</body>

<body package="Faish-UserInterface" selector="selectedStatementIndex">selectedStatementIndex	" There is a 'new statement' node in there as well. We need to account for that when working out the index of the selected statement. "	| currentIndex |	(selectionInModuleContentsTree selectionIndex = 0) ifTrue: [ ^ nil ]. " Nothing is selected. "	currentIndex := selectionInModuleContentsTree selectionIndex - 1. " Minus one because the root counts as one. "	(currentIndex = 0) ifTrue: [ ^ nil ]. " Root node is selected. "	newStatementIndex isNil ifTrue: [ ^ currentIndex ].	(currentIndex &lt;= newStatementIndex ) ifTrue: [ ^ currentIndex ].	^ currentIndex - 1.</body>

<body package="Faish-UserInterface" selector="sourceString">sourceString	^ nil.</body>

<body package="Faish-UserInterface" selector="icon">icon	^ nil.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI</class-id> <category>accessing</category>

<body package="Faish-UserInterface" selector="editString">editString	^ nil.</body>

<body package="Faish-UserInterface" selector="moduleName">moduleName	| name |	name := module name.	^ name isNil ifTrue: [ 'Unnamed module'] ifFalse: [ name ].</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI</class-id> <category>Filter</category>

<body package="Faish-UserInterface" selector="filterField:">filterField: value	filterField value: value.</body>

<body package="Faish-UserInterface" selector="filterField">filterField	^ filterField.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI</class-id> <category>Query tree</category>

<body package="Faish-UserInterface" selector="selectedQueryNode">selectedQueryNode	| candidate | 	candidate := queryTree selection.	candidate isNil ifTrue: [ ^ nil ].	candidate isQueryNode ifTrue: [ ^ candidate ].	^ nil.</body>

<body package="Faish-UserInterface" selector="queryTree">queryTree	^ queryTree.</body>

<body package="Faish-UserInterface" selector="selectedQueryChanged">selectedQueryChanged	selectionType := #query.	ignoreCallbacks ifFalse: [		queryTree selection isNil ifTrue: [ ^ self ].		self setEditedStatement: (queryTree selection editString)	].</body>

<body package="Faish-UserInterface" selector="scrollQueryTreeToBottom">scrollQueryTreeToBottom	(self widgetAt: #queryTree) makeVisible: (queryTree list  size + 1).</body>

<body package="Faish-UserInterface" selector="selectedQuery">selectedQuery	| candidate | 	candidate := queryTree selection.	candidate isQueryNode ifTrue: [ ^ candidate target ].	^ nil.</body>

<body package="Faish-UserInterface" selector="hasQueries">hasQueries	^ queryResults children isEmpty not.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI</class-id> <category>actions</category>

<body package="Faish-UserInterface" selector="actionFocusOnStatements">actionFocusOnStatements	| statements |		" Avoid a debugger popping up if the user touches the cursor keys with no selection. This appears to be a VW bug. "	selectionInModuleContentsTree selection isNil ifTrue: [ 		selectionInModuleContentsTree selectionIndex: 1.	].	statements := self widgetAt: #moduleContentsTree.	self mainWindow keyboardProcessor requestActivationFor: (statements controller).	statements flash.</body>

<body package="Faish-UserInterface" selector="queryPersevereAction">queryPersevereAction	| q type qn |	self selectedQueryNode isNil ifTrue: [ ^ self ].	qn := self selectedQueryNode.	q := QueryPersevereDialog new.	q open.		type := q searchLimitType value.	(type = #numberOfSeconds) ifTrue: [ 		| numSeconds |		numSeconds := q numberOfSeconds value.		qn stepLimit: nil. " Cancel the preset value. "		qn timeLimit: numSeconds.		qn continue.		^ self.	].	(type = #numberOfSteps) ifTrue: [		| numSteps |		numSteps := q numberOfSteps value.		qn stepLimit: numSteps.		qn continue.		^ self.	 ].	(type = #searchDepth) ifTrue: [ 		| d |		d := q searchDepth value.		qn depthLimit: d.		qn stepLimit: nil. " Cancel the preset value. "		qn continue.		^ self. 	].</body>

<body package="Faish-UserInterface" selector="actionAddAsTest">actionAddAsTest	| s |	self selectedQuery isNil ifTrue: [ Dialog warn: 'Select a query for this.'. ^self ].	s := self selectedQuery editString allButLast: 1. " Remove the '?'"	module addStatement: ('test:(', s, ').').	selectionInModuleContentsTree list refreshRoot.</body>

<body package="Faish-UserInterface" selector="executeQueryAction">executeQueryAction	(self widgetAt: #editedStatement) controller accept.	self exec: (self editedStatement value).	editedStatementOrig := self editedStatement value copy.</body>

<body package="Faish-UserInterface" selector="statementCopyAction">statementCopyAction	Dialog warn: 'TODO'.</body>

<body package="Faish-UserInterface" selector="actionOpenFish">actionOpenFish	| openMe |	openMe := FaishFishCanvasUI new.	openMe module: module.	openMe open.	^ self.</body>

<body package="Faish-UserInterface" selector="actionOpenCLI">actionOpenCLI	FaishCommandLineUI new module: module; open.</body>

<body package="Faish-UserInterface" selector="actionOpenCanvas">actionOpenCanvas	| openMe |	openMe := FaishCanvasUI new.	openMe module: module.	openMe open.	^ self.</body>

<body package="Faish-UserInterface" selector="actionFocusOnEditedStatement">actionFocusOnEditedStatement	| editWidget |	editWidget := self widgetAt: #editedStatement.	editWidget isEnabled ifFalse: [		self setEditedStatement: ''.	].	self mainWindow keyboardProcessor requestActivationFor: ((self widgetAt: #editedStatement) controller).	editWidget flash.</body>

<body package="Faish-UserInterface" selector="queryDeleteAllAction">queryDeleteAllAction	queryResults initialize.	self initializeQueryTreeFromModuleMetadata.	queryTree list refreshRoot.</body>

<body package="Faish-UserInterface" selector="executeQuerySimplyAction">executeQuerySimplyAction	(self widgetAt: #editedStatement) controller accept.	self execQuerySimply: (self editedStatement value).	editedStatementOrig := self editedStatement value copy.</body>

<body package="Faish-UserInterface" selector="statementCutAction">statementCutAction	Dialog warn: 'TODO'.</body>

<body package="Faish-UserInterface" selector="queryRerunAction">queryRerunAction	(self selectedQueryNode isNil not) ifTrue: [		self addQuery: (self selectedQuery) ].</body>

<body package="Faish-UserInterface" selector="queryRetainAction">queryRetainAction	| r v |	" The query needs to be retained as a string because variables will prevent us finding that retained query's definition. "	(self selectedQueryNode isNil not) ifTrue: [		r := RetainModuleStatement copy. 		v := FaishLiteral value: (self selectedQueryNode query).		(r at: #metadata) at: #retainQuery put: v.		r at: #module put: ( FaishLiteral value: (ModuleImport new module: module; name: module name )).		module add: r.		module changed.		selectionInModuleContentsTree list refreshRoot.	].</body>

<body package="Faish-UserInterface" selector="actionCommitChanges">actionCommitChanges	ObjectMemory snapshot.</body>

<body package="Faish-UserInterface" selector="actionAddModuleImport">actionAddModuleImport	FaishImportUI new 		showImportedModules: true;		callbackTo: self; 		title: 'Add Import'; 		open.</body>

<body package="Faish-UserInterface" selector="actionNewStatement">actionNewStatement	| numStatements |	self handleReadOnly ifTrue: [ ^ self ].	numStatements := module statements size.	newStatementIndex := (self selectedStatementIndex).	newStatementIndex isNil ifTrue: [ 		newStatementIndex := numStatements 	] ifFalse: [ 		newStatementIndex := newStatementIndex min: numStatements	].	selectionInModuleContentsTree list refreshRoot.	selectionInModuleContentsTree selectionIndex: newStatementIndex + 2. " +1 for root node, +1 because it occurs after the index. "	self mainWindow keyboardProcessor requestActivationFor: ((self widgetAt: #editedStatement) controller).	(self widgetAt: #editedStatement) controller selectEntireText.</body>

<body package="Faish-UserInterface" selector="exportToFileAction">exportToFileAction	FaishModuleListUI exportModuleToFile: module.</body>

<body package="Faish-UserInterface" selector="actionRunTests">actionRunTests	queryResults initialize. 	module allTestsDo: [ :each | 		self addQuery: each.	].</body>

<body package="Faish-UserInterface" selector="helpSyntaxAction">helpSyntaxAction	ExternalWebBrowser open: 'http://www.squl.org/documentation/'.	"VWHelp.HelpBrowser openOnBook: 'VisualWorks Tools' topic: 'Inspector'."</body>

<body package="Faish-UserInterface" selector="queryDeleteAction">queryDeleteAction	(self selectedQueryNode isNil not) ifTrue: [		queryResults remove: (self selectedQueryNode).		queryTree list refreshRoot.	].</body>

<body package="Faish-UserInterface" selector="actionFocusOnFilter">actionFocusOnFilter	self mainWindow keyboardProcessor requestActivationFor: ((self widgetAt: #filterField) controller).	(self widgetAt: #filterField) flash.</body>

<body package="Faish-UserInterface" selector="statementAsFilterAction">statementAsFilterAction	Dialog warn: 'TODO'.</body>

<body package="Faish-UserInterface" selector="statementPasteAction">statementPasteAction	Dialog warn: 'TODO'.</body>

<body package="Faish-UserInterface" selector="filterClearAction">filterClearAction	filterField value: '*'.</body>

<body package="Faish-UserInterface" selector="actionReloadImports">actionReloadImports	module clearErrors.	module reloadImports.	self actionShowErrors.</body>

<body package="Faish-UserInterface" selector="queryHaltAction">queryHaltAction	(self selectedQueryNode isNil not) ifTrue: [		self selectedQueryNode stop ].</body>

<body package="Faish-UserInterface" selector="actionDeleteStatement">actionDeleteStatement	| result |	self selectedStatement isNil ifTrue: [ ^ self ].	result := Dialog		choose: 'Really delete?'		labels: (Array with: 'Cancel' with: 'Delete')		values: #(#cancel #delete)		default: #delete.	(result = #delete) ifTrue: [		module remove: (self selectedStatement).		selectionInModuleContentsTree list refreshRoot.		selectionInModuleContentsTree selection: nil.		self actionFocusOnStatements.	]</body>

<body package="Faish-UserInterface" selector="actionFocusOnQueries">actionFocusOnQueries	| queries |	queries := self widgetAt: #queryTree.	self mainWindow keyboardProcessor requestActivationFor: (queries controller).	queries flash.</body>

<body package="Faish-UserInterface" selector="actionShowErrors">actionShowErrors	| s |	module errors isEmpty ifTrue: [ ^ self ].		s := WriteStream on: (String new: 80).	s nextPutAll: 'Errors in this module: '; cr.	module errors do: [ :each |		s nextPutAll: each.		s cr.	].	Dialog warn: (s contents).</body>

<body package="Faish-UserInterface" selector="actionExamineStatement">actionExamineStatement	| s |	s := self selectedStatement.	s isNil ifTrue: [ ^ self ].	s inspect.</body>

<body package="Faish-UserInterface" selector="queryShowDeductionAction">queryShowDeductionAction	| searchable query |		(self selectedQueryNode) isNil not ifTrue: [		query := self selectedQuery.		searchable := ImportListSearchable module: module searchingFor: query.		FaishDeductionBrowser openOn: searchable.	].</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI</class-id> <category>dialog callbacks</category>

<body package="Faish-UserInterface" selector="callbackAddImport:">callbackAddImport: aModuleToImport	| addedRule |	addedRule := module addImport: aModuleToImport.	addedRule isNil ifTrue: [ 		Dialog warn: 'That module has already been imported here.'.		^ self.	].	selectionInModuleContentsTree list refreshRoot.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI</class-id> <category>initialize-release</category>

<body package="Faish-UserInterface" selector="module:">module: aModule	module := aModule.	self initializeQueryTreeFromModuleMetadata</body>

<body package="Faish-UserInterface" selector="initialize">initialize	module := CodeModule new.	newStatementIndex := nil.	watchingQueries := false.		ignoreCallbacks := false.	selectionInModuleContentsTree := SelectionInTree new.	selectionInModuleContentsTree list: (TreeModel on: self).	filterField := ValueHolder newString.	filterField value: '*'.	self initializeQueryTree.	self initializeStatementHolder.</body>

<body package="Faish-UserInterface" selector="initializeQueryTree">initializeQueryTree	queryTree := SelectionInTree new.	queryResults := QueryTreeRoot new.	queryTree list: (TreeModel on: queryResults).	queryTree tree expandToLevel: 1.</body>

<body package="Faish-UserInterface" selector="initializeQueryTreeFromModuleMetadata">initializeQueryTreeFromModuleMetadata 	module 		withQuerySimply: 'module:M metadata:(retainQuery:Query)?'		do: [ :each |  | statement |			statement := ((each at: #metadata) at:#retainQuery) value.			( statement isNil not and: [ statement isStatement ] ) ifTrue: [				self addQueryStringWithoutRunning: statement printQueryString.			].		]		ifNoResults: [ ^ self ]		limitTo: 50.	queryTree list refreshRoot.</body>

<body package="Faish-UserInterface" selector="postBuildWith:">postBuildWith: aBuilder	| ctrlr |	self widget: #moduleContentsTree when: #selectionChanged send: #selectedStatementChanged to: self.	self widget: #queryTree when: #selectionChanged send: #selectedQueryChanged to: self.	ctrlr := (aBuilder componentAt: #editedStatement) widget controller.	ctrlr keyboardHook: [ :ev :c | 			self keyPress: ev].	ctrlr autoAccept: true.	self selectedStatementChanged.		module errors isEmpty ifFalse: [ self actionShowErrors ].</body>

<body package="Faish-UserInterface" selector="initializeStatementHolder">initializeStatementHolder	editedStatementHolder := ValueHolder new.	editedStatementHolder value: String new.	editedStatementOrig := String new.</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI</class-id> <category>printing</category>

<body package="Faish-UserInterface" selector="displayString">displayString	^ module name</body>
</methods>

<methods>
<class-id>Faish.FaishModuleUI</class-id> <category>Statement editing</category>

<body package="Faish-UserInterface" selector="keyPress:">keyPress: ev	| char |	char := ev keyValue.	((char = Character cr or: [ char = Character lf ]) and: [ev hasCtrl]) ifTrue: [ 		(ev hasShift)			ifTrue: [ self executeQuerySimplyAction. ^ nil ]			ifFalse: [ self executeQueryAction. ^ nil ] ].				^ ev.</body>

<body package="Faish-UserInterface" selector="addQueryString:">addQueryString: queryString	| query |	query := module parse: queryString onError: [ :e :i | ^ Dialog warn: e ].	self addQuery: query.</body>

<body package="Faish-UserInterface" selector="exec:">exec: statement	(statement trimSeparators endsWith: '?')		ifTrue: [ self addQueryString: statement ]		ifFalse: [ self addRuleString: statement ].	(self widgetAt: #editedStatement) controller selectEntireText.</body>

<body package="Faish-UserInterface" selector="selectNoStatement">selectNoStatement	editedStatementHolder value: 'Press CTRL+n to create a new statement. Press CTRL+e to enter a query.'.	(self widgetAt: #editedStatement) isEnabled: false.</body>

<body package="Faish-UserInterface" selector="ruleAlreadyExists:">ruleAlreadyExists: statement	" From addRule:, work out what the user wants to do with a rule that's already there. "	| answer |	answer := Dialog		choose: 'Rule already exists in this module'		labels: (Array with: 'Cancel' with: 'Go to it' with: 'Replace it')		values: #(#cancel #goto #replace)		default: #replace.		"for: self."			(answer = #goto) ifTrue: [		newStatementIndex := nil.		ignoreCallbacks := true.		selectionInModuleContentsTree selectionIndex: (module find: statement)+1.		ignoreCallbacks := false.		^ self.	].	(answer = #replace) ifTrue: [ | pos |		" The statement is the same, but we move it, and we update it's source code formatting "		" Things will move after we remove the statement. Thus: "		pos := selectionInModuleContentsTree selectionIndex - 1.		module remove: statement.		module insert: statement before: pos. 		newStatementIndex := nil.		selectionInModuleContentsTree list refreshRoot.		^ self.	].</body>

<body package="Faish-UserInterface" selector="addQuery:">addQuery: query	| queryNode |	(query isKindOf: FaishStatement) ifFalse: [ self halt ].	queryNode := QueryNode 		onQuery: query 		module: module		selectionInTreeToUpdate: queryTree.	queryNode start.	queryResults addQuery: queryNode.	queryTree list refreshRoot.	self scrollQueryTreeToBottom.</body>

<body package="Faish-UserInterface" selector="handleReadOnly">handleReadOnly	" If the module is read-only, tell the user about it. "	module isReadOnly ifTrue: [ 		Dialog warn: 'This module is read-only.'.		^ true.	].	^ false.</body>

<body package="Faish-UserInterface" selector="execQuerySimply:">execQuerySimply: statement	self addQuerySimply: statement.		(self widgetAt: #editedStatement) controller selectEntireText.</body>

<body package="Faish-UserInterface" selector="setEditedStatement:">setEditedStatement: aString	| editWidget |	editWidget := self widgetAt: #editedStatement.	editWidget isEnabled ifTrue: [		self isStatementChanged ifTrue: [		( Dialog			choose: 'Keep changes?'			labels: (Array with: 'Discard' with: 'Keep')			values: #(#discard #keep)			default: #keep		) = #keep			ifTrue: [ ^ self ]			ifFalse: [ 				newStatementIndex := nil.				selectionInModuleContentsTree list refreshRoot.			].		].	] ifFalse: [		editWidget isEnabled: true.	].	editedStatementHolder value: aString.	editedStatementOrig := aString copy.</body>

<body package="Faish-UserInterface" selector="addRuleString:">addRuleString: statementString	| ruleAdded statement errorStatement |	statement := module parse: statementString onError: [ :errorString :i | 		Dialog warn: errorString. 		" TODO: set the cursor position to i here. "		errorStatement :=  CodeModule syntaxErrorStatement: statementString position: i message:errorString.		^ self addRuleString: errorStatement.	 ].	self handleReadOnly ifTrue: [ ^ self ].	" Handle funny cases, such as before anything is selected or when a user edits a query into a statement. "	(selectionInModuleContentsTree selection isNil or: [selectionType ~= #statement]) ifTrue: [		(Dialog confirm: 'Add this as a new statement?') ifTrue: [				newStatementIndex isNil ifTrue: [ 				ruleAdded := module add: statement. 			] ifFalse: [				ruleAdded := module insert: statement before: (newStatementIndex + 1). 			].			ruleAdded isNil ifTrue: [ 				self ruleAlreadyExists: statement.			] ifFalse: [				selectionInModuleContentsTree list refreshRoot.			].			ignoreCallbacks := true.			selectionInModuleContentsTree selectionIndex: (module find: statement)+1.			ignoreCallbacks := false.					].		^ self.	].	selectionInModuleContentsTree selection isNew	ifTrue: [		ruleAdded := module insert: statement before: (newStatementIndex + 1). 		ruleAdded isNil ifTrue: [			^ self ruleAlreadyExists: statement.		].		selectionInModuleContentsTree list refreshRoot.		ignoreCallbacks := true.		selectionInModuleContentsTree selectionIndex: newStatementIndex+2.		newStatementIndex := nil.		selectionInModuleContentsTree list refreshRoot.		ignoreCallbacks := false.	] ifFalse: [		| choice |		choice := Dialog			choose: 'Replace statement?'			labels: (Array with: 'Cancel' with: 'New statement' with: 'Replace statement')			values: #(#cancel #new #replace)			default: #replace.		(choice = #new) ifTrue: [			ruleAdded := module add: statement.			ruleAdded isNil ifTrue: [ self ruleAlreadyExists: statement. ^ self. ].		] ifFalse: [			( choice = #cancel ) ifTrue: [				^ self.			] ifFalse: [				ruleAdded := module replace: (selectionInModuleContentsTree selection target) with: statement.				ruleAdded isNil ifTrue: [ self ruleAlreadyExists: statement ].				newStatementIndex := nil.			].		].			selectionInModuleContentsTree list refreshRoot.		ignoreCallbacks := true.		selectionInModuleContentsTree selectionIndex: (module find: statement)+1.		ignoreCallbacks := false.	].</body>

<body package="Faish-UserInterface" selector="addQueryStringWithoutRunning:">addQueryStringWithoutRunning: queryString	| queryNode |	queryNode := QueryNode 		on: queryString 		module: module		selectionInTreeToUpdate: queryTree.	queryResults addQuery: queryNode.	queryTree list refreshRoot.</body>

<body package="Faish-UserInterface" selector="editedStatement">editedStatement	^ editedStatementHolder.</body>

<body package="Faish-UserInterface" selector="isStatementChanged">isStatementChanged	^ (editedStatementOrig = editedStatementHolder value) not.</body>

<body package="Faish-UserInterface" selector="addQuerySimply:">addQuerySimply: queryString	| queryNode |	queryNode := QueryNode 		on: queryString 		module: module		selectionInTreeToUpdate: queryTree.	queryResults addQuery: queryNode.	queryNode startSimply.</body>
</methods>



<initialize>
<class-id>Faish.FaishModuleKeeper</class-id>
</initialize>

<initialize>
<class-id>FaishRepositoriesHolder</class-id>
</initialize>

<initialize>
<class-id>Faish.FaishFishCanvasUI</class-id>
</initialize>

<initialize>
<class-id>Faish.FaishModuleUI</class-id>
</initialize>

</st-source>
