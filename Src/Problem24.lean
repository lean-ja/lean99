/-
# Problem 24
(Easy 🌟) Lotto: Draw `N` different random numbers from the set `1..M`.
-/

/-- List of natural numbers from `1` to `n` -/
def List.nrange (n : Nat) : List Nat :=
  match n with
  | 0 => []
  | 1 => [1]
  | n + 1 => nrange n ++ [n + 1]

example : List.nrange 5 = [1, 2, 3, 4, 5] := rfl

-- You can use this function
#check List.nrange

def diffSelect (count range : Nat) : IO (List Nat) := do
  -- sorry
  if count > range then
    dbg_trace s!"can't draw {count} different numbers from 1..{range}"
    return []

  let mut univ := List.nrange range
  let mut result : List Nat := []
  for _ in [0 : count] do
    let (element, rest) ← extractOne univ
    if let some e := element then
      univ := rest
      result := e :: result

  return result
where
  extractOne (univ : List Nat) : IO (Option Nat × List Nat) := do
    if univ == [] then
      return (none, [])

    let index ← IO.rand 0 (univ.length - 1)
    let element := univ.get! index
    let rest := univ.take index ++ univ.drop (index + 1)
    return (element, rest)
  -- sorry

#eval diffSelect 3 3

#eval diffSelect 1 1

#eval diffSelect 2 2

#eval diffSelect 24 22

#eval diffSelect 6 49

#eval diffSelect 1998 1999

#eval diffSelect 5668 5998
