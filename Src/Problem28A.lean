/- # Problem 28A
(Intermediate 🌟🌟) Sorting a list of lists according to length of sublists.
-/
variable {α : Type}

-- You can use this!
#check List.mergeSort

def lsort (l : List (List α)) : List (List α) :=
  -- sorry
  List.mergeSort l (fun l₁ l₂ => l₁.length ≤ l₂.length)
  -- sorry

-- The following codes are for test and you should not edit these.

#guard lsort [["a", "b", "c"], ["a", "b"], ["a"]]
  = [["a"], ["a", "b"], ["a", "b", "c"]]

#guard lsort [[3, 1, 4], [1, 5, 9, 2], [6, 5, 3, 5], [1]]
  = [[1], [3, 1, 4], [1, 5, 9, 2], [6, 5, 3, 5]]
