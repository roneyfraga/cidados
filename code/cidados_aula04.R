# ------------------------------------------------------------
# 
# File Name: cidados_aula04.R
#
# Purpose: Ciência de Dados para Economistas - Faculdade de Economia UFMT
# 
# Creation Date: 2020-10-26
# Last Modified: 2022-10-13
# Created By: Roney Fraga Souza
# E-mail: roneyfraga@gmail.com
# roneyfraga.com
# 
# Licence:
#
# Creative Commons Attribution-NonCommercial-ShareAlike 
# CC BY-NC-SA
# http://creativecommons.org/licenses/by-nc-sa/3.0/
#
# ------------------------------------------------------------


# Gráficos com ggplot2


# ------------------------------
## ggplot2

# theory
# https://ggplot2-book.org

# or
# https://r4ds.had.co.nz/data-visualisation.html

# install.packages('ggplot2')
library(ggplot2)
# or
library(tidyverse) 

# • Data that you want to visualise and a set of aesthetic mappings describing how 
    # variables in the data are mapped to aesthetic attributes that you can perceive
# • Layers made up of geometric elements and statistical transformation.
# • The scales map values in the data space to values in an aesthetic space, whether 
    # it be colour, or size, or shape. 
# • A coordinate system, coord for short, describes how data coordinates are mapped 
    # to the plane of the graphic. 
# • A faceting specification describes how to break up the data into subsets and how to 
    # display those subsets as small multiples. 
# A theme which controls the finer points of display, like the font size and background colour.

# example data
?mpg
mpg |> dplyr::glimpse() 

# Every ggplot2 plot has three key components:
# 1. data,
# 2. A set of aesthetic mappings between variables in the data and visual properties, and
# 3. At least one layer which describes how to render each observation. 
    # Layers are usually created with a geom function.

ggplot(mpg, aes(x = displ, y = hwy)) + 
    geom_point() 

p = ggplot(mpg, aes(x = displ, y = hwy))
p + geom_point()

ggplot(mpg, aes(x = displ, 
                y = hwy, 
                colour = class, 
                shape = class
                )) +
    geom_point()   + 
    geom_line()

## Colour, Size, Shape and Other Aesthetic Attributes
ggplot(mpg, aes(x = displ,
                y = cty, 
                colour = class)) + 
    geom_point()


mpg |> count(class)

ggplot(mpg, 
       aes(displ, 
           cty, 
           shape = class)) + 
    geom_point()

ggplot(mpg, 
       aes(displ, 
           cty, 
           size = class)) + 
    geom_point()

ggplot(mpg, 
       aes(displ, 
           cty, 
           size = class)) + 
    geom_point()

mpg |> 
    dplyr::mutate(compact = ifelse(class == 'compact', 
                                   'compact', 'outros')) ->
    a

a |> dplyr::glimpse() 

ggplot(a, aes(x = displ,  
              y = cty, 
              shape = compact)) +
    geom_point()

ggplot(a, aes(x = displ,  
              y = cty, 
              color = class,
              shape = drv)) +
    geom_point() +
    geom_line()

mpg |> dplyr::glimpse() 

## Facetting
# Facetting creates tables of graphics by splitting the data into subsets and displaying 
  # the same graph for each subset.

ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    facet_wrap(~drv)

ggplot(a, aes(x = displ,  
              y = cty, 
              color = class,
              shape = drv)) +
    geom_point() +
    facet_wrap(~cyl)

## Plot Geoms
# most commonly used plot types

## geom_smooth()
ggplot(mpg, aes(displ, hwy)) + 
    geom_point() +
    geom_smooth()

# This overlays the scatterplot with a smooth curve, including an assessment of uncertainty in 
 # the form of point-wise confidence intervals shown in grey.
# If you’re not interested in the confidence interval, turn it off 
ggplot(mpg, aes(displ, hwy)) + 
    geom_point() +
    geom_smooth(se = FALSE)

?loess
# The wiggliness of the line is controlled by the span parameter, which ranges from 0 
 # (exceedingly wiggly) to 1 (not so wiggly)
ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    geom_smooth(span = 0.2)

ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    geom_smooth(span = 1)

# linear regression 
ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    geom_smooth(method = "lm")


## geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + 
    geom_point()

#  Jittering, geom jitter(), adds a little random noise to the data which can help avoid overplotting.
ggplot(mpg, aes(drv, hwy)) + 
    geom_jitter() 

# • Boxplots, geom boxplot(), summarise the shape of the distribution with a handful of summary statistics.
ggplot(mpg, aes(drv, hwy)) + 
    geom_boxplot() 

# • Violin plots, geom violin(), show a compact representation of the “density” of the distribution,
    # highlighting the areas where more points are found.
ggplot(mpg, aes(drv, hwy)) + 
    geom_violin()


