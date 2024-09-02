/- # Problem 58

Apply the generate-and-test paradigm to construct all symmetric, completely balanced binary trees with a given number of nodes.
-/

/-- binary tree -/
inductive BinTree (α : Type) where
  | empty : BinTree α
  | node : α → BinTree α → BinTree α → BinTree α

def leaf {α : Type} (a : α) : BinTree α := .node a .empty .empty

variable {α : Type} [ToString α]

def String.addIndent (s : String) (depth : Nat) : String :=
  Nat.repeat (fun s => " " ++ s) depth s

def BinTree.toString (tree : BinTree α) : String :=
  aux tree 2
where
  aux (tree : BinTree α) (depth : Nat) : String :=
    match tree with
    | .node v .empty .empty => s!"leaf {v}"
    | .node v l r =>
      let ls := aux l (depth + 2)
      let rs := aux r (depth + 2)
      s!".node {v}\n" ++ s!"{ls}\n".addIndent depth ++ s!"{rs}\n".addIndent depth
    | .empty => "empty"

instance {α : Type} [ToString α] : ToString (BinTree α) := ⟨BinTree.toString⟩

#eval BinTree.node 3 (.node 2 (leaf 1) .empty) (.node 5 .empty (leaf 7))

#eval BinTree.node 'x' (leaf 'x') (leaf 'x')

#eval BinTree.node 'x' .empty (leaf 'x')

#eval BinTree.node 'x' (leaf 'x') .empty

/-- monad instance of `List` -/
instance : Monad List where
  pure := @List.pure
  bind := @List.bind
  map := @List.map

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

def BinTree.mirror (s t : BinTree α) : Bool :=
  match s, t with
  | .empty, .empty => true
  | .node _ a b, .node _ x y => mirror a y && mirror b x
  | _, _ => false

def BinTree.isSymmetric (t : BinTree α) : Bool :=
  match t with
  | .empty => true
  | .node _ l r => mirror l r

/-- construct all balanced, symmetric binary trees with given number of elements -/
def symCbalTrees (n : Nat) : List (BinTree Unit) :=
  -- sorry
  cbalTree n |>.filter BinTree.isSymmetric
  -- sorry

-- The following codes are for test and you should not edit these.

#guard (symCbalTrees 5).length = 2
#guard (symCbalTrees 6).length = 0
#guard (symCbalTrees 7).length = 1
#guard (symCbalTrees 8).length = 0
