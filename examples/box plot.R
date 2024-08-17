library(ggplot2)

ToothGrowth$dose <- as.factor(ToothGrowth$dose)

# Basic box plot
p <- ggplot(ToothGrowth, aes(x=dose, y=len)) +
  geom_boxplot(width = 0.5) +
  labs(
    title = "This is a box plot",
    x = "x-axis label",
    y = "y-axis label",
  )

p +
  default_theme +
  add_grid_lines(horizontal = TRUE)

# Box plot with colors
p <- ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) +
  geom_boxplot(width = 0.5) +
  #scale_fill_manual(values=cgd_palette(palette_name = "categorical", n = 3)) +
  labs(
    title = "This is a box plot with colors",
    x = "x-axis label",
    y = "y-axis label",
  )

p + add_labels()
  default_theme +
  add_grid_lines(horizontal = TRUE)
