/- # How to Use

0. Install mdbook and Lean.

1. Clone this repository. Alternatively, select "Use this template" from the GitHub web UI. 

2. Change the directory name `Src` if you want. At the same time, replace `Src` in `lakefile.lean`, `ci.yml`, `deploy.yml` and `filePlay.js`. And run `lake update`.

3. If you want to use mathlib, make changes to `ci.yml` to run `lake exe cache get`.

4. After updating the Lean file, run `lake run build`. This will generate markdown with mdgen, HTML with mdbook and import statements with import-check.

5. Run `mdbook serve --open` to see the preview.

6. Push to GitHub. The workflow for deploy has already been set up, so you can publish it as a web page by enabling deploy to GitHub Pages via GitHub Action from the repository settings.
-/
