############################################################
# SEAC 2026 WORKSHOP
# Circular Statistics in Archaeoastronomy and Ethnoastronomy Using R
#
# DATASET 3
# Comparative interpretation: when pooling hides structure
#
# Dataset:
#   02_DATA/03_ethno_directions.csv
#
# IMPORTANT:
# - This is a FICTIONAL teaching dataset.
# - It does not represent a real ethnographic tradition.
# - No new major statistical method is introduced here.
############################################################


# ============================================================
# 0. RUN THIS — Clean session and output folder
# ============================================================

rm(list = ls())

dir.create(
  file.path("05_OUTPUT", "Dataset3"),
  recursive = TRUE,
  showWarnings = FALSE
)


# ============================================================
# 1. RUN THIS — Load packages
# ============================================================

library(circular)
library(readr)
library(dplyr)
library(tibble)
library(ggplot2)
library(ragg)
library(officer)
library(flextable)


# ============================================================
# 2. RUN THIS — Import the synthetic data
# ============================================================

data_path <- file.path("02_DATA", "03_ethno_directions.csv")

if (!file.exists(data_path)) {
  stop(
    "Dataset not found. Open SEAC2026_Circular_Statistics.Rproj first."
  )
}

ethno <- read_csv(data_path, show_col_types = FALSE)

cat("\n--- DATA CHECK ---\n")
cat("Number of observations:", nrow(ethno), "\n")
print(table(ethno$tradition))
print(head(ethno))

if (any(is.na(ethno$azimuth_deg))) {
  stop("azimuth_deg contains missing values.")
}

if (any(ethno$azimuth_deg < 0 | ethno$azimuth_deg >= 360)) {
  stop("azimuth_deg must be in [0, 360).")
}


# ============================================================
# 3. RUN THIS — Treat all observations as one pooled sample
# ============================================================

az_all <- circular(
  ethno$azimuth_deg,
  units = "degrees",
  template = "geographics",
  modulo = "2pi"
)

rose.diag(
  az_all,
  bins = 24,
  radii.scale = "sqrt",
  prop = 1.5,
  shrink = 1.2,
  main = "Pooled directional observations"
)

# INTERPRET THIS:
#
# Does this look genuinely uniform?
# Or does it look like two directional concentrations?


# ============================================================
# 4. RUN THIS — Pooled circular statistics
# ============================================================

n_all <- length(az_all)
mean_all_deg <- as.numeric(mean(az_all)) %% 360
Rbar_all <- rho.circular(az_all)
variance_all <- 1 - Rbar_all
sd_all_deg <- sd(az_all) * 180 / pi

rayleigh_all <- rayleigh.test(az_all)
z_all <- n_all * Rbar_all^2
p_all <- rayleigh_all$p.value

cat("\n--- POOLED RESULTS ---\n")
cat("n =", n_all, "\n")
cat("Mean direction =", round(mean_all_deg, 2), "degrees\n")
cat("R-bar =", round(Rbar_all, 4), "\n")
cat("Circular variance =", round(variance_all, 4), "\n")
cat("Rayleigh z =", round(z_all, 4), "\n")
cat("Rayleigh p =", round(p_all, 4), "\n")

# INTERPRET THIS CAREFULLY:
#
# R-bar is expected to be close to zero.
# Rayleigh p is expected to be large.
#
# But the rose diagram is NOT visually uniform.
#
# Why?
#
# Because the sample contains two roughly opposite directional modes.
# Their vectors largely cancel each other.
#
# Rayleigh's test is particularly suited to a UNIMODAL alternative.
# A bimodal pattern can therefore produce a small R-bar and a
# non-significant Rayleigh test.


# ============================================================
# 5. RUN THIS — Create one circular object per tradition
# ============================================================

morning_values <- ethno %>%
  filter(tradition == "Morning-facing practice") %>%
  pull(azimuth_deg)

evening_values <- ethno %>%
  filter(tradition == "Evening-facing practice") %>%
  pull(azimuth_deg)

az_morning <- circular(
  morning_values,
  units = "degrees",
  template = "geographics",
  modulo = "2pi"
)

az_evening <- circular(
  evening_values,
  units = "degrees",
  template = "geographics",
  modulo = "2pi"
)


# ============================================================
# 6. RUN THIS — Plot the traditions separately
# ============================================================

old_par <- par(mfrow = c(1, 2))

rose.diag(
  az_morning,
  bins = 18,
  radii.scale = "sqrt",
  prop = 1.5,
  shrink = 1.2,
  main = "Morning-facing practice"
)

