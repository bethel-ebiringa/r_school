# ==============================================================================
# SCRIPT MODULE: 7/22/2026 nhanesA Clinical Data Frame Sandbox Activity
# OBJECTIVE:     Clean, Visualize, and Analyze a Clinical Data Frame
# WORKSPACE REF: r_school / 02_clinical_sandbox / nhanesa_cholesterol_2017.R
# DEPENDENCIES:  tidyverse, here, nhanesA
# STRATIFICATION: nhanesA 2017 Cholesterol Data Frames
# ==============================================================================
library(tidyverse)
library(here)
library(nhanesA)

# Data Importation and Tidying --------------------------------------------


#Searched for data to analyze
nhanesTables(data_group = "LAB", year = 2017)


# Loaded data and included labels to search for associations
cholesterol <- nhanes("TCHOL_J", includelabels = TRUE)
cholesterol2 <- nhanes("HDL_J",includelabels = TRUE)

#
merged_cholesterol <- left_join(cholesterol, cholesterol2) |>
  janitor::clean_names()

#
cholesterol_ratio <- merged_cholesterol |>
  mutate(
    hdl_ratio = lbxtc / lbdhdd,
    risk_level = factor(case_when(
      hdl_ratio <= 3.5 ~ "Low Risk",
      hdl_ratio <= 5 ~ "Medium Risk",
      hdl_ratio >= 5 ~ "High Risk"),
      levels = c("Low Risk", "Medium Risk", "High Risk")
    )
    ) |>
  drop_na(risk_level)


# Research Questions ------------------------------------------------------


# Question one: How does HDL count vary with risk level?


# Question two: How does HDL level correlate with hdl ratio?


# Answer to Research Question One -----------------------------------------

# Plotted HDL count to observe patterns between risk levels
ggplot(cholesterol_ratio, aes(x = lbdhdd)) +
  geom_histogram() +
  facet_wrap(~risk_level, nrow = 3) +
  labs(
    title = "Heart Disease Risk Level vs HDL count in Lab Samples",
    x = "HDL count (mg/dL)",
    y= "Number of Occurances"
  ) +
  theme_bw()

# Saved Graph for reproducible work
ggsave(here("04_plots", "hdl_count_vs_risk_level.png"))

# Heart disease risk level seems to be negatively correlated with HDL count
# variation. The distribution of HDL counts are wider and further to the right
# at healthier levels. Because risk level is calculated by the HDL ratio
# variable, this trend could be due to the fact that, on average, people with
# higher HDL counts also have a higher proportion of HDL. This assumption will
# be tested with the results of question two.


# Answer to Research Question Two -----------------------------------------

# Plotted cleaned dataset to observe any trends
ggplot(cholesterol_ratio, aes(x = lbdhdd, y = hdl_ratio)) +
  geom_point(aes(color = risk_level)) +
  geom_smooth(se = FALSE,  color = "black") +
  scale_color_manual(values = c("green","yellow", "red")) +
  theme_classic() +
  labs(
    title = "HDL Cholesterol vs HDL Cholesterol ratio by Risk Level",
    y = "HDL Ratio (TC/HDL)",
    x = "HDL Level",
    color = str_wrap("Heart Disease Risk Level", width = 13)
  )

# Saved second graph for reproducible work
ggsave(here("04_plots", "hdl_cholesterol_ratio.png"))

# HDL level has a negative correlation with the HDL ratio; you move to higher
# HDL levels, you tend to see healthier risk levels. This supports the
# assumption that was made in the reflection in answer one. It is important to
# note that since the HDL ratio is derived from HDL levels outliers still fall
# in line with the trends.

