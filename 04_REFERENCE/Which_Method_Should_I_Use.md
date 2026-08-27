# Which Method Should I Use?

**A practical decision guide for orientation data in archaeoastronomy and ethnoastronomy**

Start with the **research question**, not the software menu.

## Step 1 - What kind of data do I have?

### Directions or azimuths

Use circular statistics.

### Axes with no meaningful start/end direction

Treat them as axial data before applying directional methods.

### Astronomical declinations

For the workshop curvigram, declination is treated as a linear angular coordinate over the analysed range.

## Step 2 - What question am I asking?

| Research question | First workshop method | What it tells you | Main caution |
|---|---|---|---|
| What does the pattern look like? | Individual-direction plot / rose diagram | Shape, modes, spread | Appearance depends partly on graphical choices |
| What is the typical direction? | Circular mean | Central direction | Can mislead for multimodal data |
| How concentrated are directions? | R-bar | Net directional concentration | Low R-bar can result from opposing clusters |
| How dispersed are directions? | Circular variance / circular SD | Circular spread | Interpret together with the plot |
| How precise is the mean direction? | Bootstrap CI | Precision of estimated mean | Not archaeological certainty |
| Is there a unimodal preferred direction rather than uniformity? | Rayleigh test | Evidence against uniformity for a unimodal alternative | Can miss bimodal/multimodal structure |
| Is one bell-like circular model useful? | von Mises model | Mean direction mu and concentration kappa | Do not force on obvious multimodality |
| How do uncertain declinations combine into a continuous curve? | Curvigram | Smoothed aggregate pattern | Kernel and bandwidth affect details |
| Is a curvigram feature robust? | Sensitivity analysis | Stability across reasonable settings | Not a formal significance test |
| Do two subgroups look different? | Separate plots and summaries | Descriptive differences | Formal between-group inference is outside this workshop |

## Step 3 - Recommended workflow

1. **Check the data**
   - units;
   - geographic convention;
   - directional versus axial;
   - missing values;
   - sample size;
   - measurement uncertainty.

2. **Plot before testing**
   - unimodal?
   - bimodal?
   - multimodal?
   - near-uniform?
   - isolated observations?

3. **Describe**
   - n;
   - mean direction if meaningful;
   - R-bar;
   - circular variance / SD;
   - confidence interval where appropriate.

4. **Test the question you actually have**
   - Rayleigh for a simple unimodal preferred-direction question;
   - do not treat it as a universal random/non-random button.

5. **Model only when useful**
   - a single von Mises distribution is appropriate only when one concentrated mode is scientifically plausible.

6. **Represent uncertainty explicitly**
   - in the curvigram exercise, each observation has its own reported plus/minus uncertainty.

7. **Test robustness**
   - change kernel and bandwidth deliberately;
   - report the specifications;
   - trust stable features more than specification-sensitive details.

## Minimal R cookbook

```r
library(circular)

az <- circular(
  dat$azimuth_deg,
  units = "degrees",
  template = "geographics",
  modulo = "2pi"
)

rose.diag(az, bins = 18)

as.numeric(mean(az)) %% 360
rho.circular(az)
1 - rho.circular(az)

rayleigh.test(az)

mle.vonmises(az)
```

## Three rules

**Rule 1:** Plot first, test second.

**Rule 2:** Match the method to the question and distribution shape.

**Rule 3:** Statistical regularity does not automatically establish cultural intention or an astronomical target.
