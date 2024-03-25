/-
# Problem 23
(Intermediate 🌟🌟) Extract a given number of randomly selected elements from a list.
-/
import Lean

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

-- The following code is a test case and you should not change it.

/-- generate a random list. -/
def genRandList (max_len max_num : Nat) : IO (List Nat) := do
  let mut l := []
  let len ← IO.rand 0 max_len
  for _ in [:len] do
    let x ← IO.rand 0 max_num
    l := x :: l
  return l

def runTest : IO Unit := do
  for _ in [:50] do
    let l ← genRandList 20 100
    let n ← IO.rand 0 100
    let result ← rndSelect l n

    let check := if l.isEmpty
      then result.isEmpty
      else result.length == n && result.all l.contains

    if check then
      IO.print "."
    else
      IO.throwServerError s!"\nfailure on: rndSelect {l} {n} = {result}"

  IO.println "ok!"

#eval runTest
