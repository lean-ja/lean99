/-
# Problem 34
(Intermediate 🌟🌟) Calculate Euler's totient function `phi(m)`.

Euler's so-called totient function `phi(m)` is defined as the number of positive integers `r (1 <= r < m)` that are coprime to `m`.

Example: `m = 10`: `r = 1, 3, 7, 9`; thus `phi(m) = 4`. Note the special case: `phi(1) = 1`.
-/

def totient (m : Nat) : Nat :=
  -- sorry
  let coprimes := List.range (m + 1)
    |>.drop 1
    |>.filter (Nat.gcd · m == 1)
  coprimes.length
  -- sorry

-- The following codes are for test and you should not edit these.

example : totient 1 = 1 := rfl

example : totient 10 = 4 := rfl

example : totient 7 = 6 := rfl

example : totient 70 = 24 := rfl
