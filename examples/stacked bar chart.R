library(devtools)
library(CGDtheme)
library(ggplot2)
library(scales)

default_theme <- setup_plot()
colors <- load_cgd_colors()
palette <- load_cgd_palette()

x <- c(rep("category 1" , 4) , rep("category 2" , 4) , rep("category 3" , 4) , rep("category 4" , 4) )
y <- rep(c("level 1" , "level 2" , "level 3", 'level 4') , 4)
value <- abs(rnorm(16 , 0 , 15))
sample_df <- data.frame(x,y,value)

# Stacked
stacked_bar_plot <- ggplot(sample_df, aes(fill=y, y=value, x=x)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a stacked bar chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))
  #scale_fill_manual(values = cgd_palette(palette_name = "categorical", n=4))

stacked_bar_plot
+ add_labels()
  default_theme  +
  add_legend(position = "right", justification = "top")

# Stacked + percent
percent_stacked_bar_plot <- ggplot(sample_df, aes(fill=y, y=value, x=x)) +
  geom_bar(position="fill", stat="identity") +
  labs(
    title = "This is a 100% stacked bar chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(labels = percent_format(),
                     expand = expansion(mult = c(0,0.1))) +
 #scale_fill_manual(values = cgd_palette(palette_name = "categorical", n=4))

percent_stacked_bar_plot +
  default_theme  +
  add_legend(position = "right", justification = "top")
