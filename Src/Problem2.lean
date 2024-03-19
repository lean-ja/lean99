/-
# Problem 2
(Easy 🌟) Find the last-but-one (or second-last) element of a list.
-/
variable {α : Type}

def myButLast (l : List α) : Option α :=
  -- sorry
  if l.length < 2 then
    none
  else
    let i := l.length - 2;
    match l[i]? with
    | some x => some x
    | none => none
  -- sorry

-- The following code is a test case and you should not change it.

example : myButLast [1, 2, 3, 4] = some 3 := rfl

example : myButLast ['x', 'y', 'z'] = some 'y' := rfl

example : myButLast ([] : List α) = none := rfl

example : myButLast [1] = none := rfl
