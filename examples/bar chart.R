library(devtools)
library(CGDtheme)
library(ggplot2)

default_theme <- setup_plot()
colors <- load_cgd_colors()
palette <- load_cgd_palette()

sample_df = data.frame(dose=c("D0.5", "D1", "D2", "D3", "D4", "D5", "D6", "D6.5"),
                       len=c(4.2, 10, 29.5, 10.5, 3.4, 5, 23.2, 14))

# create a bar plot using a single color
bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len)) +
  geom_bar(stat="identity",
           fill = cgd_palette(palette_name = "categorical", n=1),
           width = 0.5) +
  geom_text(aes(label=len),
            family = "Sofia Pro Light Italic",
            size = 12,
            size.unit = "pt",
            vjust = -0.5) +
  labs(
    title = "This is a bar chart with 1 color",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))

bar_plot + default_theme

# create a bar plot using a 8 colors from the categorical palette
bar_plot <- ggplot(data=sample_df, aes(x=dose, y=len)) +
  geom_bar(stat="identity",
           fill = cgd_palette(palette_name = "categorical", n=8),
           width = 0.5) +
  geom_text(aes(label=len),
            family = "Sofia Pro Light Italic",
            size = 12,
            size.unit = "pt",
            vjust = -0.5 ) +
  labs(
    title = "This is a bar chart with 8 colors",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))

bar_plot + default_theme
