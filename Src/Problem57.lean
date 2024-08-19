/- # Problem 57

Use the predicate add/3, developed in chapter 4 of the course, to write a predicate to construct a binary search tree from a list of integer numbers.
-/

inductive BinTree (α : Type) where
  | Empty : BinTree α
  | Node : α → BinTree α → BinTree α → BinTree α
deriving Repr

def leaf {α : Type} (a : α) : BinTree α := .Node a .Empty .Empty

variable {α : Type}

instance [Ord α] : Max α where
  max x y :=
    match compare x y with
    | .lt => y
    | _ => x

def BinTree.max [Ord α] (t : BinTree α) : Option α :=
  match t with
  | .Empty => none
  | .Node v l r =>
    let left_max := (max l).getD v
    let right_max := (max r).getD v
    some <| [v, left_max, right_max].foldl Max.max v

def BinTree.searchTree [Ord α] (t : BinTree α) : Bool :=
  match t with
  | .Empty => true
  | .Node v l r =>
    let left_max := (max l).getD v
    let right_max := (max r).getD v
    match compare left_max v, compare v right_max with
    | _, .gt => false
    | .gt, _ => false
    | _, _ => searchTree l && searchTree r

#guard BinTree.Node 3 (.Node 2 (leaf 1) .Empty) (.Node 5 .Empty (leaf 7)) |>.searchTree

def BinTree.searchTreeFromList [Ord α] (xs : List α) : BinTree α :=
  xs.foldl insert BinTree.Empty
where
  insert : BinTree α → α → BinTree α
  | .Empty, x => leaf x
  | .Node v l r, x =>
    match compare x v with
    | .lt => BinTree.Node v (insert l x) r
    | _ => BinTree.Node v l (insert r x)

#guard BinTree.searchTreeFromList [3, 2, 5, 7, 1] |>.searchTree
