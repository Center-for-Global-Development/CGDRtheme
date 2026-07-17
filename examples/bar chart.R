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

# add data labels (pass the column unquoted)
bar_plot +
  add_labels(len, "bar")

# create a bar plot using all 8 colors from the categorical palette
bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len, fill=dose)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with 8 colors",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  add_labels(len, "bar")
bar_plot

# wrap long category names at word boundaries
sample_df_long = data.frame(dose=c("this is a long name",
                                   "this is a very long name",
                                   "unit 3",
                                   "unit 4",
                                   "unit 5",
                                   "unit 6",
                                   "unit 7",
                                   "unit 8"),
                            len=c(4.2, 10, 29.5, 10.5, 3.4, 5, 23.2, 14))

ggplot(data=sample_df_long, aes(x=dose, y=len)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with long category names with spaces",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  wrap_axis_text(width = 8)

# also break inside long labels that have no spaces
sample_df_nospace = data.frame(dose=c("asuperlongname",
                                      "averyverylongname",
                                      "unit 3",
                                      "unit 4",
                                      "unit 5",
                                      "unit 6",
                                      "unit 7",
                                      "unit 8"),
                               len=c(4.2, 10, 29.5, 10.5, 3.4, 5, 23.2, 14))

ggplot(data=sample_df_nospace, aes(x=dose, y=len)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with long category names without spaces",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  add_labels(len, "bar") +
  wrap_axis_text(width = 4, break_words = TRUE)

# style a single plot without changing session defaults:
# theme_cgd() + scale_fill_cgd() compose like any other ggplot pieces
reset_plot()

ggplot(data=sample_df, aes(x=dose, y=len, fill=dose)) +
  geom_col() +
  labs(
    title = "This bar chart is styled without setup_plot()",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  theme_cgd() +
  scale_fill_cgd()

# a chart that needs more than 8 colors errors instead of repeating colors;
# combine smaller categories, facet, or encode the extras some other way
sample_df9 = data.frame(dose=paste("unit", 1:9),
                        len=c(4.2, 10, 29.5, 10.5, 3.4, 5, 23.2, 14, 10))

ggplot(data=sample_df9, aes(x=dose, y=len, fill=dose)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with 9 categories",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  theme_cgd() +
  scale_fill_cgd()
#> Error: The chart needs 9 colors but the CGD "categorical" palette has only 8.
#> Combine smaller categories (e.g. into an "Other" group), facet the chart,
#> or encode the extra categories some other way.
