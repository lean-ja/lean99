/-
# Problem 12
(Intermediate) Given a run-length code list generated as specified in problem 11. Construct its uncompressed version.
-/
namespace P12 --#

variable {α : Type} [BEq α]

inductive Data (α : Type) where
| multiple : Nat → α → Data α
| single : α → Data α
deriving Repr

open Data

def decodeModified (l : List (Data α)) : List α :=
  -- sorry
  match l with
  | [] => []
  | (multiple n a) :: t => (List.replicate n a) ++ decodeModified t
  | (single a) :: t => a :: decodeModified t
  -- sorry

-- The following code is a test case and you should not change it.

example : decodeModified [multiple 2 'a', single 'b', multiple 2 'c'] = ['a', 'a', 'b', 'c', 'c'] := rfl

example : decodeModified [single 'a', single 'b', single 'c'] = ['a', 'b', 'c'] := rfl

example : decodeModified [multiple 3 '2', multiple 2 '1', single '9'] = ['2', '2', '2', '1', '1', '9'] := rfl

end P12 --#
