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
# ggplot(demo_income, aes(x = dmdeduc2 , fill = indfmin2)) +
#   geom_bar(position = "dodge") +
#   facet_grid(riagendr ~ .) +
#   theme(
#     axis.text.x = element_text(angle = 90, vjust = 1, hjust = 1),
#     legend.position = "bottom",
#     legend.direction = "horizontal") +
#   scale_x_discrete(labels = function(x) str_wrap(x, width = 12)) +
#   labs(
#     title = "Education Levels of Adults vs Family Income by Sex",
#   ) +
#   guides(fill = guide_legend(ncol = 3, byrow = TRUE))


# Goal for next session: Fix x axis labels, label graph in general, proportion
# of ethnicities in the sample population, and the relationship between
# ethnicity and family size

# ==============================================================================
# SESSION PART 2: Continuation of the Analysis of Demographic Data  
# Objective: Polish Plots and Observe New Relationships
# ==============================================================================

# Cleaned Data so all categories for under 20,000 are merged into one category
demo_income <- demo_income |> 
  mutate(indfmin2 =  factor(if_else(
      indfmin2 %in% c(
        "$ 0 to $ 4,999", 
        "$ 5,000 to $ 9,999",
        "$10,000 to $14,999",
        "$15,000 to $19,999"),  
      "Under $20,000",
      indfmin2
  )) |> 
  fct_relevel("Under $20,000", after = 0) |> 
  fct_relevel("$100,000 and Over", after = Inf)
  )
    

# (Re)plotted cleaned data to look for the relationships in the goal 
ggplot(demo_income, aes(x = dmdeduc2 , fill = indfmin2)) +
  geom_bar(position = "dodge") +
  facet_grid(riagendr ~ .) +
  theme(axis.text.x = element_text(angle = 90, vjust = .5, hjust = 1)) +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15)) +
  labs(
    title = "Education Levels of Adults vs Family Income by Sex",
    x = "Education Level of Adult",
    y = "Count",
    fill = "Family Income Level"
  ) +
  scale_fill_viridis_d()

# Saved first graph
ggsave(here("04_plots", "education_vs_income.png" ))

# Plot shows that education level increases the proportion of families that
# make above $20,000. Families with an adult that graduated college are most 
# likely earning more than $100,000. Male and female education levels have
# similar impacts on family income, but higher male education levels are more
# likely to boost earnings.

# Made bar graph to show the proportion of ethnicities in the survey population
ggplot(demo_2015, aes(x = fct_infreq(ridreth3), fill = ridreth3)) +
  geom_bar(show.legend = FALSE) +
  theme_classic() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 12)) +
  labs(
    title = "Count of each Ethnicity in Survey",
    y = "Count",
    x = "Ethnicity"
  )
# Saved second graph
ggsave(here("04_plots", "ethnicity_count.png"))

# Although Non-Hispanic Whites made up the largest percentage of the survey
# the survey is not an accurate depiction of US demographics; Non-Hispanic Black
# Americans and Latino Americans are over represented.

# Replaced value to make plotting graph easier
demo_ethnicity <- demo_2015 |> 
  mutate(dmdfmsiz = if_else(
    dmdfmsiz == "7 or more people in the Family",
    "7+", 
    dmdfmsiz
  ))

# Faceted graph to view distribution of family sizes between ethnicities
ggplot(demo_ethnicity, aes(x = dmdfmsiz, fill = dmdfmsiz)) +
  geom_bar(show.legend = FALSE) +
  facet_wrap(~ridreth3, axes= "all") +
  scale_fill_brewer(palette = "Dark2") +
  theme_classic() +
  labs(
    title = "Family Size vs Ethnicity",
    y = "Count",
    x = "Size of Family"
  )
# Saved third graph
ggsave(here("04_plots", "family_size_vs_ethnicity.png"))

# Most ethnicities have a somewhat left distribution but the Mexican American
# and Non-Hispanic whites vary from this trend. Mexican Americans have a slight
# right distribution, or higher family sizes on average, while Non-Hispanic 
# Whites have a a notable left distribution, meaning they have smaller families
# on average.
