# Curvigram Explained

**A non-technical guide for archaeoastronomical research**

## 1. Basic idea

A histogram places observations into bins. A curvigram represents every observation with a smooth local kernel and then sums the contributions into a continuous curve.

In this workshop the curvigram is deliberately transparent: participants can see the kernel formula, bandwidth rule, summation and area normalisation in the R script.

## 2. One observation, one kernel

For an observation at value `x_i`, calculate:

```text
u = (x - x_i) / h_i
```

where `h_i` is that observation's bandwidth.

The observation contributes:

```text
K(u) / h_i
```

to the curve.

## 3. Epanechnikov kernel

Workshop baseline:

```text
K(u) = 0.75 x (1 - u^2), when |u| <= 1
K(u) = 0,                otherwise
```

It has finite support: beyond the bandwidth its contribution is exactly zero.

## 4. Gaussian kernel

Sensitivity comparison:

```text
K(u) = exp(-u^2 / 2) / sqrt(2*pi)
```

Its tails decrease smoothly rather than ending at a finite boundary.

## 5. Bandwidth

The bandwidth controls the width of every local contribution.

Workshop rule:

```text
h_i = multiplier x uncertainty_i
```

- smaller multiplier -> sharper, more local structure;
- larger multiplier -> smoother curve, greater merging of nearby features.

The multiplier is a methodological choice, not a decorative graph setting.

## 6. Meaning of uncertainty

`uncertainty_deg` is the **reported plus/minus measurement uncertainty**.

The workshop does **not** automatically assume that it is one standard deviation.

If your measurement protocol gives it another statistical meaning, document that meaning explicitly.

## 7. Default area normalisation

The individual kernels are summed and the displayed curve is divided by its numerical area so that:

```text
total displayed area = 1
```

This makes the vertical scale a density-like shape that is convenient for comparing distributions.

## 8. Linear versus circular geometry

The main workshop curvigram uses **astronomical declination** as a linear coordinate over the analysed range.

If you smooth azimuths, 359 degrees and 1 degree must be treated as neighbours. Circular boundary handling is then essential.

## 9. Frozen workshop baseline

```text
Variable:          declination_deg
Geometry:          linear
Kernel:            Epanechnikov
Bandwidth rule:    2 x uncertainty_deg
Vertical scale:    area = 1
Range:             -45 to +45 degrees
Grid step:         0.05 degrees
```

## 10. Required sensitivity workflow

Compare:

```text
Epanechnikov x 1
Epanechnikov x 2   baseline
Epanechnikov x 3
Gaussian x 2
```

Ask:

1. Does the major feature remain in approximately the same place?
2. Does it remain clearly visible?
3. Do smaller features merge, flatten or disappear?
4. Would the substantive interpretation change?

## 11. What a peak means

A peak indicates relatively high combined density in that coordinate region.

Possible explanations include:

- a genuine preferred orientation;
- a cultural convention;
- an astronomical target;
- topographic or architectural constraints;
- multiple practices;
- sampling structure;
- a feature amplified by smoothing choices.

The graph alone cannot decide between these explanations.

## 12. What a peak does not prove

A peak close to a solar, lunar or stellar value is not by itself proof of intentional astronomical alignment.

Interpretation should consider:

- archaeological context;
- chronology;
- landscape/topography;
- horizon visibility;
- measurement uncertainty;
- plausible alternative targets;
- possible post-hoc target selection;
- robustness to reasonable analytical specifications.

## 13. Reporting checklist

Report at least:

- coordinate analysed;
- linear/circular treatment;
- sample size;
- meaning of the uncertainty variable;
- kernel;
- bandwidth rule;
- multiplier;
- vertical scaling;
- calculation range;
- calculation step;
- sensitivity cases;
- software used.

## 14. Take-home message

**A curvigram is not a photograph of the true distribution. It is a transparent representation produced from observations plus explicit smoothing choices. Its evidential value increases when those choices are reported and tested for robustness.**
