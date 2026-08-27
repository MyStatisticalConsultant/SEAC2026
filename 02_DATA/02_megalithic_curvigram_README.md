# Dataset 2 — Curvigram and sensitivity analysis

## File

`02_megalithic_curvigram.csv`

## Status

**Synthetic teaching dataset.**

The dataset was created specifically for the SEAC 2026 workshop. It does not contain measurements from real monuments and must not be cited as empirical archaeological evidence.

## Teaching scenario

The file represents **45 hypothetical megalithic monuments** for which field orientations have already been transformed into astronomical declination.

The participants do not need to perform the azimuth/horizon-to-declination transformation in this exercise. The statistical starting point is the already calculated declination plus its reported measurement uncertainty.

## Variables

| Variable | Meaning |
|---|---|
| `monument_id` | Synthetic monument identifier. |
| `declination_deg` | Astronomical declination in degrees. This is the value to be smoothed in the curvigram. |
| `uncertainty_deg` | Reported ± measurement uncertainty in declination degrees. It is not automatically assumed to be one standard deviation. |
| `monument_type` | Synthetic monument type used for archaeological context. |
| `setting` | Simplified synthetic landscape/topographic setting. |
| `context_note` | Reminder that field context can influence measurement and interpretation. |

## Why declination?

Declination is used here because the workshop's curvigram lesson is about:

- measurement uncertainty;
- kernel choice;
- bandwidth;
- smoothing;
- sensitivity analysis.

Declination is treated as a linear quantity over the analysed range, so participants do not have to learn 0°/360° circular boundary handling at the same time.

## Deliberate statistical structure

The dataset contains:

- one **strong, robust concentration** near +23°;
- one **smaller, less robust feature** near +16°;
- a dispersed background.

Participants are **not told which observations generated which feature**.

The purpose is to discover the structure through the curvigram and then see which features survive reasonable changes in smoothing.

The main concentration is near a declination that may tempt participants to attach an immediate astronomical label. The exercise should explicitly discourage that shortcut:

> a peak is a statistical concentration first; an archaeological/astronomical interpretation requires additional evidence.

## Reported uncertainty

For example:

```text
declination_deg = 23.4
uncertainty_deg = 0.6
```

means the transformed declination is reported approximately as:

```text
+23.4° ± 0.6°
```

The workshop does not assume that ±0.6° is one standard deviation unless the measurement protocol explicitly defines it that way.

## Baseline curvigram

The Phase 4 participant script will start with:

```text
Kernel:              Epanechnikov
Bandwidth:           2 × uncertainty_deg
Vertical scaling:    area = 1
Calculation step:    0.05°
Range:               -45° to +45°
```

## Required sensitivity analysis

Participants will compare:

1. Epanechnikov, multiplier 1;
2. Epanechnikov, multiplier 2;
3. Epanechnikov, multiplier 3;
4. Gaussian, multiplier 2.

The expected teaching pattern is:

- the major feature should remain near +23° throughout;
- the smaller feature should become progressively less distinct under stronger/smoother specifications.

## Instructor-only note

The true synthetic generation groups are stored separately in:

`03_SOLUTIONS/02_megalithic_curvigram_GENERATION_KEY.csv`

That file should not be distributed as part of the participant exercise.
