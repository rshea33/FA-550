# source = https://rstudio-pubs-static.s3.amazonaws.com/254718_86eb2e4e892947869b3d56affc0dfa69.html#
# load ggplot2 library

library(ggplot2)

# view mpg data set
View(mpg)

# mpg = dataset; aesthetic mappings engine disp = x-axis, mileage = y-axis
# data represented as points using geom_point
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

# generates same output as above, note differences
ggplot(mpg, aes(displ, hwy)) + 
  geom_point()

# Demo 1: Relationship between city/highway mileage
ggplot(mpg, aes(cty, hwy)) + 
  geom_point()

# Assign colour to vehicle class
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()

# Assign shape to drivetrain type
ggplot(mpg, aes(displ, hwy, shape = drv)) + 
  geom_point()

# Assign point size to cyl
ggplot(mpg, aes(displ, hwy, size = cyl)) + 
  geom_point()

# Setting color outside of aesthetic expression
ggplot(mpg, aes(displ, hwy)) + geom_point(colour = "blue")

# Creating a boxplot to summarize a distribution
ggplot(mpg, aes(drv, hwy)) + 
  geom_boxplot()

# Histograms and Freq plot, illustrating distribution of one var
ggplot(mpg, aes(hwy)) + 
  geom_histogram()
ggplot(mpg, aes(hwy)) + 
  geom_freqpoly()

# bar chart illustrating discrete vars
ggplot(mpg, aes(manufacturer)) + 
  geom_bar()

# time line illustrating unemployment data over years
ggplot(economics, aes(date, unemploy / pop)) +
  geom_line()

# relabel y-axis
ggplot(economics, aes(date, unemploy / pop)) +
  geom_line() + 
  ylab("unemployment rate")

# Demo Set 2: Review of graph types
# Source: https://www.datanovia.com/en/blog/ggplot-examples-best-reference/

library(tidyverse)
library(ggpubr) 
theme_set(
  theme_dark() + 
    theme(legend.position = "top")
)

?theme
# Basic scatterplot with correlation conefficient using stat_cor

library("ggpubr")
p <- ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  geom_smooth(method = lm) +
  stat_cor(method = "pearson", label.x = 20)
p

# Contextual zoom using facet_zoom

library(ggforce)
ggplot(iris, aes(Petal.Length, Petal.Width, colour = Species)) +
  geom_point() +
  facet_zoom(x = Species == "versicolor")

# Encircling points for emphasis

library("ggalt")
circle.df <- iris %>% filter(Species == "setosa")
ggplot(iris, aes(Petal.Length, Petal.Width)) +
  geom_point(aes(colour = Species)) + 
  geom_encircle(data = circle.df, linetype = 2)

# Using jitter for busy plots by randomly jittering around orig position

# Basic scatter plot
ggplot(mpg, aes(cty, hwy)) +
  geom_point(size = 0.5)

# Jittered points
ggplot(mpg, aes(cty, hwy)) +
  geom_jitter(size = 0.5, width = 0.5)

# Creating count charts for larger numbers of points

ggplot(mpg, aes(cty, hwy)) +
  geom_count()

# Creating bubble charts; point size controlled by continuous var qsec

ggplot(mtcars, aes(mpg, wt)) +
  geom_point(aes(size = qsec), alpha = 0.5) +
  scale_size(range = c(0.5, 12))  # Adjust the range of points size

# Marginal density plots

library(ggpubr)
# Grouped Scatter plot with marginal density plots
ggscatterhist(
  iris, x = "Sepal.Length", y = "Sepal.Width",
  color = "Species", size = 3, alpha = 0.6,
  palette = c("#00AFBB", "#E7B800", "#FC4E07"),
  margin.params = list(fill = "Species", color = "black", size = 0.2)
)

# Use box plot as marginal plots
ggscatterhist(
  iris, x = "Sepal.Length", y = "Sepal.Width",
  color = "Species", size = 3, alpha = 0.6,
  palette = c("#00AFBB", "#E7B800", "#FC4E07"),
  margin.plot = "boxplot",
  ggtheme = theme_bw()
)

# Density plot

# Basic density plot
ggplot(iris, aes(Sepal.Length)) +
  geom_density()

# Add mean line
ggplot(iris, aes(Sepal.Length)) +
  geom_density(fill = "lightgray") +
  geom_vline(aes(xintercept = mean(Sepal.Length)), linetype = 2)

# Change line color by groups
ggplot(iris, aes(Sepal.Length, color = Species)) +
  geom_density() +
  scale_color_viridis_d()
# See https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html

# Add mean line by groups
mu <- iris %>%
  group_by(Species) %>%
  summarise(grp.mean = mean(Sepal.Length))

