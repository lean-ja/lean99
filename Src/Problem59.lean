/- # Problem 59

Construct height-balanced binary trees.
-/

/-- binary tree -/
inductive BinTree (α : Type) where
  | empty : BinTree α
  | node : α → BinTree α → BinTree α → BinTree α

deriving Repr

def leaf {α : Type} (a : α) : BinTree α := .node a .empty .empty

variable {α : Type} [ToString α]

def BinTree.height (t : BinTree α) : Nat :=
  match t with
  | .empty => 0
  | .node _ l r => 1 + max l.height r.height

namespace ListMonad

/-- monad instance of `List` -/
scoped instance : Monad List where
  pure := List.singleton
  bind := List.flatMap
  map := List.map

end ListMonad

open scoped ListMonad

/-- construct all balanced binary trees which contains `x` elements -/
partial def cbalTree (x : Nat) : List (BinTree Unit) :=
  -- sorry
  match x with
  | 0 => [.empty]
  | n + 1 => do
    let q := n / 2
    let r := n % 2
    let indices := List.range (q+r+1) |>.drop q
    let i ← indices
    let left ← cbalTree i
    let right ← cbalTree (n - i)
    pure (BinTree.node () left right)
  -- sorry

variable {β : Type}

def List.product (as : List α) (bs : List β) : List (α × β) := do
  let a ← as
  let b ← bs
  return (a, b)

/-- construct all balanced binary trees whose hight is `height`. -/
def hbalTrees (height : Nat) : List (BinTree Unit) :=
  -- sorry
  match height with
  | 0 => [.empty]
  | 1 => [leaf ()]
  | h + 2 =>
    let t1s := hbalTrees (h + 1)
    let t2s := hbalTrees h
    let ts := List.product t1s t2s ++ List.product t2s t1s
    ts.map fun (t1, t2) => BinTree.node () t1 t2
  -- sorry

-- The following codes are for test and you should not edit these.

#guard (hbalTrees 2 |>.length) = 2
#guard (hbalTrees 3 |>.length) = 4