## geom_histogram() and geom_freqpoly()
# Histograms and frequency polygons show the distribution of a single numeric variable. They provide more information about the distribution of a single group than boxplots do, at the expense of needing more space.
ggplot(mpg, aes(hwy)) + 
    geom_histogram()

ggplot(mpg, aes(hwy)) + 
    geom_freqpoly()

mpg |>
    ggplot(aes(hwy)) + 
    geom_freqpoly()

# To compare the distributions of different subgroups, you can map a categorical variable to either fill (for geom histogram()) or colour (for geom freqpoly())
ggplot(mpg, aes(displ, colour = drv)) +
    geom_freqpoly(binwidth = 0.5)

base = ggplot(mpg, aes(displ, fill = drv)) + 
    geom_histogram(binwidth = 0.5) + 
    facet_wrap(~drv, ncol = 1) +
    theme_classic()

base +  
    labs(title = "This is a ggplot") +
    theme(plot.title = element_text(face = "bold", colour = "red", hjust = 0.5))


## geom_bar()
ggplot(mpg, aes(manufacturer)) + 
    geom_bar()
# You’ll learn how to fix the labels in the future

## geom_line()
# Because the year variable in the mpg dataset only has two values, we’ll show some time series plots using the economics dataset, which contains economic data on the US measured over the last 40 years.
economics

# unemployment rate 
ggplot(economics, aes(date, unemploy / pop)) + 
    geom_line()

# median number of weeks unemployed
ggplot(economics, aes(date, uempmed)) + 
    geom_line()

# Below we plot unemployment rate vs. length of unemployment and join the individual observations with a path. Because of the many line crossings, the direction in which time flows isn’t easy to see in the first plot. In the second plot, we colour the points to make it easier to see the direction of time.
ggplot(economics, aes(unemploy / pop, uempmed)) + 
    geom_path() +
    geom_point()

year <- function(x) as.POSIXlt(x)$year + 1900 
year('1967-08-01')

# We can see that unemployment rate and length of unemployment are highly correlated, but in recent years the length of unemployment has been increasing relative to the unemployment rate.
ggplot(economics, aes(unemploy / pop, uempmed)) +
    geom_path(colour = "grey50") + 
    geom_point(aes(colour = year(date)))

economics |> glimpse()

## Modifying the Axes
ggplot(mpg, aes(cty, hwy)) + 
    geom_point(alpha = 1 / 3)

ggplot(mpg, aes(cty, hwy)) + 
    geom_point(alpha = 1 / 3) + 
    xlab("city driving (mpg)") + 
    ylab("highway driving (mpg)")

# Remove the axis labels with NULL
ggplot(mpg, aes(cty, hwy)) + 
    geom_point(alpha = 1 / 3) + 
    xlab(NULL) + 
    ylab(NULL)


# xlim() and ylim() modify the limits of axes:
ggplot(mpg, aes(drv, hwy)) +
    geom_jitter(width = 0.25)

ggplot(mpg, aes(drv, hwy)) + 
    geom_jitter(width = 0.25) + 
    xlim("f", "r") +
    ylim(20, 30)

# For continuous scales, use NA to set only one limit
ggplot(mpg, aes(drv, hwy)) + 
    geom_jitter(width = 0.25, na.rm = TRUE) + 
    ylim(NA, 30)


## Output
# Most of the time you create a plot object and immediately plot it, but you can also save a plot to a variable and manipulate it

p <- ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) + 
    geom_point()
print(p)

# Save png to disk
ggsave("images/plot.png", width = 5, height = 5)

# Briefly describe its structure with summary()
summary(p)

# Save a cached copy of it to disk, with saveRDS(). This saves a complete copy of the plot object, so you can easily re-create it with readRDS()
saveRDS(p, "rawfiles/plot.rds")
q <- readRDS("rawfiles/plot.rds")


# ------------------------------
## Toolbox
# These geoms are the fundamental building blocks of ggplot2. They are useful in their own right, but are also used to construct more complex geoms. Most of these geoms are associated with a named plot: when that geom is used by itself in a plot, that plot has a special name.

df <- data.frame(
                 x = c(3, 1, 5),
                 y = c(2, 4, 6),
                 label = c("a", "b", "c")
                 )

p <- ggplot(df, aes(x, y, label = label)) +
    labs(x = NULL, y = NULL) + # Hide axis label
    theme(plot.title = element_text(size = 12)) # Shrink plot title p + geom_point() + ggtitle("point")

p + geom_text() + ggtitle("título do meu gráfico")
p + geom_bar(stat = "identity") + ggtitle("bar")
p + geom_tile() + ggtitle("raster")
p + geom_line() + ggtitle("line")
p + geom_area() + ggtitle("area")
p + geom_path() + ggtitle("path")
p + geom_polygon() + ggtitle("polygon")


# • family gives the name of a font. There are only three fonts that are guar- anteed to work everywhere: “sans” (the default), “serif”, or “mono”:
df <- data.frame(x = 1, y = 3:1, family = c("sans", "serif", "mono")) 