rose.diag(
  az_evening,
  bins = 18,
  radii.scale = "sqrt",
  prop = 1.5,
  shrink = 1.2,
  main = "Evening-facing practice"
)

par(old_par)

# INTERPRET THIS:
#
# Compare this with the pooled rose diagram.
# The subgroup structure is now obvious.


# ============================================================
# 7. RUN THIS — Reusable circular-summary function
# ============================================================

summarise_direction <- function(x, group_name) {

  n <- length(x)
  mean_deg <- as.numeric(mean(x)) %% 360
  Rbar <- rho.circular(x)
  variance <- 1 - Rbar
  sd_deg <- sd(x) * 180 / pi

  rayleigh_result <- rayleigh.test(x)
  z <- n * Rbar^2
  p <- rayleigh_result$p.value

  tibble(
    Group = group_name,
    n = n,
    `Mean direction (degrees)` = mean_deg,
    `R-bar` = Rbar,
    `Circular variance` = variance,
    `Circular SD (degrees)` = sd_deg,
    `Rayleigh z` = z,
    `Rayleigh p` = p
  )
}


# ============================================================
# 8. RUN THIS — Compare pooled and subgroup summaries
# ============================================================

comparison_table <- bind_rows(
  summarise_direction(
    az_morning,
    "Morning-facing practice"
  ),
  summarise_direction(
    az_evening,
    "Evening-facing practice"
  ),
  summarise_direction(
    az_all,
    "Pooled data"
  )
)

print(
  comparison_table %>%
    mutate(
      across(
        where(is.numeric),
        ~ round(.x, 4)
      )
    )
)

# INTERPRET THIS:
#
# Compare:
# - mean direction;
# - R-bar;
# - Rayleigh p-value.
#
# The two subgroups are individually very concentrated.
# The pooled sample is not.


# ============================================================
# 9. RUN THIS — Create a simple comparison plot
# ============================================================

plot_data <- comparison_table %>%
  filter(Group != "Pooled data") %>%
  transmute(
    Group,
    Mean_direction = `Mean direction (degrees)`,
    Rbar = `R-bar`
  )

comparison_plot <- ggplot(
  plot_data,
  aes(
    x = Group,
    y = Rbar
  )
) +
  geom_col(width = 0.6) +
  geom_text(
    aes(
      label = paste0(
        "Mean = ",
        sprintf("%.1f", Mean_direction),
        "°"
      )
    ),
    vjust = -0.5
  ) +
  coord_cartesian(ylim = c(0, 1.08)) +
  labs(
    title = "Directional concentration by fictional tradition",
    subtitle = "Mean direction is shown above each bar",
    x = NULL,
    y = "Mean resultant length (R-bar)"
  ) +
  theme_minimal(base_size = 12)

print(comparison_plot)


# ============================================================
# 10. RUN THIS — Generate interpretation text
# ============================================================

morning_row <- comparison_table %>%
  filter(Group == "Morning-facing practice")

evening_row <- comparison_table %>%
  filter(Group == "Evening-facing practice")

pooled_row <- comparison_table %>%
  filter(Group == "Pooled data")

report_text <- paste0(
  "When the two fictional traditions were analysed separately, ",
  "the morning-facing practice had a mean direction of ",
  sprintf("%.2f", morning_row$`Mean direction (degrees)`), "° ",
  "(R-bar = ", sprintf("%.3f", morning_row$`R-bar`), "), while ",
  "the evening-facing practice had a mean direction of ",
  sprintf("%.2f", evening_row$`Mean direction (degrees)`), "° ",
  "(R-bar = ", sprintf("%.3f", evening_row$`R-bar`), "). ",
  "Both subgroup Rayleigh tests rejected circular uniformity ",
  "(p < .001). In contrast, the pooled sample had R-bar = ",
  sprintf("%.3f", pooled_row$`R-bar`),
  " and a non-significant Rayleigh result (p = ",
  sprintf("%.3f", pooled_row$`Rayleigh p`),
  "). The pooled rose diagram nevertheless showed two clear ",
  "approximately opposite modes. This example illustrates that ",
  "pooling substantively distinct directional traditions can obscure ",
  "structure, and that a non-significant Rayleigh test should not be ",
  "interpreted as proof of uniformity."
)

cat("\n--- EXAMPLE INTERPRETATION ---\n")
cat(report_text, "\n")


# ============================================================
# 11. RUN THIS — Export subgroup comparison table
# ============================================================

