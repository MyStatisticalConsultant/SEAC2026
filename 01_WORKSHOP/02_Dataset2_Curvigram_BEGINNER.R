############################################################
# SEAC 2026 WORKSHOP
# Circular Statistics in Archaeoastronomy and Ethnoastronomy Using R
#
# DATASET 2
# Curvigram and sensitivity analysis
#
# Dataset:
#   02_DATA/02_megalithic_curvigram.csv
#
# IMPORTANT:
# - This is a synthetic teaching dataset.
# - It does NOT represent real monuments.
# - declination_deg is treated as a LINEAR variable.
# - uncertainty_deg is the reported +/- measurement uncertainty.
# - We do NOT automatically interpret uncertainty_deg as one SD.
#
# HOW TO USE THIS SCRIPT
# 1. Open SEAC2026_Circular_Statistics.Rproj in RStudio.
# 2. Open this script.
# 3. Run one numbered section at a time with Ctrl+Enter.
#
# Labels:
#   RUN THIS       = run the code as supplied
#   CHANGE THIS    = safely change the named parameter
#   INTERPRET THIS = stop and think about the result
############################################################


# ============================================================
# 0. RUN THIS — Start with a clean session
# ============================================================

rm(list = ls())

dir.create(
  file.path("05_OUTPUT", "Dataset2"),
  recursive = TRUE,
  showWarnings = FALSE
)


# ============================================================
# 1. RUN THIS — Load packages
# ============================================================

library(readr)
library(tibble)
library(dplyr)
library(ggplot2)
library(ragg)
library(officer)
library(flextable)


# ============================================================
# 2. RUN THIS — Import Dataset 2
# ============================================================

data_path <- file.path("02_DATA", "02_megalithic_curvigram.csv")

if (!file.exists(data_path)) {
  stop(
    "Dataset not found. Open SEAC2026_Circular_Statistics.Rproj first, ",
    "then run this script again."
  )
}

megaliths <- read_csv(data_path, show_col_types = FALSE)

cat("\n--- DATA CHECK ---\n")
cat("Number of observations:", nrow(megaliths), "\n")
cat(
  "Declination range:",
  min(megaliths$declination_deg),
  "to",
  max(megaliths$declination_deg),
  "degrees\n"
)
cat(
  "Reported uncertainty range: +/-",
  min(megaliths$uncertainty_deg),
  "to +/-",
  max(megaliths$uncertainty_deg),
  "degrees\n"
)

print(head(megaliths))

if (any(is.na(megaliths$declination_deg))) {
  stop("declination_deg contains missing values.")
}

if (any(is.na(megaliths$uncertainty_deg))) {
  stop("uncertainty_deg contains missing values.")
}

if (any(megaliths$uncertainty_deg <= 0)) {
  stop("All uncertainty values must be greater than zero.")
}


# ============================================================
# 3. RUN THIS — Look at the raw declinations first
# ============================================================

raw_plot <- ggplot(
  megaliths,
  aes(x = declination_deg)
) +
  geom_rug(sides = "b") +
  geom_histogram(
    binwidth = 2,
    boundary = 0,
    closed = "left"
  ) +
  labs(
    title = "Raw synthetic declinations",
    subtitle = "Histogram + individual observations",
    x = "Declination (degrees)",
    y = "Count"
  ) +
  theme_minimal(base_size = 12)

print(raw_plot)

# INTERPRET THIS:
# Can you see a main concentration before any curvigram is calculated?
# Are there also scattered observations away from that concentration?
#
# A histogram depends on bin width and bin boundaries.
# A curvigram gives us a different way to display concentration while
# incorporating the reported uncertainty of each observation.


# ============================================================
# 4. RUN THIS — Understand one observation's bandwidth
# ============================================================

example_value <- megaliths$declination_deg[1]
example_uncertainty <- megaliths$uncertainty_deg[1]

# CHANGE THIS:
EXAMPLE_MULTIPLIER <- 2

example_bandwidth <- EXAMPLE_MULTIPLIER * example_uncertainty

