/-
# Problem 32
Determine the greatest common divisor of two positive integer numbers. Use the Euclid's algorithm.
-/

/-- Euclidean algorithm -/
def gcd (m n : Nat) : Nat :=
  -- sorry
  if m = 0 then
    n
  else
    gcd (n % m) m
  -- sorry

  -- Avoid proving that `gcd` terminates as a recursive function.
  -- You don't have to fill in the `sorry` here.
  termination_by m
  decreasing_by sorry

-- The following code is a test case and you should not change it.

example : gcd 6 0 = 6 := by first | native_decide | rfl

example : gcd 1 37 = 1 := by first | native_decide | rfl

example : gcd 6 15 = 3 := by first | native_decide | rfl

example : gcd 21 3 = 3 := by first | native_decide | rfl

example : gcd 42998431 120019 = 1 := by first | native_decide | rfl
