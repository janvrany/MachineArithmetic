Class {
	#name : #RefVarApp,
	#superclass : #HPred,
	#instVars : [
		'var',
		'args'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
RefVarApp class >> var: varName args: argArray [
	^self basicNew 
		var: varName;
		args: argArray;
		yourself 
	
]

{ #category : #comparing }
RefVarApp >> = another [
	self class = another class ifFalse: [ ^false ].
	^(var = another var) and: [ args = another args ]
]

{ #category : #accessing }
RefVarApp >> args [
	^ args
]

{ #category : #accessing }
RefVarApp >> args: anObject [
	args := anObject
]

{ #category : #accessing }
RefVarApp >> arity [
	^ self args size
]

{ #category : #'as yet unclassified' }
RefVarApp >> findKVarInGuard: k [ 
	k = var
		ifTrue: [ ^Either left: { k -> args. } -> #() ]
		ifFalse: [ ^Either right: self ]
]

{ #category : #comparing }
RefVarApp >> hash [
	^var hash
]

{ #category : #'as yet unclassified' }
RefVarApp >> isTauto [
	^false
]

{ #category : #'as yet unclassified' }
RefVarApp >> kvApp: ys in: kvEnv [
	| kv substs |
	kv := kvEnv at: var.
	substs := Dictionary newFromKeys: args andValues: kv kvParams.
	^DelayedSubst subst: substs in: self
]

{ #category : #logic }
RefVarApp >> pKVars [ 
	^ Set with: self var
]

{ #category : #'as yet unclassified' }
RefVarApp >> predExpr: kvEnv [
	"the most interesting case really, cf. Info.hs:104, predExpr go (H.Var k ys)"
	^self kvApp: self args in: kvEnv

]

{ #category : #printing }
RefVarApp >> printOn: aStream [
	aStream nextPut: $(.
	aStream nextPutAll: self var.
	self args do: [ :anArg |
		aStream nextPut: $ .
		aStream nextPutAll: anArg ].
	aStream nextPut: $).

]

{ #category : #'as yet unclassified' }
RefVarApp >> rename: a to: b [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
RefVarApp >> rename: a to: b renamer: α [
	^RefVarApp
		var: var
		args: (args collect: [ :arg | 
			arg isString ifFalse: [ self error ].
			arg=a ifTrue: [b] ifFalse: [arg] ])
]

{ #category : #'as yet unclassified' }
RefVarApp >> subst1: new for: old [
	self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
RefVarApp >> uniq1: α [
	^self
]

{ #category : #accessing }
RefVarApp >> var [
	^ var
]

{ #category : #accessing }
RefVarApp >> var: anObject [
	var := anObject
]

{ #category : #'well-formedness' }
RefVarApp >> wfIn: gamma [
	^false
]