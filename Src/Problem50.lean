set_option autoImplicit false

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

def String.freq (s : String) (c : Char) := s.data.filter (· == c) |>.length

def String.toLeaves (s : String) : List HuffTree :=
  let allChars : List Char := s.data.eraseDups
  allChars.map fun c => HuffTree.Leaf c (s.freq c)

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

partial def HuffTree.merge (leaves : List HuffTree) : List HuffTree :=
  let sorted := leaves |> HuffTree.sort
  match sorted with
  | [] => []
  | [tree] => [tree]
  | t1 :: t2 :: rest =>
    let t' := HuffTree.Node t1 t2
    HuffTree.merge (t' :: rest)

def HuffTree.ofString (msg : String) : HuffTree :=
  msg.toLeaves |> HuffTree.merge |>.head!

def HuffTree.encode (c : Char) : HuffTree → Option String
  | .Leaf c' _ => if c = c' then some "" else none
  | .Node l r =>
    match r.encode c with
    | none => l.encode c |>.map ("0" ++ ·)
    | some s => "1" ++ s

def huffman (input : List (Char × Nat)) : List (Char × String) :=
  let leaves : List HuffTree := input.map (fun (c, w) => HuffTree.Leaf c w)
  let tree : HuffTree := HuffTree.merge leaves |>.head!
  input.map (fun (c, _) => (c, tree.encode c |>.get!))

#guard huffman [('a',45),('b',13),('c',12),('d',16),('e',9),('f',5)] =
  [('a',"0"),('b',"101"),('c',"100"),('d',"111"),('e',"1101"),('f',"1100")]
