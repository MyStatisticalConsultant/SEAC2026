# Dataset 3 — Comparative ethnoastronomy interpretation

## File

`03_ethno_directions.csv`

## Status

**Synthetic teaching dataset.**

The records are fictional and were created only for the SEAC 2026 workshop. They do not describe a real community, ritual, oral tradition or ethnographic source and must not be cited as empirical evidence.

## Teaching scenario

The dataset contains 40 hypothetical directional observations belonging to two fictional practices:

- `Morning-facing practice`
- `Evening-facing practice`

Each record contains a direction that is treated as meaningful: the observer/practitioner is facing **toward** a direction, so the data are directional rather than axial.

Azimuth follows the geographical convention:

- 0° = North
- 90° = East
- 180° = South
- 270° = West
- angles increase clockwise.

## Variables

| Variable | Meaning |
|---|---|
| `record_id` | Synthetic observation identifier. |
| `tradition` | Fictional practice/group label. |
| `azimuth_deg` | Directional azimuth in degrees from North clockwise. |
| `record_type` | Reminder that this is a synthetic field-record example. |
| `context_note` | Reminder that the direction is treated as meaningful and the case is fictional. |

## Why this dataset?

Phase 5 is not intended to teach another major statistical method.

Instead it reinforces methods already learned in Dataset 1 and uses them to show an important interpretive problem:

> A pooled sample can hide meaningful subgroup structure.

The two fictional traditions are individually strongly concentrated but face approximately opposite directions.

When they are pooled:

- the vector contributions largely cancel;
- mean resultant length becomes very small;
- the Rayleigh test does not reject uniformity;
- yet the pooled rose diagram is visibly bimodal rather than genuinely uniform.

This allows participants to see why:

1. data provenance and grouping matter;
2. a single pooled mean can be meaningless;
3. Rayleigh's test is designed for a unimodal alternative and can miss strong bimodal structure;
4. graphical inspection and substantive context must accompany statistical testing.

## Workshop scope

Participants will:

- inspect the pooled rose diagram;
- calculate pooled circular summaries and Rayleigh test;
- analyse each tradition separately;
- compare the two mean directions and concentrations descriptively;
- explain why the pooled conclusion is misleading;
- produce a small comparison table and figure.

The workshop will **not** introduce a formal inferential test of differences between the two traditions.

That would belong in a more advanced circular-statistics workshop.
