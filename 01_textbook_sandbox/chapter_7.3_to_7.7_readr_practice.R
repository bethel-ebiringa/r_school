library(here)
library(readr)

read_csv(
  "logical,numeric,date,string
  TRUE,1,2021-01-15,abc
  false,4.5, 2021-02-15,def
  T,Inf,2021-02-16,ghi"
)

#Making a one column csv file
simple_csv <- "
  x
  10
  .
  20
  30"

#setting column to double
df <- read_csv(
  simple_csv,
  col_types = list(x = col_double())
)

#finding anomalies in columns
problems(df)

read_csv(simple_csv, na = ".")

# Removing columns experiment
students_2 <- students |>
  select(-full_name, -student_id)

#Making a two 3 column csv
another_csv <- "
  x,y,z
  1,2,3"

#
read_csv(another_csv, col_types = cols(.default = col_character()))

#
read_csv(another_csv,col_types = cols_only(x = col_character()))

#combining different files into one data frame
total_sales <- read_csv(
  c(
    here("data", "01_sales.csv"),
    here("data", "02_sales.csv"),
    here("data", "03_sales.csv")
  ), 
  id = "file"
)

#Reading all files in data folder ending with sales
read_csv(
  list.files(
    here("data"), 
    pattern = "sales\\.csv", 
    full.names = TRUE)
)

#saving the students file
write_csv(students, here("data", "students.csv"))



#Saving the file to disk
write_csv(students, here("data", "students_2.csv"))

#Making a file that saves column types
write_rds(students, here("data", "students.rds"))
read_rds(here("data", "students.rds"))

#Making tibble
tibble(
  x = c(1, 2, 5),
  y = c("h", "m", "g"),
  z = c(0.06, 0.83, 0.60)
)

#Making transposed tibble
tribble(
  ~x,~y,~z,
  1, "h", 0.06,
  2, "m", 0.83,
  5, "g", 0.60
)
