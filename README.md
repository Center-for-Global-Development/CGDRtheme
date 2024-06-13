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
To load the default_theme, use the function `setup_plot`. This function applies the following:
- correct font style and font size for the text labels and axis labels
- formats the chart area to adhere to the data visualization style guide

```
default_theme <- setup_plot()

# example:
plot <-ggplot(mtcars, aes(x=wt, y=mpg, color=qsec)) + 
  geom_point()

plot <- plot + 
  scale_color_gradient(low=colors['gold'], high=colors['teal'])+
  labs(
    title = "This is a title",
    x = "x-axis title",
    y = "y-axis title",
  ) +
  default_theme
```
![alt text](/images/image-2.png)

To add a legend, use the function `add_legend(position = "right", justification = "top")`

```
plot <- plot + 
  scale_color_gradient(low=colors['gold'], high=colors['teal'])+
  labs(
    title = "This is a title",
    x = "x-axis title",
    y = "y-axis title",
  ) +
  default_theme +
  add_legend(position = "right", justification = "top")
```
![alt text](/images/image-3.png)

To add gridlines as needed, use the function `add_grid_lines(horizontal = TRUE, vertical = FALSE)`

```
plot <- plot + 
  scale_color_gradient(low=colors['gold'], high=colors['teal'])+
  labs(
    title = "This is a title",
    x = "x-axis title",
    y = "y-axis title",
  ) +
  default_theme +
  add_legend(position = "right", justification = "top") +
  add_grid_lines(horizontal = TRUE, vertical = FALSE)
```
![alt text](/images/image-4.png)

Note: Change the vertical parameter from `FALSE` to `TRUE` to add vertical gridlines as needed.
```
plot <- plot + 
  scale_color_gradient(low=colors['gold'], high=colors['teal'])+
  labs(
    title = "This is a title",
    x = "x-axis title",
    y = "y-axis title",
  ) +
  default_theme +
  add_legend(position = "right", justification = "top") +
  add_grid_lines(horizontal = TRUE, vertical = TRUE)
```
![alt text](/images/image-5.png)

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
```
sample_df = data.frame(dose=c("D0.5", "D1", "D2"),
                       len=c(4.2, 10, 29.5))

plot <- ggplot(data=sample_df, aes(x=dose, y=len)) +
  geom_bar(stat="identity",
           fill = cgd_palette(palette_name = "categorical", n=1),
           width = 0.5) +
  geom_text(aes(label=len), 
            family = "Sofia Pro Light Italic",
            size = 12,
            size.unit = "pt",
            vjust = -0.5 ) +
  labs(
    title = "Number of cars based on number of cylinders",
    x = "Dosage",
    y = "Tooth length",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0,0.1)))

p2 + default_theme
```
![alt text](/images/image.png)

Alternatively, if we use the function `cgd_palette(palette_name = "categorical", n=3)` to use 3 colors from the categorical palette.
![alt text](/images/image-1.png)