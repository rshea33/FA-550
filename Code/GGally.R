# Introduction to GGally
# Source = https://www.ucsbtidytuesday.com/post/2020-07-07-ggally-demo/

library(tidyverse)
library(palmerpenguins)
library(skimr)
library(GGally)

# Bring it up in a new tab
# View(penguins)

# Summarize it 
summary(penguins)

# Glimpse it
tibble::glimpse(penguins)

# Skim it 
skimr::skim(penguins)

# GGally extends ggplot2 by adding several functions to reduce the complexity of 
# combining geoms with transformed data. Some of these functions include a pairwise 
# plot matrix, a scatterplot plot matrix, a parallel coordinates plot, a survival plot, 
# and several functions to plot networks.”

# Create pairwise comparison
# This is cool, but a bit of a mess
ggpairs(penguins)

penguins %>% 
  select(species, bill_length_mm:body_mass_g) %>% 
  ggpairs(aes(color = species))

# Plot outcome for explanatory variables
penguins %>% 
  ggbivariate(outcome = "body_mass_g", 
              explanatory = c("species","sex", "island","flipper_length_mm"))

# With custom formatting
penguins %>% 
  ggbivariate(outcome = "species", 
              explanatory = c("flipper_length_mm", "island", "sex"),
              rowbar_args = list(
                colour = "purple",
                size = 4,
                fontface = "bold",
                label_format = scales::label_percent(accurary = 1)
              )) +
  scale_fill_brewer(palette = 10) +
  theme_minimal()

# Model diagnostics

# Make a model: 
penguin_lm <- lm(body_mass_g ~ flipper_length_mm + bill_length_mm + bill_depth_mm, data = penguins)

# Look at the diagnostics! 
ggnostic(penguin_lm)

# Formatted counts tables

# Counts, for each species, tallied by island & sex
penguins %>% 
  ggtable("species", c("island","sex"))
