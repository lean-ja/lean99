/-
# Problem 19
(Intermediate 🌟🌟) Rotate a list `N` places to the left.
-/
variable {α : Type}

def rotate (l : List α) (n : Nat) : List α :=
  -- sorry
  let n := n % l.length
  l.drop n ++ l.take n
  -- sorry

-- The following codes are for test and you should not edit these.

example : rotate [1, 2, 3, 4, 5] 2 = [3, 4, 5, 1, 2] := rfl

example : rotate [1, 2, 3] 0 = [1, 2, 3] := rfl

example : rotate [1, 2, 3] 3 = [1, 2, 3] := rfl

example : rotate [1, 2, 3] 1 = [2, 3, 1] := rfl
