############################################################
# SEAC 2026 WORKSHOP - OPTIONAL SHORT EXTENSION
# Dataset 1: von Mises model
#
# Run this after completing:
# 01_Dataset1_Circular_Statistics_BEGINNER.R
############################################################

library(circular)
library(readr)

churches <- read_csv(
  file.path("02_DATA", "01_orientation_basics.csv"),
  show_col_types = FALSE
)

az <- circular(
  churches$azimuth_deg,
  units = "degrees",
  template = "geographics",
  modulo = "2pi"
)

# Fit one von Mises distribution.
vm <- mle.vonmises(az)

mu_deg <- as.numeric(vm$mu) %% 360
kappa <- vm$kappa

cat("\n--- VON MISES MODEL ---\n")
cat("Estimated central direction (mu):", round(mu_deg, 2), "degrees\n")
cat("Estimated concentration (kappa):", round(kappa, 3), "\n")

# INTERPRET THIS:
#
# mu:
#   the estimated central direction.
#
# kappa:
#   concentration around mu.
#   Larger values mean a tighter single cluster.
#
# IMPORTANT:
# A single von Mises model is most meaningful when one main
# unimodal circular cluster is scientifically plausible.
#
# Do not force one von Mises model onto an obviously bimodal
# or multimodal distribution.
