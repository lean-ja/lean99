/- # Problem 28B

(Intermediate 🌟🌟) Again, we suppose that a list contains elements that are lists themselves. But this time the objective is to sort the elements of this list according to their **length frequency**; i.e., in the default, where sorting is done ascendingly, lists with rare lengths are placed first, others with a more frequent length come later.
-/
variable {α : Type}

-- You can use this!
#check List.mergeSort
--#--
/-- Count the number of lists in list `l` that have the same length as `target` -/
def makeToLengthFreq (l : List (List α)) (target : List α) : Nat :=
  let lengthList := l.map (·.length)
  lengthList.filter (· = target.length) |>.length
--#--

def lfsort (l : List (List α)) : List (List α) :=
  -- sorry
  List.mergeSort l (fun t s => makeToLengthFreq l t ≤ makeToLengthFreq l s)
  -- sorry

-- The following codes are for test and you should not edit these.

#guard lfsort ([[]] : List (List String)) = [[]]

#guard lfsort [[1, 2], [1], [1, 2]] = [[1], [1, 2], [1, 2]]

#guard lfsort [[1, 2], [1], [2, 3]] = [[1], [1, 2], [2, 3]]
