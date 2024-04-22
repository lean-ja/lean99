/-
# Problem 31
(Intermediate 🌟🌟) Determine whether a given integer number is prime.
-/

def isPrime (n : Nat) : Bool :=
  -- sorry
  if n == 0 || n == 1 then
    false
  else
    let properDivisors := List.range n
      |>.drop 2
      |>.filter (n % · == 0)

    properDivisors.length == 0
  -- sorry

-- The following codes are for test and you should not edit these.

example : isPrime 7 = true := rfl

example : isPrime (7 * 43) = false := rfl

example : isPrime 307 = true := rfl

example : isPrime 0 = false := rfl

example : isPrime 1 = false := rfl
