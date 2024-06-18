library(devtools)
library(CGDtheme)
library(ggplot2)
library(scales)
library(ggrepel)
library(dplyr)

default_theme <- setup_plot()
colors <- load_cgd_colors()
palette <- load_cgd_palette()

df <- data.frame(supp=rep(c("line 1", "line 2", "line 3"), each=5),
                 year=rep(c(2018, 2019, 2020, 2021, 2022), 3),
                 len=c(6.8, 15, 33, 4.2, 10,
                       8.2, 20, 40, 6, 12,
                       10.3, 25, 44, 16, 16))
df1 <- df %>% filter(supp == 'line 1')

line_chart <-ggplot(df1, aes(x=year, y=len, group=supp)) +
  geom_line(data = subset(df1, year <= 2021),
            aes(color=supp),
            size = convert_to_pt(4)) +
  geom_line(data = subset(df1, year >= 2021),
            aes(color=supp),
            size = convert_to_pt(4),
            linetype="dashed") +
  labs(
    title = "This is a line chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_color_manual(values=cgd_palette(palette_name = "categorical", n=1)) +
  scale_x_continuous(breaks = 2018:2022)

line_chart +
  default_theme +
  add_separator_line(orientation = "vertical",
                     intercept = 2021) +
  geom_smooth(aes(group = 1),
              method = "lm",
              size = convert_to_pt(3),
              color = colors['gold'],
              linetype = "dotted",
              se = FALSE) +
  annotate("text", x = 2019, y = 35, label = "Some text", family = "Sofia Pro Light Italic",
           colour = colors['teal_black'],
           size = convert_to_pt(12)) +
  annotate("segment", x = 2019, xend = 2019.9, y = 33, yend = 33,
           colour = colors['teal_gray'],
           size = convert_to_pt(1))



##############

df2 <- df %>%
  mutate(label = if_else(year == max(year), as.character(supp), NA_character_))

line_chart_mult <-ggplot(df2, aes(x=year, y=len, group=supp)) +
  geom_line(data = df2,
            aes(color=supp),
            size = convert_to_pt(4)) +
  labs(
    title = "This is a line chart with multiple lines",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_color_manual(values=cgd_palette(palette_name = "categorical", n=3)) +
  scale_x_continuous(breaks = 2018:2022) +
  geom_text_repel(aes(label = label),
                  nudge_x = 0.1,
                  na.rm = TRUE,
                  family = "Sofia Pro Light Italic",
                  segment.color = NA
                   )

line_chart_mult +
  default_theme

