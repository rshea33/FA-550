library(ggplot2)

# generate a discrete uniform random variable
# with 1000 observations
x <- runif(1000, min = 0, max = 10)
x <- round(x)
y <- runif(1000, min = 0, max = 10)
y <- round(y)

# create a grouped bar chart with x and y side by side
ggplot(data.frame(x, y), aes(x, fill = factor(y))) +
  geom_bar(position = 'dodge') +
  labs(x = "x", y = "Count", fill = "y") +
  theme_bw()
