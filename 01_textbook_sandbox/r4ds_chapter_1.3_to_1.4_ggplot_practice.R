library(palmerpenguins)
library(tidyverse)
library(ggthemes)


# Book examples -----------------------------------------------------------


# Argument free (first 2) code
ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point()

# Ordering a bar graph by frequency
ggplot(penguins, aes(fct_infreq(species))) +
  geom_bar()

#Histogram Bar
ggplot(penguins, aes(x = body_mass_g)) + 
  geom_histogram(binwidth = 200)

#Frequency Experiment (A)
experiment_one <- penguins |>
  drop_na(flipper_length_mm) |>
  group_by(island, species) |>
  summarize(average_flipper_length = mean(flipper_length_mm))

#Frequency Experiment (B)
ggplot(experiment_one, aes(x = average_flipper_length, y = island)) +
  geom_col(aes(y = fct_infreq(island), fill = species), position = "dodge")

#Density Plot
ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

#Density Plot Experiment
ggplot(penguins, aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_density_2d_filled()

# Y vs X aesthetic bar graph exercise
ggplot(penguins, aes(y = fct_infreq(species))) + 
  geom_bar()

#Geom color vs fill arguments(1)
ggplot(penguins, aes(x = species)) +
  geom_bar(aes(fill = "red"))

#Geom color vs fill arguments(2)
ggplot(penguins, aes(x = species)) +
  geom_bar(aes(color = "red"))

#Bins argument for geom_histogram
ggplot(penguins, aes(x = bill_length_mm)) +
  geom_histogram(bins = 20)
  
           
# Ordering a bar graph by frequency
ggplot(penguins, aes(fct_infreq(species))) +
  geom_bar()