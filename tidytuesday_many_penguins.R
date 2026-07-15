# ==============================================================================
# SCRIPT MODULE: 7/14/2026 TidyTuesday Exercise "Many Penguins"
# OBJECTIVE:     Analyzing Traits of Different Penguin Species by Genus and Sex
# WORKSPACE REF: r_school / 03_tidytuesday / tidytuesday_many_penguins.R
# DEPENDENCIES:  tidyverse, here
# STRATIFICATION: TidyTuesday Github Page
# ==============================================================================
library(tidyverse)
library(here)

# Loaded Tidytuesday data into r for cleaning and visualization
many_penguins <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-14/many_penguins.csv')

# Removed unknown genders to compare male and female beak sizes by genus
many_penguins_beaks <- many_penguins |>
  group_by(genus, sex) |>
  mutate(sex = if_else(sex == "U", NA, sex)) |>
  drop_na(sex) |>
  summarize(beak_ratio = mean(beak.depth / beak.width)) 

# Made a bar graph to compare the beak ratio of depth to width by genus
ggplot(many_penguins_beaks, aes(x = fct_reorder(genus, beak_ratio), y = beak_ratio)) +
  geom_col(aes(fill = sex), position = "dodge") +
  scale_fill_brewer(
    palette = "Set1", 
    labels = c(
      "F" = "Female", "M" = "Male"
    )
  ) +
  labs(
    title = "Ratio of Penguin Beak Depth to Width by Sex and Genus",
    x = "Genus",
    y = "Beak Ratio (Depth / Width)",
    fill = "Sex"
  )

# Saved First Graph
ggsave(here("04_plots", "penguin_beak_ratio.png"))

# Made new data frame to compare wing and tail size
many_penguins_limbs <- many_penguins |>
  group_by(genus) |>
  drop_na(tail.length, wing.length)

# Plotted data for wing and tail size to check for any correlation between
# the variables
ggplot(
  many_penguins_limbs, 
  aes(x = wing.length, 
    y = tail.length,
    color = genus 
    )
  ) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_brewer(
    palette = "Set1"
  ) + 
  theme_classic() +
  labs(
    title = "Relationship Between Penguin Wing and Tail Length by Genus",
    x = "Wing Length",
    y = "Tail Length",
    color = "Genus"
  )
  
# Saved second graph
ggsave(here("04_plots", "penguin_limbs.png"))