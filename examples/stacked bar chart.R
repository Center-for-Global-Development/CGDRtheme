library(CGDtheme)
library(ggplot2)
library(dplyr)
library(scales)

setup_plot()

sample_df <- data.frame(
  x = rep(c("category 1", "category 2", "category 3", "category 4"), each = 4),
  y = rep(c("level 1", "level 2", "level 3", "level 4"), 4),
  value = c(4, 12, 21, 8,
            16, 24, 2, 12,
            22, 8, 14, 17,
            6, 9, 19, 11))

# create a stacked bar plot (a legend is shown automatically)
stacked_bar_plot <- ggplot(sample_df, aes(fill=y, y=value, x=x)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a stacked bar chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))
stacked_bar_plot

# reposition the legend / apply CGD legend styling (hides the legend title)
stacked_bar_plot +
  add_legend(position = "right", justification = "top")

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

# add percent data labels; "stacked" labels are formatted as percentages,
# so pass a proportion column (here pct), not raw counts
percent_stacked_bar_plot +
  add_legend(position = "right", justification = "top") +
  add_labels(pct, "stacked")
