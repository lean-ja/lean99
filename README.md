# Lean 99: Ninety-Nine Lean Problems

These are Lean translations of [Ninety-Nine Haskell Problems](https://wiki.haskell.org/H-99:_Ninety-Nine_Haskell_Problems), which are themselves translations of [Ninety-Nine Lisp Problems](https://www.ic.unicamp.br/~meidanis/courses/mc336/problemas-lisp/L-99_Ninety-Nine_Lisp_Problems.html).

## Contributing

All contributions are wellcome! This repository uses external libraries as follows:

* Generate HTML from `.md` files using [mdbook](https://github.com/rust-lang/mdBook).
* Generate `.md` files from `.lean` files in the `build` directory using [mdgen](https://github.com/Seasawher/mdgen).
* The Lean files in the `Src` folder contain the answers to the questions. The answers are deleted using the [mk-exercise](https://github.com/Seasawher/mk-exercise) and output to the `build` folder.

To contribute to this repository, please follow these steps.

1. Create a new branch.
2. Edit the Lean files in the `Src` folder.
3. Edit [SUMMARY.md](./md/SUMMARY.md) if you are going to add new pages.
4. Run `lake run build`.
5. To view the preview, run `mdbook serve --open`. Don't forget to run `lake run build` after modifying the `.lean` file in the `Src` directory.
6. Commit the changes and open a pull request!
