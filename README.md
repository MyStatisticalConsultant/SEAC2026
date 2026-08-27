# SEAC 2026 Workshop: Circular Statistics in Archaeoastronomy and Ethnoastronomy Using R

Workshop materials for the **SEAC 2026 Annual Meeting** workshop:

**Circular Statistics in Archaeoastronomy and Ethnoastronomy Using R**  
**Instructor:** Zlatko J. Kovačić  
**Workshop time:** Sunday, 16:00–20:00

This repository contains the complete participant materials for a hands-on methods workshop on circular statistics, directional data and curvigram analysis in **R**.

The workshop is designed primarily for researchers and students in archaeoastronomy, astronomy, archaeology, ethnoastronomy, cultural heritage and related fields. It assumes **no previous R programming experience**. The emphasis is on understanding the statistical method, running prepared and validated code, changing a small number of clearly identified parameters, interpreting the result and exporting reproducible outputs.

> **Core principle:** this is a methods workshop supported by R, not an R-programming course.

---

## What you will learn

The workshop introduces and applies:

- linear versus circular data;
- directional versus axial data;
- geographic azimuth conventions;
- rose diagrams and circular visualisation;
- circular mean direction;
- mean resultant length (`R-bar`);
- circular variance and circular standard deviation;
- confidence intervals for the mean direction;
- the Rayleigh test for a unimodal preferred direction;
- a brief introduction to the von Mises distribution;
- transparent curvigram construction;
- measurement uncertainty and observation-specific bandwidths;
- Epanechnikov and Gaussian kernels;
- area-normalised density;
- sensitivity analysis across kernel and bandwidth choices;
- reproducible export of figures, numerical results and Word tables;
- careful use of AI as an R assistant;
- the **Curvigram Explorer** Shiny application.

The workshop repeatedly emphasises an important interpretive rule:

> A statistical concentration or curvigram peak is evidence of a pattern. It is not, by itself, proof of intentional astronomical or cultural targeting.

---

## Repository contents

The main repository structure is:

```text
SEAC2026/
|
|-- SEAC2026_Circular_Statistics.Rproj
|
|-- 01_WORKSHOP/
|   |-- SEAC2026_Workshop_Guide.pdf
|   |-- SEAC2026_Workshop_Guide.md
|   |-- 01_Dataset1_Circular_Statistics_BEGINNER.R
|   |-- 01B_VonMises_OPTIONAL.R
|   |-- 01_Exercise_Dataset1_Circular_Statistics.md
|   |-- 02_Dataset2_Curvigram_BEGINNER.R
|   |-- 02_Exercise_Dataset2_Curvigram.md
|   |-- 02_Curvigram_Reporting_Template.md
|   |-- 03_Dataset3_Ethno_Comparison_BEGINNER.R
|   `-- 03_Exercise_Dataset3_Ethno_Comparison.md
|
|-- 02_DATA/
|   |-- 01_orientation_basics.csv
|   |-- 02_megalithic_curvigram.csv
|   `-- 03_ethno_directions.csv
|
|-- 04_REFERENCE/
|   |-- Circular_Statistics_Cheat_Sheet.pdf
|   |-- Which_Method_Should_I_Use.pdf
|   |-- Curvigram_Explained.pdf
|   |-- AI_R_Assistant_Prompt_Card.pdf
|   |-- Further_Reading.pdf
|   |
|   |-- BOOK/
|   |   `-- Tadic&Kovacic~Orientation.pdf
|   |
|   |-- POSTERS/
|   |   |-- Circular_Statistics_Cheat_Sheet_Poster.png
|   |   |-- SEAC2026_circular.pdf
|   |   |-- SEAC2026_method.pdf
|   |   `-- Which_Method_Should_I_Use_Poster.png
|   |
|   `-- PRESENTATION/
|       `-- SEAC2026_Circular_Statistics_Workshop_Slides.pptx
|
`-- 05_OUTPUT/
    |-- Dataset1/
    |-- Dataset2/
    `-- Dataset3/
```

The exact contents may grow slightly as workshop materials are updated. Participants normally work with `01_WORKSHOP`, `02_DATA`, `04_REFERENCE` and their own files created under `05_OUTPUT`.

---

## Workshop datasets

The repository contains three small teaching datasets.

### Dataset 1 — circular-statistics fundamentals

