Extension { #name : #Equation }

{ #category : #'*PLE' }
Equation >> normalize [
"
instance Normalizable Equation where
  normalize eq = eq {eqArgs = zip xs' ss, eqBody = normalizeBody (eqName eq) $ subst su $ eqBody eq }
    where
      su      = mkSubst $ zipWith (\x y -> (x,EVar y)) xs xs'
      (xs,ss) = unzip (eqArgs eq)
      xs'     = zipWith mkSymbol xs [0..]
      mkSymbol x i = x `suffixSymbol` intSymbol (eqName eq) i
"
	| xs ss xs′ body′ |
	xs := eqArgs unzipAssociations first.
	ss := eqArgs unzipAssociations last.
	xs′ := xs zip: (0 to: xs size-1) with: [ :x :i |
		"mkSymbol"
		x suffixSymbol: (eqName intSymbol: i) ].
	"BOGUS!!!  self shouldBeImplemented" "su, normalizeBody....".
	body′ := 
	ECon prim: (PInt integer: 42)
	"for ple0: EBin
		bop: #+
		left: (EVar of: 'xººadderºº0')
		right: (EVar of: 'yººadderºº1')".
	^self copy
		eqArgs: (xs′ zip: ss);
		eqBody: body′;
		yourself
]

{ #category : #'*PLE' }
Equation >> substEqCoerce: env es: es [
"
substEqCoerce :: SEnv Sort -> Equation -> [Expr] -> Expr
                   env        eq=self       es
"
	| ts |
	ts := eqArgs collect: #value.
	"BOGUS, just example"
	^ECon prim: (PInt integer: 42)
]