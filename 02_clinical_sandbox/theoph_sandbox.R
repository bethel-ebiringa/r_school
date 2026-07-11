library(tidyverse)


#Plotted the Theoph data to observe how the trends of drug clearance 
ggplot(Theoph, aes(x = Time, y =  conc)) +
  #
  geom_point(aes(color = Wt)) +
  geom_smooth(se = FALSE, color = "red") +
  geom_line(aes(group = Subject, alpha = 0.0001)) +
  labs(
    title = "Drug Concentration in Blood Over Time",
    subtitle = "(Twelve Trials)",
    x = "Time (hours)",
    y = "Drug Concentration (mg/L)",
  )
 
# Make curve of the average concentration over time (1)
average_concentration_data <- Theoph |>
  mutate(time_bin = round(Time * 3) / 3) |>
  group_by(time_bin) |>
  drop_na(conc) |>
  summarize(average_concentration = mean(conc))
  
# Make curve of the average concentration over time (2)
ggplot(average_concentration_data, aes(x = time_bin, y = average_concentration)) +
  geom_point() +
  geom_line()

#Time bin method made a choppy graph so a new method of grouping data was used
average_theoph <- Theoph |> 
  drop_na(conc) |>
  group_by(Subject) |>
  mutate(sample_index = row_number()) |> 
  group_by(sample_index) |>
  summarize(
    time = mean(Time), 
    average_concentration = mean(conc),
    medication = "Theophylline"
  ) |>
  select(time, average_concentration, medication)

#New method of grouping was tested by plotting
ggplot(average_theoph, aes(x = time, y = average_concentration)) + 
  geom_line() +
  geom_point() +
  labs( 
    title = "Average Theophylline Concentration in Blood Over Time",
    subtitle = "(Twelve Trials)",
    x = "Time (hours)",
    y = "Drug Concentration (mg/L)"
  )
  
  
  