`02_DATA/01_orientation_basics.csv`

A synthetic dataset of 40 hypothetical Orthodox-church orientations. It is used to demonstrate rose diagrams, circular mean direction, `R-bar`, circular variance, circular SD, confidence intervals and the Rayleigh test.

### Dataset 2 — curvigram and sensitivity analysis

`02_DATA/02_megalithic_curvigram.csv`

A synthetic dataset of 45 hypothetical megalithic observations with astronomical declination and reported measurement uncertainty. It is used to construct and interpret curvigrams and to compare reasonable kernel/bandwidth specifications.

### Dataset 3 — optional subgroup example

`02_DATA/03_ethno_directions.csv`

A fictional ethnoastronomical example showing how two strongly concentrated but approximately opposite groups can cancel when pooled. It demonstrates why a small `R-bar` or non-significant Rayleigh test does not necessarily imply uniformity.

**These three workshop datasets are synthetic/fictional teaching data and must not be interpreted as empirical archaeological findings.**

---

## Software requirements

The workshop uses **R** through **RStudio Desktop**.

### Recommended software

The workshop environment was prepared and tested with:

- **R 4.6.1**
- **RStudio Desktop 2026.07.1**

A later compatible version will usually work, but using the tested versions is the safest option if you want to reproduce the workshop environment as closely as possible.

Official downloads:

- R: <https://cran.r-project.org/>
- RStudio Desktop: <https://posit.co/download/rstudio-desktop/>

Install **R first**, then install **RStudio Desktop**.

---

## Required R packages

The participant R scripts use the following packages:

```text
circular
readr
dplyr
tibble
ggplot2
ragg
officer
flextable
```

You can install any missing packages from within RStudio with:

```r
required_packages <- c(
  "circular",
  "readr",
  "dplyr",
  "tibble",
  "ggplot2",
  "ragg",
  "officer",
  "flextable"
)

missing_packages <- setdiff(
  required_packages,
  rownames(installed.packages())
)

if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}
```

After installation, restart RStudio if necessary.

---

## How to download the complete workshop materials

### Option 1 — Download ZIP from GitHub

This is the easiest method for most participants.

1. Open this GitHub repository.
2. Click the green **Code** button.
3. Choose **Download ZIP**.
4. Save the ZIP file to your computer.
5. Extract the ZIP into a normal writable folder, for example your Documents folder.
6. Do **not** run the workshop directly from inside the ZIP archive.

After extraction, keep the complete folder structure unchanged.

### Option 2 — Clone with Git

If you already use Git:

1. Click **Code** in this repository.
2. Copy the HTTPS repository address.
3. Run:

```bash
git clone <paste-the-repository-HTTPS-address-here>
```

No Git knowledge is required for the workshop; downloading the ZIP is perfectly adequate.

---

## Starting the workshop on your own computer

After downloading and extracting the repository:

1. Install R.
2. Install RStudio Desktop.
3. Install the required R packages listed above.
4. Open the repository folder.
5. Double-click:

```text
SEAC2026_Circular_Statistics.Rproj
```

6. In RStudio, open:

```text
01_WORKSHOP/SEAC2026_Workshop_Guide.pdf
```

or the Markdown version:

```text
01_WORKSHOP/SEAC2026_Workshop_Guide.md
```

7. Start with:

```text
01_WORKSHOP/01_Dataset1_Circular_Statistics_BEGINNER.R
```

Run the current line or selected code with:

```text
Ctrl + Enter
```

### Important: do not use `setwd()`

The workshop project is designed to use project-relative file paths.

If R reports that it cannot find a data file, first check that you opened:

```text
SEAC2026_Circular_Statistics.Rproj
```

Do not solve the problem by adding a personal path such as:

```r
setwd("C:/Users/MyName/Documents/...")
```

---

## Suggested order for self-study

If you are using the repository after the conference, a useful sequence is:

1. read the relevant sections of `SEAC2026_Workshop_Guide`;
2. run Dataset 1 from a clean R session;
3. reproduce the circular-statistics outputs;
4. run Dataset 2 and reproduce the four curvigram sensitivity specifications;
5. run the optional Dataset 3 example;
6. use the reference sheets in `04_REFERENCE`;
7. open the workshop presentation in `04_REFERENCE/PRESENTATION`;
8. try the Curvigram Explorer with the synthetic workshop data;
9. adapt one validated R script to a small dataset of your own;
10. keep the final script, data definitions, software information and exported outputs with your research files.

