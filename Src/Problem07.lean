/-
# Problem 7
(Intermediate 🌟🌟) Flatten a nested list structure.
-/

variable {α : Type}

-- We have to define a new data type, because lists in Lean are homogeneous.
inductive NestedList (α : Type) where
  | elem : α → NestedList α
  | list : List (NestedList α) → NestedList α

/-- convert NestedList to String. -/
partial def NestedList.toString [ToString α] : NestedList α → String
  | NestedList.elem x => ToString.toString x
  | NestedList.list xs => "[" ++ String.intercalate ", " (xs.map toString) ++ "]"

/-- Display `NestedList` in a readable manner when you run `#eval`. -/
instance [ToString α] : ToString (NestedList (α : Type)) where
  toString nl := NestedList.toString nl

/-- flatten the list structure -/
def flatten (nl : NestedList α) : List α :=
  -- sorry
  match nl with
  | .elem x => [x]
  | .list [] => []
  | .list (x :: xs) => flatten x ++ flatten (.list xs)
  -- sorry

-- The following codes are for test and you should not edit these.

open NestedList

def sample : NestedList Nat :=
  list [elem 1, list [elem 2, elem 3], elem 4]

#eval sample

def empty : NestedList String := list []

#eval empty

example : flatten (.elem 5) = [5] := by
  delta flatten
  rfl

example : flatten sample = [1, 2, 3, 4] := by
  delta flatten
  rfl

example : flatten (empty) = [] := by
  delta flatten
  rfl
