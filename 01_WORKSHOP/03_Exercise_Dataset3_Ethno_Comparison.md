# Exercise 3 — When pooling hides directional structure

**SEAC 2026 workshop**  
**Dataset:** `02_DATA/03_ethno_directions.csv`  
**R script:** `01_WORKSHOP/03_Dataset3_Ethno_Comparison_BEGINNER.R`

## Purpose

This short final exercise uses methods you already know. It introduces no new major statistical test.

The dataset contains two **fictional** directional traditions created only for teaching.

The question is:

> What can happen when substantively different directional groups are pooled before analysis?

---

## Part A — Inspect the pooled sample

Run Sections 2–4.

Look first at the pooled rose diagram.

Answer:

1. Does the pooled distribution look uniform?
2. How many obvious directional modes do you see?
3. What is the pooled R-bar?
4. What is the pooled Rayleigh p-value?
5. If you looked only at the p-value, what mistaken conclusion might you make?

---

## Part B — Why does vector cancellation matter?

The two traditions face approximately opposite directions.

Think about the mean resultant vector.

If one group contributes vectors toward roughly east and another contributes vectors toward roughly west, what happens when those vectors are added?

Explain in ordinary language why a very small pooled R-bar does **not necessarily** mean that the observations are evenly spread around the circle.

---

## Part C — Analyse the traditions separately

Run Sections 5–8.

Complete:

| Group | n | Mean direction | R-bar | Rayleigh p |
|---|---:|---:|---:|---:|
| Morning-facing practice | | | | |
| Evening-facing practice | | | | |
| Pooled data | | | | |

Answer:

1. Which subgroup is more concentrated?
2. Are both subgroups individually non-uniform?
3. How different are their mean directions?
4. Why does the pooled result hide this information?

---

## Part D — What does the Rayleigh test actually tell us here?

Recall:

**H0:** circular uniformity.

The general Rayleigh alternative is **unimodal** directional concentration.

Answer:

1. Why is the pooled bimodal pattern a difficult case for the Rayleigh test?
2. Does a non-significant pooled Rayleigh result prove uniformity?
3. What did the rose diagram reveal that the single p-value did not?

---

## Part E — Descriptive comparison is not a formal group test

This workshop compares the two fictional traditions descriptively using:

- mean direction;
- R-bar;
- rose diagrams;
- separate Rayleigh tests.

We do **not** perform a formal inferential test of whether the two traditions differ from one another.

Explain the difference between:

> “The two groups have different sample mean directions.”

and:

> “A formal statistical test demonstrates that the population directions differ.”

The second statement requires an additional between-group inferential method that is outside this workshop.

---

## Part F — Ethnoastronomical interpretation

Imagine that these were real ethnographic records.

Before pooling them, what contextual questions should you ask?

Consider:

- Are the observations from the same practice?
- Same community?
- Same period?
- Same season?
- Same ritual context?
- Same definition of direction?
- Same measurement protocol?
- Same source quality?

Why might grouping decisions be substantively more important than running another statistical test?

---

## Part G — Export

Run Sections 11–14.

Expected files:

```text
05_OUTPUT/Dataset3/
Dataset3_group_comparison.csv
Dataset3_group_comparison_300dpi.png
Dataset3_group_comparison_600dpi.png
Dataset3_rose_diagrams_300dpi.png
Dataset3_comparative_results.docx
```

Open the outputs outside RStudio and check that they are usable.

---

## Final lesson

Complete this sentence:

> A non-significant Rayleigh test does not necessarily mean that directional data are uniform because ...

Then complete:

> Before pooling directional observations from different archaeological or ethnographic contexts, I should ...