ggplot(df, aes(x, y)) + 
    geom_text(aes(label = family, family = family))

# • fontface specifies the face: “plain” (the default), “bold” or “italic”.
df <- data.frame(x = 1, y = 3:1, face = c("plain", "bold", "italic")) 

ggplot(df, aes(x, y)) +
    geom_text(aes(label = face, fontface = face))

# • You can adjust the alignment of the text with the hjust (“left”, “center”, “right”, “inward”, “outward”) and vjust (“bottom”, “middle”, “top”, “in- ward”, “outward”) aesthetics. The default alignment is centered. One of the most useful alignments is “inward”: it aligns text towards the middle of the plot:
df <- data.frame(
                 x = c(1, 1, 2, 2, 1.5), 
                 y = c(1, 2, 1, 2, 1.5), 
                 text = c(
                          "bottom-left", "bottom-right",
                          "top-left", "top-right", "center" )
                 )
ggplot(df, aes(x, y)) +
    geom_text(aes(label = text)) 

ggplot(df, aes(x, y)) +
    geom_text(aes(label = text), vjust = "inward", hjust = "inward")

# • Often you want to label existing points on the plot. You don’t want the text to overlap with the points (or bars etc), so it’s useful to offset the text a little. The nudge x and nudge y parameters allow you to nudge the text a little horizontally or vertically:
df <- data.frame(trt = c("a", "b", "c"), resp = c(2.2, 3.4, 2.5)) 

# (Note that I manually tweaked the x-axis limits to make sure all the text fit on the plot.)
ggplot(df, aes(resp, trt)) +
    geom_point() +
    geom_text(aes(label = paste0("(", resp, ")")), nudge_y = -0.25) + xlim(1, 3.6)

# • If check overlap = TRUE, overlapping labels will be automatically removed. The algorithm is simple: labels are plotted in the order they appear in the data frame; if a label would overlap with an existing point, it’s omitted. This is not incredibly useful, but can be handy.
ggplot(mpg, aes(displ, hwy)) + 
    geom_text(aes(label = model)) + 
    xlim(1, 8)

ggplot(mpg, aes(displ, hwy)) +
    geom_text(aes(label = model), check_overlap = TRUE) + 
    xlim(1, 8)

ggplot(mpg, aes(displ, hwy, colour = class)) + 
    geom_point()

# need install the package directlabels
# install.packages("directlabels")
library(directlabels)

ggplot(mpg, aes(displ, hwy, colour = class)) + 
    geom_point(show.legend = FALSE) + 
    directlabels::geom_dl(aes(label = class), method = "smart.grid")


## Multiple Groups, One Aesthetic
# load new data
data(Oxboys, package = "nlme")

ggplot(Oxboys, aes(age, height, group = Subject)) + 
    geom_point() +
    geom_line()


## Different Groups on Different Layers
ggplot(Oxboys, aes(Occasion, height)) + 
    geom_boxplot() +
    geom_line(colour = "#3366FF", alpha = 0.5)


## Matching Aesthetics to Graphic Objects
ggplot(mpg, aes(class)) + 
    geom_bar()

ggplot(mpg, aes(class, fill = drv)) + 
    geom_bar()


## Displaying Distributions
# new data
?diamonds

ggplot(diamonds, aes(depth)) + 
    geom_histogram()

ggplot(diamonds, aes(depth)) +
    geom_histogram(binwidth = 0.1) +
    xlim(55, 70)

# difference between groups
ggplot(diamonds, aes(depth)) +
    geom_freqpoly(aes(colour = cut), binwidth = 0.1, na.rm = TRUE) + xlim(58, 68) +
    theme(legend.position = "none")

ggplot(diamonds, aes(depth)) +
    geom_histogram(aes(fill = cut), binwidth = 0.1, position = "fill", na.rm = TRUE) +
    xlim(58, 68) 

ggplot(diamonds, aes(depth, fill = cut, colour = cut)) + 
    geom_density(alpha = 0.2, na.rm = TRUE) +
    xlim(58, 68) 

## Dealing with Overplotting
df <- data.frame(x = rnorm(2000), y = rnorm(2000))
norm <- ggplot(df, aes(x, y)) + 
    xlab(NULL) + 
    ylab(NULL) 

# Very small amounts of overplotting can sometimes be alleviated by making the points smaller, or using hollow glyphs. The following code shows some options for 2000 points sampled from a bivariate normal distribution.
norm + geom_point()
norm + geom_point(shape = 1) # Hollow circles
norm + geom_point(shape = ".") # Pixel sized

# For larger datasets with more overplotting, you can use alpha blending (transparency) to make the points transparent. If you specify alpha as a ratio, the denominator gives the number of points that must be overplotted to give a solid colour.
norm + geom_point(alpha = 1 / 3) 
norm + geom_point(alpha = 1 / 5) 
norm + geom_point(alpha = 1 / 10)
