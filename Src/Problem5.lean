/-
# Problem 5
Reverse a list.
-/
variable {α : Type}

def myReverse (l : List α) : List α :=
  -- sorry
  match l with
  | [] => []
  | a :: as => myReverse as ++ [a]
  -- sorry

-- The following is a test case, you don't need to edit it.

example : myReverse [1,2,3,4] = [4,3,2,1] := rfl

example : myReverse ["man", "plan", "canal", "panama"]
  = ["panama", "canal", "plan", "man"] := rfl
