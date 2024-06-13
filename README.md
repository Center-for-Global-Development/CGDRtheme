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
- correct font style and font size for the text labels and axis
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