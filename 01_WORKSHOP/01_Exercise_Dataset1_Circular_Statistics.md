# Exercise 1 — Circular-statistics fundamentals

**SEAC 2026 workshop**  
**Dataset:** `02_DATA/01_orientation_basics.csv`  
**R script:** `01_WORKSHOP/01_Dataset1_Circular_Statistics_BEGINNER.R`

## Purpose

This exercise introduces the minimum circular-statistical workflow needed for directional archaeoastronomical data.

The dataset contains **40 synthetic Orthodox-church orientations**. The values are teaching data only and must not be treated as empirical measurements from real sites.

The main longitudinal direction is defined **from entrance toward apse**, so the measurements are directional rather than merely axial.

## Learning objectives

By the end of the exercise you should be able to:

1. explain why ordinary arithmetic statistics can fail for directions;
2. convert azimuths into an R `circular` object;
3. inspect individual directions and a rose diagram;
4. calculate and interpret mean direction;
5. calculate and interpret mean resultant length (R-bar);
6. calculate circular variance and circular standard deviation;
7. obtain a 95% bootstrap confidence interval for mean direction;
8. perform and interpret the Rayleigh test;
9. export a print-ready PNG and formatted Word results table;
10. distinguish a statistical directional pattern from an archaeological claim of intentional alignment.

---

## Part A — Why circular statistics?

Run Section 2 of the R script.

The four observations are:

```text
358°, 359°, 1°, 2°
```

Answer:

1. What is the ordinary arithmetic mean?
2. Where are the four observations actually concentrated?
3. What is the circular mean?
4. In one sentence: why is the ordinary arithmetic mean misleading here?

---

## Part B — Import and define the archaeological data

Run Sections 3 and 4.

Check:

- How many observations are present?
- What is the minimum observed azimuth?
- What is the maximum observed azimuth?
- What does `template = "geographics"` mean?

### Directional or axial?

The workshop defines each orientation **from entrance toward apse**.

Explain why this makes the data directional.

Then consider the alternative situation in which you knew only the building's undirected longitudinal axis. Would 90° and 270° then describe different axes or the same axis?

---

## Part C — Visual inspection

Run Sections 5 and 6.

First inspect the individual directions.

Then create the rose diagram with:

```r
ROSE_BINS <- 18
```

Repeat using:

```r
ROSE_BINS <- 12
ROSE_BINS <- 24
ROSE_BINS <- 36
```

Answer:

1. What is the main preferred directional region?
2. Are all orientations tightly identical?
3. Which observations/region appear furthest from the main concentration?
4. Does changing the number of bins alter the main archaeological impression?
5. Why should you avoid choosing the number of bins only because one setting produces the most impressive-looking peak?

---

## Part D — Circular descriptive statistics

Run Section 7.

Record:

| Statistic | Your result |
|---|---|
| n | |
| Mean direction | |
| Mean resultant length (R-bar) | |
| Circular variance | |
| Circular standard deviation | |

Interpret each result in ordinary language.

### Mean resultant length

Use the following qualitative guide only as an intuitive aid:

- nearer 1 → stronger concentration;
- nearer 0 → weak net concentration.

Do **not** treat arbitrary cut-offs such as “0.7 = strong” as universal archaeological rules.

Answer:

1. Does R-bar agree with your visual impression?
2. Does the circular variance tell the same story?
3. Why should the observations far from the main cluster not automatically be deleted as “outliers”?

---

## Part E — Confidence interval

Run Section 8.

Record the 95% bootstrap confidence interval for the mean direction.

Answer:

1. Is the interval centred reasonably close to the sample mean direction?
2. What does the interval tell you about precision?
3. What does it **not** tell you about the builders' intention?

The workshop uses the `circular` package's percentile bootstrap interval for the mean direction in a von Mises framework. We will treat the underlying model intuitively rather than derive it mathematically.

---

## Part F — Rayleigh test

Run Section 9.

The hypotheses are:

**H0:** the directions are uniformly distributed around the circle.

**H1:** the distribution has a unimodal preferred direction.

Record:

| Result | Your value |
|---|---|
| R-bar returned by `rayleigh.test()` | |
| Rayleigh z | |
| p-value | |

Answer:

1. At α = .05, do you reject H0?
2. Does the result agree with the rose diagram?
3. Why does a significant Rayleigh result **not** demonstrate that a specific astronomical target was intentional?
4. Why should you be cautious if a rose diagram is clearly bimodal or multimodal?

---

## Part G — Reporting

Run Section 10.

Copy the automatically generated reporting sentence.

Then add **one additional archaeological sentence** that appropriately qualifies the statistical result.

A good qualification should mention that interpretation also depends on evidence such as chronology, topography, horizon characteristics, building constraints, cultural practice, or the plausibility of a proposed astronomical target.

---

## Part H — Export

Run Sections 11–14.

Confirm that these files have been created under:

```text
05_OUTPUT/Dataset1/
```

Expected files:

```text
Dataset1_rose_diagram_300dpi.png
Dataset1_rose_diagram_600dpi.png
Dataset1_circular_statistics.docx
```

Open the PNG and DOCX files outside RStudio.

Check:

1. Is the graph readable?
2. Is the Word table ready to copy into a report/manuscript?
3. Is the manuscript-reporting sentence included in the Word document?

---

## Final discussion

In a short paragraph, answer:

> What can the circular-statistical analysis establish about this sample, and what additional evidence would be needed before making an archaeological or archaeoastronomical claim about intentional orientation?

