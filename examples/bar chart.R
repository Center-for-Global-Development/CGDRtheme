library(devtools)
library(CGDtheme)
library(ggplot2)
library(scales)
library(stringr)

#default_theme <- setup_plot()
#colors <- load_cgd_colors()
#palette <- load_cgd_palette()

sample_df = data.frame(dose=c("unit 1",
                              "unit 2",
                              # "unit 3",
                              # "unit 4",
                              # "unit 5",
                              # "unit 6",
                              # "unit 7",
                              "xxxxxxxxxxxxxxx"),
                       len=c(4.2, 10, 29.5)) #, 10.5, 3.4, 5, 23.2, 14))
sample_df$column_new = sub("\\s+$", "", gsub('(.{8})', '\\1 ', sample_df$dose))

setup_plot()

# create a bar plot using a single color
bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a bar chart with 1 color",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  # wrap_axis_text(add_space = TRUE,
  #                column = sample_df$dose,
  #                num_text = 8)
  add_labels()

bar_plot

# create a bar plot using a 8 colors from the categorical palette
bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len)) +
  geom_bar(stat="identity",
           fill = cgd_palette(palette_name = "categorical", n=8),
           width = 0.5) +
  geom_text(aes(label=len),
            vjust = -0.5 ) +
  labs(
    title = "This is a bar chart with 8 colors",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))


bar_plot
