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

# Question 1: How does reach impact the percentage of landed significant
# strikes?

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
    .groups = "drop"
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

# All styles have a very similar percentage of significant strikes. This could 
# be associated with the level of talent it takes to be in the UFC. It is also
# noteworthy that the Kickboxer style, which has the lowest amount of 
# observations has the highest percentage. This could be linked to the lower
# sample size skewing the percentage upwards.


# Session One Conclusion --------------------------------------------------

# Successful significant strike had a slight positive correlation with arm reach
# and low variation between the top six fighting styles. Next session question 
# three will be answered.

# ==============================================================================
# SESSION PART 2: TidyTuesday UFC Athletes Data Analysis  
# Objective: Answer Research Question Three via Data Visualization
# ==============================================================================


# Summarized data to have a mean value to pair with the boxplots
ufc_style_wins_mean <- ufc_athletes |> 
  mutate(fighting_style = if_else(
    fighting_style %in% (
      count(ufc_athletes, fighting_style, sort = TRUE) |> 
        drop_na(fighting_style) |> 
        slice_max(n, n = 6) |> 
        pull(fighting_style)
    ),
    fighting_style,
    NA
  )) |> 
  drop_na(fighting_style) |> 
  group_by(fighting_style) |> 
  summarize(
    average_sub_percent = mean(sub_percent, na.rm = TRUE),
    average_ko_tko_percent = mean(ko_tko_percent, na.rm = TRUE),
    average_dec_percent = mean(dec_percent, na.rm = TRUE)
  ) |> 
  pivot_longer(
    cols = contains("average"),
    names_to = "percent_type",
    values_to = "percent_value"
  )

# Isolated top 6 fighting styles in order to make box plots
ufc_style_wins_total <- ufc_athletes |> 
  mutate(fighting_style = if_else(
    fighting_style %in% (
      count(ufc_athletes, fighting_style, sort = TRUE) |> 
        drop_na(fighting_style) |>
        slice_max(n, n = 6) |> 
        pull(fighting_style)
    ),
    fighting_style,
    NA
  )) |> 
  drop_na(fighting_style) |> 
  pivot_longer(
    cols = c(sub_percent, ko_tko_percent, dec_percent),
    names_to = "percent_type",
    values_to = "percent_value"
  )

# Plotted pivoted variables to observe the distribution of win types
ggplot(ufc_style_wins_total, aes(x = percent_value, y = percent_type)) +
  geom_boxplot() +
  facet_wrap(~fighting_style) +
  scale_y_discrete(
    labels = str_wrap(c("Decision Win", "KO/TKO Win", "Submission Win"), 
    width = 10)) +
  theme_bw() +
  theme(axis.text.x = element_text(vjust = .5, angle = 90)) +
  labs(
    title = "Distribution of Win Type Proportions by Fighting Style",
    x = "Proportion of Wins",
    y = "Type of Win"
  )
# Saved plot to have reproducible Work
ggsave(here("04_plots", "fighting_style_win_proportions.png"))

# Plotted mean variable to compare the median and mean values
ggplot(ufc_style_wins_mean, aes(x = percent_type, y = percent_value)) +
  geom_col(aes(fill = percent_type)) +
  facet_wrap(~fighting_style) +
  theme_bw() +
  scale_fill_brewer(
    palette = "Set1",
    labels = str_wrap(c(
      "average_dec_percent" = "Average Proportion of Decision Wins",
      "average_ko_tko_percent" = "Average Proportion of KO/TKO Wins",
      "average_sub_percent" = "Average Proportion of Submission Wins"
  ),
    width = 15
  )) +
  theme(
    axis.text.x = element_blank(), 
    axis.title.x = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  labs(
    title = str_wrap(
      "Fighting Styles in in the UFC vs Average Proportion of Win Types",
      width = 60),
    y = "Proportion",
    fill = "Win Types"
  ) 
# Saved plot to have reproducible Work
ggsave(here("04_plots", "fighting_style_average_win_proportions.png"))

# There are four patterns in the relationship of fighting styles to win
# proportion. The descending order of the win types of Freestyle and MMA styles 
# is KO/TKO, decision, then submission. The order for Kickboxer and Striker
# styles is also KO/TKO, decision, then submission. However, for the Kickboxer
# and Striker styles KO/TKO wins are much more prominent and submissions are
# less prominent. Jiu-Jitsu's order is submission and a tie between KO/TKO and 
# decision. Muay Thai's order also is led by KO/TKO wins, and is followed by
# decision then submission. I chose to separate Mauy Thai because it's pattern
# is a hybrid between the Freestyle/MMA and the Kickboxer/Striker patterns: it
# KO/TKO wins have only a moderate lead with a low submission win proportion.

