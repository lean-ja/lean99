/- # Problem 56

Let us call a binary tree symmetric if you can draw a vertical line through the root node and then the right subtree is the mirror image of the left subtree. Write a predicate symmetric/1 to check whether a given binary tree is symmetric. Hint: Write a predicate mirror/2 first to check whether one tree is the mirror image of another. We are only interested in the structure, not in the contents of the nodes.
-/

inductive BinTree (α : Type) where
  | Empty : BinTree α
  | Node : α → BinTree α → BinTree α → BinTree α
deriving Repr

def leaf {α : Type} (a : α) : BinTree α := .Node a .Empty .Empty

variable {α : Type}

def BinTree.mirror (s t : BinTree α) : Bool :=
  match s, t with
  | .Empty, .Empty => true
  | .Node _ a b, .Node _ x y => mirror a y && mirror b x
  | _, _ => false

def BinTree.isSymmetric (t : BinTree α) : Bool :=
  match t with
  | .Empty => true
  | .Node _ l r => mirror l r

#guard BinTree.isSymmetric (leaf 'x')

#guard ! BinTree.isSymmetric (BinTree.Node 'x' (leaf 'x') BinTree.Empty)

#guard BinTree.isSymmetric (BinTree.Node 'x' (leaf 'x') (leaf 'x'))
