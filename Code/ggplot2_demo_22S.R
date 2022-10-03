library(tidytuesdayR)
# Obtain data
ultra_running <- tidytuesdayR::tt_load(x = 2021, week = 44)

## 
##     Downloading file 1 of 2: `ultra_rankings.csv`
##     Downloading file 2 of 2: `race.csv`

# It's a list object, with two elements: "ultra_rankings" and "race"
names(ultra_running)

## [1] "ultra_rankings" "race"

# Pull those two elements out into separate objects
ultra_rankings <- ultra_running[["ultra_rankings"]]
race <- ultra_running[["race"]]

# We'll use the dplyr package for some basic wrangling.
library(dplyr)
# Using the ultra_rankings dataframe
runners_per_nation <- ultra_rankings %>%
  # Only care about the runner and nationality columns
  select(runner, nationality) %>%
  # Obtain distinct combinations
  distinct() %>%
  # Count the number of runners from each country
  group_by(nationality) %>%
  tally(name = "number") %>%
  arrange(desc(number)) %>%
  ungroup()

head(runners_per_nation, n = 15)

library(ggplot2)
ggplot(
  data = runners_per_nation,
  # geom_bar() requires both 
  # and y mapped
  mapping = aes(x = nationality, 
                y = number)) +
  # Raw counts
  geom_bar(stat = "identity")

# Global v. geom-specific mapping
ggplot(
  data = runners_per_nation) +
  geom_bar(
    mapping = aes(
      x = nationality,
      y = number),
    stat = "identity")

ggplot(
  data = runners_per_nation) +
  geom_col(
    mapping = aes(
      x = nationality,
      y = number))
# Shortcut

# A look at the top 10
top10 <- runners_per_nation %>%
  slice_max(number, n = 10)
# Aside: how many runners is this of the total?
runners_per_nation %>%
  mutate(prop = round(prop.table(number), digits = 2)) %>%
  slice_max(number, n = 10) %>%
  summarise(prop_top_10 = sum(prop))
# 78% of runners are from the top 10 countries

ggplot(data = top10) +
  geom_col( 
    mapping = aes(
      x = nationality,
      y = number))
# More informative!

# Sort in descending order
library(forcats)
top10 <- top10 %>%
  mutate(
    nationality = fct_reorder(
      nationality,
      number,
      .desc = TRUE
    )
  )
ggplot(data = top10) +
  geom_col(
    mapping = aes(
      x = nationality,
      y = number))

# Using color
ggplot(data = top10) +
  geom_col( 
    mapping = aes(
      x = nationality,
      y = number,
      # Within aes()
      # Simple expression
      colour = number > 10000))

ggplot(data = top10) +
  geom_col( 
    mapping = aes(
      x = nationality,
      y = number,
      # We actually wanted fill 
      # in this case
      fill = number > 10000))

ggplot(data = top10) +
  geom_col( 
    mapping = aes(
      x = nationality,
      y = number,
      # We actually wanted fill 
      # in this case
      fill = number > 10000))

ggplot(data = top10) +
  geom_col( 
    mapping = aes(
      x = nationality,
      y = number,
      fill = number))
scale_fill_gradient(
  low = "#c6dbef",
  high = "#08306b"
)

ggplot(data = top10) +
  geom_col( 
    mapping = aes(
      x = nationality,
      y = number,
      fill = number)) +
  # More exotic
  scale_fill_viridis_c(
    direction = -1
  )

ggplot(data = top10) +
  geom_col( 
    mapping = aes(
      x = nationality,
      y = number,
      # No longer continuous
      fill = nationality)) +
theme(legend.position = "none")

library(RColorBrewer)
ggplot(
  filter(top10, 
         number < 10000)) +
  geom_col( 
    mapping = aes(
      x = nationality,
      y = number,
      fill = nationality)) +
  scale_fill_brewer(
    palette = "Dark2") +
  theme(legend.position = "none")

# When a legend is not necessary
ggplot(data = top10) +
  geom_col( 
    mapping = aes(
      x = nationality,
      y = number),
    fill = "steelblue")
# No legend in this case.
# Nothing to communicate
# about the fill.

library(countrycode)
top10 <- top10 %>%
  mutate(full_nm = countrycode(nationality,
                               origin = "iso3c",
                               destination = "country.name"),
         full_nm = fct_reorder(full_nm,
                               number,
                               .desc = FALSE))
head(top10)

plot1 <- ggplot(data = top10) +
  geom_col( 
    mapping = aes(
      x = full_nm,
      y = number))
plot1

plot1 +
  coord_flip()

plot1 +
  coord_flip() +
  labs(
    title = "Top 10 countries with most ultra runners",
    subtitle = "In races held between 2012-2021.") +
  scale_y_continuous(
    labels = scales::comma) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank())

library(stringr)
# Maybe we want to highlight certain countries.
top10 <- top10 %>%
  mutate(group = case_when(
    str_detect(nationality, "FRA|GBR|ESP|ITA|POL") ~ "Europe",
    nationality == "CAN" ~ "Canada",
    TRUE ~ "Other"
  ))
