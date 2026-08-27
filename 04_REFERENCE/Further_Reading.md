# Further Reading and Resources

**SEAC 2026 Workshop: Circular Statistics in Archaeoastronomy and Ethnoastronomy Using R**

This list is deliberately selective and aligned with the methods covered in the workshop.

## 1. Applied follow-up: instructor's book

**Tadić, M., & Kovačić, Z. J. (2025). _Astronomical orientation of medieval Orthodox churches and mosques (XV-XVI centuries) in former Yugoslavia – Circular statistical analysis in R_.**

This is the main applied follow-up resource recommended in the workshop. It contains numerous R code examples for descriptive and inferential analyses that participants can adapt to their own research, including with the AI-assisted workflow demonstrated at the end of the workshop. 

## 2. Practical circular statistics in R

**Pewsey, A., Neuhäuser, M., & Ruxton, G. D. (2013). _Circular Statistics in R_. Oxford University Press.**

A practical bridge between circular-statistical concepts and implementation in R.

## 3. General circular-data reference

**Fisher, N. I. (1993). _Statistical Analysis of Circular Data_. Cambridge University Press.**  
DOI: 10.1017/CBO9780511564345

A standard comprehensive reference on circular description and inference.

## 4. Classic applied reference

**Batschelet, E. (1981). _Circular Statistics in Biology_. Academic Press.**

A historically influential applied introduction to circular reasoning.

## 5. Broader directional-statistics reference

**Jammalamadaka, S. R., & SenGupta, A. (2001). _Topics in Circular Statistics_. World Scientific.**  
DOI: 10.1142/4031

Useful when moving beyond introductory circular analysis.

## 6. R package used in the workshop

The core package is:

```text
circular
```

In R:

```r
help(package = "circular")
```

Useful workshop functions include:

```r
circular()
rose.diag()
rho.circular()
rayleigh.test()
mle.vonmises()
mle.vonmises.bootstrap.ci()
```

## 7. Graphics and Word export

The workshop also uses:

- `ggplot2` - graphics;
- `ragg` - high-resolution PNG output;
- `officer` - Word documents;
- `flextable` - formatted Word tables.

## 8. More advanced R work

Specialised R packages for skyscape archaeology and broader directional statistics exist and can be valuable for advanced projects. They are intentionally outside this four-hour introductory workshop and may deserve a dedicated workshop of their own.

## 9. Recommended sequence after the workshop

1. Re-run Dataset 1 from a clean R session.
2. Re-run Dataset 2 and reproduce all four sensitivity curves.
3. Use the Curvigram Explorer Shiny app with the synthetic datasets.
4. Adapt one validated script to a small dataset of your own.
5. Use the AI prompt card only for controlled code adaptation/troubleshooting.
6. Consult the instructor's book for additional applied R examples.
7. Move to more advanced circular-statistics texts/packages only when your research question requires them.

## 10. Final advice

Learn enough statistics to understand **what question a method answers, what assumptions it makes, and what its output can and cannot establish**. You do not need to become an R programmer to conduct reproducible quantitative research, but you should retain the code, parameter values, data definitions and software versions that generated every published result.
