# CGDtheme

## Installation
1. Install and load `devtools`
```
install.packages(devtools)
library(devtools)
```

2. Install and load the package
```
remotes::install_git("https://github.com/cgdevDC/CGDtheme.git")
library(CGDTheme)
```

## Usage
### Applying a `default_theme` to the plot
To load the default_theme, use the function `setup_plot()`. This function applies the following:
- correct font style and font size for the text labels and axis labels
- formats the chart area to adhere to the data visualization style guide

```
default_theme <- setup_plot()

# example:
sample_df = data.frame(
  dose=c("D0.5", "D1", "D2", "D3", "D4", "D5", "D6", "D6.5"),
  len=c(4.2, 10, 29.5, 10.5, 3.4, 5, 23.2, 14))

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
  
bar_plot +
  default_theme
```
![alt text](/images/image.png)

Note that for bar labels, the appropriate font family and size should be declared when adding a `geom_text()`. Refer to code for the configuration. 

### Using multiple colors for a bar chart
To use different colors for each of the bars in a bar chart, modify the parameters of the function `cgd_palette()`. Since the bars are categorical in nature, `palette_name` can remain as `categorical`. However, since there are 8 bars, `n` should be 8.

```
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
```
![alt text](/images/image-1.png)

More about colors is discussed later in this guide.

### Creating a line plot
In the same way as the bar plot, start by adding the `default_theme` to the base plot.

```
df <- data.frame(
  supp=rep(c("line 1", "line 2", "line 3"), each=5),
  year=rep(c(2018, 2019, 2020, 2021, 2022), 3),
  len=c(6.8, 15, 33, 4.2, 10,
        8.2, 20, 40, 6, 12,
        10.3, 25, 44, 16, 16))
df1 <- df %>% filter(supp == 'line 1')

line_chart <-ggplot(df1, aes(x=year, y=len, group=supp)) +
  geom_line(data = subset(df1, year <= 2021),
            aes(color=supp),
            size = convert_to_pt(4)) +
  labs(
    title = "This is a line chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_color_manual(values=cgd_palette(palette_name = "categorical", n=1)) +
  scale_x_continuous(breaks = 2018:2021)

line_chart +
  default_theme
```

![alt text](/images/image-2.png)

To add a projection, add another `geom_line` in the base plot.
```
geom_line(data = subset(df1, year >= 2021),
            aes(color=supp),
            size = convert_to_pt(4),
            linetype="dashed") 
```

![alt text](/images/image-3.png)

To add a separator line, use the function `add_separator_line` with the appropriate parameters for `orientation` and `intercept`. As an example, we want to add a vertical line on year 2021. 

```
add_separator_line(orientation = "vertical", intercept = 2021)
```

![alt text](/images/image-4.png)

There are different ways to add a trend line. `geom_smooth` is typcally used. However, the important configuration is as to use the `color`, `linetype`, and `size` that follows the data visualization style guide.

```
geom_smooth(aes(group = 1), 
              method = "lm", 
              size = convert_to_pt(3),
              color = colors['gold'],
              linetype = "dotted",
              se = FALSE) 
```

![alt text](/images/image-5.png)

Annotations or text call outs are tricky to add. Below are some guidelines on how to add accordingly.

The example below calls out a single point only. 
Add a text annotation by identifying the x and y coordinates where you want the text to display. Use the appropriate font family, color, and size.
Add a line segment by identifying the starting x and y coordinates and the ending x and y coordinates of the line segment. Use the appropriate colors and size for the line segment.

```
# identify the placement of the text
annotate("text", 
  x = 2019, 
  y = 35, 
  label = "Some text", 
  family = "Sofia Pro Light Italic",
  colour = colors['teal_black'],
  size = convert_to_pt(12)) +

# identify the placement of the line
annotate("segment", 
  x = 2019, 
  xend = 2019.9, 
  y = 33, 
  yend = 33,
  colour = colors['teal_gray'],
  size = convert_to_pt(1))
```

![alt text](/images/image-6.png)

### Creating a line plot with multiple lines
When there are multiple lines in a plot, the lines should be labeled accordingly. Following the data visualization style guide, add labels within the plot when it makes sense.

To accomplish this in a time-series line plot, add a column that should only display labels for the latest year.

