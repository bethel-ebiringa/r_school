# ==============================================================================
# SCRIPT MODULE: nhanesA 2015 Demographics Survey Sandbox
# OBJECTIVE: To Clean Data and Visualize Trends
# WORKSPACE REF: r_school / 02_clinical_sandbox / nhanesa_demographics_2015.R
# DEPENDENCIES:  tidyverse, here
# STRATIFICATION: nhanesA Package
# ==============================================================================
library(tidyverse)
library(here)
library(nhanesA)

# Searched for a usable demographic data set to analyze
nhanesTables(data_group = "DEMO", year = 2015)

# Imported Data and included labels to be able to find trends
demo_2015 <- nhanes(nh_table = "DEMO_I", includelabels =  TRUE) |>
  janitor::clean_names()

# GOAL: Compare how levels of education between men and women affect
# family income

# Removed certain variables that can give broadly interpreted results and 
# limited the sample population to those of at least middle age  
demo_income <- demo_2015 |>
  mutate(
    dmdeduc2 = if_else(dmdeduc2 == "Don't Know", NA, dmdeduc2), 
    ridageyr = if_else(ridageyr <= 39, NA, ridageyr),
    indfmin2 = if_else(indfmin2 %in% c("Refused", "Don't know"), NA, indfmin2)
  ) |>
  drop_na(dmdeduc2, ridageyr,indfmin2)

# Plot cleaned data to look for the relationships in the goal 
ggplot(demo_income, aes(x = dmdeduc2 , fill = indfmin2)) +
  geom_bar(position = "dodge") +
  facet_grid(riagendr ~ . ) 
# Goal for next session: Fix x axis labels, label graph in general, proportion
# of ethnicities in the sample population, and the relationship between
# ethnicity and family size

