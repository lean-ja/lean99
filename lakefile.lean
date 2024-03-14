import Lake
open Lake DSL

package «Src» where
  -- add package configuration options here
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

lean_lib «Src» where
  -- add library configuration options here
