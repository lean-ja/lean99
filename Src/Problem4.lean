/-
# Problem 4
(Easy 🌟) Find the number of elements in a list.
-/
variable {α : Type}

def myLength (l : List α) : Nat :=
  -- sorry
  match l with
  | [] => 0
  | _ :: a => myLength a + 1
  -- sorry

-- The following codes are for test and you should not edit these.

example : myLength [123, 456, 789] = 3 := by rfl

example : myLength ['L', 'e', 'a', 'n', '4'] = 5 := by rfl

example : myLength [False, True, True] = 3 := by rfl

example : myLength ([] : List α) = 0 := by rfl
