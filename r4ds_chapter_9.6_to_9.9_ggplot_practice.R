# ==============================================================================
# SCRIPT MODULE: Chapter 9.6 - 9.8 R4DS Textbook Examples and Exercises
# OBJECTIVE: Practice Position Adustments, Coordinate Systems and ggplot Grammar
# WORKSPACE REF: r_school / 01_textbook_sandbox  
#                         / r4ds_chapter_9.6_to_9.9_ggplot_practice.R
# DEPENDENCIES:  tidyverse, here
# STRATIFICATION: Built in Tidyverse Datasets
# ==============================================================================
library(tidyverse)
library(here)


# Chapter 9.6 examples ----------------------------------------------------
# Color vs Fill bar chart
ggplot(mpg, aes(x = drv, color = drv)) +
  geom_bar()

# Color vs Fill bar chart (2)
ggplot(mpg, aes(x = drv, fill = drv)) +
  geom_bar()

# Two variable bar chart
ggplot(mpg, aes(x = drv, fill = class)) +
  geom_bar()

# Position identity with alpha argument
ggplot(mpg, aes(x = drv, fill = class)) +
  geom_bar(alpha = 1/5, position = "identity")

# Position identity with fill = NA
ggplot(mpg, aes(x = drv, color = class)) +
  geom_bar(fill = NA, position = "identity")

# Position fill graph
ggplot(mpg, aes(x = drv, fill = class)) +
  geom_bar(position = "fill")

#Position dodge graph
ggplot(mpg, aes(x = drv, fill = class)) +
  geom_bar(position = "dodge")

#Position jitter graph
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(position = "jitter")

#Position dodge experiment
ggplot(mpg, aes(x = hwy, y = displ)) +
  geom_boxplot(position = "dodge", aes(group = class)) +
  coord_flip()


# Chapter 9.6 Exercises ---------------------------------------------------
# Fixing graph 
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point(position = "jitter")

# Difference between code
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

# Difference between code (2)
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(position = "identity")

# Geom_jitter vs Geom_count
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_count()

# Geom_jitter vs Geom_count
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_jitter()

# geom_boxplot() exercise/experiment
ggplot(mpg, aes(x = displ, y = hwy, group = class)) +
  geom_boxplot()



# Chapter 9.7 examples ----------------------------------------------------

#Saving map data
nz <- map_data("nz")
# Map without correct aspect ratio
map_data("nz") |>
ggplot(aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

# Map with correct asepct ratio
 map_data("nz") |> 
  ggplot(aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black" ) +
  coord_quickmap()

 # Polar graph
bar <- ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = clarity, fill = clarity), 
    show.legend = FALSE, 
    width = 1
  ) +
  theme(aspect.ratio = 1)
# Flipped graph
bar + coord_flip()
# Polar graph
bar + coord_polar()


# 9.7 Chapter Exercises ---------------------------------------------------
# Pie chart
ggplot(diamonds, aes(x = " ", fill = clarity)) +
  geom_bar(stat = "count", show.legend = FALSE) +
  coord_polar(theta = "y") +
  theme_void() +
  scale_fill_brewer(palette = "Set1")

# Coord_quickmap vs coord_map
ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(color = "black", fill = "white") +
  coord_map()

ggplot(nz, aes(x = long, y = lat, group = group)) + 
  geom_polygon(color = 'black', fill = "white") +
  coord_quickmap()

# coord_fixed and geom_abline
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()

# Grammar of Graphics
ggplot(data = <DATA>) +
  <GEOM_FUNCTION>(
    mapping = aes(<MAPPINGS>),
    stat = <STAT>,
    position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
  
