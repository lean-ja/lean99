/- # Problem 49
(Intermediate 🌟🌟) Gray codes.

An n-bit Gray code is a sequence of n-bit strings constructed according to certain rules. For example,

```
n = 1: C(1) = ['0','1'].
n = 2: C(2) = ['00','01','11','10'].
n = 3: C(3) = ['000','001','011','010',´110´,´111´,´101´,´100´].
```

Find out the construction rules and write a predicate with the following specification:

```
% gray(N,C) :- C is the N-bit Gray code
```

Can you apply the method of "result caching" in order to make the predicate more efficient, when it is to be used repeatedly?
-/

inductive Digit : Type where
  | zero
  | one
deriving DecidableEq

abbrev GrayCode := List Digit

def Digit.toString : Digit → String
  | .zero => "0"
  | .one => "1"

instance : OfNat Digit 0 where
  ofNat := Digit.zero

instance : OfNat Digit 1 where
  ofNat := Digit.one

instance : ToString Digit where
  toString := Digit.toString

def gray (n : Nat) : List GrayCode :=
  -- sorry
  match n with
  | 0 => []
  | 1 => [[.zero], [.one]]
  | n + 1 =>
    let prev := gray n
    let revPrev := prev.reverse
    (prev.map (fun d => Digit.zero :: d)) ++ (revPrev.map (fun d => Digit.one :: d))
  -- sorry

-- The following codes are for test and you should not edit these.

#guard gray 1 = [[0], [1]]

#guard gray 2 = [[0, 0], [0, 1], [1, 1], [1, 0]]

#guard gray 3 = [
  [0, 0, 0],
  [0, 0, 1],
  [0, 1, 1],
  [0, 1, 0],
  [1, 1, 0],
  [1, 1, 1],
  [1, 0, 1],
  [1, 0, 0]
]
