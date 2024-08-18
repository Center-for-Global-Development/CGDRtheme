library(devtools)
library(CGDtheme)
library(ggplot2)
library(scales)
library(ggrepel)
library(dplyr)

setup_plot()

sample_df <- data.frame(supp=rep(c("line 1", "line 2", "line 3"), each=5),
                 year=rep(c(2018, 2019, 2020, 2021, 2022), 3),
                 len=c(6.8, 15, 33, 4.2, 10,
                       8.2, 20, 40, 6, 12,
                       10.3, 25, 44, 16, 16))
sample_df_single <- sample_df %>% filter(supp == 'line 1')

# create a single line chart
line_chart <-
  ggplot(sample_df_single, aes(x=year, y=len, group=supp)) +
  geom_line(data = subset(df1, year <= 2021)) +
  labs(
    title = "This is a line chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_x_continuous(breaks = 2018:2022)
line_chart

# create a single line chart with a projection line
line_chart +
  geom_line(data = subset(df1, year >= 2021),
                      aes(color=supp),
                      linetype="dashed")

# create a single line chart with a projection line and a separator
line_chart +
  add_projection_line(df = subset(sample_df_single, year >= 2021)) +
  add_separator_line(orientation = "vertical",
                                intercept = 2021)

# create a single line chart with a projection line, a separator, and a trend line
line_chart +
  add_projection_line(df = subset(sample_df_single, year >= 2021)) +
  add_separator_line(orientation = "vertical",
                     intercept = 2021) +
  add_trend_line(method = "lm")

# create a single line chart with a projection line, a separator, and a trend line with annotations
line_chart +
  add_projection_line(df = subset(sample_df_single, year >= 2021)) +
  add_separator_line(orientation = "vertical",
                     intercept = 2021) +
  add_trend_line(method = "lm") +
  add_annotations(type = "text",
                  text = "Some text",
                  text_x_position = 2019,
                  text_y_position = 34) +
  add_annotations(type = "segment",
                  segment_x_position_start = 2019,
                  segment_x_position_end = 2019.9,
                  segment_y_position_start = 33,
                  segment_y_position_end = 33)

# create a line chart with multiple lines
sample_df_mult <- sample_df %>%
  mutate(label = if_else(year == max(year), as.character(supp), NA_character_))

line_chart_mult <-ggplot(sample_df_mult, aes(x=year, y=len, group=supp)) +
  geom_line(data = sample_df_mult,
            aes(color=supp)) +
  labs(
    title = "This is a line chart with multiple lines",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_x_continuous(breaks = 2018:2022) +
  add_labels(label, "line")
line_chart_mult


