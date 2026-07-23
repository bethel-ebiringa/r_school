# ==============================================================================
# SCRIPT MODULE: HOPR Chapter 5.1 to 5.5 Examples and  Exercises
# OBJECTIVE:     Learn About and Practice Using Objects in R
# WORKSPACE REF: r_school / 01_textbook_sandbox 
#                         / hopr_chapter_5.1_to_5.5_object_practice.R
# DEPENDENCIES:  Base R
# STRATIFICATION:In-text Objects
# ==============================================================================

# 5.1 Exercises and Examples ----------------------------------------------

# Atomic vector example
die <- c(1, 2, 3, 4, 5, 6)
die
is.vector(die)

# Single Atomic vector example
five <- 5
five
is.vector(five)
length(five)
length(die)

# Character and integer vectors example
int <- 1L
text <- "ace"

# Combining elements in vectors example
int <- c(1L, 5L)
text <- c("ace", "hearts")

# Characteristics of different vectors example
sum(int)
sum(text)

# Double vectors examples
die <- c(1, 2, 3, 4, 5, 6)
die
typeof(die)

# Integer vector examples
int <- c(-1L, -2L, 4L)
int
typeof(int)

# Rounding error examples
sqrt(2)^2 - 2

# Character vectors examples
text <- c("Hello", "World")
text
typeof(text)
typeof("Hello")

# Logical vectors examples
3 > 4
logic <- c(TRUE, FALSE, TRUE)
typeof(logic)
typeof(F)

# Complex and raw vectors examples
comp <- c(1 + 1i, 1 + 2i, 1 + 3i)
comp
typeof(comp)

raw(3)
typeof(raw(3))


# 5.2 Exercises and Examples ----------------------------------------------

# 5.2 Exercise
royal_flush <- c("ace", "king", "queen", "jack", "10")

# Attributes example
attributes(die)
names(die) <- c("one", "two", "three", "four", "five", "six")
names(die)
attributes(die)
die

# Attributes renaming example
names(die) <- c("uno", "dos", "tres", "cuatro", "cinco", "seis")
die
names(die) <- NULL
die

# Dimensional Attributes example
dim(die) <- c(2, 3)
die
dim(die) <- c(3,2)
die
dim(die) <- c(1,2,3)
die

# 5.3 and 5.4 Exercises and Examples ---------------------------------------

# Matrices examples
m <- matrix(die, nrow = 2)
m
m <- matrix(die, nrow = 2, byrow = TRUE)
m

# Array examples
ar <- array(c(11:14, 21:24, 31:34), dim = c(2,3,3))

# 5.3 Exercise
flush <- c(
  "ace", 
  "king", 
  "queen", 
  "jack", 
  "ten", 
  "spades", 
  "spades", 
  "spades", 
  "spades", 
  "spades"
  )

matrix(flush, ncol = 2)


# 5.5 Exercises and Examples ----------------------------------------------

# Class example
dim(die) <- c(2,3)
typeof(die)
class(die)
attributes(die)

# Class vector example
class("Hello")
class(5)

# Time exmaple
now <- Sys.time()
now
typeof(now)
class(now)
unclass(now)

# Time example (2)
mil <- -1000000
class(mil) <- c("POSIXct", "POSIXt")
mil
mil

# Factors example
gender <- factor(c("male", "female", "female", "male"))
typeof(gender)
attributes(gender)
unclass(gender)
gender
as.character(gender)

# Exercise 5.4
ace <- c("ace", "hearts",  1)
typeof(ace)
ace