# New base plot ...
plot2 <- ggplot(top10) +
  geom_col(aes(x = full_nm, y = number, fill = group)) +
  coord_flip() +
  labs(title = "Top 10 countries with most ultra runners",
       subtitle = "In races held between 2012-2021.") + 
  scale_y_continuous(labels = scales::comma)

# Using guding fill color
plot2 + 
  scale_fill_manual(
    values = c(
      "Europe" = "steelblue",
      "Canada" = "#FF0000",
      "Other" = "grey60"),
    name = NULL) +
  theme(
    legend.position = "bottom",
    axis.title = element_blank()
  )

# Let's write some cool text.
library(ggtext)
# About what?
top10 %>%
  group_by(group) %>%
  summarise(total_runners = sum(number)) %>%
  mutate(prop = prop.table(total_runners))

## # A tibble: 3 x 3
##   group  total_runners   prop
##   <chr>          <int>  <dbl>
## 1 Canada          1427 0.0240
## 2 Europe         29654 0.498 
## 3 Other          28409 0.478

cool_text <- '<span style="color:#4682b4;">**European**</span> countries<br>account for 49.8% of all runners<br>among the top 10 countries.<br><br>There have been<br>1,427 ultra runners from <span style="color:#FF0000;">**Canada**</span>.'

# Improvement on use of legend
plot2 + 
  annotate(
    geom = "richtext",
    x = 6, y = 14500,
    label = cool_text,
    label.colour = NA, fill = NA,
    fontface = "bold",
    color = "grey20",
    size = 3.5
  ) +
  scale_fill_manual(
    values = c( 
      "Europe" = "steelblue",
      "Canada" = "#FF0000",
      "Other" = "grey60"),
    name = NULL) +
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.title = element_blank())

# Going to re-do the whole plot ... getting complicated!!
plot1 <- ggplot(top10) +
  geom_col(aes(x = full_nm, y = number, fill = group)) +
  geom_text(aes(y = number + 1000, x = full_nm, colour = group,
                label = scales::comma(number)), size = 3) +
  annotate(geom = "richtext", x = 6, y = 14500, label = cool_text, label.colour = NA, 
           fill = NA, fontface = "bold", color = "grey20", size = 3.5) +
  labs(title = "Top 10 countries with most ultra runners",
       subtitle = "In races held between 2012-2021.") + 
  scale_y_continuous(expand = c(0, 150)) +
  scale_fill_manual(values = c("Europe" = "steelblue", "Canada" = "#FF0000",
                               "Other" = "grey50"), name = NULL) +
  scale_color_manual(values = c("Europe" = "steelblue", "Canada" = "#FF0000",
                                "Other" = "grey50"), name = NULL) +
  coord_flip() +
  theme_classic() +
  theme(axis.title = element_blank(),
        axis.text.x = element_blank(), axis.text.y = element_text(face = "bold"),
        legend.position = "none",
        panel.grid = element_blank(),
        axis.ticks = element_blank(), axis.line = element_blank())

plot1

# Let's change the fonts and add a caption
# sysfonts::font_add_google("gochi")
# sysfonts::font_add_google("bell")
library(showtext)
## Loading Google fonts (https://fonts.google.com/)
font_add_google("Gochi Hand", "gochi")
font_add_google("Schoolbell", "bell")

## Automatically use showtext to render text
showtext_auto()

plot1 +
  labs(
    caption = "Data from #TidyTuesday project. Plot by M.Becker.") +
  theme(
    text = element_text(
      family = "bell"))

library(ggdark)
last_plot1 <- ggplot(top10) +
  geom_col(aes(x = full_nm, y = number, fill = group)) +
  geom_text(aes(y = number + 1000, x = full_nm, label = scales::comma(number)), 
            size = 3, family = "gochi", color = "white") +
  annotate(geom = "richtext", x = 6, y = 14500, label = cool_text, label.colour = NA, 
           fill = NA, fontface = "bold", color = "white", size = 3.5,
           family = "gochi")

last_plot2 <- last_plot1 +
  labs(title = "Top 10 countries with most ultra runners",
       subtitle = "In races held between 2012-2021.",
       caption = "Data from #TidyTuesday project. Plot by M.Becker.") +
  scale_y_continuous(expand = c(0, 150)) +
  scale_fill_manual(values = c("Europe" = "steelblue", "Canada" = "#FF0000",
                               "Other" = "grey50"), name = NULL) +
  scale_color_manual(values = c("Europe" = "steelblue", "Canada" = "#FF0000",
                                "Other" = "grey50"), name = NULL) +
  coord_flip() +
  dark_theme_classic() +
  theme(axis.title = element_blank(),
        axis.text.x = element_blank(), axis.text.y = element_text(face = "bold"),
        legend.position = "none",
        panel.grid = element_blank(),
        axis.ticks = element_blank(), axis.line = element_blank(),
        text = element_text(family = "gochi", color = "white"))

last_plot2
