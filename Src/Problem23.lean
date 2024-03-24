/-
# Problem 23
(Intermediate 🌟🌟) Extract a given number of randomly selected elements from a list.
-/
variable {α : Type} [Inhabited α]

def rndSelect (l : List α) (n : Nat) : IO (List α) := do
  -- sorry
  match l, n with
  | [], _ => pure []
  | _, 0 => pure []
  | _, n + 1 =>
    let index ← IO.rand 0 $ l.length - 1
    let previous ← rndSelect l n
    pure <| l[index]! :: previous
  -- sorry

#eval rndSelect [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] 3

#eval rndSelect [1, 1, 1] 2

#eval rndSelect [1, 2, 3] 0
