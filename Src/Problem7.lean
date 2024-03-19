/-
# Problem 7
(Intermediate) Flatten a nested list structure.
-/

-- We have to define a new data type, because lists in Lean are homogeneous.

variable {α : Type}

inductive NestedList (α : Type) where
| elem : α → NestedList α
| list : List (NestedList α) → NestedList α

section
  /-!
  ## Pretty printing of NestedList
  Display `NestedList` in a readable manner when you run `#eval`.
  When solving this problem, do not mind the contents of this section.

  The following code was provided by Mario Carneiro.
  -/
  open Std

  partial def NestedList.repr [Repr α] (a : NestedList α) (n : Nat) : Format :=
    let _ : ToFormat (NestedList α) := ⟨(NestedList.repr · 0)⟩
    match a, n with
    | elem x, _ => reprPrec x n
    | list as, _ => Format.bracket "[" (Format.joinSep as ("," ++ Format.line)) "]"

  instance [Repr α] : Repr (NestedList α) where
    reprPrec := NestedList.repr
end

-- Here is an example of how to use the `NestedList` type.

open NestedList

def sample : NestedList Nat :=
  list [elem 1, list [elem 2, elem 3], elem 4]

#eval sample

def empty : NestedList String := list []

#eval empty

/-- flatten the list structure -/
def flatten (nl : NestedList α) : List α :=
  -- sorry
  match nl with
  | elem x => [x]
  | list [] => []
  | list (x :: xs) => flatten x ++ flatten (list xs)
  -- sorry

-- The following code is a test case and you should not change it.

example : flatten (elem 5) = [5] := rfl

example : flatten sample = [1, 2, 3, 4] := rfl

example : flatten (empty) = [] := rfl
