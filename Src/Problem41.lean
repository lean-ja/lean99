/- # Problem 41

(Intermediate 🌟🌟) A list of even numbers and their Goldbach compositions in a given range.
-/

def Nat.isPrime (n : Nat) : Bool := Id.run do
  if n ≤ 2 then
    return false
  for d in [2:n] do
    if n % d = 0 then
      return false
    if d ^ 2 > n then
      break
  return true

def goldbach (n : Nat) : Nat × Nat := Id.run do
  for cand in [2:n] do
    if not cand.isPrime then
      continue
    let rest := n - cand
    if not rest.isPrime then
      continue
    return (cand, rest)

  panic! "we've found a counter example of goldbach conjecture!! 🎉"

def goldbachList (lower upper : Nat) (primeLower : Nat := 2) : List (Nat × Nat) :=
  -- sorry
  List.range (upper + 1)
    |>.filter (· ≥ lower)
    |>.filter (· % 2 == 0)
    |>.map (fun n => (goldbach n))
    |>.filter (fun t => t.fst > primeLower)
  -- sorry

-- The following codes are for test and you should not edit these.

#guard goldbachList 9 20 == [(3, 7), (5, 7), (3, 11), (3, 13), (5, 13), (3, 17)]

#guard goldbachList 9 20 3 == [(5, 7), (5, 13)]

#guard goldbachList 4 2000 50 == [(73,919),(61,1321),(67,1789),(61,1867)]
