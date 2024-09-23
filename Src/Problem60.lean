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

def BinTree.nodeCount : BinTree α → Nat
  | .empty => 0
  | .node _ l r => 1 + l.nodeCount + r.nodeCount

def BinTree.isCompletelyBalanced {α : Type} : BinTree α → Bool
  | .empty => true
  | .node _ l r =>
    l.isCompletelyBalanced ∧ r.isCompletelyBalanced ∧
    Int.natAbs ((l.nodeCount : Int) - (r.nodeCount : Int)) ≤ 1

def BinTree.isHeightBalanced {α : Type} : BinTree α → Bool
  | .empty => true
  | .node _ l r => Int.natAbs ((l.height : Int) - (r.height : Int)) ≤ 1


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

#eval cbalTree 10
#eval cbalTree 10 |>.length
#eval cbalTree 10 |>.map (·.height)
#eval cbalTree 7 |>.map (·.height) |>.eraseDups
#eval cbalTree 8

-- ノード数を固定した時のcbalTreeの高さは全部一緒(要証明)なので、最大値も最小値も一緒っぽい (maxHeightの話)

/--
completely balanced binary treeのうち，高さがheightの木のノード数の最小値
-/
def minNodes (height : Nat) : Nat := if height > 0 then 2 ^ (height - 1) else 0

#guard minNodes 1 = 1
#guard minNodes 3 = 4
#guard minNodes 4 = 8
#guard minNodes 5 = 16

/--
completely balanced binary treeのうち，高さがheightの木のノード数の最大値
-/
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

/-
## `hbalTreeNodes` (指定されたノード数の高さ平衡二分木を列挙する関数) の実装
-/

/-- hになる2つの数を列挙する補助関数 -/
def possiblePairs (n : Nat) : List (Nat × Nat) :=
  let «0..n-1» := List.range n
  let l := «0..n-1».map (fun x => (n, x))
  let r := «0..n-1».map (fun x => (x, n))
  (n, n) :: (l ++ r)

/-- 指定された高さの木を全て列挙する(平衡でなくても構わない) -/
partial def treeOfHeight : Nat → List (BinTree Unit)
  | 0 => [.empty]
  -- | 1 => [leaf ()]
  | h + 1 => do
    let (hl, hr) ← possiblePairs h
    let l ← treeOfHeight hl
    let r ← treeOfHeight hr
    return .node () l r

/--
指定された高さの高さ平衡木を全て列挙する
(Problem59 の解答は多分間違ってる)
-/
partial def hbalTrees : Nat -> List (BinTree Unit)
  | 0 => [.empty]
  | 1 => [leaf ()]
  | h => do
    let (hl, hr) ← [(h-2, h-1), (h-1, h-1), (h-1, h-2)]
    let l ← treeOfHeight hl
    let r ← treeOfHeight hr
    return .node () l r

/-- 指定されたノード数を持つ、height-balancedな木を全て列挙する -/
def hbalTreeNodes (nodeCount : Nat) : List (BinTree Unit) :=
  /-
    **実装の計画**
    1. minHeightとmaxHeightを出して、[minHeight, .. , maxHeight]のリストを作る
    2. `hbalTrees`(高さ平衡木を全列挙する関数)から要素数が`nodeCount`なものだけをfilterする
  -/
  let minHeight := Nat.log2 nodeCount + 1
  dbg_trace "minHeight: {minHeight}"
  let maxHeight := (nodeCount) / 2 + 1
  dbg_trace "maxHeight: {maxHeight}"
  do
    let h ← List.range (maxHeight + 1)|>.drop (minHeight)
    -- heightがh, nodeCountがnodeCountの木を全列挙
    (hbalTrees h).filter (·.nodeCount = nodeCount)

#eval hbalTreeNodes 5
#eval (hbalTreeNodes 5).length

/-- ノード数が7のheight-balancedな木 -/
def hoge :=
  BinTree.node () (.node () (.empty) (leaf ())) (.node () (.node () .empty (leaf ())) (leaf ()))

-- `hoge ∈ hbalTreeNodees 7` が真でなければならないが、今そうなっていない
#guard hoge.nodeCount = 7
#guard hoge.isCompletelyBalanced = true
#guard hoge.isHeightBalanced = true
#guard hoge ∈ hbalTreeNodes 7

/-
## 問題文の実行例との比較
-/

-- #eval hbalTreeNodes 15
-- #guard (hbalTreeNodes 15 |>.length) = 1553
#eval hbalTreeNodes 0
#eval hbalTreeNodes 1
#eval hbalTreeNodes 2
#eval hbalTreeNodes 3

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
