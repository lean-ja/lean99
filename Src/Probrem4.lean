/-
# Problem 4
Find the number of elements in a list.
-/

variable {α : Type}

def myLength (l : List α) : Nat :=
  --sorry
  List.length l
  --sorry
  
-- The following is a test case, you don't need to edit it.

example : myLength [123, 456, 789] = 3 := by rfl

example : myLength ([] : List α) = 0 := by rfl

example : myLength [1,1,1,1,1,1,1,1,1,1,1,1] = 12 := by rfl

example : myLength ['w','x', 'y', 'z'] = 4 := by rfl
