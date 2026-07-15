
# 7/2/2026: Chapter 2- Workflow Basics ------------------------------------


# This code creates a stored vector to the name
Name <- c(1,2,3,4,5)

# <- This code creates a sequence from the first argument to the second one
seq(from = 1, to = 10)
seq(1,10)


# #7/3/2026: Here Experiments ---------------------------------------------

# This code determines the location of a file under a directory
here("sub-directory",...,"file.type")


# 7/5/2026 ggplot2 --------------------------------------------------------

#this function links data to a plot and labels the x and y axes
ggplot(
  data = data_name, mapping = aes(x = x_value, y = y_value)
)

# these functions plot data on a graph 
  geom_line()/ geom_bar()/ geom_plot()

# this function plots a linear model line of best fit
  geom_smooth(method = "lm")

# Used to edit the Labels of a graph
  labs(
  title= "Title",
  subtitle = "Subtitle",
  x = "X_axis_name",
  y = "Y_axis_name" )

# Used to make colors colorblind friendly (ggthemes function)
 scale_color_colorblind()

#allows for graphs from new files to be loaded
while (!is.null(dev.list())) dev.off()

# Displays different aspects of data
View(data)

# Gives a brief view of variables of a data set (in Console)
glimpse(data)

# This makes a new graph with no missing data for bill lengths and three columns
# for island, species and the newly created column average bill length
bill_length_data <- penguins |>
  drop_na(bill_length_mm) |>
  group_by(island, species) |>
  summarise(
    average_bill_length = mean(bill_length_mm)
  )

# This separates the bar graph with multiple colors by the color variable
geom_col(
  aes(fill = species), 
  position = "dodge"
)

# Phase 1 Test Script
library(here)

# Print the top-level anchor path of your project
here()

# Create a test placeholder data file inside your data folder
write.csv(cars, here("data", "test_cars_data.csv"), row.names = FALSE)


# 7/6/2026 Chapter 1.3 to 1.4 -----------------------------------------------

# Histogram that has an altered binwidth
ggplot(penguins, aes(x = body_mass_g)) + 
  geom_histogram(binwidth = 200)

# Bins argument for geom_histogram that changes bin count
ggplot(penguins, aes(x = bill_length_mm)) +
  geom_histogram(bins = 20)

# Fall Concept: Rounding to the nearest 15 minutes (0.25 hours)
binned_data <- Theoph |>
  mutate(time_bin = round(Time * 4) / 4) # Multiplies, rounds, and divides to create 0.25-hour bins


# 7/7/2026 Chapter 1.5 to 1.8 ---------------------------------------------

# Bar Graph by proportion
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

# Optimized Four variable scatter plot
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)

# Saving a graph
ggplot(penguins, aes(x = flipper_length_mm, y =  body_mass_g)) +
  geom_point() +
  ggsave(filename = "penguin-plot.png")


# 7/8/2026 Chapter 7.1 to 7.2 ---------------------------------------------

# Pie Chart
ggplot(students, aes(x = " ", fill = meal_plan)) +
  geom_bar(width = 1, stat = "count") +
  coord_polar(theta = "y") +
  theme_void() +
  scale_fill_brewer(palette = "Set1")


# 7/9/2026 Chapter 7.3 to 7.7 ---------------------------------------------

# combining different files into one data frame
total_sales <- read_csv(
  c(
    here("data", "01_sales.csv"),
    here("data", "02_sales.csv"),
    here("data", "03_sales.csv")
  ), 
  id = "file"
)

# Reading all files in data folder ending with sales
read_csv(
  list.files(
    here("data"), 
    pattern = "sales\\.csv", 
    full.names = TRUE)
)

# Removing columns experiment
students_2 <- students |>
  select(-full_name, -student_id)

# Ordering a data frame by levels
cleaned_message_data <- read_message_data |>
  drop_na(RECORD_DATE) |>
  mutate(
    ADVERSE_EVENT = factor(
      ADVERSE_EVENT,
      levels = c("None", "Mild", "Severe")
    )
  ) |>
  arrange(ADVERSE_EVENT)

# 7/10/2026 Chapter 9.4 to 9.5 ------------------------------------------------

# Facet grid
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(drv ~ cyl)
  # facet_grid(row ~ col)

# Proportional bar graph (naming experiment)
ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) +
  geom_bar() +
  scale_y_continuous(
    labels = scales::percent, 
    breaks = seq(0, 1, by = .2)
  )

# New value experiment
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

# stat_summary graph
ggplot(diamonds) +
  stat_summary(
    aes(x = cut, y = depth), 
    fun.min = min,
    fun.max = max,
    fun = median
  )

# Stat_summary geom form
ggplot(diamonds, aes(x = cut, y = depth)) +
  geom_pointrange(aes(
    ymin = depth - se.depth,
    ymax = depth + se.depth
  ))

# Flushes active security token cache
gitcreds::gitcreds_cache_clean()


# 7/13/2026 Sandbox -------------------------------------------------------

# Gives levels of a factor variable
levels(data_frame$variable_name)


# 7/14/2026 Chapters 3.1 to 3.3.1 /Sandbox --------------------------------

# Orders a graph by descending order
flights |>
  arrange(desc(dep_delay))

# distinct function (2)
flights |>
  distinct(origin, dest, .keep_all = TRUE)

#distinct function (3)
flights |>
  count(origin, dest, sort = TRUE)

# Ordering a bar graph with preset values by frequency
ggplot(many_penguins_beaks, aes(x = fct_reorder(genus, beak_ratio), y = beak_ratio)) +
  geom_col(aes(fill = sex), position = "dodge")
