/- # Problem 28B
b) Again, we suppose that a list contains elements that are lists themselves. But this time the objective is to sort the elements of this list according to their **length frequency**; i.e., in the default, where sorting is done ascendingly, lists with rare lengths are placed first, others with a more frequent length come later.

Example:

\* (lfsort '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
((i j k l) (o) (a b c) (f g h) (d e) (d e) (m n))

Example in Haskell:

λ\> lfsort \["abc", "de", "fgh", "de", "ijkl", "mn", "o"\]
\["ijkl","o","abc","fgh","de","de","mn"\]
-/
variable {α : Type}

-- def count [BEq] (l : List α)

def orderedInsert (a : α) (ord : α → Nat) : List α → List α
  | [] => [a]
  | b :: l =>
    if ord a ≤ ord b then a :: b :: l
    else b :: orderedInsert a ord l

/-- insertion sort -/
def insertionSort (ord : α → Nat) : List α → List α
  | [] => []
  | b :: l => orderedInsert b ord <| insertionSort ord l

/-- リストのリスト l の中で target と同じ長さのものが何個あるか数える -/
def makeToLengthFreq (l : List (List α)) (target : List α) : Nat :=
  let lengthList := l.map (·.length)
  lengthList.filter (· = target.length) |>.length

#guard makeToLengthFreq [[1, 2, 3], [2, 3], [1], [0], [2]] (target := [1]) = 3

def lfsort (l : List (List α)) : List (List α) :=
  insertionSort (makeToLengthFreq l) l

#guard lfsort ([[]] : List (List String)) = [[]]

#guard lfsort [[1, 2], [1], [1, 2]] = [[1], [1, 2], [1, 2]]

#guard lfsort [[1, 2], [1], [2, 3]] = [[1], [1, 2], [2, 3]]
