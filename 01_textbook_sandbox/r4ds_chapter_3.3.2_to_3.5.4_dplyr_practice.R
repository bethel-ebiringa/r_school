# ==============================================================================
# SCRIPT MODULE: R4DS Chapter 3.3.2 to 3.5.4 Exercises and Examples
# OBJECTIVE:     Practice Data Cleaning Techniques 
# WORKSPACE REF: r_school / 01_textbook_sandbox 
#                         / r4ds_chapter_3.3.1_to_3.5.4_dplyr_practice.R
# DEPENDENCIES:  tidyverse, here, nycflights13
# STRATIFICATION: nycflights13 package
# ==============================================================================
library(tidyverse)
library(here)
library(nycflights13)


# Chapter 3.3 Examples ----------------------------------------------------

# Selecting column names
flights |>
  select(year, month, day)

# Selecting column names between variables
flights |>
  select(year:day)

# Select column names except between variables
flights |>
  select(!year:day)

# Select column names for certain column types
flights |>
  select(where(is.character))

# Select helper functions
#   starts_with("abc")
#   ends_with("xyz")
#   contains("ijk")
#   num_range("x", 1:3)

# Select column names and renaming them
flights |>
  select(tail_num = tailnum)

# Renaming variables
flights |>
  rename(tail_num = tailnum)

# relocating variables
flights |>
  relocate(time_hour, air_time)

# relocating variables (2)
flights |>
  relocate(year:dep_time, .after = time_hour)

# relocating variables (3)
flights |>
  relocate(starts_with("arr"), .before = dep_time)

# Chapter 3.3 Exercises ---------------------------------------------------
# Comparing depature variables
flights |>
  select(dep_time, dep_delay, sched_dep_time)

# Brainstorming exericse
flights |>
  select(dep_time, dep_delay, arr_time, arr_delay)
flights |>
  select(starts_with("arr"), starts_with("dep"))
flights |>
  relocate(starts_with("sched"), .after = time_hour) |>
  select(dep_time:arr_delay)

# Multiple specification exercise
flights |>
  select(dep_time, dep_time, arr_time)

# any_of function
flights |>
  select(any_of(c("dep_time", "dep_delay", "arr_time", "arr_delay")))

# Case sensitive prompts
flights |>
  select(contains("TIME", ignore.case = FALSE))

# Transforming _airtime exercise
flights |>
  mutate(air_time_min = air_time, .before = 1)

# Fixing error exercise
flights |>
  select(tailnum, arr_delay) |>
  arrange(arr_delay)


# Chapter 3.4 Exampless ---------------------------------------------------
# Multiple functions connected by pipes
flights |>
  filter(dest == "IAH") |>
  mutate(speed = distance / air_time * 60) |>
  select(year:day, dep_time, carrier, flight, speed) |>
  arrange(desc(speed))

# Multiple functions without pipes
arrange(
  select(
    mutate(
      filter(
        flights,
        dest == "IAH"
      ),
      speed = distance / air_time * 60
    ),
    year:day, dep_time, carrier, flight, speed
  ),
  desc(speed)
)

# Mupltiple functions without pipes (2)
flights1 <- filter(flights, dest == "IAH")
flights2 <- mutate(flights1, speed = distance / air_time * 60)
flights3 <- select(flights2, year:day, dep_time, carrier, flight, speed)
arrange(flights3, desc(speed))


# Chapter 3.5 Examples ----------------------------------------------------

# Group by function
flights |> 
  group_by(month)

# Summarizing function
flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay)
  )

# Summarizing function (fixed)
flights |> 
  group_by(month) |> 
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE))

# Summarizing function (continued)
flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE),
    count = n()
  )

# Slice_ functions
#   df |> slice_head(n = 1)
#   df |> slice_tail(n = 1)
#   df |> slice_min(x, n = 1)
#   df |> slice_max(x, n = 1)
#   df |> slice_sample(n = 1)

# Using slice function 
flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1) |> 
  relocate(dest)
