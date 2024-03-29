/-
# Problem 26
(Intermediate 🌟🌟) Generate combinations of `K` distinct objects chosen from the `N` elements of a list.
-/
variable {α : Type}

def List.combinations (k : Nat) (l : List α) : List (List α) :=
  -- sorry
  match k, l with
  | 0, _ => [[]]
  | _, [] => []
  | k + 1, x :: xs =>
    ((x :: ·) <$> (List.combinations k xs)) ++ (List.combinations (k + 1) xs)
  -- sorry

-- The following codes are for test and you should not edit these.

example : [1, 2, 3, 4].combinations 2
  = [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]] := rfl

example : [1, 2, 3, 4].combinations 3
  = [[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]] := rfl

example : ['a', 'b', 'c'].combinations 1
  = [['a'], ['b'], ['c']] := rfl
