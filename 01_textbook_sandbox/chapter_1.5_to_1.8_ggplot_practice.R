library(palmerpenguins)
library(tidyverse)
library(ggthemes)

penguins
# Book Examples -----------------------------------------------------------
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

#Density Plot
ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75)

#Density Plot filled
ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.3)

#Bar Graph
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

#Bar Graph by proportion
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

#Bar Graph by proportion (labeled)
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill") +
  labs(y = "proportion")

#Four variable scatter plot
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))
 
#Optimized Four variable scatter plot
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)


# 1.5 Exercises -----------------------------------------------------------
#MPG variables
?mpg
View(mpg)

#hwy vs displ mpg data frame
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(size = cty, color = cty)) +
  labs(size = "City mpg", color = "City mpg")

#hwy vs dipls mpg linewidth
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(linewidth = cty) 
  
#Depth vs Length scatterplot by species(A)
ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm )) +
  geom_point(aes(color = species))

#Depth vs Length scatterplot by species(B)
ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() +
  facet_wrap(~species)

#Two legends Solution
ggplot(
  penguins, 
  aes(
    x = bill_length_mm, y = bill_depth_mm,
    color = species,
    shape = species
  )
) +
  geom_point() +
  labs(color = "Species", shape = "Species")

# Two Plots visualization(A)
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill") 

# Two Plots Visualization (B)
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")
  

# 1.6 Examples ------------------------------------------------------------

ggplot(penguins, aes(x = flipper_length_mm, y =  body_mass_g)) +
  geom_point() +
  ggsave(filename = "penguin-plot.png")

# 1.6 Exercises
ggplot(mpg, aes(x = class)) +
  geom_bar() 
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point() +
  ggsave("mpg-plot.png")
  
  