```
df <- data.frame(
  supp=rep(c("line 1", "line 2", "line 3"), each=5),
  year=rep(c(2018, 2019, 2020, 2021, 2022), 3),
  len=c(6.8, 15, 33, 4.2, 10,
        8.2, 20, 40, 6, 12,
        10.3, 25, 44, 16, 16))
df2 <- df %>%
  mutate(label = if_else(year == max(year), as.character(supp), NA_character_))
```

Use the function `geom_text_repel` to add the labels. Use the appropriate font family, colors and size for the labels.
```
geom_text_repel(aes(label = label),
                  nudge_x = 0.1,
                  na.rm = TRUE,
                  family = "Sofia Pro Light Italic",
                  segment.color = NA
                   )
```

![alt text](/images/image-7.png)

### Creating a stacked bar plot
Below is a sample code to create a stacked bar plot.
```
x <- c(rep("category 1" , 4) , rep("category 2" , 4) , rep("category 3" , 4) , rep("category 4" , 4) )
y <- rep(c("level 1" , "level 2" , "level 3", 'level 4') , 4)
value <- abs(rnorm(16 , 0 , 15))
sample_df <- data.frame(x,y,value)

stacked_bar_plot <- ggplot(sample_df, aes(fill=y, y=value, x=x)) +
  geom_bar(stat="identity") +
  labs(
    title = "This is a stacked bar chart",
    x = "x-axis label",
    y = "y-axis label",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  scale_fill_manual(values = cgd_palette(palette_name = "categorical", n=4))

stacked_bar_plot +
  default_theme 
```
![alt text](/images/image-9.png)

To add a legend, use the function `add_legend(position = "right", justification = "top")`

```
stacked_bar_plot +
  default_theme  +
  add_legend(position = "right", justification = "top")
```
![alt text](/images/image-10.png)

### Creating a scatter plot
Below is an example of a scatter plot with the default theme and a legend.
```
mtcars2 <- within(mtcars, {
  vs <- factor(vs, labels = c("V-shaped", "Straight"))
  am <- factor(am, labels = c("Automatic", "Manual"))
  cyl  <- factor(cyl)
  gear <- factor(gear)
})

scatter_plot <-ggplot(mtcars, aes(x=wt, y=mpg, color=qsec)) + 
  geom_point() +
  scale_color_gradient(low=cgd_palette(palette_name = "polar2")[1], 
                       high=cgd_palette(palette_name = "polar2")[2])+
  labs(
    title = "This is a scatter plot",
    x = "x-axis title",
    y = "y-axis title",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1))) +
  scale_x_continuous(expand = expansion(mult = c(0,0.1)))

scatter_plot + 
  default_theme +
  add_legend(position = "right", justification = "top")
```

![alt text](/images/image-11.png)
To add gridlines as needed, use the function `add_grid_lines(horizontal = TRUE, vertical = FALSE)`

```
scatter_plot + 
  default_theme +
  add_legend(position = "right", justification = "top") +
  add_grid_lines(horizontal = TRUE, vertical = FALSE)
```

![alt text](/images/image-8.png)

Note: Change the vertical parameter from `FALSE` to `TRUE` to add vertical gridlines as needed.
```
scatter_plot + 
  default_theme +
  add_legend(position = "right", justification = "top") +
  add_grid_lines(horizontal = TRUE, vertical = FALSE)
```

![alt text](/images/image-12.png)

## Access Colors
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

Recall in the example above, we used the function `cgd_palette(palette_name = "categorical", n=1)` for the bars.

![alt text](/images/image.png)

Alternatively, if we use the function `cgd_palette(palette_name = "categorical", n=8)` to use 8 colors from the categorical palette.

![alt text](/images/image-1.png)

In another example above, we used the palette for polar with 2 colors in the scatter plot. 

![alt text](/images/image-11.png)
```
scale_color_gradient(low=cgd_palette(palette_name = "polar2")[1], 
                       high=cgd_palette(palette_name = "polar2")[2])
```
![alt text](/images/image-16.png)

Individual colors can also be accessed by using the function `load_cgd_colors()`
```
colors <- load_cgd_colors()
```
To inspect the colors, enter the variable name used to store the colors (in this case `colors`) into the console. 

![alt text](/images/image-13.png)

To access the individual colors:
```
colors['teal']
```
This should give you the hex code for teal.

![alt text](/images/image-17.png)


Individual color palettes can also be access by using the function `load_cgd_palette()`
```
palette <- load_cgd_palette()
```

![alt text](/images/image-14.png)

To access the individual palettes:
```
palette['categorical']
```
This should give you a list of the categorical palette's hexes.

![alt text](/images/image-15.png)