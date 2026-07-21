# ==============================================================================
# SCRIPT MODULE: HOPR Chapter 3 Exercises and Examples
# OBJECTIVE:     Learn About and Practice Packages and Help Pages
# WORKSPACE REF: r_school / 01_textbook_sandboc 
#                         / hopr_chapter_3_package_and_help_practice.R
# DEPENDENCIES:  ggplot2
# STRATIFICATION: Created Dice Function
# ==============================================================================
library(ggplot2)

# 3.1 Examples and Exercises ----------------------------------------------
# unloaded function example
qplot

# loaded function example
qplot

# Concatenate vector example
x <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
x

# Qplot scatterplot example 
y <- x^3
y
qplot(x, y)

# Qplot histogram example
x <- c(1, 2, 2, 2, 3, 3)
qplot(x, binwidth = 1)

# Qplot histogram example (2)
x2 <- c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4)
qplot(x2, binwidth = 1)

# Qplot exercise
x3 <- c(0, 1, 1, 2, 2, 2, 3, 3, 4)
qplot(x3, binwidth = 1)

# Replicate function
replicate(3,1 +1)
replicate(10, roll())

# Replicate + qplot
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)


# 3.2 Exercises and Examples ----------------------------------------------

# Help pages examples
?sqrt
?log10
?sample

# Keyword help pages examples
??log

# Weighted dice exercise
roll <- function() {
  dice <- 1:6
  dice <- sample(
    die, size = 2, 
    replace = TRUE,
    prob = c(1 / 8, 1 / 8, 1 / 8, 1 / 8, 1 / 8, 3 / 8)
  )
  sum(dice)
}

# Weighted dice exercise (2)
test <- replicate(10000, roll())
qplot(test, binwidth = 1)
