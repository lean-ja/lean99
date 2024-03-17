/-
# Problem 3
Find the K'th element of a list.
-/

variable {α : Type}

def element_at (l : List α)(k:Nat) : Option α :=
  --sorry
  match k with
  | 0 => none
  | Nat.succ n =>
    match l[n]? with
    | some x => some x
    | none => none
  --sorry
-- The following is a test case, you don't need to edit it.
example : element_at ['a','b','c','d','e'] 3 = some 'c' := by rfl

example : element_at ['a','b','c','d','e'] 6 = none := by rfl

example : element_at ['a','b','c','d','e'] 0 = none := by rfl

example : element_at ([] : List α) 0 = none := by rfl

example : element_at [1,2,3] 2 = some 2 := by rfl
