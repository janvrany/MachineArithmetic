Class {
	#name : #SpriteDataPosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpriteDataPosTest >> test_A_is_A [
	self processString: '
type a_or_b =
  | A (bool)
  | B (int)
  ;

⟦val is_a : a_or_b => bool[b|b]⟧
let is_a = (x) => {
	let a = A(false)
  switch(a){
    | A(i) => true
    | B(j) => false
  }
};
'
]

{ #category : #tests }
SpriteDataPosTest >> test_VoidIsTerminal [
	self processString: '
type void =
  | Nil
  ;

⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val main : void => void => int⟧
let main = (x, y) => {
  let ok = x == y;
  cassert(ok)
};
'
]

{ #category : #tests }
SpriteDataPosTest >> test_data_with_bv_01 [
	self processString: '
type a =
  | A (BitVec(Size32))
  ;

⟦val id : a => a⟧
let id = (x) => { 
	x
};
'
]

{ #category : #tests }
SpriteDataPosTest >> test_data_with_bv_02 [
	self processString: '
type a =
  | A (BitVec(Size32))
  ;

⟦val f : int => a⟧
let f = (x) => {
	let a = A(toBitVector(12));
 	a
};
'
]
