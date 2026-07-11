# ==============================================================================
# PROJECT: Simulated Clinical Data Intake Challenge (Creatinine Cleansing)
# OBJECTIVE: To Clean and Save Messy Data
# DATA SOURCE: Synthetic Patient Biomarker Logs
# AUTHOR: Bethel Ebiringa
# ==============================================================================

library(readr)
library(here)
library(tidyr)
library(dplyr)

# Saved the csv data so it could be cleansed 
raw_message_data <- "
PAT_ID, RECORD_DATE  , BASELINE_CREATININE , ADVERSE_EVENT
  P_101,  2026-05-12  ,       1.12          ,    None
  P_102,  2026-05-14  ,       Unknown       ,    Mild
  P_103,  Missing     ,       0.98          ,    Severe
  P_104,  2026-05-20  ,       1.45          ,    None
"
# Cleaned messy data by setting relevant column types
read_message_data <- raw_message_data |>
  read_csv(
    col_types = list(
      PAT_ID = col_character(), 
      RECORD_DATE = col_date(), #
      BASELINE_CREATININE = col_double(), 
      na = c("Unknown" , "Missing"), 
      trim_ws = TRUE # Removed white space to fix weird spacing
    )
  )
  
# Checked parsing for any data anomalies 
problems(read_message_data)

# Ordered a data frame by set levels
cleaned_message_data <- read_message_data |>
  drop_na(RECORD_DATE) |> # Removed missing date to make data less messy
  mutate(
    ADVERSE_EVENT = factor(
      ADVERSE_EVENT, 
      levels = c("None", "Mild", "Severe")
    )
  ) |>
  arrange(ADVERSE_EVENT)

#Saved the project twice to preserve column types
write_csv(cleaned_message_data, here("data", "cleaned_message_data.csv"))
write_rds(cleaned_message_data, here("data", "cleaned_message_data.rds"))
