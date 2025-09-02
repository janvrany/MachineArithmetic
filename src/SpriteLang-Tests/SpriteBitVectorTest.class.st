Class {
	#name : #SpriteBitVectorTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpriteBitVectorTest >> test_Add_01 [
	self proveSafe: '
⟦val main : int => BitVec(Size8)[v|v === (127///8)]⟧
let main = (x) => {
  let a = toBitVector(126);
  let b = toBitVector(1);
  bvadd(a, b)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Add_02 [
	self should: [
		self proveSafe: '
⟦val main : BitVec(Size8) => BitVec(Size9) => int⟧
let main = (x, y) => {
  let ignored = bvadd(x, y);
  0
};
'
	] raise: Error
]

{ #category : #tests }
SpriteBitVectorTest >> test_Add_03 [
	self proveSafe: '
⟦val main : int => BitVec(Size8)[v|v === (127///8)]⟧
let main = (x) => {
  bv(8, 127)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Add_03_neg [
	self should: [
		self proveSafe: '
⟦val main : int => BitVec(Size8)[v|v === (127///8)]⟧
let main = (x) => {
  bv(32, 127)
};
'
	] raise: Error
]

{ #category : #tests }
SpriteBitVectorTest >> test_Add_03_neg′ [
	self proveUnsafe: '
⟦val main : int => BitVec(Size8)[v|v === (128///8)]⟧
let main = (x) => {
  bv(8, 127)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_AndZeroSmashesAnything_01 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(Size32) => BitVec(Size32)⟧
let main = (x, y) => {
  let result = bvand(x, y);
  result
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_AndZeroSmashesAnything_02 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(Size32)[v|v === (0///32)] => BitVec(Size32)[v|v === (0///32)]⟧
let main = (x, y) => {
  let result = bvand(x, y);
  result
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_AndZeroSmashesAnything_03 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(Size32)[v|v === (0///32)]⟧
let main = (x) => {
  let zero = toBitVector(0);
  let result = bvand(x, zero);
  result
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_AndZeroSmashesAnything_04 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(Size32)[v|v === (0///32)]⟧
let main = (x) => {
  let zero = toBitVector(0);
  let result = bvand(zero, x);
  result
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Create [
	self proveSafe: '
⟦val int8 : BitVec(Size8)[v|v === (127///8)]⟧
let int8 = toBitVector(127);
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Matias_01 [
	self proveSafe: '
⟦reflect BB_003 : x:BitVec(Size32) => i:BitVec(Size32) => BitVec(Size32)⟧
let BB_003 = (x, i) => {
    let N017 = i;
    N017
};


⟦reflect BB_001 : x:BitVec(Size32) => i:BitVec(Size32) => BitVec(Size32) / [100]⟧
let rec BB_001 = (x, i) => {
    let N014 = i;
    let tmp1 = toBitVector(5);
    let N015 = tmp1;
    let cond = bvsge(N014, N015);
    if (cond) {
        BB_003(x, i)
    } else {
        let zzz = 0;
        let yyy = 1234;
        let tmp1 = toBitVector(1);
        let N009 = tmp1;
        let N010 = bvadd(N014, N009);
        let i = N010;
        BB_001(x, i)
    }
};


⟦reflect dead_branch : x:BitVec(Size32) => BitVec(Size32)⟧
let dead_branch = (x) => {
    let tmp1 = toBitVector(42);
    let N002 = tmp1;
    let i = N002;
    BB_001(x, i)
};

⟦val verify : BitVec(Size32) => bool[b|b]⟧
let verify = (x) => {
	let exp = toBitVector(42);
	let got = dead_branch(x);
	got == exp
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Matias_02 [
	self proveSafe: '
[--check-termination]	
	
⟦reflect BB_003 : x:BitVec(Size32) => i:BitVec(Size32) => BitVec(Size32)⟧
let BB_003 = (x, i) => {
    let N017 = i;
    N017
};


⟦reflect BB_001 : x:BitVec(Size32) => i:BitVec(Size32) => BitVec(Size32) / [100 toInt]⟧
let rec BB_001 = (x, i) => {
    let N014 = i;
    let tmp1 = toBitVector(5);
    let N015 = tmp1;
    let cond = bvsge(N014, N015);
    if (cond) {
        BB_003(x, i)
    } else {
        let zzz = 0;
        let yyy = 1234;
        let tmp1 = toBitVector(1);
        let N009 = tmp1;
        let N010 = bvadd(N014, N009);
        let i = N010;
        BB_001(x, i)
    }
};


⟦reflect dead_branch : x:BitVec(Size32) => BitVec(Size32)⟧
let dead_branch = (x) => {
    let tmp1 = toBitVector(42);
    let N002 = tmp1;
    let i = N002;
    BB_001(x, i)
};

⟦val verify : BitVec(Size32) => bool[b|b]⟧
let verify = (x) => {
	let exp = toBitVector(42);
	let got = dead_branch(x);
	got == exp
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Sge_01 [
	self proveSafe: '
⟦val icmpge : a:BitVec(Size32) => b:BitVec(Size32) => bool[v|v === (a >= b)]⟧
let icmpge = (a, b) => {
  bvsge(a, b)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Sge_01_neg [
	self proveUnsafe: '
⟦val icmpge : a:BitVec(Size32) => b:BitVec(Size32) => bool[v|v === (a > b)]⟧
let icmpge = (a, b) => {
  bvsge(a, b)
};
'
]
