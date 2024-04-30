/- # Problem 27
(Intermediate 🌟🌟) Group the elements of a set into disjoint subsets.

Write a function that generates all the possibilities and returns them in a list.
-/
universe u
variable {α : Type}

/-- `List` is a Monad.
Since Lean does not use lazy evaluation, no Monad instance of List is defined in the Lean standard library for performance reasons. -/
instance : Monad List.{u} where
  pure := @List.pure
  bind := @List.bind
  map := @List.map

def List.split (n : Nat) (xs : List α) : List (List α × List α) :=
  -- sorry
  match n, xs with
  | 0, _ => [([], xs)]
  | _, [] => []
  | n + 1, x :: xs =>
    let ts := (xs.split n).map fun ⟨ys, zs⟩ => (x :: ys, zs)
    let ds := (xs.split (n + 1)).map fun ⟨ys, zs⟩ => (ys, x :: zs)
    ts ++ ds
  -- sorry

#guard [1, 2].split 1 = [([1], [2]), ([2], [1])]

#guard [1, 2, 3].split 2 = [([1, 2], [3]), ([1, 3], [2]), ([2, 3], [1])]

#guard [1, 2, 3].split 3 = [([1, 2, 3], [])]

#guard [1, 2, 3].split 0 = [([], [1, 2, 3])]

def group (pattern : List Nat) (xs : List α): List <| List <| List α :=
  -- sorry
  match pattern, xs with
  | [], _ => [[]]
  | n :: ns, xs => do
    let (g, rs) ← xs.split n
    let gs ← group ns rs
    pure <| g :: gs
  -- sorry

#guard group [1, 2] [1, 2, 3] = [[[1], [2, 3]], [[2], [1, 3]], [[3], [1, 2]]]
