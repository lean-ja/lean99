/-
# Problem 9
(Intermediate 🌟🌟) Pack consecutive duplicates of list elements into sublists.
-/
namespace P9 --#

variable {α : Type} [BEq α]

partial def pack (l : List α) : List (List α) :=
  -- sorry
  match l with
  | [] => []
  | x :: _ =>
    let (packed, rest) := l.span (· == x)
    packed :: pack rest
  -- sorry

-- The following codes are for test and you should not edit these.

def _root_.List.unpack (l : List (List α)) : List α :=
  match l with
  | [] => []
  | x :: xs => x ++ unpack xs

def runTest [ToString α] (l : List α) : IO Unit := do
  let result := pack l
  let check := result.unpack == l
  if check then
    IO.println "ok!"
  else
    throw <| .userError s!"failed: pack {l} = {result}"

#eval runTest ([] : List Nat)

#eval runTest [1]

#eval runTest [0, 0, 1, 0]

#eval runTest ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']

end P9 --#
