# Content from https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/#read-more
library(ggplot2)
library(gganimate)
theme_set(theme_bw())

library(gapminder)
head(gapminder)

# Static plot
p <- ggplot(
  gapminder, 
  aes(x = gdpPercap, y=lifeExp, size = pop, colour = country)
) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy")
p

# transition_time and frame_time
p + transition_time(year) +
  labs(title = "Year: {frame_time}")

# transition_time, frame time, and facets
p + facet_wrap(~continent) +
  transition_time(year) +
  labs(title = "Year: {frame_time}")

# View and rescale for each year
p + transition_time(year) +
  labs(title = "Year: {frame_time}") +
  view_follow(fixed_y = TRUE)

# Show preceding frames using wake
p + transition_time(year) +
  labs(title = "Year: {frame_time}") +
  shadow_wake(wake_length = 0.1, alpha = FALSE)

# Original data as background marks
p + transition_time(year) +
  labs(title = "Year: {frame_time}") +
  shadow_mark(alpha = 0.3, size = 0.5)


# Demo 2: Reveal data along a given dimension
p <- ggplot(
  airquality,
  aes(Day, Temp, group = Month, color = factor(Month))
) +
  geom_line() +
  scale_color_viridis_d() +
  labs(x = "Day of Month", y = "Temperature") +
  theme(legend.position = "top")
p

# Reveal data over time
p + transition_reveal(Day)

# Show points on reveal line
p + 
  geom_point() +
  transition_reveal(Day)

# Keeping points visible using group
p + 
  geom_point(aes(group = seq_along(Day))) +
  transition_reveal(Day)

# Demo 3: Data Transition
library(dplyr)
mean.temp <- airquality %>%
  group_by(Month) %>%
  summarise(Temp = mean(Temp))
mean.temp

# Create a bar chart
p <- ggplot(mean.temp, aes(Month, Temp, fill = Temp)) +
  geom_col() +
  scale_fill_distiller(palette = "Reds", direction = 1) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    panel.grid.major.y = element_line(color = "white"),
    panel.ontop = TRUE
  )
p

# Transition states
p + transition_states(Month, wrap = FALSE) +
  shadow_mark()

# Grow and fade
p + transition_states(Month, wrap = FALSE) +
  shadow_mark() +
  enter_grow() +
  enter_fade()

# Using anim_save to save last rendered frame
anim_save("temp_data_example.gif")
