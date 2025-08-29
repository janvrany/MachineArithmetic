Class {
	#name : #SemTheory,
	#superclass : #SMTSem,
	#category : #'Refinements-Theories'
}

{ #category : #yoneda }
SemTheory class >> apply: f to: args ofZ3sorts: argSorts returning: retSort [
	self assert: ((args zip: argSorts) allSatisfy: [ :arg_argSort | arg_argSort key sort = arg_argSort value ]).
	
	^ retSort cast: (f value: args value: retSort).

]
