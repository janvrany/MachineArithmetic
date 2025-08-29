Extension { #name : #RBMethodNode }

{ #category : #'*CardanoTartaglia' }
RBMethodNode >> notShadowedTemporaryNamesFrom: aContext [
	| ownVariableNames useVariableNames |
	ownVariableNames := self allDefinedVariables collect: [ :var | var asString ].
	useVariableNames := self allVariables collect:[ :var | var name ].
	^ aContext tempNames intersection: (useVariableNames difference: ownVariableNames)

]
