library(tidyverse)
library(here)

# Summarized the Indometh data frame in order to merge it with the Theoph data
average_indometh_concentration <- Indometh |>
  drop_na(conc) |> 
  group_by(time) |>
  summarize(average_concentration = mean(conc)) |>
  mutate(medication = "Indomethacin")

# Reused old code for combined drug data frame
average_theoph <- Theoph |> 
  drop_na(conc) |>
  group_by(Subject) |>
  mutate(sample_index = row_number()) |> 
  group_by(sample_index) |>
  summarize(
    time = mean(Time), 
    average_concentration = mean(conc),
    medication = "Theophylline"
  ) |>
  select(time, average_concentration, medication)


# Merged data so one plot could house both medications 
# NOTE: Use bind_rows NOT left_join when merging files with the goal of saving
# observations with overlapping values
merged_data <- bind_rows( 
  average_theoph, 
  average_indometh_concentration
)

# Plotted data to compare the clearance rates of the two drugs
ggplot(
  merged_data, 
  aes(
    x = time, 
    y = average_concentration, 
    color = medication, 
    shape = medication
  )
) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 2.5) +
  labs(
    title = "Clearance rates of Indomethacin compared to Theophylline",
    x     = "Time (hours)",
    y     = "Average Concentration (mg/L)",
    color = "medication",
    shape = "medication"
  ) +
  scale_color_brewer(palette = "Set1") + 
  theme_classic(base_size = 12)


