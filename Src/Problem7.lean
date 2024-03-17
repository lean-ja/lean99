/-
# Problem 7
Flatten a nested list structure.
-/

-- We have to define a new data type, because lists in Lean are homogeneous.

variable {α : Type}

inductive NestedList (α : Type) where
| elem : α → NestedList α
| list : List (NestedList α) → NestedList α

open Std

protected def NestedList.repr [Repr α] (a : NestedList α) (n : Nat) : Format :=
  let _ : ToFormat α := ⟨repr⟩
  match a, n with
  | elem x, _ => reprPrec x n
  | list as, _ =>
    -- this code raise an error! :(
    Format.bracket "[" (Format.joinSep as ("," ++ Format.line)) "]"

instance [Repr α] : Repr (NestedList α) where
  reprPrec := NestedList.repr

open NestedList

def sample : NestedList Nat :=
  list [elem 1, list [elem 2, elem 3], elem 4]

/-
What I want is:

[1, [2, 3], 4]
-/
#eval sample
