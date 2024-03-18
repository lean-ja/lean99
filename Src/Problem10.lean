/-
# Problem 10
Use the result of Problem 9 to implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as lists `(N, E)` where `N` is the number of duplicates of the element `E`.
-/
variable {α : Type} [BEq α] [Inhabited α]

def pack (l : List α) : List (List α) :=
  -- sorry
  match l with
  | [] => []
  | [a] => [[a]]
  | a :: b :: t =>
    let p := pack (b :: t)
    if a != b then
      [a] :: p
    else
      ([a] ++ p.head!) :: p.tail!
  -- sorry

def encode (l : List α) : List (Nat × α) :=
  -- sorry
  pack l |>.map fun x => (x.length, x.head!)
  -- sorry

-- The following code is a test case and you should not change it.

example : encode [1, 1, 2, 2, 2, 3, 4, 4, 4, 4] = [(2, 1), (3, 2), (1, 3), (4, 4)] := rfl

example : encode ['a', 'a', 'b', 'c', 'c'] = [(2, 'a'), (1, 'b'), (2, 'c')] := rfl

example : encode [1, 1] = [(2, 1)] := rfl

example : encode ([] : List α) = [] := rfl
