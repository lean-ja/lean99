/-
# Problem 21
(Easy 🌟) Insert an element at a given position into a list.
-/
variable {α : Type}

def insertAt (e : α) (l : List α) (i : Nat) : List α :=
  -- sorry
  match l, i with
  | a :: b , i + 2 => a :: insertAt e b (i + 1)
  | _ , _ => e :: l
  -- sorry

-- The following codes are for test and you should not edit these.

example : insertAt "X" ["1", "2", "3", "4"] 2 = ["1", "X", "2", "3", "4"] := rfl

example : insertAt "X" ["1", "2", "3", "4"] 1 = ["X", "1", "2", "3", "4"] := rfl

example : insertAt "X" [] 1 = ["X"] := rfl
