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

universe u

/-- monad instance of `List` -/
instance : Monad List.{u} where
  pure := @List.pure
  bind := @List.bind
  map := @List.map

partial def cbalTree : Nat → List (BinTree Unit)
| 0 => [.Empty]
| n + 1 => do
  let q := n / 2
  let r := n % 2
  let indices := List.range (q+r+1) |>.drop q
  let i ← indices
  let left ← cbalTree i
  let right ← cbalTree (n - i)
  pure (BinTree.Node () left right)

#eval (cbalTree 4)
#eval (cbalTree 6)|>.map BinTree.isBalanced