cat("\n--- ONE OBSERVATION ---\n")
cat("Declination:", example_value, "degrees\n")
cat("Reported uncertainty: +/-", example_uncertainty, "degrees\n")
cat("Multiplier:", EXAMPLE_MULTIPLIER, "\n")
cat("Bandwidth h:", example_bandwidth, "degrees\n")

# INTERPRET THIS:
#
# Our rule is:
#
#   h_i = multiplier x uncertainty_i
#
# The multiplier controls smoothing.
#
# Smaller multiplier -> narrower individual kernels -> sharper curve.
# Larger multiplier  -> wider individual kernels  -> smoother curve.
#
# The default multiplier 2 is a teaching baseline.
# It is NOT a universal statistically optimal bandwidth.


# ============================================================
# 5. RUN THIS — Define the kernel formulas
# ============================================================

kernel_value <- function(u, kernel = "Epanechnikov") {

  if (kernel == "Epanechnikov") {

    # K(u) = 0.75 * (1 - u^2) for |u| <= 1
    # K(u) = 0 outside that interval

    return(ifelse(
      abs(u) <= 1,
      0.75 * (1 - u^2),
      0
    ))
  }

  if (kernel == "Gaussian") {

    # Standard Gaussian kernel:
    # K(u) = exp(-u^2 / 2) / sqrt(2*pi)

    return(exp(-0.5 * u^2) / sqrt(2 * pi))
  }

  stop("Unknown kernel. Use 'Epanechnikov' or 'Gaussian'.")
}


# ============================================================
# 6. RUN THIS — Define numerical area under a curve
# ============================================================

trapz_area <- function(x, y) {

  # Trapezoidal numerical integration:
  #
  # area = sum of small trapezoids between adjacent grid points.

  sum(
    diff(x) *
      (head(y, -1) + tail(y, -1)) / 2
  )
}


# ============================================================
# 7. RUN THIS — Define the complete curvigram calculation
# ============================================================

calculate_curvigram <- function(
    values,
    uncertainties,
    kernel = "Epanechnikov",
    multiplier = 2,
    grid_min = -45,
    grid_max = 45,
    step = 0.05
) {

  if (length(values) != length(uncertainties)) {
    stop("values and uncertainties must have the same length.")
  }

  if (any(!is.finite(values))) {
    stop("All values must be finite numbers.")
  }

  if (any(!is.finite(uncertainties)) || any(uncertainties <= 0)) {
    stop("All uncertainties must be finite and greater than zero.")
  }

  if (multiplier <= 0) {
    stop("multiplier must be greater than zero.")
  }

  if (step <= 0) {
    stop("step must be greater than zero.")
  }

  grid <- seq(grid_min, grid_max, by = step)

  summed_density <- numeric(length(grid))

  for (i in seq_along(values)) {

    h_i <- multiplier * uncertainties[i]

    u <- (grid - values[i]) / h_i

    contribution <- kernel_value(u, kernel) / h_i

    summed_density <- summed_density + contribution
  }

  # Default vertical scale: total displayed area = 1.
  area_before_normalising <- trapz_area(grid, summed_density)

  if (!is.finite(area_before_normalising) ||
      area_before_normalising <= 0) {
    stop("The calculated curve has invalid total area.")
  }

  area_normalised_density <-
    summed_density / area_before_normalising

  tibble(
    declination_deg = grid,
    density = area_normalised_density
  )
}


# ============================================================
# 8. RUN THIS — Calculate the baseline curvigram
# ============================================================

# FROZEN BASELINE:
#
# Kernel:       Epanechnikov
# Multiplier:   2
# Grid:         -45 to +45 degrees
# Step:         0.05 degrees
# Scaling:      total displayed area = 1

# CHANGE THIS later in the exercise:
KERNEL <- "Epanechnikov"
MULTIPLIER <- 2

baseline_curve <- calculate_curvigram(
  values = megaliths$declination_deg,
  uncertainties = megaliths$uncertainty_deg,
  kernel = KERNEL,
  multiplier = MULTIPLIER
)

