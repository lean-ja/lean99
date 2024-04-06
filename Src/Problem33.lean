/- # Problem 33
(Easy 🌟) Determine whether two positive integer numbers are coprime.
-/

-- You can use this
#check Nat.gcd

def coprime (a b : Nat) : Bool :=
  -- sorry
  Nat.gcd a b = 1
  -- sorry

-- The following codes are for test and you should not edit these.

example : coprime 35 64 = true := rfl

example : coprime 38859 233153 = true := rfl

example : coprime 10284412 24135577 = true := rfl
