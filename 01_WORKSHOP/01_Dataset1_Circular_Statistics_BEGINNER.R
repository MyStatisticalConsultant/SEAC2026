############################################################
# SEAC 2026 WORKSHOP
# Circular Statistics in Archaeoastronomy and Ethnoastronomy Using R
#
# PHASE 2 / DATASET 1
# Circular-statistics fundamentals
#
# Dataset:
#   02_DATA/01_orientation_basics.csv
#
# IMPORTANT:
# - This is a synthetic teaching dataset.
# - The 40 observations do NOT represent real churches.
# - Azimuth is measured from entrance toward apse.
# - 0 degrees = North, 90 = East, 180 = South, 270 = West.
#
# HOW TO USE THIS SCRIPT
# 1. Open SEAC2026_Circular_Statistics.Rproj in RStudio.
# 2. Open this script.
# 3. Run one section at a time with Ctrl+Enter.
#
# Labels used below:
#   RUN THIS       = run the code as supplied
#   CHANGE THIS    = safely change one value and rerun
#   INTERPRET THIS = stop and think about the output
############################################################


# ============================================================
# 0. RUN THIS — Start with a clean session
# ============================================================

rm(list = ls())

# Create output folders if they do not already exist.
dir.create(file.path("05_OUTPUT", "Dataset1"), recursive = TRUE, showWarnings = FALSE)


# ============================================================
# 1. RUN THIS — Load the packages
# ============================================================

library(circular)
library(readr)
library(tibble)
library(ragg)
library(officer)
library(flextable)


# ============================================================
# 2. RUN THIS — Why ordinary arithmetic can fail on a circle
# ============================================================

# Four directions clustered around North:
boundary_deg <- c(358, 359, 1, 2)

# Ordinary arithmetic mean:
boundary_linear_mean <- mean(boundary_deg)

# Tell R that these are circular directions in degrees.
boundary_circular <- circular(
  boundary_deg,
  units = "degrees",
  template = "geographics",
  modulo = "2pi"
)

# Circular mean:
boundary_circular_mean <- as.numeric(mean(boundary_circular)) %% 360

cat("\n--- LINEAR VERSUS CIRCULAR MEAN ---\n")
cat("Data:", paste(boundary_deg, collapse = ", "), "degrees\n")
cat("Ordinary arithmetic mean:", round(boundary_linear_mean, 2), "degrees\n")
cat("Circular mean:", round(boundary_circular_mean, 2), "degrees\n")

# INTERPRET THIS:
# The four observations are all close to North.
# The ordinary mean is 180 degrees (South), which is clearly misleading.
# Circular statistics respect the fact that 359 degrees and 1 degree
# are only 2 degrees apart.


# ============================================================
# 3. RUN THIS — Import Dataset 1
# ============================================================

data_path <- file.path("02_DATA", "01_orientation_basics.csv")

if (!file.exists(data_path)) {
  stop(
    "Dataset not found. Open SEAC2026_Circular_Statistics.Rproj first, ",
    "then run this script again."
  )
}

churches <- read_csv(data_path, show_col_types = FALSE)

cat("\n--- FIRST SIX ROWS ---\n")
print(head(churches))

cat("\nNumber of observations:", nrow(churches), "\n")
cat(
  "Azimuth range:",
  min(churches$azimuth_deg, na.rm = TRUE),
  "to",
  max(churches$azimuth_deg, na.rm = TRUE),
  "degrees\n"
)

# Simple safety checks.
if (any(is.na(churches$azimuth_deg))) {
  stop("azimuth_deg contains missing values. Check the dataset.")
}

if (any(churches$azimuth_deg < 0 | churches$azimuth_deg >= 360)) {
  stop("azimuth_deg must be between 0 (inclusive) and 360 (exclusive).")
}


# ============================================================
# 4. RUN THIS — Convert azimuths into a circular object
# ============================================================

az <- circular(
  churches$azimuth_deg,
  units = "degrees",
  template = "geographics",
  modulo = "2pi"
)

cat("\n--- CIRCULAR OBJECT ---\n")
print(az[1:10])

# INTERPRET THIS:
# "geographics" means:
#   0 degrees at North
#   angles increase clockwise
#
# This matches the usual azimuth convention.


# ============================================================
# 5. RUN THIS — Plot the individual directions
# ============================================================

plot(
  az,
  stack = TRUE,
  bins = 36,
  shrink = 1.25,
  main = "Individual church orientations"
)

# INTERPRET THIS:
# Do you see one broad preferred direction?
# Are all observations identical?
# Are there several observations noticeably away from the main group?


# ============================================================
# 6. RUN THIS — Rose diagram
# ============================================================

