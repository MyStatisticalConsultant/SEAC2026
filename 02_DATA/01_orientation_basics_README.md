# Dataset 1 — Circular-statistics fundamentals

## File

`01_orientation_basics.csv`

## Status

**Synthetic teaching dataset.**

The observations were created specifically for the SEAC 2026 workshop. They are archaeologically plausible but **must not be cited or interpreted as empirical measurements of real churches**.

## Teaching scenario

The dataset represents 40 hypothetical Orthodox churches.

For each church, the main longitudinal orientation is measured **from the entrance toward the apse**. This makes the measurement **directional** rather than merely axial.

Azimuth follows the geographical convention:

- 0° = North
- 90° = East
- 180° = South
- 270° = West
- angles increase clockwise

The sample contains a clear overall easterly tendency, realistic dispersion and a small number of more strongly deviating orientations that can be discussed in relation to local constraints.

## Variables

| Variable | Type | Meaning |
|---|---|---|
| `site_id` | character | Synthetic site identifier. |
| `azimuth_deg` | numeric | Directional azimuth of the longitudinal axis from entrance toward apse, in degrees from North clockwise. |
| `uncertainty_deg` | numeric | Reported ± measurement uncertainty in degrees. It is not automatically assumed to equal one standard deviation. |
| `period` | character | Broad synthetic chronological category. |
| `setting` | character | Simplified local-setting category. |
| `context_note` | character | Short reminder that orientation can be influenced by archaeological/topographic context. |

## Directional versus axial interpretation

The workshop treats `azimuth_deg` as **directional** because “entrance → apse” has a meaningful direction.

If only the undirected building axis were known, 90° and 270° would represent the same axis and an **axial** treatment would be required.

## Measurement uncertainty

`uncertainty_deg` means the reported plus/minus uncertainty attached to the field measurement.

For example:

```text
azimuth_deg = 94
uncertainty_deg = 1.2
```

means approximately:

```text
94° ± 1.2°
```

The uncertainty is not automatically interpreted as a Gaussian standard deviation.

## Intended learning outcomes

Participants will use this dataset to learn:

1. import and inspection of orientation data;
2. construction of a `circular` object in R;
3. rose diagrams;
4. circular mean direction;
5. mean resultant length (R-bar);
6. circular variance;
7. confidence interval for mean direction;
8. Rayleigh test;
9. interpretation together with archaeological context.

The dramatic 359°/0° boundary problem will be taught separately with a four-value mini-example in the Phase 2 R script.
