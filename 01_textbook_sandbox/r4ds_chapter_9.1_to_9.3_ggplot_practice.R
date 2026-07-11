library(tidyverse)

#Chapter 9.2 Examples------------------------------------------------------
#Relationship between displ and hwy between classes
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()

#Relationship between displ and hwy between classes(2)
ggplot(mpg, aes(x = displ, y = hwy, shape = class)) +
  geom_point()

#Relationship between displ and hwy between classes(3)
ggplot(mpg, aes(x = displ, y = hwy, size = class)) +
  geom_point()

#Relationship between displ and hwy between classes(4)
ggplot(mpg, aes(x = displ, y = hwy, alpha = class)) +
  geom_point()

#Relationship between displ and hwy
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue")


# Chapter 9.2 Exercise ----------------------------------------------------
#Pink triangles
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(shape = 24, fill = "pink")

#Make plot blue
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy), color = "blue")

#Stroke aesthetic
ggplot(mpg, aes(x = displ, y = hwy)) + 
geom_point(shape = 21, fill = "pink", stroke = 1)
  
#Alternative Aesthetic mapping
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = displ < 5), show.legend = FALSE)

# Chapter 9.3 Examples ----------------------------------------------------
#Left graph
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

#Right graph
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth()

#Ignoring Argument 1
ggplot(mpg, aes(x = displ, y = hwy, shape = drv)) +
  geom_smooth()

#Ignoring Argument 2
ggplot(mpg, aes(x = displ, y = hwy, linetype = drv)) +
  geom_smooth()

#Clarifying graph
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(aes(linetype = drv))

#Group example 1
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth()

#Group example 2
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(group = drv))

#Group example 3
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(color = drv), show.legend = FALSE)

#Local Mappings
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth()

#Local Mappings 2
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_point(
    data = mpg |> filter(class == "2seater"), color = "red"
  ) +
  geom_point(
    data = mpg |> filter(class == "2seater"), 
    shape = "circle open",
    color = "red",
    size = 3
  )

#Unique data 1
ggplot(mpg, aes(hwy)) +
  geom_histogram(binwidth = 2)

#Unique data 2
ggplot(mpg, aes(hwy)) +
  geom_density()

#Unique data 3
ggplot(mpg, aes(hwy)) +
  geom_boxplot()


# Chapter 9.3 Exercise  ---------------------------------------------------
#Recreation 1
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)
 
#Recreation 2
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(aes(group = drv), se = FALSE)

#Recreation 3
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

#Recreation 4
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(se = FALSE)

#Recreation 5
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)

#Recreation 6
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_point(color = "white", shape = "circle open", size = 3)

