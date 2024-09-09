/-
height-balanced binary tree の高さがHのとき、木が最大どれくらいの数のノードを含む可能性があるかを求めると、
MaxN = 2^H - 1 になる。では MinN はどうなるか？

Try to find a recursive statement and turn it into a function minNodes that returns the minimum number of nodes in a height-balanced binary tree of height H.
再帰的な関数 minNodes に変換して、高さ H の高さ平衡二分木に必要な最小ノード数を返すようにしてください。
On the other hand, we might ask: what is the maximum height H a height-balanced binary tree with N nodes can have? Write a function maxHeight that computes this.
一方で、高さ平衡二分木が N 個のノードを持つ場合、その最大の高さ H はどれくらいかを尋ねることができます。この計算を行う関数 maxHeight を作成してください。
Now, we can attack the main problem: construct all the height-balanced binary trees with a given number of nodes. Find out how many height-balanced trees exist for N = 15.
さて、主な問題に取り組みましょう。指定されたノード数で全ての高さ平衡二分木を構築します。N = 15 の場合、いくつの高さ平衡木が存在するかを調べてください。

Example in Haskell:

λ> length $ hbalTreeNodes 'x' 15
1553
λ> map (hbalTreeNodes 'x') [0..3]
[[Empty],
 [Branch 'x' Empty Empty],
 [Branch 'x' Empty (Branch 'x' Empty Empty),Branch 'x' (Branch 'x' Empty Empty) Empty],
 [Branch 'x' (Branch 'x' Empty Empty) (Branch 'x' Empty Empty)]]

-/

/-- monad instance of `List` -/
instance : Monad List where
  pure := @List.pure
  bind := @List.bind
  map := @List.map

/-- binary tree -/
inductive BinTree (α : Type) where
  | empty : BinTree α
  | node : α → BinTree α → BinTree α → BinTree α

deriving DecidableEq, Inhabited

variable {α : Type}

def leaf (a : α) : BinTree α := .node a .empty .empty

section ToString

variable [ToString α]

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

instance : ToString (BinTree α) := ⟨BinTree.toString⟩

end ToString

def BinTree.height (t : BinTree α) : Nat :=
  match t with
  | .empty => 0
  | .node _ l r => 1 + max l.height r.height

#eval BinTree.node () (leaf ()) (leaf ())

/-- construct all balanced binary trees which contains `x` elements -/
partial def cbalTree (x : Nat) : List (BinTree Unit) :=
  -- sorry
  match x with
  | 0 => [.empty]
  | n + 1 => do
    let q := n / 2
    let indices := if n % 2 = 1 then [q, q+1] else [q]
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

/-- construct all balanced binary trees whose height is `height`. -/
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


#eval cbalTree 10
#eval cbalTree 10 |>.length
#eval cbalTree 10 |>.map (·.height)
#eval cbalTree 7 |>.map (·.height) |>.eraseDups
#eval cbalTree 8

-- ノード数を固定した時のcbalTreeの高さは全部一緒(要証明)なので、最大値も最小値も一緒っぽい (maxHeightの話)

def minNodes (height : Nat) : Nat := if height > 0 then 2 ^ (height - 1) else 0

#guard minNodes 1 = 1
#guard minNodes 3 = 4
#guard minNodes 4 = 8
#guard minNodes 5 = 16

def maxHeight (nodeCount : Nat) : Nat := Nat.log2 nodeCount + 1

-- maxHeight ∘ minNodes = id は成り立ちそう
-- minNodes ∘ maxHeight = id は成り立たない
#guard maxHeight 6 = 3
#guard maxHeight 6 ≠ minNodes 3

#guard maxHeight 1 = 1
#guard maxHeight 3 = 2
#guard maxHeight 4 = 3
#guard maxHeight 7 = 3
#guard maxHeight 8 = 4
#guard maxHeight 15 = 4
#guard (cbalTree 15 |>.map (·.height) |>.eraseDups) = [4]
#guard maxHeight 16 = 5
#guard (cbalTree 16 |>.map (·.height) |>.eraseDups) = [5]

def hbalTreeNodes : (nodeCount : Nat) → List (BinTree Unit) := cbalTree

#eval cbalTree 7
#guard cbalTree 7 =
  [BinTree.node () (.node () (leaf ()) (leaf ())) (.node () (leaf ()) (leaf ()))]
#eval BinTree.node () (.node () (.empty) (leaf ())) (.node () (.node () .empty (leaf ())) (leaf ()))

def hoge :=
  BinTree.node () (.node () (.empty) (leaf ())) (.node () (.node () .empty (leaf ())) (leaf ()))

def BinTree.isBalanced {α : Type} : BinTree α → Bool
  | .empty => true
  | .node _ l r =>
    l.isBalanced ∧ r.isBalanced ∧
    Int.natAbs ((l.height : Int) - (r.height : Int)) ≤ 1

def BinTree.nodeCount : BinTree α → Nat
  | .empty => 0
  | .node _ l r => 1 + l.nodeCount + r.nodeCount

-- `hoge ∈ hbalTreeNodees 7` が真でなければならないが、今そうなっていない
#guard hoge.nodeCount = 7
#guard hoge.isBalanced = true

#eval hbalTreeNodes 15
#guard (hbalTreeNodes 15 |>.length) = 1553

#guard (List.range 4 |>.map hbalTreeNodes) = [
  [.empty],
  [leaf ()],
  [.node () .empty (leaf ()), .node () (leaf ()) .empty],
  [.node () (leaf ()) (leaf ())]
]
/-
λ> length $ hbalTreeNodes 'x' 15
1553
λ> map (hbalTreeNodes 'x') [0..3]
[[Empty],
 [Branch 'x' Empty Empty],
 [Branch 'x' Empty (Branch 'x' Empty Empty),Branch 'x' (Branch 'x' Empty Empty) Empty],
 [Branch 'x' (Branch 'x' Empty Empty) (Branch 'x' Empty Empty)]]
-/
