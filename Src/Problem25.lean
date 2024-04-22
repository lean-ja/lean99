/-
# Problem 25
(Easy 🌟) Generate a random permutation of the elements of a list.
-/
variable {α : Type} [Inhabited α] [BEq α]

/-- Randomly removes one element from the given list
and returns the removed element and the remaining pairs of elements in the List. -/
def List.extractOne (univ : List α) : IO (Option α × List α) := do
  if univ == [] then
    return (none, [])

  let index ← IO.rand 0 (univ.length - 1)
  let element := univ.get! index
  let rest := univ.take index ++ univ.drop (index + 1)
  return (element, rest)

partial def rndPermu (l : List α) : IO (List α) := do
  -- sorry
  let (element, rest) ← l.extractOne
  match element with
  | none => return []
  | some e =>
    return e :: (← rndPermu rest)
  -- sorry

-- The following codes are for test and you should not edit these.

def List.isPerm [BEq α] : List α → List α → Bool
  | [], l₂ => l₂.isEmpty
  | a :: l₁, l₂ => l₂.contains a && l₁.isPerm (l₂.erase a)

def runTest [ToString α] (l : List α) : IO Unit := do
  let result ← rndPermu l
  let check := result.isPerm l

  if l.length >= 30 then
    let result' ← rndPermu l
    if result == result' then
      throw <| .userError "failed: Your function is not random."

  if check then
    IO.println "ok!"
  else
    throw <| .userError s!"failed: rndPermu {l} = {result}"

#eval runTest [1, 2, 3]

#eval runTest ['a', 'a', 'a']

#eval runTest ([] : List Nat)

#eval runTest (List.range 35)
