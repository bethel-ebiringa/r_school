library(ggplot2)
library(dplyr)
library(tidyr)

# 1. Clean Theophylline and calculate Standard Error (SE) using sample_index
clean_theophh <- Theoph |>
  drop_na(conc) |>
  group_by(Subject) |>
  mutate(sample_index = row_number()) |> 
  group_by(sample_index) |>
  summarize(
    time = mean(Time), 
    average_concentration = mean(conc),
    sd_conc = sd(conc, na.rm = TRUE),
    n       = n(),
    se_conc = sd_conc / sqrt(n), # Calculate Standard Error
    drug    = "Theophylline",
    .groups = "drop"
  ) |>
  select(time, average_concentration, se_conc, drug)

# 2. Clean Indomethacin and calculate Standard Error (SE) using time
clean_indomethh <- Indometh |>
  drop_na(conc) |>
  group_by(time) |>
  summarize(
    average_concentration = mean(conc),
    sd_conc = sd(conc, na.rm = TRUE),
    n       = n(),
    se_conc = sd_conc / sqrt(n), # Calculate Standard Error
    drug    = "Indomethacin",
    .groups = "drop"
  ) |>
  select(time, average_concentration, se_conc, drug)

# 3. Stack datasets vertically and sort chronologically
perfect_data_with_error <- bind_rows(clean_theophh, clean_indomethh) |> 
  arrange(drug, time)

# 4. Generate the final plot with error bars
ggplot(perfect_data_with_error, aes(x = time, y = average_concentration, color = drug, shape = drug)) +
  # Add the error bars (width = 0.3 controls the horizontal cap width)
  geom_errorbar(
    aes(ymin = average_concentration - se_conc, ymax = average_concentration + se_conc), 
    width = 0.3, 
    alpha = 0.7,
    linewidth = 0.6
  ) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 2.5) +
  labs(
    title = "Pharmacokinetic Profiles of Indomethacin vs. Theophylline",
    x     = "Time (hours)",
    y     = "Mean Concentration (mg/L)",
    color = "Medication",
    shape = "Medication"
  ) +
  scale_color_brewer(palette = "Set1") + 
  theme_classic(base_size = 12) +
  theme(
    plot.title    = element_text(face = "bold", size = 13, hjust = 0.5),
    plot.margin   = margin(t = 15, r = 15, b = 15, l = 20), # Adds margin padding to prevent title clipping
    legend.position = "right"
  )