ggplot(iris, aes(Sepal.Length, color = Species)) +
  geom_density() +
  geom_vline(aes(xintercept = grp.mean, color = Species),
             data = mu, linetype = 2) +
  scale_color_viridis_d()

# Histograms

# Basic histogram with mean line
ggplot(iris, aes(Sepal.Length)) +
  geom_histogram(bins = 20, fill = "white", color = "black")  +
  geom_vline(aes(xintercept = mean(Sepal.Length)), linetype = 2)

# Add density curves
ggplot(iris, aes(Sepal.Length, stat(density))) +
  geom_histogram(bins = 20, fill = "white", color = "black")  +
  geom_density() +
  geom_vline(aes(xintercept = mean(Sepal.Length)), linetype = 2)

# Change color by group

ggplot(iris, aes(Sepal.Length)) +
  geom_histogram(aes(fill = Species, color = Species), bins = 20, 
                 position = "identity", alpha = 0.5) +
  scale_fill_viridis_d() +
  scale_color_viridis_d()

# QQPlot

library(ggpubr)
ggqqplot(iris, x = "Sepal.Length",
         ggtheme = theme_bw())

# Empirical cumulative distribution

ggplot(iris, aes(Sepal.Length)) +
  stat_ecdf(aes(color = Species)) +
  scale_color_viridis_d()

# Density ridgeline plots

library(ggridges)
ggplot(iris, aes(x = Sepal.Length, y = Species)) +
  geom_density_ridges(aes(fill = Species)) +
  scale_fill_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))

# Bar charts and alternatives

# Manipulating data frames
df <- mtcars %>%
  rownames_to_column() %>%
  as_tibble() %>%
  mutate(cyl = as.factor(cyl)) %>%
  select(rowname, wt, mpg, cyl)
df

# Basic bar plots
ggplot(df, aes(x = rowname, y = mpg)) +
  geom_col() +
  rotate_x_text(angle = 45)

# Reorder row names by mpg values
ggplot(df, aes(x = reorder(rowname, mpg), y = mpg)) +
  geom_col()  +
  rotate_x_text(angle = 45)

# Horizontal bar plots, 
# change fill color by groups and add text labels
ggplot(df, aes(x = reorder(rowname, mpg), y = mpg)) +
  geom_col( aes(fill = cyl)) + 
  geom_text(aes(label = mpg), nudge_y = 2) + 
  coord_flip() +
  scale_fill_viridis_d()

# Order bars by groups and by mpg values

df2 <- df %>% 
  arrange(cyl, mpg) %>%
  mutate(rowname = factor(rowname, levels = rowname))

ggplot(df2, aes(x = rowname, y = mpg)) +
  geom_col( aes(fill = cyl)) + 
  scale_fill_viridis_d() +
  rotate_x_text(45)

# Lolllipop Charts

ggplot(df2, aes(x = rowname, y = mpg)) +
  geom_segment(
    aes(x = rowname, xend = rowname, y = 0, yend = mpg), 
    color = "lightgray"
  ) + 
  geom_point(aes(color = cyl), size = 3) +
  scale_color_viridis_d() +
  theme_pubclean() +
  rotate_x_text(45)

# Bar Plot with multiple groups

# Data
df3 <- data.frame(supp=rep(c("VC", "OJ"), each=3),
                  dose=rep(c("D0.5", "D1", "D2"),2),
                  len=c(6.8, 15, 33, 4.2, 10, 29.5))


# Stacked bar plots of y = counts by x = cut,
# colored by the variable color
ggplot(df3, aes(x = dose, y = len)) +
  geom_col(aes(color = supp, fill = supp), position = position_stack()) +
  scale_color_manual(values = c("#0073C2FF", "#EFC000FF"))+
  scale_fill_manual(values = c("#0073C2FF", "#EFC000FF"))

# Use position = position_dodge() 
ggplot(df3, aes(x = dose, y = len)) +
  geom_col(aes(color = supp, fill = supp), position = position_dodge(0.8), width = 0.7) +
  scale_color_manual(values = c("#0073C2FF", "#EFC000FF"))+
  scale_fill_manual(values = c("#0073C2FF", "#EFC000FF"))

# Line Plots

# Data
df3 <- data.frame(supp=rep(c("VC", "OJ"), each=3),
                  dose=rep(c("D0.5", "D1", "D2"),2),
                  len=c(6.8, 15, 33, 4.2, 10, 29.5))

# Line plot
ggplot(df3, aes(x = dose, y = len, group = supp)) +
  geom_line(aes(linetype = supp)) +
  geom_point(aes(shape = supp))

