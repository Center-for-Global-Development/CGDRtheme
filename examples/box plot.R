library(CGDtheme)
library(ggplot2)

setup_plot()

ToothGrowth$dose <- as.factor(ToothGrowth$dose)

# create a box plot
boxplot <- ggplot(ToothGrowth, aes(x=dose, y=len)) +
  stat_boxplot(geom ='errorbar', width = 0.2) +
  geom_boxplot(width = 0.5) +
  labs(
    title = "This is a box plot",
    x = "x-axis label",
    y = "y-axis label",
  )
boxplot

# create a box plot with grid lines
boxplot +
  add_grid_lines(horizontal = TRUE)

# create a box plot with colors: CGD colors as outline, a lightened version
# as fill (equivalent to adding scale_fill_cgd(lighten = 0.5) to the plot)
boxplot_colored <- ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose, colour=dose)) +
  stat_boxplot(geom ='errorbar', width = 0.2) +
  geom_boxplot(width = 0.5) +
  labs(
    title = "This is a box plot with colors",
    x = "x-axis label",
    y = "y-axis label",
  )
boxplot_colored <- change_boxplot_color(plot = boxplot_colored)
boxplot_colored
