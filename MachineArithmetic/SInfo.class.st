Class {
	#name : #SInfo,
	#superclass : #HornInfo,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #logic }
SInfo >> kVars [
	^ws keys asSet
]

{ #category : #logic }
SInfo >> solve [
	| fi si wkl s0 ks act |
	
	fi := self.
	si := SolverInfo basicNew initializeFrom: fi.
	
	wkl := si initWorklist.
	s0 := si sol.
	ks := si vars.
	act := [ :solverState | solverState solve_: self s0: s0 ks: ks wkl: wkl ].
	^si runSolverM: act
]

{ #category : #logic }
SInfo >> solverInfo [
	^SolverInfo from: self
]

{ #category : #logic }
SInfo >> symbolEnv [
	"Answer a SymEnv"
	"cf. Sanitize.hs"
	^SymEnv new "IMPLEMENT NOW!" 
]