/-
# Problem 8
(Intermediate 🌟🌟) Eliminate consecutive duplicates of list elements.
-/
variable {α : Type} [BEq α]

def compress (l : List α) : List α :=
  -- sorry
  match l with
  | [] => []
  | a :: b => a :: comp' b a
  where comp' (ls : List α) (x : α) : List α :=
    match ls with
    | [] => []
    | a' :: l' =>
      if a' == x then
        comp' l' a'
      else
        a' :: comp' l' a'
  -- sorry

-- The following codes are for test and you should not edit these.

example : compress [1, 1, 2, 2, 1, 2, 2] = [1, 2, 1, 2] := by rfl

example : compress ([] : List α) = [] := by rfl

example : compress ['C', 'o', 'o', 'o', 'p', 'y', 'y'] = ['C', 'o', 'p', 'y'] := by rfl
