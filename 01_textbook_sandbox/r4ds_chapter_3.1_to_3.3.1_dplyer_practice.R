# ==============================================================================
# SCRIPT MODULE: R4DS Chapter 3 Exercises and Examples
# OBJECTIVE:     1-sentence explanation of what you are calculating or plotting
# WORKSPACE REF: r_school / 01_textbook_sandbox 
#                         / r4ds_chapter_3.1_to_3.3_dplyer_practice.R
# DEPENDENCIES:  tidyverse, here, nycflights13
# STRATIFICATION: nycflights13 package
# ==============================================================================
library(tidyverse)
library(here)
library(nycflights13)

# Average delay per day code
flights |>
  filter(dest == "IAH") |>
  group_by(year, month, day) |>
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

# Filter example
flights |>
  filter(month == 1, day == 1)

# Filter example (2)
flights |> 
  filter(month == 1 | month == 2)

# Filter shortcut
flights |>
  filter(month %in% c(1,2))

# Saving filter edit
jan1 <- flights |>
  filter(month == 1, day == 1)

# Common mistakes (1)
flights |>
  filter(month = 1)

# Common mistakes (2)
flights |>
  filter(month == 1 | 2)

# arrange function
flights |>
  arrange(year, month, day, dep_time)

# desc function
flights |>
  arrange(desc(dep_delay))

# distinct function
flights |>
  distinct()

# distinct function
flights |>
  distinct(origin, dest)

# distinct function (2)
flights |>
  distinct(origin, dest, .keep_all = TRUE)

#distinct function (3)
flights |>
  count(origin, dest, sort = TRUE)


# Chapter 3.2 Exercises ---------------------------------------------------


# Meeting conditions exercise
flights |>
  filter(arr_delay >= 120)
flights |>
  filter(dest %in% c(IAH, HOU))
flights |>
  filter(carrier %in% c("DL", "AA", "UA"))
flights |>
  filter(month %in% c (7,8,9))
flights |>
  filter(dep_delay <= 0, arr_delay > 120)
flights |>
  filter(dep_delay >= 60, arr_delay <= dep_delay - 30)

# Sorting flights exercise    
flights |>
  arrange(desc(dep_delay))
flights |>
  arrange(dep_time)

# Fastest flights exercise
flights |>
  arrange(air_time / distance)

# Flight every day exercise
flights |>
  distinct(day, month)

# Farthest and least distance exercise
flights |>
  arrange(desc(distance))
flights |>
  arrange(distance)


# Chapter 3.3 examples ----------------------------------------------------
flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
  )

flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60, 
    .before = 1
  )

flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )

flights |>
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )
