/-
# Problem 3
(Easy) Find the K'th element of a list.
-/
variable {α : Type}

def elementAt (l : List α) (k : Nat) : Option α :=
  -- sorry
  match l, k with
  | [], _ => none
  | _, 0 => none
  | a :: _, 1 => some a
  | _ :: a, k + 1 => elementAt a k
  -- sorry

-- The following code is a test case and you should not change it.

example : elementAt ['a', 'b', 'c', 'd', 'e'] 3 = some 'c' := by rfl

example : elementAt ['a', 'b', 'c', 'd', 'e'] 6 = none := by rfl

example : elementAt ['a', 'b', 'c', 'd', 'e'] 0 = none := by rfl

example : elementAt ([] : List α) 0 = none := by rfl

example : elementAt [1, 2, 3] 2 = some 2 := by rfl
