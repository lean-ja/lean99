/-
# Problem 11
(Easy 🌟) Modify the result of problem 10 in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as `(N E)` lists.
-/
namespace P11 --#

variable {α : Type} [BEq α]

inductive Data (α : Type) where
  | multiple : Nat → α → Data α
  | single : α → Data α
deriving Repr, DecidableEq

open Data

partial def encodeModified (l : List α) : List (Data α) :=
  -- sorry
  match l with
  | [] => []
  | x :: _xs =>
    let (as, bs) := l.span (· == x)
    if as.length > 1 then
      multiple as.length x :: encodeModified bs
    else
      single x :: encodeModified bs
  -- sorry

-- The following codes are for test and you should not edit these.

example : encodeModified ['a', 'a', 'b', 'c'] =
  [multiple 2 'a', single 'b', single 'c'] := by native_decide

example : encodeModified ([] : List Nat) = [] := by native_decide

example : encodeModified ['a', 'b', 'b', 'b', 'c', 'b', 'b'] =
  [single 'a', multiple 3 'b', single 'c', multiple 2 'b'] := by native_decide

end P11 --#
