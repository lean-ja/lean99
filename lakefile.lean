import Lake
open Lake DSL

package «lean99» where
  -- add package configuration options here
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

@[default_target]
lean_lib «Src» where
  globs := #[.submodules `Src]
  -- add library configuration options here

require «mk-exercise» from git
  "https://github.com/Seasawher/mk-exercise" @ "lean/v4.10.0"

require mdgen from git
  "https://github.com/Seasawher/mdgen" @ "main"

def runCmd (cmd : String) (args : Array String) : ScriptM Bool := do
  let out ← IO.Process.output {
    cmd := cmd
    args := args
  }
  let hasError := out.exitCode != 0
  if hasError then
    IO.eprint out.stderr
  return hasError

script build do
  if ← runCmd "lake" #["exe", "mk_exercise", "Src", "build"] then return 1
  if ← runCmd "lake" #["exe", "mdgen", "build", "md/build"] then return 1
  if ← runCmd "mdbook" #["build"] then return 1
  return 0
