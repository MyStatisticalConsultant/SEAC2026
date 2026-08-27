# Exercise 2 — Curvigram and sensitivity analysis

**SEAC 2026 workshop**  
**Dataset:** `02_DATA/02_megalithic_curvigram.csv`  
**R script:** `01_WORKSHOP/02_Dataset2_Curvigram_BEGINNER.R`

## Purpose

This exercise shows how to construct a transparent curvigram from astronomical declinations with heterogeneous reported measurement uncertainty.

The central question is:

> Which features remain substantively stable when reasonable analytical choices are changed?

The dataset contains **45 synthetic megalithic observations**. It is teaching material only.

---

## Learning objectives

By the end of the exercise you should be able to:

1. explain what a kernel contributes to a curvigram;
2. explain how reported measurement uncertainty enters the bandwidth;
3. distinguish kernel choice from bandwidth choice;
4. construct an area-normalised curvigram;
5. explain what the vertical scale means;
6. compare light, baseline and stronger smoothing;
7. compare Epanechnikov and Gaussian kernels;
8. distinguish a robust feature from a smoothing-sensitive feature;
9. export publication-ready plots and numerical curves;
10. report the method without over-interpreting a statistical peak.

---

## Part A — Inspect the data before smoothing

Run Sections 2 and 3.

Record:

| Quantity | Result |
|---|---|
| Number of observations | |
| Minimum declination | |
| Maximum declination | |
| Smallest reported uncertainty | |
| Largest reported uncertainty | |

Look at the histogram and rug marks.

Answer:

1. Where does the largest raw concentration appear?
2. Are there observations spread widely outside the main concentration?
3. Why should you inspect raw observations before looking at a smoothed curve?

---

## Part B — From uncertainty to bandwidth

Run Section 4.

The rule is:

```text
h_i = multiplier × uncertainty_i
```

For the first observation, record:

- declination;
- reported ± uncertainty;
- multiplier;
- resulting bandwidth.

Then change:

```r
EXAMPLE_MULTIPLIER <- 1
EXAMPLE_MULTIPLIER <- 2
EXAMPLE_MULTIPLIER <- 3
```

Answer:

1. What happens to the bandwidth as the multiplier increases?
2. What effect do you expect a larger bandwidth to have on the final curvigram?
3. Why does using a different uncertainty for each observation make sense when measurement precision is heterogeneous?

Remember: `uncertainty_deg` is the reported ± measurement uncertainty. The workshop does **not** automatically reinterpret it as one standard deviation.

---

## Part C — Read the kernel formulas

Run Sections 5–7.

You do not need to memorise the R syntax.

Identify:

- where the Epanechnikov kernel is defined;
- where the Gaussian kernel is defined;
- where `h_i` enters the calculation;
- where all observation-specific contributions are summed;
- where the total curve is normalised so that its displayed area equals 1.

In your own words:

> What does one observation contribute to the final curvigram?

---

## Part D — Baseline curvigram

Use:

```r
KERNEL <- "Epanechnikov"
MULTIPLIER <- 2
```

Run Sections 8 and 9.

Record:

| Baseline result | Value |
|---|---|
| Numerical area under curve | |
| Location of highest point | |

Answer:

1. Is the area approximately 1?
2. Where is the dominant concentration?
3. Can you see a smaller feature to the left of the dominant concentration?
4. Are there small features elsewhere that you would hesitate to interpret?

Do **not** yet assign a celestial target to the dominant peak.

---

## Part E — Bandwidth sensitivity

Set:

```r
KERNEL <- "Epanechnikov"
```

Repeat Sections 8 and 9 using:

```r
MULTIPLIER <- 1
MULTIPLIER <- 2
MULTIPLIER <- 3
```

Complete:

| Multiplier | Main feature | Smaller feature | Overall smoothness |
|---:|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |

Questions:

1. Does the main feature move substantially?
2. What happens to the smaller feature?
3. Which setting produces the sharpest-looking curve?
4. Why would choosing that setting solely because it looks most impressive be poor methodology?

---

## Part F — Kernel sensitivity

Set:

```r
MULTIPLIER <- 2
```

Compare:

```r
KERNEL <- "Epanechnikov"
KERNEL <- "Gaussian"
```

Answer:

1. Does the dominant feature remain in approximately the same location?
2. What happens to the apparent separation of the smaller feature?
3. Which conclusion is more convincing:
   - “There is definitely a second peak”, or
   - “There is a smaller concentration/shoulder whose prominence is sensitive to smoothing”?

Explain why.

---

## Part G — Four-specification comparison

Run Sections 12–14.

The four required specifications are:

```text
Epanechnikov × 1
Epanechnikov × 2
Epanechnikov × 3
Gaussian × 2
```

Record the global peak under each one:

| Specification | Highest point |
|---|---:|
| Epanechnikov ×1 | |
| Epanechnikov ×2 | |
| Epanechnikov ×3 | |
| Gaussian ×2 | |

Answer:

1. How large is the total range of global peak locations?
2. Would you describe the dominant feature as robust to these sensitivity checks?
3. Would you describe the smaller feature with the same confidence?
4. What evidence supports your answer?

---

## Part H — Robustness versus significance

This exercise does **not** calculate a p-value for a curvigram peak.

Discuss:

1. Why is visual stability across reasonable analytical specifications useful?
2. Is sensitivity analysis equivalent to a formal inferential test?
3. Can a robust peak by itself establish intentional astronomical targeting?

A strong answer should distinguish:

- **descriptive robustness**;
- **formal statistical inference**;
- **archaeological interpretation**.

---

## Part I — Reporting

Run Section 15.

Read the generated reporting paragraph.

Identify the pieces that make the analysis reproducible:

- coordinate analysed;
- kernel;
- bandwidth rule;
- multiplier;
- uncertainty interpretation;
- vertical scaling;
- calculation range;
- calculation step;
- sensitivity cases.

Then write one sentence explaining why the smaller feature should be interpreted cautiously.

---

## Part J — Export

Run Sections 16–19.

Confirm that `05_OUTPUT/Dataset2/` contains:

```text
Dataset2_baseline_curve.csv
Dataset2_sensitivity_curves.csv
Dataset2_baseline_curvigram_300dpi.png
Dataset2_baseline_curvigram_600dpi.png
Dataset2_sensitivity_comparison_300dpi.png
Dataset2_sensitivity_comparison_600dpi.png
Dataset2_curvigram_results.docx
```

Open the PNG and Word files outside RStudio.

Check:

1. Are axis labels and legend readable?
2. Can the comparison figure be understood in grayscale?
3. Does the Word file state the method clearly enough for later reporting?

---

## Final interpretation

Write a short paragraph answering:

> Which feature in this synthetic dataset is robust to the tested smoothing choices, which feature is less robust, and what additional evidence would be required before giving either feature an archaeoastronomical interpretation?

