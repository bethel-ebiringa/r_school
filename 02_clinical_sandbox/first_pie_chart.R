library(here)
library(readr)
library(janitor)

#Load data
students <- read_csv(here("Data", "students.csv")) |>
  clean_names()

#Pie Chart
ggplot(students, aes(x = " ", fill = meal_plan)) +
  geom_bar(width = 1, stat = "count") +
  coord_polar(theta = "y") +
  theme_void() +
  scale_fill_brewer(palette = "Set1")

#Scatter plot graph
students |>
  filter(!is.na(age)) |>
  mutate(age = parse_number(if_else(age == "five", "5", age))) |>
ggplot(aes(x = age)) +
  geom_histogram(aes(fill = meal_plan), binwidth = 1.5) +
  scale_fill_brewer(palette = "Set1")




