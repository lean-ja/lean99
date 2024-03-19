/-
# Problem 16
Drop every N'th element from a list.
-/
variable {α : Type}

def dropEvery (l : List α) (n : Nat) : List α :=
  -- sorry
  helper l n 1
where
  helper : List α → Nat → Nat → List α
  | [], _, _ => []
  | x :: xs, n, m =>
    if m % n = 0 then
      helper xs n (m + 1)
    else
      x :: helper xs n (m + 1)
  -- sorry

-- The following code is a test case and you should not change it.

example : dropEvery [1, 2, 3] 0 = [1, 2, 3] := by rfl

example : dropEvery ['a', 'b', 'c', 'd'] 2 = ['a', 'c'] := by rfl

example : dropEvery ['a', 'b', '3', 'c', 'd', '6', 'e'] 3
  = ['a', 'b', 'c', 'd', 'e'] := by rfl
