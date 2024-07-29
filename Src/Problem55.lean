/- # Problem 55
(Intermediate 🌟🌟) Construct completely balanced binary trees.
-/

inductive BinTree (α : Type)where
  | Empty : BinTree α
  | Node : α → BinTree α → BinTree α → BinTree α
deriving Repr

def BinTree.depth {α : Type} : BinTree α → Nat
| .Empty => 0
| .Node _ l r => 1 + max l.depth r.depth

def BinTree.isBalanced {α : Type} : BinTree α → Bool
  | .Empty => true
  | .Node _ l r =>
    l.isBalanced ∧ r.isBalanced ∧
    Int.natAbs ((l.depth : Int) - (r.depth : Int)) ≤ 1

def leaf {α : Type} (a : α) : BinTree α := .Node a .Empty .Empty

def goodTree : BinTree Nat := .Node 3 (leaf 9) (.Node 20 (leaf 15) (leaf 7))

#eval goodTree.isBalanced

def badTree : BinTree Nat :=
.Node 1 (
  .Node 2
    (.Node 3
      (leaf 4)
      (leaf 4)
    )
    (leaf 3)
  )
  (leaf 2)

#eval badTree.isBalanced
