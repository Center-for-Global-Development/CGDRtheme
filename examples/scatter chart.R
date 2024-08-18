library(devtools)
library(CGDtheme)
library(ggplot2)

setup_plot()

mtcars2 <- within(mtcars, {
  vs <- factor(vs, labels = c("V-shaped", "Straight"))
  am <- factor(am, labels = c("Automatic", "Manual"))
  cyl  <- factor(cyl)
  gear <- factor(gear)
})

# create a scatter plot
scatter_plot <-ggplot(mtcars, aes(x=wt, y=mpg, color=qsec)) +
  geom_point() +
  labs(
    title = "This is a scatter plot",
    x = "x-axis title",
    y = "y-axis title",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  scale_x_continuous(expand = expansion(mult = c(0,0.1)))
scatter_plot

# create a scatter plot with legend
scatter_plot +
  add_legend(position = "right", justification = "top")

# create a scatter plot with legend and grid lines
scatter_plot +
  add_legend(position = "right", justification = "top") +
  add_grid_lines(horizontal = TRUE, vertical = TRUE)

