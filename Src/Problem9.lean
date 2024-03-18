/-
# Problem 9
Pack consecutive duplicates of list elements into sublists.
-/
variable {α : Type} [BEq α]

def pack (l : List α) : List $ List α :=
  -- sorry
  match l with
  | [] => [[]]
  | [a] => [[a]]
  | a :: b :: as =>
    let ps := pack (b :: as)
    if a != b then
      [a] :: ps
    else
      (a :: ps.head!) :: ps.tail!
  -- sorry

-- The following code is a test case and you should not change it.

example : pack ([] : List α) = [[]] := rfl

example : pack [1] = [[1]] := rfl

example : pack [0, 0, 1, 0] = [[0, 0], [1], [0]] := rfl

example : pack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']
  = [['a', 'a', 'a', 'a'], ['b'], ['c', 'c'], ['a', 'a'], ['d'], ['e', 'e', 'e', 'e']] := rfl
