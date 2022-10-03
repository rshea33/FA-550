# Introduction to ggiraph
# Source = https://davidgohel.github.io/ggiraph/articles/offcran/using_ggiraph.html

# Used for producing interactive graphics in ggplot2
# Key features:
# Animate points, polygons, and lines
# Display tooltips on mouseover
# Select elements when the graphic is shown in a Shiny application

# Load the mpg dataset
library(ggplot2)
library(ggiraph)
g <- ggplot(mpg, aes( x = displ, y = cty, color = hwy) )

# Adding a tooltip
my_gg <- g + geom_point_interactive(aes(tooltip = model), size = 2)
girafe(code = print(my_gg) )

# Hover effects
my_gg <- g + geom_point_interactive(
  aes(tooltip = model, data_id = model), size = 2)
x <- girafe(code = print(my_gg))
x

# Load crimes data
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
head(crimes)


# create an 'onclick' column
crimes$onclick <- sprintf("window.open(\"%s%s\")",
                          "http://en.wikipedia.org/wiki/", as.character(crimes$state) )

gg_crime <- ggplot(crimes, aes(x = Murder, y = Assault, color = UrbanPop )) +
  geom_point_interactive(
    aes( data_id = state, tooltip = state, onclick = onclick ), size = 3 ) +
  scale_colour_gradient(low = "#999999", high = "#FF3333")

girafe(ggobj = gg_crime)

