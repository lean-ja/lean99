/-
# Problem 22
Create a list containing all integers within a given range.
-/

def range (m n : Int) : List Int :=
  -- sorry
  generate m (n - m + 1).toNat
where
  generate (start : Int) (length : Nat) : List Int :=
    match length with
    | 0 => []
    | l + 1 => generate start l ++ [start + l]
  -- sorry

-- The following code is a test case and you should not change it.

example : range 4 9 = [4, 5, 6, 7, 8, 9] := by rfl

example : range (-1) 2 = [-1, 0, 1, 2] := by rfl

example : range (-2) (-1) = [-2, -1] := by rfl
