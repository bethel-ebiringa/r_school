library(tidyverse)


# Chapter 9.4 examples ----------------------------------------------------

#Facet Wrap Review
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() +
  facet_wrap(~cyl)

#Facet grid
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(drv ~ cyl)

#Free argument for facet grid
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(drv ~ cyl, scale = "free_y")

#Chapter 9.4 exercises ----------------------------------------------------
#Continuous Faceting
ggplot(mpg, aes(x = hwy, y = cty)) +
  geom_point() +
  facet_wrap(~displ)

#facet grid by row
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

#Grid by column  
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

#Facet advantages
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~ cyl, nrow = 4)

#Facet row vs column (1)
ggplot(mpg, aes(x = displ)) +
  geom_histogram() +
  facet_grid(drv ~ .)

#Facet row vs column (1)
ggplot(mpg, aes(x = displ)) +
  geom_histogram() +
  facet_grid(. ~ drv)

#Facet grid recreation (1)
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

#Facet grid recreation (2)
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~drv, ncol = 1)

#Chapter 9.5 examples
#geom_bar
ggplot(diamonds, aes(x = cut)) +
  geom_bar()

#geom_bar (two variables)
diamonds |>
  count(cut) |>
  ggplot(aes(x = cut, y = n)) +
  geom_bar(stat = "identity")

#Proportional bar graph (naming experiment)
ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) +
  geom_bar() +
  scale_y_continuous(
    labels = scales::percent, 
    breaks = seq(0, 1, by = .2)
  )

#New value experiment
diamonds_new <- diamonds |>
  mutate(price_tier = case_when(
    price < 1000 ~ "Budget",
    price <= 5000 ~ "Mid-Range",
    price > 5000 ~ "Premium"
  )) |>
  mutate(price_tier = factor(
    price_tier, 
    levels = c("Budget", "Mid-Range", "Premium")
  )) |>
  arrange(price_tier)

#stat_summary graph
ggplot(diamonds) +
  stat_summary(
    aes(x = cut, y = depth), 
    fun.min = min,
    fun.max = max,
    fun = median
  )


# Chapter 9.5 exercises ---------------------------------------------------

#Stat_summary geom form
ggplot(diamonds, aes(x = cut, y = depth)) +
  geom_pointrange(aes(
    ymin = depth - se.depth,
    ymax = depth + se.depth
  ))

#Groupless Graphs
ggplot(diamonds, aes(x = cut, y = after_stat(prop))) +
  geom_bar()

#Groupless Graphs (2)
ggplot(diamonds, aes(x = cut, fill = color, y = after_stat(prop))) +
  geom_bar()

#Groupless graphs fix 1
ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) +
  geom_bar()

#groupless graphs fix 2
ggplot(diamonds, aes(
  x = cut, 
  fill = color,
  y = after_stat(count/sum(count)),
)) +
  geom_bar()

