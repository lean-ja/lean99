set_option autoImplicit false

def plain := "BACADAEAFABBAAAGAH"

def Encoder := Char → String

def encoder₁ : Encoder
  | 'A' => "000" | 'B' => "001" | 'C' => "010" | 'D' => "011"
  | 'E' => "100" | 'F' => "101" | 'G' => "110" | 'H' => "111"
  | _ => ""

def encode (f : Encoder) (p : String) : String :=
  p.data.foldl (fun acc x => acc ++ f x) ""

def encoder₂ : Encoder
  | 'A' => "0" | 'B' => "100" | 'C' => "1010" | 'D' => "1011"
  | 'E' => "1100" | 'F' => "1101" | 'G' => "1110" | 'H' => "1111"
  | _ => ""

#guard encode encoder₁ plain =
  "001000010000011000100000101000001001000000000110000111"
#guard encode encoder₂ plain =
  "100010100101101100011010100100000111001111"

inductive HuffTree where
  | Node (left : HuffTree) (right : HuffTree)
  | Leaf (c : Char) (weight : Nat)
deriving Inhabited

def HuffTree.toString' : HuffTree → String × Nat
  | .Leaf c w => (c.toString, w)
  | .Node l r =>
    let (ls, lw) := l.toString'
    let (rs, rw) := r.toString'
    (ls ++ rs, lw + rw)

def HuffTree.toString (t : HuffTree) : String :=
  match t with
  | .Leaf c w => s!"({c} {w})"
  | .Node _ _ =>
    let (s, w) := t.toString'
    let s' := " ".intercalate <| s.data.map (·.toString)
    "({" ++ s' ++ "} " ++ ToString.toString w ++ ")"

instance : ToString HuffTree := ⟨HuffTree.toString⟩

#eval "aaabc".data.eraseDups

def String.freq (s : String) (c : Char) := s.data.filter (· == c) |>.length

def String.toLeaves (s : String) : List HuffTree :=
  let allChars : List Char := s.data.eraseDups
  allChars.map fun c => HuffTree.Leaf c (s.freq c)

#eval plain.toLeaves
#eval HuffTree.Node (HuffTree.Leaf 'c' 1) (HuffTree.Leaf 'd' 1)

variable {α : Type}

/-- Insert an element in a way that
does not break the order of the sorted list. -/
def orderedInsert (a : α) (ord : α → Nat) : List α → List α
  | [] => [a]
  | b :: l =>
    if ord a ≤ ord b then a :: b :: l
    else b :: orderedInsert a ord l

/-- insertion sort -/
def insertionSort (ord : α → Nat) : List α → List α
  | [] => []
  | b :: l => orderedInsert b ord <| insertionSort ord l

def HuffTree.weight : HuffTree → Nat
  | Leaf _ w => w
  | Node l r => l.weight + r.weight

def HuffTree.sort (trees : List HuffTree) : List HuffTree := insertionSort (HuffTree.weight) trees

#eval plain.toLeaves |> HuffTree.sort

partial def HuffTree.merge (leaves : List HuffTree) : List HuffTree :=
  let sorted := leaves |> HuffTree.sort
  dbg_trace sorted
  match sorted with
  | [] => []
  | [tree] => [tree]
  | t1 :: t2 :: rest =>
    let t' := HuffTree.Node t1 t2
    HuffTree.merge (t' :: rest)

def HuffTree.ofString (msg : String) : HuffTree :=
  msg.toLeaves |> HuffTree.merge |>.head!

#eval HuffTree.ofString plain
