/- # Lean Book
Lean Book is the mdbook template configured for the Lean Project. Intended for use in writing textbooks and documentation in Lean.

## Features
Lean Book has a variety of features.
-/

/-! ### Syntax Highlighting
Here is an example of Lean code block.-/

variable {P Q : Prop}

example : P → (P ∨ Q) := by
  intro hP
  apply Or.inl
  exact hP