baseline_area <- trapz_area(
  baseline_curve$declination_deg,
  baseline_curve$density
)

baseline_peak_row <-
  baseline_curve[which.max(baseline_curve$density), ]

cat("\n--- BASELINE CURVIGRAM ---\n")
cat("Kernel:", KERNEL, "\n")
cat("Multiplier:", MULTIPLIER, "\n")
cat("Area under displayed curve:", round(baseline_area, 6), "\n")
cat(
  "Highest point of the curve:",
  round(baseline_peak_row$declination_deg, 2),
  "degrees\n"
)

# INTERPRET THIS:
# The area should be approximately 1.
#
# The position of the highest point is a useful descriptive summary.
# Do not automatically attach an astronomical label to it.


# ============================================================
# 9. RUN THIS — Plot the baseline curvigram
# ============================================================

baseline_plot <- ggplot(
  baseline_curve,
  aes(x = declination_deg, y = density)
) +
  geom_line(linewidth = 0.9) +
  geom_rug(
    data = megaliths,
    aes(x = declination_deg),
    inherit.aes = FALSE,
    sides = "b"
  ) +
  labs(
    title = "Baseline curvigram",
    subtitle = paste0(
      KERNEL,
      " kernel; bandwidth = ",
      MULTIPLIER,
      " x reported uncertainty; area = 1"
    ),
    x = "Declination (degrees)",
    y = "Area-normalised density"
  ) +
  coord_cartesian(xlim = c(-45, 45)) +
  theme_minimal(base_size = 12)

print(baseline_plot)

# INTERPRET THIS:
#
# 1. Where is the strongest feature?
# 2. Is there a smaller feature on its left?
# 3. Which parts of the curve look weak or isolated?
#
# At this point we do NOT know which small features are robust.
# That is why we now perform sensitivity analysis.


# ============================================================
# 10. CHANGE THIS — Lighter and stronger smoothing
# ============================================================

# Run these one at a time:
#
# MULTIPLIER <- 1
# MULTIPLIER <- 2
# MULTIPLIER <- 3
#
# Then rerun Sections 8 and 9.
#
# Watch especially:
# - sharpness of the main peak;
# - whether the smaller feature remains distinct;
# - whether isolated bumps appear/disappear.


# ============================================================
# 11. CHANGE THIS — Compare kernel shapes
# ============================================================

# Try:
#
# KERNEL <- "Epanechnikov"
# KERNEL <- "Gaussian"
#
# Keep:
#
# MULTIPLIER <- 2
#
# Then rerun Sections 8 and 9.
#
# INTERPRET THIS:
#
# The kernel changes the way each observation contributes to nearby
# declination values.
#
# Do not choose a kernel because it gives the most attractive result.


# ============================================================
# 12. RUN THIS — Calculate all four required sensitivity curves
# ============================================================

specifications <- tribble(
  ~kernel,         ~multiplier, ~specification,
  "Epanechnikov",  1,           "Epanechnikov x 1",
  "Epanechnikov",  2,           "Epanechnikov x 2 (baseline)",
  "Epanechnikov",  3,           "Epanechnikov x 3",
  "Gaussian",      2,           "Gaussian x 2"
)

curve_list <- vector("list", nrow(specifications))

for (j in seq_len(nrow(specifications))) {

  one_curve <- calculate_curvigram(
    values = megaliths$declination_deg,
    uncertainties = megaliths$uncertainty_deg,
    kernel = specifications$kernel[j],
    multiplier = specifications$multiplier[j]
  )

  one_curve$specification <- specifications$specification[j]

  curve_list[[j]] <- one_curve
}

sensitivity_curves <- bind_rows(curve_list)


# ============================================================
# 13. RUN THIS — Compare all four curves
# ============================================================

comparison_plot <- ggplot(
  sensitivity_curves,
  aes(
    x = declination_deg,
    y = density,
    linetype = specification
  )
) +
  geom_line(linewidth = 0.85) +
  labs(
    title = "Curvigram sensitivity analysis",
    subtitle = "Do substantive features survive reasonable smoothing choices?",
    x = "Declination (degrees)",
    y = "Area-normalised density",
    linetype = "Specification"
  ) +
  coord_cartesian(xlim = c(5, 30)) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "bottom"
  )

