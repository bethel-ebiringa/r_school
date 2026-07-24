# ==============================================================================
# SCRIPT MODULE: 7/23/2026 HOPR Chapter 5.6 to 5.11 Exercises and Examples
# OBJECTIVE:     Learn About and Practice More Object Types in R
# WORKSPACE REF: r_school / 01_textbook_sandbox 
#                         / hopr_chapter 5.6_to_5.11_vector_practice.R
# DEPENDENCIES:  Base R
# STRATIFICATION:Atomic Vectors from Textbook
# ==============================================================================


# 5.6 and 5.7 Exercises and Examples --------------------------------------
# Coersion Experiment
test <- c(TRUE, FALSE, 1, 2, 3, 5)
test

# Coersion example
sum(c(TRUE, TRUE, FALSE, FALSE))
sum(c(1, 1, 0, 0))
as.character(1)
as.logical(1)
as.numeric(FALSE)

# List example
list1 <- list(100:130, "R", list(TRUE, FALSE))
list1

# 5.6 Exercise
card <- list("ace","hearts", 1)
card


# 5.8 to 5.10 Exercises and Examples --------------------------------------
# Data frame example
df <- data.frame(
  face = c("ace", "two", "six"),
  suit = c("clubs", "clubs", "clubs"),
  value = c(1, 2, 3)
)
df
typeof(df)
class(df)
str(df)

# Names example
card2 <- list(
  face = "ace", 
  suit = "hearts",
  value = 1
)
card2

card3 <- c(
  face = "ace",
  suit = "hearts",
  value = "one"
)
card3

# Factor free df example
df <- data.frame(
  face = c("ace", "two", "six"),
  suit = c("clubs", "clubs", "clubs"),
  value = c(1, 2, 3),
  stringsAsFactors = FALSE
)
str(df)
glimpse(df)

# Loading deck example
head(deck, 5)

# Writing csv file
write.csv(deck, file = "card.csv", row.names = FALSE)
