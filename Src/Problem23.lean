/-
# Problem 23
(Intermediate 🌟🌟) Extract a given number of randomly selected elements from a list.
-/
import Lean

namespace P23

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

-- The following codes are for test and you should not edit these.

def runTest [BEq α] [ToString α] (l : List α) (n : Nat) : IO Unit := do
  let result ← rndSelect l n
  let mut check := true
  check := check && result.length == n
  check := check && result.all l.contains
  if check then
    IO.println s!"ok!"
  else
    IO.throwServerError s!"failed: rndSelect {l} {n} = {result}"

#eval runTest [1, 2, 3] 0

#eval runTest ['a', 'b'] 1

#eval runTest [1, 2, 3, 4, 5] 2

#eval runTest [1, 1, 1] 2

#eval runTest [2, 2, 2] 12

#eval runTest (List.range 5200) 1897

end P23