export_table <- comparison_table %>%
  mutate(
    `Mean direction (degrees)` =
      sprintf("%.2f", `Mean direction (degrees)`),
    `R-bar` =
      sprintf("%.3f", `R-bar`),
    `Circular variance` =
      sprintf("%.3f", `Circular variance`),
    `Circular SD (degrees)` =
      sprintf("%.2f", `Circular SD (degrees)`),
    `Rayleigh z` =
      sprintf("%.3f", `Rayleigh z`),
    `Rayleigh p` =
      ifelse(
        `Rayleigh p` < 0.001,
        "< .001",
        sub("^0", "", sprintf("%.3f", `Rayleigh p`))
      )
  )

write_csv(
  export_table,
  file.path(
    "05_OUTPUT",
    "Dataset3",
    "Dataset3_group_comparison.csv"
  )
)


# ============================================================
# 12. RUN THIS — Export comparison plot
# ============================================================

ggsave(
  filename = file.path(
    "05_OUTPUT",
    "Dataset3",
    "Dataset3_group_comparison_300dpi.png"
  ),
  plot = comparison_plot,
  device = ragg::agg_png,
  width = 170,
  height = 110,
  units = "mm",
  dpi = 300,
  bg = "white"
)

ggsave(
  filename = file.path(
    "05_OUTPUT",
    "Dataset3",
    "Dataset3_group_comparison_600dpi.png"
  ),
  plot = comparison_plot,
  device = ragg::agg_png,
  width = 170,
  height = 110,
  units = "mm",
  dpi = 600,
  bg = "white"
)


# ============================================================
# 13. RUN THIS — Export pooled and subgroup rose diagrams
# ============================================================

rose_file <- file.path(
  "05_OUTPUT",
  "Dataset3",
  "Dataset3_rose_diagrams_300dpi.png"
)

ragg::agg_png(
  filename = rose_file,
  width = 240,
  height = 90,
  units = "mm",
  res = 300,
  background = "white"
)

old_par <- par(mfrow = c(1, 3))

rose.diag(
  az_all,
  bins = 24,
  radii.scale = "sqrt",
  prop = 1.4,
  shrink = 1.1,
  main = "Pooled"
)

rose.diag(
  az_morning,
  bins = 18,
  radii.scale = "sqrt",
  prop = 1.4,
  shrink = 1.1,
  main = "Morning"
)

rose.diag(
  az_evening,
  bins = 18,
  radii.scale = "sqrt",
  prop = 1.4,
  shrink = 1.1,
  main = "Evening"
)

par(old_par)
dev.off()

cat("\nSaved:", rose_file, "\n")


# ============================================================
# 14. RUN THIS — Export Word report
# ============================================================

ft <- flextable(export_table)
ft <- bold(ft, part = "header")
ft <- autofit(ft)

doc <- read_docx()

doc <- body_add_par(
  doc,
  "Dataset 3 — Comparative directional interpretation",
  style = "heading 1"
)

doc <- body_add_par(
  doc,
  paste(
    "Synthetic ethnoastronomical teaching example.",
    "The traditions and records are fictional."
  )
)

doc <- body_add_par(
  doc,
  "Circular-statistical comparison",
  style = "heading 2"
)

doc <- body_add_flextable(doc, value = ft)

doc <- body_add_par(
  doc,
  "Interpretation",
  style = "heading 2"
)

doc <- body_add_par(doc, report_text)

doc <- body_add_par(
  doc,
  "Methodological caution",
  style = "heading 2"
)

doc <- body_add_par(
  doc,
  paste(
    "The two traditions are compared descriptively here.",
    "No formal inferential test of between-group differences is performed.",
    "A pooled non-significant Rayleigh result should not be treated as",
    "proof of uniformity when the rose diagram shows strong multimodality."
  )
)

print(
  doc,
  target = file.path(
    "05_OUTPUT",
    "Dataset3",
    "Dataset3_comparative_results.docx"
  )
)


# ============================================================
# 15. RUN THIS — Final checklist
# ============================================================

cat("\n============================================================\n")
cat("DATASET 3 COMPLETE\n")
cat("============================================================\n")
cat("You have now:\n")
cat("1. analysed a pooled directional sample;\n")
cat("2. seen a case where pooled R-bar is near zero;\n")
cat("3. seen a non-significant Rayleigh test despite clear bimodality;\n")
cat("4. separated substantively different traditions;\n")
cat("5. compared subgroup mean directions and concentrations;\n")
cat("6. learned why provenance/grouping matter before testing;\n")
cat("7. exported a comparison table, figure and Word report.\n")
cat("============================================================\n")
