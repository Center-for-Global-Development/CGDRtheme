# CGD's R theme

## Installation
1. Install and load `devtools`
```
install.packages(devtools)
library(devtools)
```

2. Install and load the package
```
remotes::install_git("https://github.com/Center-for-Global-Development/CGDRtheme.git")
library(CGDtheme)
```

## Usage
### Applying a default theme to the plot
To load the default theme, use the function `setup_plot()`. This function applies the following:
- correct font style and font size for the text labels and axis labels
- formats the chart area to adhere to the data visualization style guide
- uses the CGD colors as default

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
    title = "This is a bar chart with 1 color and has bar labels",
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
Column to be used for the label

chart_type:
bar = for bar charts
stacked = for stacked bar charts
line = for line charts
```
```
# add the function to the plot
bar_plot + 
  add_labels(sample_df$len, "bar")
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
  add_labels(sample_df$len, "bar")
bar_plot
```
![alt text](/images/image-2.png)

>NOTE: there are only 8 distinct colors in the default colors. If the categories are > 8, the colors will repeat.
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
  add_labels(sample_df$len, "bar")
bar_plot
```
![alt text](/images/image-3.png)

### Adjusting long axis label names in bar charts
For long axis labels, use the function `wrap_axis_text()` and configure the parameters.
```
add_space: 
FALSE - when there are spaces in the categories
TRUE - when the categories do not have spaces and therefore should be truncated

column:
Column from the dataframe identified to be the axis

num_text:
If `add_space = TRUE`, define the number of letter placement that the word will be truncated
```

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
  wrap_axis_text(add_space = FALSE,
                 column = sample_df$dose,
                 num_text = 8)
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
  add_labels(sample_df$len, "bar") +
  wrap_axis_text(add_space = TRUE,
                 column = sample_df$dose,
                 num_text = 4)
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

To add a projection, use the function `add_projection()` and define the parameters.
```
df:
Dataframe to be used for the plot

year:
Starting year for the projection
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
![alt text](/images/image-11.png)

### Creating a stacked bar plot
Below is a sample code to create a stacked bar plot.
```
stacked_bar_plot <- ggplot(sample_df, aes(fill=y, y=value, x=x, label=value)) +
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

To add a legend, use the function `add_legend(position = "right", justification = "top")`

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
  add_labels(label=sample_df_rec$pct, "stacked")
```
![alt text](/images/image-15.png)

### Creating a scatter plot
Below is an example of a scatter plot with the default theme. The colors applied by default is based on the style guide that uses polar colors from two hexes.
```
light_teal <- "#006970"
gold <- "#FFB52C"
polar = c(light_teal, gold)
```
```
mtcars2 <- within(mtcars, {
  vs <- factor(vs, labels = c("V-shaped", "Straight"))
  am <- factor(am, labels = c("Automatic", "Manual"))
  cyl  <- factor(cyl)
  gear <- factor(gear)
})

# create a scatter plot
scatter_plot <-ggplot(mtcars, aes(x=wt, y=mpg, color=qsec)) +
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

To add legends, use the function `add_legend()`
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
  geom_boxplot(width = 0.5)
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
These are accessible by calling the function `cgd_palette(palette_name = "categorical", n=1)`
The parameter for `palette_name` can be one of the palettes in the list above. The parameter `n` is the number of colors to be used from the identified palette.

Individual colors can also be accessed by using the function `load_cgd_colors()`
```
colors <- load_cgd_colors()
```
To inspect the colors, enter the variable name used to store the colors (in this case `colors`) into the console. 

![alt text](/images/image-22.png)

To access the individual colors:
```
colors['teal']
```
This should give you the hex code for teal.

![alt text](/images/image-23.png)


Individual color palettes can also be access by using the function `load_cgd_palette()`
```
palette <- load_cgd_palette()
```

![alt text](/images/image-24.png)

To access the individual palettes:
```
palette['categorical']
```
This should give you a list of the categorical palette's hexes.

![alt text](/images/image-25.png)
