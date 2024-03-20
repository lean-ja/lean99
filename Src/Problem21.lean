/-
# Problem 21
Insert an element at a given position into a list.
-/
variable {α : Type}

def insertAt (e : α) (l : List α) (i : Nat) : List α :=
  -- sorry
  l.take (i - 1) ++ [e] ++ l.drop (i - 1)
  -- sorry

-- The following code is a test case and you should not change it.

example : insertAt "X" ["1", "2", "3", "4"] 2 = ["1", "X", "2", "3", "4"] := rfl

example : insertAt "X" ["1", "2", "3", "4"] 1 = ["X", "1", "2", "3", "4"] := rfl

example : insertAt "X" [] 1 = ["X"] := rfl
