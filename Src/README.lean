/- # Lean Book
Lean Book is the mdbook template configured for the Lean Project.
-/

/-! ## Syntax Highlighting
Here is an example of Lean code block.-/

variable {P Q : Prop}

example : P → (P ∨ Q) := by
  intro hP
  apply Or.inl
  exact hP
