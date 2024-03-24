/-
# Problem 24
(Easy 🌟) Lotto: Draw `N` different random numbers from the set `1..M`.
-/

-- You can use this function
#check List.range

def diffSelect (count range : Nat) : IO (List Nat) := do
  -- sorry
  if count > range then
    dbg_trace s!"can't draw {count} different numbers from 1..{range}"
    pure []
  else
    let mut univ := List.range range |>.drop 1
    let mut result : List Nat := []
    for _ in [0 : count] do
      let (element, rest) ← extractOne univ
      univ := rest
      result := element :: result
    pure result
where
  extractOne (univ : List Nat) : IO (Nat × List Nat) := do
    let index ← IO.rand 0 univ.length
    let element := univ.get! index
    let rest := univ.take index ++ univ.drop (index + 1)
    pure (element, rest)
  -- sorry

#eval diffSelect 24 22

#eval diffSelect 6 49

#eval diffSelect 1998 1999