# Raw data
df <- ToothGrowth %>% mutate(dose = as.factor(dose))
head(df, 3)

# Summary statistics
df.summary <- df %>%
  group_by(dose) %>%
  summarise(sd = sd(len, na.rm = TRUE), len = mean(len))
df.summary

# (1) Line plot
ggplot(df.summary, aes(dose, len)) +
  geom_line(aes(group = 1)) +
  geom_errorbar( aes(ymin = len-sd, ymax = len+sd),width = 0.2) +
  geom_point(size = 2)

# (2) Bar plot
ggplot(df.summary, aes(dose, len)) +
  geom_bar(stat = "identity", fill = "lightgray", color = "black") +
  geom_errorbar(aes(ymin = len, ymax = len+sd), width = 0.2) 

# Grouped line/bar plots

# Data preparation
df.summary2 <- df %>%
  group_by(dose, supp) %>%
  summarise( sd = sd(len), len = mean(len))
df.summary2

# (1) Line plot + error bars
ggplot(df.summary2, aes(dose, len)) +
  geom_line(aes(linetype = supp, group = supp))+
  geom_point()+
  geom_errorbar(
    aes(ymin = len-sd, ymax = len+sd, group = supp),
    width = 0.2
  )

# (2) Bar plots + upper error bars.
ggplot(df.summary2, aes(dose, len)) +
  geom_bar(aes(fill = supp), stat = "identity",
           position = position_dodge(0.8), width = 0.7)+
  geom_errorbar(
    aes(ymin = len, ymax = len+sd, group = supp),
    width = 0.2, position = position_dodge(0.8)
  )+
  scale_fill_manual(values = c("grey80", "grey30"))

# Box plots and alternatives
# Convert data frame column from character to factor

ToothGrowth$dose <- as.factor(ToothGrowth$dose)

# Basic
ggplot(ToothGrowth, aes(dose, len)) +
  geom_boxplot()

# Box plot + violin plot
ggplot(ToothGrowth, aes(dose, len)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = 0.2)

# Add jittered points
ggplot(ToothGrowth, aes(dose, len)) +
  geom_boxplot() +
  geom_jitter(width = 0.2)

# Dot plot + box plot
ggplot(ToothGrowth, aes(dose, len)) +
  geom_boxplot() +
  geom_dotplot(binaxis = "y", stackdir = "center")

# Box plots
ggplot(ToothGrowth, aes(dose, len)) +
  geom_boxplot(aes(color = supp)) +
  scale_color_viridis_d()

# Add jittered points
ggplot(ToothGrowth, aes(dose, len, color = supp)) +
  geom_boxplot() +
  geom_jitter(position = position_jitterdodge(jitter.width = 0.2)) +
  scale_color_viridis_d()

# Visualizing Time Series

# Data preparation
df <- economics %>%
  select(date, psavert, uempmed) %>%
  gather(key = "variable", value = "value", -date)
head(df, 3)

# Multiple line plot
ggplot(df, aes(x = date, y = value)) + 
  geom_line(aes(color = variable), size = 1) +
  scale_color_manual(values = c("#00AFBB", "#E7B800")) +
  theme_minimal()

# Scatterplot matrix

library(GGally)
ggpairs(iris[,-5])+ theme_bw()

# Correlograms

library("ggcorrplot")
# Compute a correlation matrix
my_data <- mtcars[, c(1,3,4,5,6,7)]
corr <- round(cor(my_data), 1)
# Visualize
ggcorrplot(corr, p.mat = cor_pmat(my_data),
           hc.order = TRUE, type = "lower",
           color = c("#FC4E07", "white", "#00AFBB"),
           outline.col = "white", lab = TRUE)

# Cluster analysis

library(factoextra)
USArrests %>%
  scale() %>%                           # Scale the data
  dist() %>%                            # Compute distance matrix
  hclust(method = "ward.D2") %>%        # Hierarchical clustering
  fviz_dend(cex = 0.5, k = 4, palette = "jco") # Visualize and cut 
# into 4 groups using Jour of CLinical Oncology palette

# Balloon Plots

library(ggpubr)
# Data preparation
housetasks <- read.delim(
  system.file("demo-data/housetasks.txt", package = "ggpubr"),
  row.names = 1
)
head(housetasks, 4)

# Visualization
ggballoonplot(housetasks, fill = "value")+
  scale_fill_viridis_c(option = "C")


# Demo Set 5: GGPlot Colors
# Source = https://www.datanovia.com/en/blog/ggplot-colors-best-tricks-you-will-love/

library(ggplot2)
theme_set(
  theme_minimal() +
    theme(legend.position = "right")
)
 
# Initialize ggplots using the iris data set. 

