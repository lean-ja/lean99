/-
# Problem 4
Find the K'th element of a list.
-/

variable {α : Type}

def myLength (l : List α) : Nat :=
  -- sorry
  match l with
  | [] => 0
  | [_] => 1
  | _ :: a => (myLength a).succ
  -- sorry
-- The following is a test case, you don't need to edit it.
example : myLength [123,456,789] = 3 := by rfl

example : myLength ['L','e','a','n','4'] = 5 := by rfl

example : myLength [False,True,True] = 3 := by rfl

example : myLength ([] : List α) = 0 := by rfl
