# ==============================================================================
# SCRIPT MODULE: 7/21/2026 TidyTuesday Exercise "UFC Athletes"
# OBJECTIVE:     Clean, Visualize, and Analyze TidyTuesday Data Frame 
# WORKSPACE REF: r_school / 03_tidytuesday / tidytuesday_ufc_athletes.R
# DEPENDENCIES:  tidyverse, here
# STRATIFICATION:TidyTuesday Github Page 
# ==============================================================================
library(tidyverse)
library(here)


# Data Loading and Questions  ----------------------------------------------

# Loaded Data into R for analysis
ufc_athletes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_athletes.csv')

# Question 1: How does reach impact the percentage of landed significant stikes?

# Question 2: How does the percentage of landed strikes vary between the top 6
# fighting styles?

# Question 3: How does fighting style change which win types are more common?


# Question One Sandbox ----------------------------------------------------


# Created new variable to observe the relationships between the ratio of strikes
# landed and attempted
ufc_reach <- ufc_athletes |> 
  drop_na(sig_strikes_landed, sig_strikes_attempted, reach) |> 
  mutate(sig_strike_percent = sig_strikes_landed / sig_strikes_attempted)

# Plotted new variable against reach to analyze any trends
ggplot(ufc_reach, aes(x = reach, y = sig_strike_percent)) +
  geom_point(alpha = .3, position = "jitter") + # code makes points more visible
  geom_smooth(method = "lm", se = FALSE) +
  theme_bw() +
  labs(
    title = "Reach vs Percentage of Successful Significant strikes",
    x = "Athlete's Arm Reach (in inches)",
    y = "Percentage of Successful Significant Strikes"
  ) +
  scale_y_continuous(
    labels = scales::percent, 
    breaks = seq(0,1, by = .25) 
  )

# There is a slight positive correlation between reach and successful strikes.
# It is important to note that age, fighting style, number of fights
# and weight could also be important factors that can skew results.

# Saved plot to have reproducible work
ggsave(here("04_plots", "reach_vs_successful_strikes.png"))



# Question 2 Sandbox ------------------------------------------------------

# Summarized the striking percentages for the selected styles for data analysis
ufc_style1 <- ufc_athletes |> 
  mutate(
    fighting_style = if_else(
      fighting_style %in% c(
        "MMA",
        "Striker", 
        "Muay Thai", 
        "Jiu-Jitsu", 
        "Kickboxer",
        "Freestyle"),
      fighting_style,
      NA) 
  ) |> 
  drop_na(
    fighting_style, 
    sig_strikes_landed, 
    sig_strikes_attempted
  ) |> 
  group_by(fighting_style) |> 
  summarize(
    sig_strike_percent = mean(sig_strikes_landed / sig_strikes_attempted),
    .group = "drop"
    )

# Plotted summarized data frame to look for trends
ggplot(ufc_style1, aes(x = fighting_style, y = sig_strike_percent)) +
  geom_col(aes(fill = fighting_style)) +
  theme_classic() +
  scale_fill_brewer(palette = "Dark2") +
  labs(
    title = "Fighting Style vs Successful Significant Strike Percentage",
    fill = "Fighting Style",
    x = "Fighting Style",
    y = "Successful Significant Strike Percentage"
  )

#Saved second graph for reproducible work
ggsave(here("04_plots", "fighting_style_vs_strike_percentage.png"))

# All styles have a very similar percentage of significant stikes. This could 
# be associated with the level of talent it takes to be in the UFC. It is also
# noteworthy that the Kickboxer style, which has the lowest amount of 
# observations has the highest percentage. This could be linked to the lower
# sample size skewing the percentage upwards.

#


# Session One Conclusion --------------------------------------------------

# Successful significan strike had a slight positive correlation with arm reach
# and low variation between the top six fighting styles. Next session question 
# three will be answered.