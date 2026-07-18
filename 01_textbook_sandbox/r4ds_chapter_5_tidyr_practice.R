# ==============================================================================
# SCRIPT MODULE: R4DS Chapter 5 Examples and Exercises
# OBJECTIVE:     Learn and Practice Data Tidying Methods
# WORKSPACE REF: r_school / 01_textbook_sandbox 
#                         / r4ds_chapter_5_tidyr_practice.R
# DEPENDENCIES:  tidyverse, here
# STRATIFICATION: Tidyverse Data Sets
# ==============================================================================
library(tidyverse)
library(here)

# Chapter 5.2 Examples ----------------------------------------------------


# Clean table
table1
#> # A tibble: 6 × 4
#>   country      year  cases population
#>   <chr>       <dbl>  <dbl>      <dbl>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3 Brazil       1999  37737  172006362
#> 4 Brazil       2000  80488  174504898
#> 5 China        1999 212258 1272915272
#> 6 China        2000 213766 1280428583

# Clean table transformation
table1 |> 
  mutate(rate = cases / population * 10000)

# Clean table transformation (2)
table1 |> 
  group_by(year) |> 
  summarize(total_cases = sum(cases))

# Clean table plotting 
ggplot(table1, aes(x = year, y = cases)) +
  geom_line(aes(group = country), color = "grey50") +
  geom_point(aes(color = country, shape = country)) +
  scale_x_continuous(breaks = c(1999, 2000))


# Chapter 5.3 Examples ----------------------------------------------------
# Pivoting Data
billboard |> 
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank"
  )

# Removing NA pivoted Data
billboard |> 
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE
  )

# Parsed and pivoted data
billboard_longer <- billboard |> 
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE
  ) |> 
  mutate(
    week = parse_number(week)
  )
# Plotted clean data
billboard_longer |> 
  ggplot(aes(x = week, y = rank, group = track)) +
  geom_line(alpha = 0.25) +
  scale_y_reverse()

# Sample data example
df <- tribble(
  ~id, ~bp1, ~bp2,
  "A",  100,  120,
  "B",  140,  115,
  "C",  120,  125
)

# Sample data example (2)
df |> 
  pivot_longer(
    col = bp1:bp2,
    names_to = "measurement",
    values_to = "value"
  )

# Many variables in column names
who2 |> 
  pivot_longer(
    cols = !(country:year),
    names_to = c("diagnosis", "gender", "age"),
    names_sep = "_",
    values_to = "count"
  )

# Variable/Value column names fix
household |> 
  pivot_longer(
    cols = !family,
    names_to = c(".value", "child"),
    names_sep = "_",
    values_drop_na = TRUE
)


# Chapter 5.4 Examples ----------------------------------------------------
cms_patient_experience |> 
  distinct(measure_cd, measure_title)

cms_patient_experience |> 
  pivot_wider(
    names_from = measure_cd,
    values_from = prf_rate
  )

cms_patient_experience |> 
  pivot_wider(
    id_cols = starts_with("org"),
    names_from = measure_cd,
    values_from = prf_rate
  )

# Sanple data set
df <- tribble(
  ~id, ~measurement, ~value,
  "A",        "bp1",    100,
  "B",        "bp1",    140,
  "B",        "bp2",    115, 
  "A",        "bp2",    120,
  "A",        "bp3",    105
)

# Cleaning sample data
df |> 
  pivot_wider(
    names_from = measurement,
    values_from = value
  )
# Pivot Wider step one
df |> 
  distinct(measurement) |> 
  pull()

# Pivot wider step two
df |> 
  select(!measurement & !value) |> 
  distinct()

# Pivot wider step three
df |> 
  select(!measurement & !value) |> 
  distinct() |> 
  mutate(x = NA, y = NA, z = NA)

# Sample data two
df <- tribble(
  ~id, ~measurement, ~value,
  "A",        "bp1",    100,
  "A",        "bp1",    102,
  "A",        "bp2",    120,
  "B",        "bp1",    140, 
  "B",        "bp2",    115
)

# Overlapping value pivoting 
df |> 
  pivot_wider(
    names_from = measurement,
    values_from = value
  )

# Finding overlapping values
df |> 
  group_by(id, measurement) |> 
  summarize(n = n(), .groups = "drop") |> 
  filter(n > 1)
