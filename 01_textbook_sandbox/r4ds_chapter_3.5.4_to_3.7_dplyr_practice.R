# ==============================================================================
# SCRIPT MODULE: R4DS Chapter 3.5.4 to 3.7 Exercises and Examples
# OBJECTIVE:     Learn and Practice New dplyr Function Calls
# WORKSPACE REF: r_school / 01_textbook_sandbox 
#                         / r4ds_chapter_3.5.4_to_3.7_dplyr_practice
# DEPENDENCIES:  tidyverse, here
# STRATIFICATION: nycflights13 and Lahman Packages
# ==============================================================================
library(tidyverse)
library(here)
library(nycflights13)


# Chapter 3.5.4 Examples --------------------------------------------------

# Multivariable grouping
daily <-  flights |> 
  group_by(year, month, day)
daily

# Multivariable grouping (2)
daily_flights <- daily |> 
  summarize(n = n())
daily_flights

# Keeping characteristics of multivariable grouping
daily_flights <- daily |> 
  summarize(
    n = n(),
    .groups = "drop_last",
  )

# Ungrouping function
daily |> 
  ungroup()

# Ungrouping function (2)
daily |> 
  ungroup() |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE),
    flights = n()
  )

# New grouping function
flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE),
    n = n(),
    .by = month
  ) 

# New grouping function (2)
flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE),
    n = n(),
    .by = c(origin, dest)
  )

# Chapter 3.5 Exercises ---------------------------------------------------

# Worst delays exercises 
flights |> 
  group_by(carrier) |> 
  summarize(delay = mean(dep_delay, na.rm = TRUE)) |> 
  arrange(desc(delay))

# Worst delays (2)
flights |>
  group_by(dest) |> 
  summarize(delay = mean(dep_delay, na.rm = TRUE)) |> 
  arrange(desc(delay))

# Worst delays (3)
flights |> 
  group_by(carrier,dest) |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE),
    .groups = "drop") |> 
  arrange(desc(delay))

# Worst flights
flights |> 
  group_by(dest, flight) |> 
  slice_max(dep_delay, n = -1) |>
  summarize(flight, dest, dep_delay) |> 
  arrange(desc(dep_delay))

# Delays by the hour
flight_delay <- flights |> 
  group_by(dep_time) |> 
  summarize(avg_delay = mean(dep_delay))

# Delays by the hour plot
ggplot(flight_delay, aes(x = dep_time, y = avg_delay)) +
  geom_point() +
  geom_line()

# Prediction exercise
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)

# PE (2)
df |> 
  group_by(y)

# PE (3)
df |> 
  arrange(y)

# PE (4)
df |> 
  group_by(y) |> 
  summarize(mean_x = mean(x))

df |> 
  group_by(y, z) |> 
  summarize(mean_x = mean(x))

df |> 
  group_by(y, z) |> 
  summarize(mean_x = mean(x), .groups = "drop")

df |> 
  group_by(y, z) |> 
  mutate(mean_x = mean(x))


# Chapter 3.6 Examples ----------------------------------------------------

# Batting Data
batters <- Lahman::Batting |> 
  group_by(playerID) |> 
  summarize(
    performance = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    n = sum(AB, na.rm = TRUE)
  )
batters

# Batting Graph
batters |> 
  filter(n > 100) |> 
  ggplot(aes(x = n, y = performance)) +
  geom_point(alpha = 1 / 10) +
  geom_smooth(se = FALSE)

batters |> 
  arrange(desc(performance))
