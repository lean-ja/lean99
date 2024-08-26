/- # Problem 55
(Intermediate 🌟🌟) Construct completely balanced binary trees.

In a completely balanced binary tree, the following property holds for every node: The number of nodes in its left subtree and the number of nodes in its right subtree are almost equal, which means their difference is not greater than one.

Write a function `cbalTree` to construct completely balanced binary trees for a given number of nodes. The predicate should generate all solutions via backtracking.
-/

inductive BinTree (α : Type) where
  | Empty : BinTree α
  | Node : α → BinTree α → BinTree α → BinTree α
deriving Repr

def leaf {α : Type} (a : α) : BinTree α := .Node a .Empty .Empty

def BinTree.depth {α : Type} : BinTree α → Nat
| .Empty => 0
| .Node _ l r => 1 + max l.depth r.depth

def BinTree.isBalanced {α : Type} : BinTree α → Bool
  | .Empty => true
  | .Node _ l r =>
    l.isBalanced ∧ r.isBalanced ∧
    Int.natAbs ((l.depth : Int) - (r.depth : Int)) ≤ 1

/-- monad instance of `List` -/
instance : Monad List where
  pure := @List.pure
  bind := @List.bind
  map := @List.map

/-- construct all balanced binary trees which contains `x` elements -/
partial def cbalTree (x : Nat) : List (BinTree Unit) :=
  -- sorry
  match x with
  | 0 => [.Empty]
  | n + 1 => do
    let q := n / 2
    let r := n % 2
    let indices := List.range (q+r+1) |>.drop q
    let i ← indices
    let left ← cbalTree i
    let right ← cbalTree (n - i)
    pure (BinTree.Node () left right)
  -- sorry

-- The following codes are for test and you should not edit these.

#eval (cbalTree 3).length = 1
#eval (cbalTree 3)|>.map BinTree.isBalanced |>.and
#eval (cbalTree 4)|>.map BinTree.isBalanced |>.and
#eval (cbalTree 4).length = 4
#eval (cbalTree 5)|>.map BinTree.isBalanced |>.and
#eval (cbalTree 6)|>.map BinTree.isBalanced |>.and
#eval (cbalTree 7).length = 1
