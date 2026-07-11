library(palmerpenguins)
library(tidyverse)
library(ggthemes)

#Body mass to flipper length plot--------------------------------------
ggplot(
  data = penguins, 
  aes(x = flipper_length_mm, y = body_mass_g,)
) +
  geom_point(
    mapping = aes(colour = species, shape = species)
  ) +
  geom_smooth(
    method = "lm"
  ) + 
  labs(
    title = "Penguin Flipper Length (mm) Compared to Body Mass (g)",
    subtitle = "Penguins of X, Y, and Z species",
    x = "Flipper Length (mm)",
    y = "Body Mass (g)",
  ) +
  scale_color_colorblind() 

#Bill length and depth plot------------------------------------------
ggplot(
  data = penguins,
  aes(x = bill_length_mm, y = bill_depth_mm)
) + 
  geom_point(na.rm = TRUE) +
  geom_smooth(method = "lm") 

#Beak depth by species plot-----------------------------------------------
ggplot(
  data = penguins, 
  aes(x = species, y = bill_depth_mm)
) +
  geom_col() +
  labs(
    caption = "Data come from the palmerpenguins package"
  )

#Recreation exercise-------------------------------------
ggplot(
  data = penguins, 
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(
    mapping = aes(color = bill_depth_mm)
  ) +
  geom_smooth() +
  scale_color_colorblind()

#Prediction Exercise------------------------------------
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

#Difference Exercise (Part A)------------------------------

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

#Difference Exercise (Part B)------------------------------
ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )


# Extra Practice (1) ------------------------------------------------------

#Finding average of bill Length
bill_length_data <- penguins |>
  drop_na(bill_length_mm) |>
  group_by(island, species) |>
  summarise(
    average_bill_length = mean(bill_length_mm)
  ) 
  
#Plotting average)
ggplot(
  data = bill_length_data, 
  mapping = aes(x = average_bill_length, y = island)
) + 
  geom_col(
    aes(fill = species), 
    position = "dodge"
  )

  