# CHANGE THIS:
# Try 12, 18, 24 and 36 bins.
ROSE_BINS <- 18

rose.diag(
  az,
  bins = ROSE_BINS,
  radii.scale = "sqrt",
  prop = 1.4,
  shrink = 1.2,
  main = paste0("Church orientations — rose diagram (", ROSE_BINS, " bins)")
)

# INTERPRET THIS:
# Does your substantive interpretation change when the number of bins changes?
#
# A good conclusion should not depend on one convenient visual setting.


# ============================================================
# 7. RUN THIS — Circular descriptive statistics
# ============================================================

n_obs <- length(az)

mean_direction <- mean(az)
mean_direction_deg <- as.numeric(mean_direction) %% 360

Rbar <- rho.circular(az)

circular_variance <- 1 - Rbar

# IMPORTANT:
# circular::sd.circular() computes the circular SD in radians internally.
# Convert it explicitly to degrees for easier interpretation.
circular_sd_rad <- sd(az)
circular_sd_deg <- circular_sd_rad * 180 / pi

cat("\n--- CIRCULAR DESCRIPTIVE STATISTICS ---\n")
cat("n =", n_obs, "\n")
cat("Mean direction =", round(mean_direction_deg, 2), "degrees\n")
cat("Mean resultant length (R-bar) =", round(Rbar, 3), "\n")
cat("Circular variance =", round(circular_variance, 3), "\n")
cat("Circular standard deviation =", round(circular_sd_deg, 2), "degrees\n")

# INTERPRET THIS:
#
# Mean direction
#   = the average direction around the circle.
#
# R-bar
#   = concentration of the directions.
#   It lies between 0 and 1.
#   Values nearer 1 mean stronger directional concentration.
#
# Circular variance
#   = 1 - R-bar.
#   Values nearer 0 mean stronger concentration.
#
# Circular standard deviation
#   = an angular measure of spread around the circle.


# ============================================================
# 8. RUN THIS — 95% bootstrap confidence interval
# ============================================================

# The circular package provides a percentile bootstrap interval
# for the mean direction in a von Mises framework.
#
# We use a fixed seed so everybody in the room obtains the same result.

set.seed(2026)

mean_ci <- mle.vonmises.bootstrap.ci(
  az,
  alpha = 0.05,
  reps = 2000
)

ci_low_deg <- as.numeric(mean_ci$mu.ci[1]) %% 360
ci_high_deg <- as.numeric(mean_ci$mu.ci[2]) %% 360

cat("\n--- 95% BOOTSTRAP CI FOR MEAN DIRECTION ---\n")
cat(
  "95% CI:",
  round(ci_low_deg, 2),
  "to",
  round(ci_high_deg, 2),
  "degrees\n"
)

# INTERPRET THIS:
# The interval gives a range of plausible values for the population
# mean direction under the bootstrap/model assumptions.
#
# A narrow interval indicates greater precision about the mean direction.
#
# Statistical precision is NOT the same thing as archaeological certainty.


# ============================================================
# 9. RUN THIS — Rayleigh test of circular uniformity
# ============================================================

rayleigh_result <- rayleigh.test(az)

# circular::rayleigh.test() returns R-bar as its "statistic".
# We calculate the commonly reported Rayleigh z separately:
rayleigh_z <- n_obs * Rbar^2
rayleigh_p <- rayleigh_result$p.value

cat("\n--- RAYLEIGH TEST ---\n")
print(rayleigh_result)

cat("Rayleigh z =", round(rayleigh_z, 3), "\n")
cat("p-value =", format(rayleigh_p, scientific = TRUE, digits = 4), "\n")

# H0:
# Directions are uniformly distributed around the circle.
#
# H1 for this general Rayleigh test:
# The distribution has a unimodal preferred direction.
#
# INTERPRET THIS:
# If p < .05, reject H0.
# If p >= .05, do NOT say that uniformity has been "proved".
#
# IMPORTANT:
# Rayleigh's test is particularly suited to a unimodal alternative.
# A clearly bimodal or multimodal pattern requires visual inspection
# and may require a different uniformity test.


# ============================================================
# 10. RUN THIS — Create a manuscript-reporting sentence
# ============================================================

format_apa_p <- function(p) {
  if (p < 0.001) {
    return("p < .001")
  }
  paste0("p = ", sub("^0", "", sprintf("%.3f", p)))
}

report_sentence <- paste0(
  "The distribution of church orientations was significantly non-uniform, ",
  "Rayleigh's z = ", sprintf("%.2f", rayleigh_z), ", ",
  format_apa_p(rayleigh_p), ". ",
  "The mean direction was ", sprintf("%.2f", mean_direction_deg), "° ",
  "(95% bootstrap CI [", sprintf("%.2f", ci_low_deg), "°, ",
  sprintf("%.2f", ci_high_deg), "°], ",
  "R-bar = ", sprintf("%.3f", Rbar), ", n = ", n_obs, ")."
)

