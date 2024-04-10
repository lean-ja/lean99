/-
# Problem 35
(Intermediate 🌟🌟) Determine the prime factors of a given positive integer.

Construct a flat list containing the prime factors in ascending order.
-/

def primeFactors (n : Nat) : List Nat :=
  -- sorry
  loop n 2 [] |>.reverse
  where loop (tgt candidate : Nat) (acc : List Nat) : List Nat :=
    if tgt ≤ 1 || candidate > tgt then
      acc
    else if tgt % candidate = 0 then
      loop (tgt / candidate) candidate <| candidate :: acc
    else
      loop tgt (candidate + 1) acc

    decreasing_by all_goals sorry
  -- sorry

-- The following codes are for test and you should not edit these.

example : primeFactors 17 = [17] := by native_decide

example : primeFactors 315 = [3, 3, 5, 7] := by native_decide

example : primeFactors 65536 = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2] := by native_decide

example : primeFactors 20063 = [20063] := by native_decide

example : primeFactors 627537863 = [24137, 25999] := by native_decide

example : primeFactors 10963345907 = [104683, 104729] := by native_decide