# Box plot
bp <- ggplot(iris, aes(Species, Sepal.Length))

# Scatter plot
sp <- ggplot(iris, aes(Sepal.Length, Sepal.Width))

# Box plot
bp + geom_boxplot(fill = "#FFDB6D", color = "#C4961A")

# Scatter plot
sp + geom_point(color = "#00AFBB") 

# List of 657 R Color Names
# https://www.datanovia.com/en/blog/awesome-list-of-657-r-color-names/

# Box plot
bp + geom_boxplot(fill = "lightgray", color = "black")

# Scatter plot
sp + geom_point(color = "steelblue") 

# Change colors by groups: ggplot default colors

# Box plot
bp <- bp + geom_boxplot(aes(fill = Species)) +
  theme(legend.position = "top")
bp

# Scatter plot
sp <- sp + geom_point(aes(color = Species)) +
  theme(legend.position = "top")
sp

# Set custom color palettes

# Box plot
bp + scale_fill_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))

# Scatter plot
sp + scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))

custom.col <- c("#FFDB6D", "#C4961A", "#F4EDCA", 
                "#D16103", "#C3D7A4", "#52854C", "#4E84C4", "#293352")

# Use colorblind-friendly palette

# The palette with grey:
cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# The palette with black:
cbp2 <- c("#000000", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# To use for fills, add
bp + scale_fill_manual(values = cbp1)

# To use for line and point colors, add
sp + scale_colour_manual(values=cbp1)

# Predefined ggplot color palettes

library(viridis)
# Gradient color
ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(color = Sepal.Length)) +
  scale_color_viridis(option = "D")

# Discrete color. use the argument discrete = TRUE
ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(color = Species)) +
  geom_smooth(aes(color = Species, fill = Species), method = "lm") + 
  scale_color_viridis(discrete = TRUE, option = "D")+
  scale_fill_viridis(discrete = TRUE) 

# RColorBrewer palettes
# scale_fill_brewer() for box plot, bar plot, violin plot, dot plot, etc
# scale_color_brewer() for lines and points

# Box plot
bp + scale_fill_brewer(palette = "Dark2")

# Scatter plot
sp + scale_color_brewer(palette = "Dark2")

# Display colorblind-friendly brewer palettes

library(RColorBrewer)
display.brewer.all(colorblindFriendly = TRUE)

# Grey color palettes

# Box plot
bp + scale_fill_grey(start = 0.8, end = 0.2) 

# Scatter plot
sp + scale_color_grey(start = 0.8, end = 0.2)

# Scientific journal color palettes
# scale_color_npg() and scale_fill_npg(): Nature Publishing Group color palettes
# scale_color_aaas() and scale_fill_aaas(): American Association for the Advancement 
# of Science color palettes
# scale_color_lancet() and scale_fill_lancet(): Lancet journal color palettes
# scale_color_jco() and scale_fill_jco(): Journal of Clinical Oncology color palettes
# scale_color_tron() and scale_fill_tron(): This palette is inspired by the colors 
# used in Tron Legacy. It is suitable for displaying data when using a dark theme.

library("ggsci")
# Change area fill color using jco palette
bp + scale_fill_jco()


# Change point color 
sp + scale_color_jco()

# Wes Anderson color palettes
# Contains 16 color palettes from Wes Anderson movies.

library(wesanderson)
names(wes_palettes)

library(wesanderson)
# Discrete color
bp + scale_fill_manual(values = wes_palette("GrandBudapest1", n = 3))

# Gradient color
pal <- wes_palette("Zissou1", 100, type = "continuous")
ggplot(heatmap, aes(x = X2, y = X1, fill = value)) +
  geom_tile() + 
  scale_fill_gradientn(colours = pal) + 
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) + 
  coord_equal() 

# Top R Color Palettes to Know for Great Data Visualization
# https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/

# Gradients or continuous colors

# Default ggplot gradient colors

sp2 <- ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(color = Sepal.Length))


# scale_color_gradient(), scale_fill_gradient() for sequential gradients between two colors
# scale_color_gradient2(), scale_fill_gradient2() for diverging gradients
# scale_color_gradientn(), scale_fill_gradientn() for gradient between n colors

# Set gradient between two colors

# Sequential color scheme. 
# Specify the colors for low and high ends of gradient
sp2 + scale_color_gradient(low = "blue", high = "red")

# Diverging color scheme
# Specify also the colour for mid point
mid <- mean(iris$Sepal.Length)
sp2 + scale_color_gradient2(midpoint = mid, low = "blue", mid = "white",
                            high = "red", space = "Lab" )

# Set gradient between n colors

sp2 + scale_color_gradientn(colours = rainbow(5))

