# ==============================================================================
# SCRIPT MODULE: 7/27/2026 HOPR Chapter 6 Exercises and Examples
# OBJECTIVE:     Learn about and Practice Accessing Values in R
# WORKSPACE REF: r_school / 01_textbook_sandbox 
#                         / hopr_chapter_6_values_practice.R
# DEPENDENCIES:  tidyverse, here
# STRATIFICATION:deck.csv Full Deck of Cards 
# ==============================================================================
library(tidyverse)
library(here)

# Read deck file into R for book examples
deck <- read_csv(here("data", "deck.csv"))


# 6.1 Exercises and Examples ----------------------------------------------

# Positive Integer Value Selection Examples
head(deck)
deck[1,1]
deck[1,c(1,2,3)]
new <- deck[1, c(1,2,3)]
deck[c(1,1), c(1,2,3)]
vec <- c(6, 1, 3, 6, 10, 5)
vec[1:3]

# drop = FALSE Examples
deck[1:2, 1:2]
deck[1:2, 1]
deck[1:2, 1, drop = FALSE]

# Negative Integer Value Selection Examples
deck[-(2:52), 1:3]
deck[c(-1,1), 1]

# Zero Value Selection Examples
deck[0, 0]

# Blank Spaces Value Selection Examples
deck[1, ]

# Logical Values and Names Value Selection Examples
deck[1, c(TRUE, TRUE, FALSE)]
rows <- c(TRUE, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, 
          F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, 
          F, F, F, F, F, F, F)
deck[rows, ]
deck[1, c("face", "suit", "value")]
deck[ , "value"]


# 6.2 to 6.3 Exercises and Examples ---------------------------------------
# 6.2 Exercise
deal <- function(cards) {
  cards[1, ]
}
deal(deck)

# Shuffling Deck Examples
deck2 <- deck[1:52, ]
head(deck2)
deck3 <- deck[c(2, 1, 3:52), ] 
head(deck3)
random <- sample(1:52, size = 52)
random
deck4 <- deck[random, ]
head(deck4)

# 6.3 Exercise
deal2 <- function(cards) {
  order <- sample(1:52, size = 52)
  card <- order[1]
  cards[card, ]
}
deal2(deck)


# 6.4 Examples and Exercises ----------------------------------------------
# Dollar Signs Examples
deck$value
mean(deck$value)
lst <- list(numbers = c(1, 2), logical = TRUE, strings = c("a", "b", "c"))
lst
lst[1]
sum(lst[1])
lst$numbers
sum(lst$numbers)

# Double Brackets Examples
lst[[1]]
lst["numbers"]
lst[["numbers"]]

