/-
# Problem 18
(Intermediate 🌟🌟) Given two indices, `i` and `k`, the slice is the list containing the elements between the i'th and k'th element of the original list (both limits included). Start counting the elements with 1.
-/
variable {α : Type}

def slice (l : List α) (i k : Nat) : List α :=
  -- sorry
  if i <= k then
    l.drop (i - 1) |>.take (k - i + 1)
  else
    l.drop (k - 1) |>.take (i - k + 1)
  -- sorry

-- The following code is a test case and you should not change it.

example : slice [1, 2, 3, 4, 5, 6, 7, 8, 9] 3 7 = [3, 4, 5, 6, 7] := by rfl

example : slice [1, 2, 3, 4, 5] 1 1 = [1] := by rfl

example : slice [1, 2, 3, 4, 5] 2 3 = [2, 3] := by rfl
