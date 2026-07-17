# CGD's R theme

This ggplot2 theme implements CGD's [branding and data viz guidelines](https://centerforglobaldevelop.sharepoint.com/:b:/r/sites/fileshare/Shared%20Documents/NDrive/Communications/CGD%20Branding%20Materials/CGD-Data-Viz-Style-Guide.pdf?csf=1&web=1&e=H081DY) (internal link — requires a CGD account). If you find a bug or would like to suggest an improvement, please submit a pull request or contact Jeremy Gaines (jgaines@cgdev.org). 

*A similar Stata scheme which implements the branding and data viz guide is available [here](https://github.com/Center-for-Global-Development/CGD-stata-scheme/).*


## Installation
1. Install `remotes`
```
install.packages("remotes")
```

2. Install and load the package
```
remotes::install_github("Center-for-Global-Development/CGDRtheme")
library(CGDtheme)
```

The examples below also use `ggplot2`, `dplyr`, and `scales`:
```
library(ggplot2)
library(dplyr)
library(scales)
```

## Fonts
CGD's brand font is Sofia Pro, which is commercially licensed and cannot be bundled with this package. The first time a theme is built in a session, the package resolves fonts automatically:

- If Sofia Pro is installed on your machine (e.g. via Adobe Fonts), it is used.
- Otherwise, [Poppins](https://fonts.google.com/specimen/Poppins) is downloaded once from Google Fonts into a per-user cache (no admin rights or system install needed) and used instead. A message tells you when this substitution happens.
- If neither is available (e.g. offline with no cached copy), charts fall back to the default sans font with a warning.

Render charts with the `ragg` device so these fonts are picked up: `ggsave(..., device = ragg::agg_png)`, or in R Markdown / Quarto set `dev = "ragg_png"` in the knitr chunk options.

## Usage
### Applying a default theme to the plot
To load the default theme, use the function `setup_plot()`. This function applies the following:
- correct font style and font size for the text labels and axis labels
- formats the chart area to adhere to the data visualization style guide
- uses the CGD colors as default
- shows legends by default (right side, top-justified) whenever a chart maps color or fill, so charts stay decodable; use `add_legend()` to reposition or apply CGD legend styling, and `theme(legend.position = "none")` to hide one

`setup_plot()` changes defaults for the whole session. To undo it, call `reset_plot()` — it restores the theme, geom defaults, and scale options that were in effect before.

To style a single plot without touching session state, add the composable pieces directly:
```
ggplot(df, aes(x = group, y = value, fill = group)) +
  geom_col() +
  theme_cgd() +
  scale_fill_cgd()
```
`scale_fill_cgd()` and `scale_colour_cgd()` accept any palette from the package, e.g. `scale_fill_cgd(palette = "polar2")`, plus `reverse = TRUE`, `lighten = 0.5`, and `discrete = FALSE` (interpolates the palette into a continuous gradient).

```
setup_plot()

# example:
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
    title = "This is a bar chart with 1 color",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) 
bar_plot
```
![alt text](/images/image-0.png)

### Adding data labels to a bar chart
To add data labels to a bar chart, use the function `add_labels()` and configure the parameters.
```
label:
Unquoted column in the plot data to use for the label, e.g. add_labels(len, "bar").
(A detached vector like df$len still works but is discouraged: a column reference
follows any filtering or reordering of the data.)

chart_type:
bar = for bar charts (labels sit above positive bars and below negative bars)
stacked = for stacked bar charts (percent labels; ink turns white on dark segments)
line = for line charts (direct labels at line ends; the legend is hidden automatically)
```
```
# add the function to the plot
bar_plot + 
  add_labels(len, "bar")
```
![alt text](/images/image-1.png)

### Using multiple colors for a bar chart
To color each bar differently, update the aesthetic function and use the parameter `fill`. 
```
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
```
![alt text](/images/image-2.png)

>NOTE: there are only 8 distinct colors in the categorical palette. A chart that needs more than 8 stops with an error instead of silently repeating colors — repeated colors would make different categories indistinguishable. Combine smaller categories (e.g. into an "Other" group), facet the chart, or encode the extra categories some other way.
```
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
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  add_labels(len, "bar")
bar_plot
#> Error: The chart needs 9 colors but the CGD "categorical" palette has only 8.
#> Combine smaller categories (e.g. into an "Other" group), facet the chart,
#> or encode the extra categories some other way.
```

### Adjusting long axis label names in bar charts
For long axis labels, use the function `wrap_axis_text()` and configure the parameters.
```
width:
Target line width in characters (default 10)

break_words:
FALSE (default) - wrap at word boundaries
TRUE - also insert breaks inside long labels that have no spaces

axis:
"x" (default) or "y" - which axis to wrap
```
The older `add_space`/`column`/`num_text` arguments still work but are deprecated.

```
# example with long axis labels with spaces
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
  wrap_axis_text(width = 8)
bar_plot
```
![alt text](/images/image-4.png)
```
# example with long axis labels without spaces
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
  add_labels(len, "bar") +
  wrap_axis_text(width = 4, break_words = TRUE)
bar_plot
```
![alt text](/images/image-5.png)

### Creating a line plot
Below is a sample code on how to create a line plot.

```
sample_df <- data.frame(supp=rep(c("line 1", "line 2", "line 3"), each=5),
                 year=rep(c(2018, 2019, 2020, 2021, 2022), 3),
                 len=c(6.8, 15, 33, 4.2, 10,
                       8.2, 20, 40, 6, 12,
                       10.3, 25, 44, 16, 16))
sample_df_single <- sample_df %>% filter(supp == 'line 1')

# create a single line chart
line_chart <-
  ggplot(sample_df_single, aes(x=year, y=len, group=supp)) +
  geom_line(data = subset(sample_df_single, year <= 2021)) +
  labs(
    title = "This is a line chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_x_continuous(breaks = 2018:2022)
line_chart
```
![alt text](/images/image-6.png)

To add a projection, use the function `add_projection_line()` and define the parameters.
```
df:
Dataframe to be used for the plot
```
```
line_chart +
  add_projection_line(df = subset(sample_df_single, year >= 2021)) 
```
![alt text](/images/image-7.png)

To add a separator line, use the function `add_separator_line` and define the parameters.
```
orientation:
vertical = vertical line
horizontal = horizontal line

intercept:
Point in the axis where the line will be placed
```
```
line_chart +
  add_projection_line(df = subset(sample_df_single, year >= 2021)) +
  add_separator_line(orientation = "vertical",
                                intercept = 2021)
```
![alt text](/images/image-8.png)

To add a trend line, use the function `add_trend_line` and define the parameters.
```
method:
Identified method to calculate the trend line
```
```
line_chart +
  add_projection_line(df = subset(sample_df_single, year >= 2021)) +
  add_separator_line(orientation = "vertical",
                     intercept = 2021) +
  add_trend_line(method = "lm")
```
![alt text](/images/image-9.png)

To add annotations, use the `add_annotations()` function and define the parameters.
```
type:
text = to add a text annotation
segment = to add a segment / line that points to the text annotation

text_x_position:
x-coordinate where the text will be displayed

text_y_position:
y-coordinate where the text will be displayed

segment_x_position_start:
x-cooridinate where segment will start

segment_x_position_end:
x-cooridinate where segment will end

segment_y_position_start:
y-cooridinate where segment will start

segment_y_position_end:
y-cooridinate where segment will end
```
>NOTE: only define the parameters of the type of annotation. Please see example below for better understanding.
```
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
```
![alt text](/images/image-10.png)

### Creating a line plot with multiple lines
When there are multiple lines in a plot, the lines should be labeled accordingly. Following the data visualization style guide, add labels within the plot when it makes sense.

To accomplish this in a time-series line plot, add a column that should only display labels for the latest year.

```
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
```
> NOTE: the label column can have any name (here it happens to be `label`) — pass it unquoted, as with the other `add_labels()` chart types. The legend is hidden automatically since the lines are labeled directly.

![alt text](/images/image-11.png)

### Creating a stacked bar plot
Below is a sample code to create a stacked bar plot.
```
sample_df <- data.frame(
  x = rep(c("category 1", "category 2", "category 3", "category 4"), each = 4),
  y = rep(c("level 1", "level 2", "level 3", "level 4"), 4),
  value = c(4, 12, 21, 8,
            16, 24, 2, 12,
            22, 8, 14, 17,
            6, 9, 19, 11))

stacked_bar_plot <- ggplot(sample_df, aes(fill=y, y=value, x=x)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a stacked bar chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))
stacked_bar_plot
```
![alt text](/images/image-12.png)

A legend is shown automatically. To reposition it or apply the CGD legend styling (which hides the legend title), use `add_legend()` — both arguments default to the values shown:

```
stacked_bar_plot +
  add_legend(position = "right", justification = "top")
```
![alt text](/images/image-13.png)

Below is a sample code to create a 100% stacked bar plot.
```
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
```
![alt text](/images/image-14.png)

To add a legend and data labels, use the functions `add_legend()` and `add_labels()` respectively.
```
percent_stacked_bar_plot +
  add_legend(position = "right", justification = "top") +
  add_labels(pct, "stacked")
```
![alt text](/images/image-15.png)

### Creating a scatter plot
Below is an example of a scatter plot with the default theme. When a *continuous* variable is mapped to color (here `qsec`), the default is a gradient interpolated between two brand colors — the same two hexes as the `polar2` palette:
```
light_teal <- "#006970"
gold <- "#FFB52C"
```
(A *discrete* color variable would instead get the categorical palette shown earlier.)
```
# create a scatter plot
scatter_plot <- ggplot(mtcars, aes(x=wt, y=mpg, color=qsec)) +
  geom_point() +
  labs(
    title = "This is a scatter plot",
    x = "x-axis title",
    y = "y-axis title",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  scale_x_continuous(expand = expansion(mult = c(0,0.1)))
scatter_plot
```
![alt text](/images/image-16.png)

The legend is shown automatically. To reposition it or apply the CGD legend styling, use `add_legend()`:
```
scatter_plot +
  add_legend(position = "right", justification = "top")
```
![alt text](/images/image-17.png)

To add gridlines as needed, use the function `add_grid_lines()`
>Note: Change the vertical parameter from `FALSE` to `TRUE` to add vertical gridlines as needed.
```
scatter_plot +
  add_legend(position = "right", justification = "top") +
  add_grid_lines(horizontal = TRUE, vertical = TRUE)
```
![alt text](/images/image-18.png)

### Creating a box plot
Creating a box plot is similar to how other plots are created.
```
ToothGrowth$dose <- as.factor(ToothGrowth$dose)

# create a box plot
boxplot <- ggplot(ToothGrowth, aes(x=dose, y=len)) +
  stat_boxplot(geom ='errorbar', width = 0.2) +
  geom_boxplot(width = 0.5) +
  labs(
    title = "This is a box plot",
    x = "x-axis label",
    y = "y-axis label",
  )
boxplot
```
![alt text](/images/image-19.png)

To add grid lines for readability, use the function `add_grid_lines()`
```
boxplot +
  add_grid_lines(horizontal = TRUE)
```
![alt text](/images/image-20.png)

To use colors, use the function `change_boxplot_color()` and put the plot variable inside the function as parameter. The function applies the custom colors of using CGD colors as outline and a lightened color of the outline as fill.
```
boxplot_colored <- ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose, colour=dose)) +
  stat_boxplot(geom ='errorbar', width = 0.2) +
  geom_boxplot(width = 0.5) +
  labs(
    title = "This is a box plot with colors",
    x = "x-axis label",
    y = "y-axis label",
  )
boxplot_colored <- change_boxplot_color(plot = boxplot_colored)
boxplot_colored
```
![alt text](/images/image-21.png)

## Accessing Colors
Adhering to the data visualization style guide, the following palette were added to the package:
```
cgd_colors <- list(
  categorical = c(light_teal, gold, blue, light_blue, light_gold, teal_gray,
                   dark_gray, light_gray),
  sequential1 = c(light_teal),
  sequential2 = c(light_blue, light_teal),
  sequential3 = c(light_gray, light_blue, light_teal),
  sequential4 = c(light_gray, light_blue, light_teal, dark_gray),
  sequential8 = c(light_gray, teal_gray, light_blue, blue, light_teal,
                   teal, dark_gray, teal_black),
  polar1 = c(light_teal),
  polar2 = c(light_teal, gold),
  polar3 = c(light_teal, teal_gray, gold),
  polar4 = c(light_teal, teal_gray, light_gold, gold),
  polar5 = c(light_teal, teal_gray, light_blue, light_gold, gold),
  stoplight = c(green, gold, red)
)
```
The easiest way to use a palette on a plot is `scale_fill_cgd(palette = "...")` or `scale_colour_cgd(palette = "...")` (see Usage above).

The raw hex values are accessible with `cgd_palette()`. `palette_name` is one of the palettes in the list above, and `n` is the number of colors to take from it (defaults to the full palette):
```
cgd_palette(palette_name = "categorical")
#> [1] "#006970" "#FFB52C" "#2D99B5" "#BFDEE0" "#FEE8BF" "#85A5AD" "#394649"
#> [8] "#DFE0E2"
```
For a smooth gradient with any number of colors interpolated from a palette, use `type = "continuous"`, e.g. `cgd_palette("sequential3", n = 20, type = "continuous")`.

Individual colors can be accessed with `load_cgd_colors()`, which returns a named vector of every brand color:
```
colors <- load_cgd_colors()
colors
#>       teal       gold  teal_gray light_teal      cream  dark_gray teal_black 
#>  "#0B4C5B"  "#FFB52C"  "#85A5AD"  "#006970"  "#F3F6F7"  "#394649"  "#1A272A" 
#>       blue light_blue light_gold light_gray        red      green 
#>  "#2D99B5"  "#BFDEE0"  "#FEE8BF"  "#DFE0E2"  "#D15553"  "#00896C" 

colors["teal"]
#>      teal 
#> "#0B4C5B" 
```

All palettes at once are available with `load_cgd_palette()`, which returns a named list:
```
palette <- load_cgd_palette()
palette[["categorical"]]
#> [1] "#006970" "#FFB52C" "#2D99B5" "#BFDEE0" "#FEE8BF" "#85A5AD" "#394649"
#> [8] "#DFE0E2"
```
