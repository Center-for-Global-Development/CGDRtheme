library(devtools)
library(CGDtheme)
library(ggplot2)
library(tidyverse)

setup_plot()

x <- c(rep("category 1" , 4) , rep("category 2" , 4) , rep("category 3" , 4) , rep("category 4" , 4) )
y <- rep(c("level 1" , "level 2" , "level 3", 'level 4') , 4)
value <- abs(rnorm(16 , 0 , 15))
sample_df <- data.frame(x,y,value)

# create a stacked bar plot
stacked_bar_plot <- ggplot(sample_df, aes(fill=y, y=value, x=x, label=value)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a stacked bar chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))
stacked_bar_plot

# create a stacked bar plot with legend
stacked_bar_plot +
  add_legend(position = "right", justification = "top")

# create a stacked bar plot with legend and data labels
stacked_bar_plot +
  add_legend(position = "right", justification = "top") +
  add_labels(label=ceiling(value), "stacked")

# create a 100% stacked bar plot
sample_df_rec <- sample_df %>%
  group_by(x) %>%
  mutate(pct = value/sum(value))

percent_stacked_bar_plot <- ggplot(sample_df_rec, aes(fill=y, y=pct, x=x)) +
  geom_bar(position = "fill", stat="identity") +
  labs(
    title = "This is a 100% stacked bar chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(labels = percent_format(),
                     expand = expansion(mult = c(0,0.1)))
percent_stacked_bar_plot

# create a stacked bar plot with legend and data labels
percent_stacked_bar_plot +
  add_legend(position = "right", justification = "top") +
  add_labels(label=sample_df_rec$pct, "stacked")
