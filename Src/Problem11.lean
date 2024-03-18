/-
# Problem 11
Modify the result of problem 10 in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as `(N E)` lists.
-/
variable {α : Type} [BEq α]

inductive Data (α : Type) where
| multiple : Nat → α → Data α
| single : α → Data α
deriving Repr

open Data

def encodeModified (l : List α) : List (Data α) :=
  match l with
  | [] => []
  | x :: xs =>
    let (as, bs) := l.span (· == x)
    if as.length > 1 then
      multiple as.length x :: encodeModified bs
    else
      single x :: encodeModified bs

  -- Avoid proving that the function terminates as a recursive function.
  -- You don't have to fill in the `sorry` here.
  decreasing_by
    all_goals sorry

-- The following code is a test case and you should not change it.

example : encodeModified ['a', 'a', 'b', 'c'] =
  [multiple 2 'a', single 'b', single 'c'] := by rfl

example : encodeModified ([] : List α) = [] := by rfl

example : encodeModified ['a', 'b', 'b', 'b', 'c', 'b', 'b'] =
  [single 'a', multiple 3 'b', single 'c', multiple 2 'b'] := by rfl
