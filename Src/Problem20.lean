/-
# Problem 20
(Easy) Remove the K'th element from a list.
-/
variable {α : Type}

def removeAt (l : List α) (n : Nat) : List α :=
  -- sorry
  match l, n with
  | [], _ => []
  | _, 0 => l
  | _ :: b, 1 => b
  | x :: b, m + 2 => x :: removeAt b (m + 1)
  -- sorry

-- The following code is a test case and you should not change it.

example : removeAt ['a', 'b', 'c', 'd'] 2 = ['a', 'c', 'd'] := rfl

example : removeAt ['a', 'b', 'c', 'd'] 5 = ['a', 'b', 'c', 'd'] := rfl

example : removeAt ['a', 'b', 'c', 'd'] 0 = ['a', 'b', 'c', 'd'] := rfl

example : removeAt ['a'] 1 = [] := rfl

example : removeAt ([] : List α) 1 = [] := rfl
