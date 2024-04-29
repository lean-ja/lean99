/-
# Problem 13
(Intermediate 🌟🌟) Implement the so-called run-length encoding data compression method directly. I.e. don't explicitly create the sublists containing the duplicates, as in [Problem 9](./Problem9.md), but only count them. As in [Problem 11](./Problem11.md), simplify the result list by replacing the singleton lists `(1 X)` by `X`.
-/
namespace P13 --#

variable {α : Type} [BEq α] [Inhabited α]

inductive Data (α : Type) where
  | multiple : Nat → α → Data α
  | single : α → Data α
deriving Repr

open Data

def encodeDirect (l : List α) : List (Data α) :=
  -- sorry
  counting l |>.map fun (n, a) =>
    if n == 1 then
      single a
    else
      multiple n a
where
  counting : List α → List (Nat × α)
    | [] => []
    | [a] => [(1, a)]
    | a :: b :: t =>
      if a != b then
        (1, a) :: counting (b :: t)
      else
        let (n, a) := counting (b :: t) |>.head!
        (n + 1, a) :: (counting (b :: t) |>.tail!)
  -- sorry

-- The following codes are for test and you should not edit these.

example : encodeDirect ['a', 'a', 'b', 'c'] =
  [multiple 2 'a', single 'b', single 'c'] := by rfl

example : encodeDirect ([] : List α) = [] := by rfl

example : encodeDirect ['a', 'b', 'b', 'b', 'c', 'b', 'b'] =
  [single 'a', multiple 3 'b', single 'c', multiple 2 'b'] := by rfl

end P13 --#
