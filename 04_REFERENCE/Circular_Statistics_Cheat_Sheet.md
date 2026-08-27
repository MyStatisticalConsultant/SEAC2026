# Circular Statistics - Quick Reference

**SEAC 2026 Workshop: Circular Statistics in Archaeoastronomy and Ethnoastronomy Using R**

## 1. Why circular statistics?

Directions repeat after one complete turn. On a 0-360 degree scale, 359 degrees and 1 degree are only 2 degrees apart, even though ordinary arithmetic treats them as far apart.

Teaching example:

```text
358, 359, 1, 2 degrees
```

The ordinary arithmetic mean is 180 degrees, which points South. The circular mean is approximately 0/360 degrees, which correctly represents the cluster around North.

## 2. Directional or axial?

**Directional data:** start and end matter. Example: orientation measured from a church entrance toward the apse.

**Axial data:** the axis has no arrow. An axis at 20 degrees is equivalent to the same axis at 200 degrees.

Never analyse axial measurements as ordinary 0-360 degree directional data without an appropriate transformation.

## 3. Geographic azimuth convention

For this workshop:

- 0 degrees = North
- 90 degrees = East
- 180 degrees = South
- 270 degrees = West
- angles increase clockwise.

Always document the convention used.

## 4. Circular object in R

```r
library(circular)

az <- circular(
  dat$azimuth_deg,
  units = "degrees",
  template = "geographics",
  modulo = "2pi"
)
```

## 5. Rose diagram

```r
rose.diag(
  az,
  bins = 18,
  radii.scale = "sqrt"
)
```

Plot first, test second. Try more than one defensible bin count.

## 6. Mean direction

```r
mean_deg <- as.numeric(mean(az)) %% 360
```

Use only when a single central direction is meaningful. A pooled or multimodal sample can make one mean misleading.

## 7. Mean resultant length (R-bar)

```r
Rbar <- rho.circular(az)
```

- near 1: strong net directional concentration;
- near 0: weak net directional concentration.

Important: R-bar near 0 can result from uniformity **or from opposing clusters that cancel vectorially**.

## 8. Circular variance

```r
circular_variance <- 1 - Rbar
```

- near 0: tighter concentration;
- larger values: more dispersion.

## 9. Circular standard deviation

With the current workshop workflow:

```r
circular_sd_deg <- sd(az) * 180 / pi
```

The explicit conversion keeps the reported result in degrees.

## 10. Confidence interval for mean direction

```r
set.seed(2026)

mean_ci <- mle.vonmises.bootstrap.ci(
  az,
  alpha = 0.05,
  reps = 2000
)
```

Use the interval as a measure of precision for the estimated mean direction under the bootstrap/model assumptions. It does not measure archaeological certainty.

## 11. Rayleigh test

```r
rayleigh_result <- rayleigh.test(az)

Rbar <- rho.circular(az)
z <- length(az) * Rbar^2
p <- rayleigh_result$p.value
```

**H0:** directions are uniform around the circle.

**General alternative:** unimodal directional concentration.

A small p-value is evidence against circular uniformity for that alternative. A non-significant result does not prove uniformity, especially for bimodal or multimodal patterns.

## 12. von Mises model

The von Mises distribution is a useful single-cluster circular model.

- `mu` = central direction
- `kappa` = concentration; larger values indicate tighter concentration.

```r
vm <- mle.vonmises(az)

as.numeric(vm$mu) %% 360
vm$kappa
```

Do not force a single von Mises model onto an obviously multimodal sample.

## 13. Curvigram baseline

For the workshop declination exercise:

```text
Coordinate:       declination_deg
Geometry:         linear
Kernel:           Epanechnikov
Bandwidth:        2 x uncertainty_deg
Scaling:          area = 1
Range:            -45 to +45 degrees
Step:             0.05 degrees
```

`uncertainty_deg` is the reported plus/minus measurement uncertainty. It is not automatically assumed to be one standard deviation.

## 14. Curvigram sensitivity checks

At minimum compare:

```text
Epanechnikov x 1
Epanechnikov x 2   baseline
Epanechnikov x 3
Gaussian x 2
```

Ask whether the substantive feature stays in approximately the same place and remains visible.

## 15. Three rules to remember

1. **Plot first, test second.**
2. **Match the method to the distribution and research question.**
3. **Statistical concentration is not proof of cultural or astronomical intention.**
