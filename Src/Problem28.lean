/- # Problem 28A
(Intermediate 🌟🌟) Sorting a list of lists according to length of sublists.
-/
variable {α : Type}

def orderedInsert (a : α) (ord : α → Nat) : List α → List α
  | [] => [a]
  | b :: l =>
    if ord a ≤ ord b then a :: b :: l
    else b :: orderedInsert a ord l

/-- insertion sort -/
def insertionSort (ord : α → Nat) : List α → List α
  | [] => []
  | b :: l => orderedInsert b ord <| insertionSort ord l

#guard insertionSort (fun x => x) [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
  = [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

-- You can use this!
#check insertionSort

def lsort (l : List (List α)) : List (List α) :=
  -- sorry
  insertionSort (fun l => l.length) l
  -- sorry

-- The following codes are for test and you should not edit these.

#guard lsort [["a", "b", "c"], ["a", "b"], ["a"]]
  = [["a"], ["a", "b"], ["a", "b", "c"]]

#guard lsort [[3, 1, 4], [1, 5, 9, 2], [6, 5, 3, 5], [1]]
  = [[1], [3, 1, 4], [1, 5, 9, 2], [6, 5, 3, 5]]
