/-
# Problem 32
(Intermediate 🌟🌟) Determine the greatest common divisor of two positive integer numbers. Use the Euclid's algorithm.
-/

/-- Euclidean algorithm -/
def gcd (m n : Nat) : Nat :=
  -- sorry
  if m = 0 then
    n
  else
    gcd (n % m) m
  -- sorry

  -- Avoid proving that the function terminates as a recursive function.
  -- You don't have to fill in the `sorry` here.
  decreasing_by sorry

-- The following codes are for test and you should not edit these.

example : gcd 6 0 = 6 := by first | native_decide | rfl

example : gcd 1 37 = 1 := by first | native_decide | rfl

example : gcd 6 15 = 3 := by first | native_decide | rfl

example : gcd 21 3 = 3 := by first | native_decide | rfl

example : gcd 42998431 120019 = 1 := by first | native_decide | rfl