cat("\n--- EXAMPLE MANUSCRIPT REPORTING ---\n")
cat(report_sentence, "\n")

# IMPORTANT:
# The sentence reports the statistical pattern.
# It does NOT say that a specific astronomical target was intentional.
# Archaeological interpretation must use additional contextual evidence.


# ============================================================
# 11. RUN THIS — Results table
# ============================================================

results_table <- tibble(
  Statistic = c(
    "Number of observations",
    "Mean direction (degrees)",
    "95% CI — lower (degrees)",
    "95% CI — upper (degrees)",
    "Mean resultant length (R-bar)",
    "Circular variance",
    "Circular standard deviation (degrees)",
    "Rayleigh z",
    "Rayleigh p-value"
  ),
  Result = c(
    as.character(n_obs),
    sprintf("%.2f", mean_direction_deg),
    sprintf("%.2f", ci_low_deg),
    sprintf("%.2f", ci_high_deg),
    sprintf("%.3f", Rbar),
    sprintf("%.3f", circular_variance),
    sprintf("%.2f", circular_sd_deg),
    sprintf("%.3f", rayleigh_z),
    ifelse(rayleigh_p < 0.001, "< .001", sub("^0", "", sprintf("%.3f", rayleigh_p)))
  )
)

print(results_table)


# ============================================================
# 12. RUN THIS — Export the rose diagram as 300-dpi PNG
# ============================================================

rose_300_file <- file.path(
  "05_OUTPUT",
  "Dataset1",
  "Dataset1_rose_diagram_300dpi.png"
)

ragg::agg_png(
  filename = rose_300_file,
  width = 180,
  height = 180,
  units = "mm",
  res = 300,
  background = "white"
)

rose.diag(
  az,
  bins = ROSE_BINS,
  radii.scale = "sqrt",
  prop = 1.4,
  shrink = 1.2,
  main = "Church orientations — rose diagram"
)

dev.off()

cat("\nSaved:", rose_300_file, "\n")


# ============================================================
# 13. RUN THIS — Export the same plot as 600-dpi PNG
# ============================================================

rose_600_file <- file.path(
  "05_OUTPUT",
  "Dataset1",
  "Dataset1_rose_diagram_600dpi.png"
)

ragg::agg_png(
  filename = rose_600_file,
  width = 180,
  height = 180,
  units = "mm",
  res = 600,
  background = "white"
)

rose.diag(
  az,
  bins = ROSE_BINS,
  radii.scale = "sqrt",
  prop = 1.4,
  shrink = 1.2,
  main = "Church orientations — rose diagram"
)

dev.off()

cat("Saved:", rose_600_file, "\n")

# INTERPRET THIS:
# 300 dpi is normally sufficient for many reports.
# 600 dpi gives a higher-resolution raster file for publication workflows.


# ============================================================
# 14. RUN THIS — Export the results table to Word
# ============================================================

word_file <- file.path(
  "05_OUTPUT",
  "Dataset1",
  "Dataset1_circular_statistics.docx"
)

ft <- flextable(results_table)
ft <- bold(ft, part = "header")
ft <- autofit(ft)

doc <- read_docx()

doc <- body_add_par(
  doc,
  "Dataset 1 — Circular statistics",
  style = "heading 1"
)

doc <- body_add_par(
  doc,
  "Synthetic Orthodox-church orientation dataset used for the SEAC 2026 workshop."
)

doc <- body_add_flextable(doc, value = ft)

doc <- body_add_par(
  doc,
  "Example manuscript reporting",
  style = "heading 2"
)

doc <- body_add_par(doc, report_sentence)

print(doc, target = word_file)

cat("\nSaved:", word_file, "\n")


# ============================================================
# 15. RUN THIS — Final checklist
# ============================================================

cat("\n============================================================\n")
cat("DATASET 1 COMPLETE\n")
cat("============================================================\n")
cat("You have now:\n")
cat("1. seen why circular means are necessary;\n")
cat("2. imported azimuth data;\n")
cat("3. created circular data in R;\n")
cat("4. produced a rose diagram;\n")
cat("5. calculated circular descriptive statistics;\n")
cat("6. calculated a bootstrap confidence interval;\n")
cat("7. performed a Rayleigh test;\n")
cat("8. created a manuscript-reporting example;\n")
cat("9. exported 300- and 600-dpi PNG files;\n")
cat("10. exported a formatted Word results table.\n")
cat("============================================================\n")
