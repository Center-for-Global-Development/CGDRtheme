library(devtools)
library(CGDtheme)
library(ggplot2)

setup_plot()

sample_df = data.frame(dose=c("unit 1",
                              "unit 2",
                              "unit 3",
                              "unit 4",
                              "unit 5",
                              "unit 6",
                              "unit 7",
                              "unit 8"),
                       len=c(4.2, 10, 29.5, 10.5, 3.4, 5, 23.2, 14))

# create a bar plot using a single color
bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with 1 color",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))
bar_plot

# create a bar plot using a 8 colors from the categorical palette
bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len, fill=dose)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with 8 colors",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))
bar_plot

# create a bar plot with > 8 categories
sample_df = data.frame(dose=c("unit 1",
                              "unit 2",
                              "unit 3",
                              "unit 4",
                              "unit 5",
                              "unit 6",
                              "unit 7",
                              "unit 8",
                              "unit 9"),
                       len=c(4.2, 10, 29.5, 10.5, 3.4, 5, 23.2, 14, 10))

bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len, fill=dose)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with 9 categories",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))
bar_plot

# create a bar plot with long category names
sample_df = data.frame(dose=c("this is a long name",
                              "this is a very long name",
                              "unit 3",
                              "unit 4",
                              "unit 5",
                              "unit 6",
                              "unit 7",
                              "unit 8"),
                       len=c(4.2, 10, 29.5, 10.5, 3.4, 5, 23.2, 14))

bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with long category names with spaces",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  wrap_axis_text(add_space = FALSE,
                 column = sample_df$dose,
                 num_text = 8)
bar_plot

# create a bar plot with long category names
sample_df = data.frame(dose=c("asuperlongname",
                              "averyverylongname",
                              "unit 3",
                              "unit 4",
                              "unit 5",
                              "unit 6",
                              "unit 7",
                              "unit 8"),
                       len=c(4.2, 10, 29.5, 10.5, 3.4, 5, 23.2, 14))

bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with long category names without spaces",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  wrap_axis_text(add_space = TRUE,
                 column = sample_df$dose,
                 num_text = 4)
bar_plot

# create a bar plot with labels
sample_df = data.frame(dose=c("unit 1",
                              "unit 2",
                              "unit 3",
                              "unit 4",
                              "unit 5",
                              "unit 6",
                              "unit 7",
                              "unit 8"),
                       len=c(4.2, 10, 29.5, 10.5, 3.4, 5, 23.2, 14))

bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with 1 color and has bar labels",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  add_labels(sample_df$len, "bar")
bar_plot


