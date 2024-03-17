/-
# Problem 1
Find the last element of a list.
-/

variable {α : Type}

def myLast (l : List α) : Option α :=
  -- sorry
  match l with
  | [] => none
  | [a] => some a
  | _ :: as => myLast as
  -- sorry

-- The following code is a test case and you should not change it.

example : myLast [1, 2, 3, 4] = some 4 := by rfl

example : myLast ([] : List α) = none := by rfl

example : myLast [1] = some 1 := by rfl

example : myLast ['x', 'y', 'z'] = some 'z' := by rfl
