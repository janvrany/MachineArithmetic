Class {
	#name : #BindEnv,
	#superclass : #Object,
	#instVars : [
		'indexDict'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
BindEnv class >> empty [
	^self new
]

{ #category : #'as yet unclassified' }
BindEnv >> copyDictFrom: aBindEnv [ 
	indexDict := aBindEnv indexDict copy
]

{ #category : #'as yet unclassified' }
BindEnv >> ctContext [
	| ctx |
	ctx := CardanoTartagliaContext new.
	self indexDict do: [ :ass |
		| v sort |
		v := ass key.
		sort := ass value sr_sort.
		ctx tempNamed: v put: (sort mkConst: v) ].
	^ctx
]

{ #category : #'as yet unclassified' }
BindEnv >> evaluate: aString [ 
	| compiler |
	compiler := self class compiler class new.
	compiler context: self ctContext.
	^compiler evaluate: aString
]

{ #category : #GT }
BindEnv >> gtInspectorBindsIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite fastTable
		title: 'Binds';
		display: [ self indexDict associations ];
			column: 'Index' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Bind' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ]
]

{ #category : #accessing }
BindEnv >> indexDict [
	indexDict isNil ifTrue: [indexDict := Dictionary new].
	^ indexDict
]

{ #category : #'as yet unclassified' }
BindEnv >> insertVar: name sort: s [
	"Instantiate a new BindEnv which is a copy of the receiver grown by
	the association, name->TrueRefinement, at the next index, j.
	Answer the association, j->grownBindEnv."
	| j new |
	j := self indexDict size.
	new := BindEnv new. "horrible :-("
	new copyDictFrom: self.
	new indexDict
		at: j
		put: name -> s trueSortedReft.
	^new -> j
]

{ #category : #'as yet unclassified' }
BindEnv >> sortOf: varName [
	^((Dictionary newFromAssociations: self indexDict values) at: varName) sr_sort
]

{ #category : #'as yet unclassified' }
BindEnv >> subcKVars: c [
	^(self envKVars: c), c rhsKVars
]

{ #category : #'as yet unclassified' }
BindEnv >> toList [
	"Answer a collection each element of which is of the form {BindId.Symbol.SortedReft.}"
	^indexDict associations collect: [ :ass | { ass key. ass value key. ass value value. } ]
]

{ #category : #'as yet unclassified' }
BindEnv >> variableNamed: v [
	^(self sortOf: v) mkConst: v
]