print(comparison_plot)

# INTERPRET THIS:
#
# Focus on STABILITY, not on which curve looks best.
#
# Ask:
#
# 1. Does the dominant feature remain in roughly the same place?
# 2. Does the smaller feature remain equally distinct?
# 3. Which conclusion would you trust more:
#       a feature present under all reasonable specifications, or
#       a feature visible only under one sharp specification?


# ============================================================
# 14. RUN THIS — Global peak under each specification
# ============================================================

peak_summary <- sensitivity_curves %>%
  group_by(specification) %>%
  slice_max(
    order_by = density,
    n = 1,
    with_ties = FALSE
  ) %>%
  ungroup() %>%
  transmute(
    Specification = specification,
    `Highest point (degrees)` = round(declination_deg, 2)
  )

cat("\n--- GLOBAL PEAK STABILITY ---\n")
print(peak_summary)

# INTERPRET THIS:
# The precise curve changes, but the main feature should remain close
# to the same declination under all four specifications.


# ============================================================
# 15. RUN THIS — Create a short reporting paragraph
# ============================================================

baseline_peak_deg <-
  sensitivity_curves %>%
  filter(specification == "Epanechnikov x 2 (baseline)") %>%
  slice_max(density, n = 1, with_ties = FALSE) %>%
  pull(declination_deg)

all_peak_values <- peak_summary$`Highest point (degrees)`

peak_min <- min(all_peak_values)
peak_max <- max(all_peak_values)

report_paragraph <- paste0(
  "The declination distribution was examined using an area-normalised ",
  "kernel curvigram. The baseline specification used an Epanechnikov ",
  "kernel with observation-specific bandwidths equal to twice the ",
  "reported +/- measurement uncertainty, evaluated from -45 degrees ",
  "to +45 degrees at 0.05-degree increments. The dominant concentration ",
  "occurred near +", sprintf("%.2f", baseline_peak_deg), " degrees. ",
  "Across sensitivity analyses using uncertainty multipliers of 1 to 3 ",
  "and a Gaussian kernel at multiplier 2, the global peak remained between +",
  sprintf("%.2f", peak_min), " and +", sprintf("%.2f", peak_max),
  " degrees. The main feature was therefore stable under the tested ",
  "smoothing choices, whereas smaller features should be interpreted ",
  "more cautiously if their visual prominence changes substantially. ",
  "These statistical concentrations are not, by themselves, evidence ",
  "of intentional astronomical targeting."
)

cat("\n--- EXAMPLE REPORTING PARAGRAPH ---\n")
cat(report_paragraph, "\n")


# ============================================================
# 16. RUN THIS — Export numerical curves as CSV
# ============================================================

write_csv(
  baseline_curve,
  file.path(
    "05_OUTPUT",
    "Dataset2",
    "Dataset2_baseline_curve.csv"
  )
)

write_csv(
  sensitivity_curves,
  file.path(
    "05_OUTPUT",
    "Dataset2",
    "Dataset2_sensitivity_curves.csv"
  )
)

cat("\nSaved numerical curve CSV files.\n")


# ============================================================
# 17. RUN THIS — Export baseline plot at 300 and 600 dpi
# ============================================================

ggsave(
  filename = file.path(
    "05_OUTPUT",
    "Dataset2",
    "Dataset2_baseline_curvigram_300dpi.png"
  ),
  plot = baseline_plot,
  device = ragg::agg_png,
  width = 180,
  height = 120,
  units = "mm",
  dpi = 300,
  bg = "white"
)

ggsave(
  filename = file.path(
    "05_OUTPUT",
    "Dataset2",
    "Dataset2_baseline_curvigram_600dpi.png"
  ),
  plot = baseline_plot,
  device = ragg::agg_png,
  width = 180,
  height = 120,
  units = "mm",
  dpi = 600,
  bg = "white"
)


