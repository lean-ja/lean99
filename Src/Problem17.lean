/-
# Problem 17
(Easy 🌟) Split a list into two parts; the length of the first part is given.
-/
variable {α : Type}

-- Don't use these functions
#check List.take
#check List.drop

def split (l : List α) (n : Nat) : List α × List α :=
  -- sorry
  match l, n with
  | [], _ => ([], [])
  | _, 0 => ([], l)
  | h :: t, n =>
    let (a, b) := split t (n - 1)
    (h :: a, b)
  -- sorry

-- The following code is a test case and you should not change it.

example : split [1, 2, 3, 4, 5] 2 = ([1, 2], [3, 4, 5]) := rfl

example : split ["a"] 3 = (["a"], []) := rfl

example : split ([] : List α) 1 = ([], []) := rfl

example : split ["a", "b", "c", "d", "e", "f"] 3
  = (["a", "b", "c"], ["d", "e", "f"]) := rfl
