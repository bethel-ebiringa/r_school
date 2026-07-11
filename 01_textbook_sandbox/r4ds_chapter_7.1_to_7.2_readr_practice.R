library(tidyverse)
students <- read_csv("https://pos.it/r4ds-students-csv", na = c("", "N/A"))


# 7.1-7.2 Examples --------------------------------------------------------


#making syntatic names
students |>
  rename("student_id" = 'Student ID', "full_name" = 'Full Name')

#Changing meals from character to factor
students |> 
  janitor::clean_names() |> 
  mutate(meal_plan = factor(meal_plan))

#Replacing values to make age numerical
students |>
  janitor::clean_names() |>
  mutate(
    meal_plan = factor(meal_plan),
  age = parse_number(if_else(age == "five", "5", age))
  )

#Making a csv file
read_csv(
  "a,b,c
  1,2,3
  4,5,6"
)

#Making a csv file with metadata
read_csv(
  "First line of metadata,
  Second line of meta data
  a,b,c
  1,2,3
  4,5,6", 
  skip = 2
)

#Making a csv file with comments
read_csv(
  "#Comment I want to skip,
  a,b,c
  1,2,3", 
  comment = "#"
)

#Csv file with no column names
read_csv(
  "1,2,3
  4,5,6",
  col_names = FALSE
)

# Csv file with vector names
read_csv(
  "1,2,3
  4,5,6", 
  col_names = c("x","y","z"))


# 7.2 Exercises -----------------------------------------------------------

# "|" delimiter
read_delim(
"A|B|C
1|2|3")

#Fixing quotes
read_csv("x,y\n1,'a,b'", quote = "'")

#Fixing inline CSV files
read_csv("a,b,c\n1,2,3\n4,5,6")
read_csv("a,b,c,d\n1,2\n1,2,3,4")
read_csv("a,b\n1")
read_csv("a,b\n1,2\na,b") 
read_csv2("a;b\n1;3")
