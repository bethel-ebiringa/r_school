# ==============================================================================
# SCRIPT MODULE: HOPR Chapter 2 Exercises and Examples
# OBJECTIVE:     Learn and Practice Basic Commands and Functions
# WORKSPACE REF: r_school / 01_textbook_sandbox 
#                         / hopr_chapter_2_base_r_practice.R
# DEPENDENCIES:  Base R
# STRATIFICATION: Sample Function Call
# ==============================================================================

# 2.1 Examples and Exercises ----------------------------------------------


# Command example

1 + 1

# Multiple results command example
100:130

# Incomplete results command example
5 -
1  

# Error command examples
3 % 5

# Basic arithmetic examples
2 * 3
4 - 1
6 / (4- 1)

# Exercise 2.1
100 + 2
102 * 3
306 - 6
300 / 3


# 2.2 Examples and Exercises ----------------------------------------------

# Vector examples
1:6

# Saved object examples
a <- 1
a + 2

# Making a die vector
die <- 1:6
die

# Case sensitive examples
Name <- 1
name <- 0
Name + 1

# Overwriting objects exmaples
my_number <- 1
my_number

my_number <- 999
my_number

# Checking objecy names example
ls()

# Math with vector object examples
die - 1
die / 2
die * die

# Vector math experiment
1:3 * 1:8 # NOTE: vectors should be multiples/ factors of eachother for math 

# Vector recycling examples
1:2
1:4
die
die + 1:2
die + 1:4

# Matrix multiplication examples
die %*% die
die %o% die


# 2.3 Examples and Exercises --------------------------------------

# Function examples
round(3.1415)
factorial(3)

# Function argument flow example
mean(1:6)
mean(die)
round(mean(die))

# Sample function
sample(x = 1:4, size = 2)

# Sample die rolling
sample(x = die, size = 1)

# Name free argument example
sample(die, size = 1)

# Unexpected argument example
round(3.1415, corners = 2)

# Argument checker
args(round)

# Round experiment
round(12.54, digits = 1)

# Digit argument example
round(3.1415)
round(3.1415, digits = 2)

# Name free argument example (2)
sample(die, 1)

# Order of arguments example
sample(size = 1, x = die)

# Sample with replacement exmaple
sample(die, size = 2)
sample(die, size = 2, replace = TRUE)

# Sum of dice example
dice <-  sample(die, size = 2)
sum(dice)


# 2.4 Examples and Exercises ----------------------------------------------

# Dice code recap
dice <- 1:6
dice <- sample(die, size = 2, replace = TRUE)
sum(dice)

# Function creation
my_function <- function() {}

# Function creation (2)
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

# Using created function
roll()

# Viewing Created function
roll

# 2.5 Exercises and Examples

# New dice function
roll2 <- function(){
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2()

# New dice function fix
roll2 <- function(bones){
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2(1:6)

# New dice function examples
roll2(bones = 1:4)
roll2(bones = 1:6)
roll2(1:20)
roll2() # still broken

# New dice function full fix
roll2 <- function(bones= 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2()
