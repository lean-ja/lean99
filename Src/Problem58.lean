/- # Problem 58

Apply the generate-and-test paradigm to construct all symmetric, completely balanced binary trees with a given number of nodes.
-/

/-- binary tree -/
inductive BinTree (α : Type) where
  | Empty : BinTree α
  | Node : α → BinTree α → BinTree α → BinTree α

def leaf {α : Type} (a : α) : BinTree α := .Node a .Empty .Empty

variable {α : Type} [ToString α]

def String.addIndent (s : String) (depth : Nat) : String :=
  Nat.repeat (fun s => " " ++ s) depth s

def BinTree.toString (tree : BinTree α) : String :=
  aux tree 2
where
  aux (tree : BinTree α) (depth : Nat) : String :=
    match tree with
    | .Node v .Empty .Empty => s!"leaf {v}"
    | .Node v l r =>
      let ls := aux l (depth + 2)
      let rs := aux r (depth + 2)
      s!".Node {v}\n" ++ s!"{ls}\n".addIndent depth ++ s!"{rs}\n".addIndent depth
    | .Empty => "Empty"

instance {α : Type} [ToString α] : ToString (BinTree α) := ⟨BinTree.toString⟩

#eval BinTree.Node 3 (.Node 2 (leaf 1) .Empty) (.Node 5 .Empty (leaf 7))

#eval BinTree.Node 'x' (leaf 'x') (leaf 'x')

#eval BinTree.Node 'x' .Empty (leaf 'x')

#eval BinTree.Node 'x' (leaf 'x') .Empty
