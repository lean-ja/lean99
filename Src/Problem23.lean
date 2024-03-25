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

#eval do
  let genL : IO (List Nat) := do
    let mut l := []
    let len ← IO.rand 0 20
    for _ in [:len] do
      let x ← IO.rand 0 100
      l := x::l
    return l
  let genN : IO Nat := IO.rand 0 100

  for _ in [:50] do
    let l ← genL
    let n ← genN
    let result ← rndSelect l n

    let check := if l.isEmpty
      then result.isEmpty
      else result.length == n && result.all l.contains

    if check then
      IO.print "."
    else
      IO.throwServerError s!"\nfailure on: rndSelect {l} {n} = {result}"

  IO.println "ok!"
