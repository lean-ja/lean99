/-
  # Problem 15
  Replicate the elements of a list a given number of times.
-/

variable {α : Type}

def repli (l : List α)(n : Nat) : List α :=
  -- sorry
  match l with
  | [] => []
  | a :: b => (solorepl a n) ++ repli b n
  where solorepl (x : α)(n : Nat) : List α :=
    match n with
    | 0 => []
    | Nat.succ m => x :: solorepl x m
  -- sorry

-- The following code is a test case and you should not change it.

example : repli [1,2,3] 3 = [1,1,1,2,2,2,3,3,3] := by rfl

example : repli [1,2,3] 2 = [1,1,2,2,3,3] := by rfl

example : repli [1,2,3] 1 = [1,2,3] := by rfl

example : repli [1,2,3] 0 = [] := by rfl

example : repli ([] : List α) 255 = [] := by rfl