---

## Curvigram Explorer

The **Curvigram Explorer** is a companion Shiny application intended to reduce coding friction after participants understand the methodological choices demonstrated in the R scripts.

Live application:

<https://statisticar-curvigram-explorer.share.connect.posit.cloud/>

The app includes, among other features:

- built-in demonstration data;
- CSV upload;
- linear and circular geometry;
- Epanechnikov and Gaussian kernels;
- uncertainty-based and fixed bandwidths;
- bandwidth-multiplier controls;
- area-normalised, raw and maximum-normalised scales;
- circular descriptive statistics;
- enhanced rose diagrams;
- Rayleigh testing;
- Monte Carlo reference/null options;
- downloadable figures and numerical results;
- help material in English, Greek and Serbian-Latin.

The app is a convenience interface. It does not remove the need to document and justify the analytical choices.

---

## Reference material

The `04_REFERENCE` folder contains quick-reference sheets, posters, the workshop presentation and a full applied book.

### Book

The workshop includes:

**Tadić, M. & Kovačić, Z. J. (2025). _Astronomical orientation of medieval Orthodox churches and mosques (XV–XVI centuries) in former Yugoslavia: Circular statistical analysis in R._**

File:

```text
04_REFERENCE/BOOK/Tadic&Kovacic~Orientation.pdf
```

The book provides substantially more extensive applications of circular statistics in R, including real archaeological and architectural data, graphical methods, circular distributions, statistical tests and exercises.

### Posters

Printable/reference posters are available in:

```text
04_REFERENCE/POSTERS/
```

### Presentation

The workshop PowerPoint presentation is available in:

```text
04_REFERENCE/PRESENTATION/
```

---

## Reproducible outputs

The scripts demonstrate how to export:

- 300 dpi PNG figures;
- 600 dpi PNG figures;
- calculated curves as CSV;
- formatted Word (`.docx`) output.

Generated participant files are placed under:

```text
05_OUTPUT/Dataset1/
05_OUTPUT/Dataset2/
05_OUTPUT/Dataset3/
```

Keeping the original scripts together with exported outputs makes the analysis easier to reproduce and audit later.

---

## Troubleshooting

### `object not found`

You may have skipped the line that creates the object.

**Fix:** rerun the current section from its beginning.

### `could not find function ...`

The required package may not be loaded or installed.

**Fix:** install the package if necessary and rerun the package-loading section.

### `file does not exist`

The RStudio project root is probably wrong.

**Fix:** open `SEAC2026_Circular_Statistics.Rproj`.

### The plot differs from the workshop example

Check that you are using the same:

- dataset;
- script version;
- rose-diagram bin count;
- kernel;
- bandwidth multiplier;
- plotting range;
- calculation step.

### The Rayleigh test is non-significant but the plot is clearly structured

Check whether the distribution is bimodal or multimodal. Dataset 3 was designed specifically to demonstrate this issue.

---

## Licence

This repository uses a **dual licence**:

- **R source code (`.R`)**: [MIT License](LICENSE)
- **workshop documentation, synthetic teaching datasets, reference sheets, presentation and original workshop graphics/posters**: [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/), unless a file states otherwise.

The book in `04_REFERENCE/BOOK/` is a separately published work and retains the copyright and licence notice printed inside that PDF. It is **not relicensed** by the repository-level CC BY 4.0 licence.

See the repository [`LICENSE`](LICENSE) file for details.

---

## Attribution

For the repository as a whole, a suggested attribution is:

> Kovačić, Z. J. (2026). *Circular Statistics in Archaeoastronomy and Ethnoastronomy Using R: SEAC 2026 Workshop Materials*. GitHub repository: `SEAC2026`.

If you adapt a specific figure, poster, dataset or script, please also identify the item used and indicate any changes you made.

---

## Feedback

If you encounter a reproducibility problem, unclear instruction or possible error, please open a GitHub Issue if Issues are enabled for this repository. When reporting an R problem, include:

- the script name;
- the exact error message;
- your R version;
- your operating system;
- the relevant package version if known.

---

## Copyright

Copyright © 2026 Zlatko J. Kovačić.

See [`LICENSE`](LICENSE) for the dual-licence terms and for exceptions applying to separately licensed material.
