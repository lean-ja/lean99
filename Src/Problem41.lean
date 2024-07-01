/- # Problem 40

(Intermediate 🌟🌟) A list of even numbers and their Goldbach compositions in a given range.
-/

def Nat.isPrime (n : Nat) : Bool :=
  if n == 0 || n == 1 then
    false
  else
    let properDivisors := List.range n
      |>.drop 2
      |>.filter (n % · == 0)
    properDivisors.length == 0

def goldbach (n : Nat) : Nat × Nat := Id.run do
  -- sorry
  for cand in (List.range n) do
    if not cand.isPrime then
      continue
    let rest := n - cand
    if not rest.isPrime then
      continue
    return (cand, rest)

  panic! "we've found a counter example of goldbach conjecture!! 🎉"


def goldbachList (lower upper : Nat) (primeLower : Nat := 2) : List (Nat × Nat) :=
  List.range (upper + 1)
    |>.filter (· ≥ lower)
    |>.filter (· % 2 == 0)
    |>.map (fun n => (goldbach n))
    |>.filter ( fun t => t.fst > primeLower)

#guard goldbachList 9 20 == [(3, 7), (5, 7), (3, 11), (3, 13), (5, 13), (3, 17)]

#guard goldbachList 4 2000 50 == [(73,919),(61,1321),(67,1789),(61,1867)]
