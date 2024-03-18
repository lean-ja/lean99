/-
# Problem 10
Implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as lists `(N, E)` where `N` is the number of duplicates of the element `E`.
-/
variable {α : Type} [BEq α]

def encode (l : List α) : List (Nat × α) :=
  -- sorry
  match l with
  | [] => []
  | h :: t =>
    let (a, b) := t.span (· == h)
    (a.length + 1, h) :: encode b
  -- sorry

  -- Avoid proving that the function terminates as a recursive function.
  -- You don't have to fill in the `sorry` here.
  decreasing_by sorry

-- The following code is a test case and you should not change it.

example : encode [1, 1, 2, 2, 2, 3, 4, 4, 4, 4] = [(2, 1), (3, 2), (1, 3), (4, 4)] := rfl

example : encode ['a', 'a', 'b', 'c', 'c'] = [(2, 'a'), (1, 'b'), (2, 'c')] := rfl

example : encode [1, 1] = [(2, 1)] := rfl

example : encode ([] : List α) = [] := rfl
