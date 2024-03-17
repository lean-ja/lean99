# Lean 99: Ninety-Nine Lean Probelms

These are Lean translations of [Ninety-Nine Haskell Problems](https://wiki.haskell.org/H-99:_Ninety-Nine_Haskell_Problems), which are themselves translations of [Ninety-Nine Lisp Probelms](https://www.ic.unicamp.br/~meidanis/courses/mc336/problemas-lisp/L-99_Ninety-Nine_Lisp_Problems.html).

## Contributing

All contributions are wellcome! This repository uses external libraries as follows:

* Generate HTML from `.md` files using [mdbook](https://github.com/rust-lang/mdBook).
* Generate `.md` files from `.lean` files in the `md` directory using [md-gen](https://github.com/Seasawher/mdgen).
* The Lean files in the `Src` folder contain the answers to the questions. The answers are deleted using the [mk-exercise](https://github.com/Seasawher/mk-exercise) and output to the `md` folder.
* [import-all](https://github.com/Seasawher/import-all) is used to generate import statements automatically. This is also used in CI.

To contribute to this repository, please follow these steps.

0. Create a new branch.
1. Edit the Lean files in the `Src` folder.
2. Edit [SUMMARY.md](./md/SUMMARY.md) if you are going to add new pages.
3. Run `lake run build`.
4. Commit the changes and open a pull request!