# ============================================================
# 18. RUN THIS — Export sensitivity plot at 300 and 600 dpi
# ============================================================

ggsave(
  filename = file.path(
    "05_OUTPUT",
    "Dataset2",
    "Dataset2_sensitivity_comparison_300dpi.png"
  ),
  plot = comparison_plot,
  device = ragg::agg_png,
  width = 190,
  height = 130,
  units = "mm",
  dpi = 300,
  bg = "white"
)

ggsave(
  filename = file.path(
    "05_OUTPUT",
    "Dataset2",
    "Dataset2_sensitivity_comparison_600dpi.png"
  ),
  plot = comparison_plot,
  device = ragg::agg_png,
  width = 190,
  height = 130,
  units = "mm",
  dpi = 600,
  bg = "white"
)

cat("\nSaved 300- and 600-dpi PNG files.\n")


# ============================================================
# 19. RUN THIS — Export a Word results document
# ============================================================

method_table <- tibble(
  Item = c(
    "Coordinate",
    "Geometry",
    "Baseline kernel",
    "Bandwidth rule",
    "Baseline multiplier",
    "Vertical scaling",
    "Calculation range",
    "Calculation step"
  ),
  Setting = c(
    "Astronomical declination (degrees)",
    "Linear",
    "Epanechnikov",
    "Multiplier x reported +/- uncertainty",
    "2",
    "Area-normalised; total displayed area = 1",
    "-45 degrees to +45 degrees",
    "0.05 degrees"
  )
)

method_ft <- flextable(method_table)
method_ft <- bold(method_ft, part = "header")
method_ft <- autofit(method_ft)

peak_ft <- flextable(peak_summary)
peak_ft <- bold(peak_ft, part = "header")
peak_ft <- autofit(peak_ft)

doc <- read_docx()

doc <- body_add_par(
  doc,
  "Dataset 2 — Curvigram sensitivity analysis",
  style = "heading 1"
)

doc <- body_add_par(
  doc,
  "Synthetic megalithic-declination dataset used for the SEAC 2026 workshop."
)

doc <- body_add_par(
  doc,
  "Baseline method",
  style = "heading 2"
)

doc <- body_add_flextable(doc, value = method_ft)

doc <- body_add_par(
  doc,
  "Global peak sensitivity",
  style = "heading 2"
)

doc <- body_add_flextable(doc, value = peak_ft)

doc <- body_add_par(
  doc,
  "Example reporting paragraph",
  style = "heading 2"
)

doc <- body_add_par(doc, report_paragraph)

doc <- body_add_par(
  doc,
  "Interpretation reminder",
  style = "heading 2"
)

doc <- body_add_par(
  doc,
  paste(
    "A robust statistical concentration is one that remains substantively",
    "stable under reasonable analytical choices. Stability does not by itself",
    "establish intentional astronomical orientation; archaeological,",
    "chronological, landscape and cultural evidence remain necessary."
  )
)

word_file <- file.path(
  "05_OUTPUT",
  "Dataset2",
  "Dataset2_curvigram_results.docx"
)

print(doc, target = word_file)

cat("Saved:", word_file, "\n")


# ============================================================
# 20. RUN THIS — Final checklist
# ============================================================

cat("\n============================================================\n")
cat("DATASET 2 COMPLETE\n")
cat("============================================================\n")
cat("You have now:\n")
cat("1. inspected raw declinations;\n")
cat("2. linked reported uncertainty to bandwidth;\n")
cat("3. seen the Epanechnikov and Gaussian kernel formulas;\n")
cat("4. calculated a transparent area-normalised curvigram;\n")
cat("5. changed the smoothing multiplier;\n")
cat("6. compared kernel choices;\n")
cat("7. performed four required sensitivity checks;\n")
cat("8. assessed stability of the dominant feature;\n")
cat("9. distinguished robust from smoothing-sensitive features;\n")
cat("10. exported numerical curves, PNGs and a Word document.\n")
cat("============================================================\n")
