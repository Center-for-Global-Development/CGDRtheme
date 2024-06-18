library(devtools)
library(CGDtheme)
library(ggplot2)
library(scales)
library(ggrepel)
library(dplyr)

default_theme <- setup_plot()
colors <- load_cgd_colors()
palette <- load_cgd_palette()

mtcars2 <- within(mtcars, {
  vs <- factor(vs, labels = c("V-shaped", "Straight"))
  am <- factor(am, labels = c("Automatic", "Manual"))
  cyl  <- factor(cyl)
  gear <- factor(gear)
})

scatter_plot <-ggplot(mtcars, aes(x=wt, y=mpg, color=qsec)) +
  geom_point() +
  scale_color_gradient(low=cgd_palette(palette_name = "polar2")[1],
                       high=cgd_palette(palette_name = "polar2")[2])+
  labs(
    title = "This is a scatter plot",
    x = "x-axis title",
    y = "y-axis title",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  scale_x_continuous(expand = expansion(mult = c(0,0.1)))

scatter_plot +
  default_theme +
  add_legend(position = "right", justification = "top") +
  add_grid_lines(horizontal = TRUE, vertical = TRUE)
