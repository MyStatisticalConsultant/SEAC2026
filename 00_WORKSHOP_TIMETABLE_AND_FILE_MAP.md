# SEAC 2026 Workshop — Participant timetable and file map

**Workshop time:** Sunday, 16:00–20:00

Open `SEAC2026_Circular_Statistics.Rproj` first. Keep the project open for the whole workshop.

The participant folder deliberately keeps stable functional paths (`01_WORKSHOP`, `02_DATA`, `04_REFERENCE`, `05_OUTPUT`) because the prepared R scripts use those relative paths.

| Time | Session | Main activity | Files to use |
|---|---|---|---|
| 16:00–16:50 | Session 1 — From ordinary statistics to circular data | RStudio orientation; linear vs circular; directional vs axial; geographic azimuth; plot-first principle; 358/359/1/2 demonstration | `01_WORKSHOP/00_START_HERE.pdf`; `01_WORKSHOP/SEAC2026_Workshop_Guide.pdf` Sections 1–3; `01_WORKSHOP/01_Dataset1_Circular_Statistics_BEGINNER.R` Sections 0–4; `04_REFERENCE/Circular_Statistics_Cheat_Sheet.pdf` |
| 16:50–17:50 | Session 2 — Circular description and inference in R | Rose diagrams; circular mean; R-bar; circular variance/SD; bootstrap CI; Rayleigh test; Dataset 1 exercise; optional von Mises | `01_WORKSHOP/01_Dataset1_Circular_Statistics_BEGINNER.R`; `01_WORKSHOP/01_Exercise_Dataset1_Circular_Statistics.md`; `02_DATA/01_orientation_basics.csv`; optional `01_WORKSHOP/01B_VonMises_OPTIONAL.R`; `04_REFERENCE/Which_Method_Should_I_Use.pdf` |
| 17:50–18:10 | Break | Save work; leave RStudio project open | No new files |
| 18:10–19:15 | Session 3 — Measurement uncertainty and curvigrams | Kernel; bandwidth; uncertainty; area-normalised density; Dataset 2; Epanechnikov/Gaussian; sensitivity analysis; reproducible export | `01_WORKSHOP/02_Dataset2_Curvigram_BEGINNER.R`; `01_WORKSHOP/02_Exercise_Dataset2_Curvigram.md`; `01_WORKSHOP/02_Curvigram_Reporting_Template.md`; `02_DATA/02_megalithic_curvigram.csv`; `04_REFERENCE/Curvigram_Explained.pdf` |
| 19:15–20:00 | Session 4 — Robustness, AI and participant gift | Optional Dataset 3; pooled-data caution; method decision aid; ~15-min AI demonstration; Curvigram Explorer reveal; take-home workflow; Q&A | Optional `01_WORKSHOP/03_Dataset3_Ethno_Comparison_BEGINNER.R`; `01_WORKSHOP/03_Exercise_Dataset3_Ethno_Comparison.md`; `02_DATA/03_ethno_directions.csv`; `04_REFERENCE/AI_R_Assistant_Prompt_Card.pdf`; `04_REFERENCE/Which_Method_Should_I_Use.pdf` |

## If the workshop runs late

The priority order is:

1. Dataset 1 — **must be completed**.
2. Dataset 2 curvigram — **must be completed**.
3. AI demonstration — keep approximately 15 minutes if possible.
4. Dataset 3 — first item to shorten, demonstrate only, or assign as take-home.
5. Curvigram Explorer — reveal/demo near the end even if Dataset 3 is skipped.

## Where your outputs go

The R scripts create files under:

- `05_OUTPUT/Dataset1/`
- `05_OUTPUT/Dataset2/`
- `05_OUTPUT/Dataset3/`
