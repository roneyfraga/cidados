# ------------------------------------------------------------
# 
# File Name: cidados_aula03.R
#
# Purpose: Ciência de Dados para Economistas - Faculdade de Economia UFMT
# 
# Creation Date: 2020-11-02
# Last Modified: 2022-09-08_13:25
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


# Structure
# Part 1: tibble and pipe 
# Part 2: dplyr basic
# Part 3: tidyr basic
# Part 4: dplyr advanced
# Part 5: tidyr advanced


# ------------------------------
## Preparing the home

#install.packages(c('tibble','dplyr','magrittr','pipeR'))
library(tibble)
library(dplyr)
library(tidyr) 
library(magrittr)
library(pipeR)
library(nycflights13)

# or to load all tidyverse family  
# install.packages('tidyverse')
# library(tidyverse)


# ------------------------------
## tibble and pipe
#
# https://tibble.tidyverse.org/index.html

?starwars
# Description: Starwars characters
# A tibble with 87 rows and 13 variables:
# name: Name of the character
# height: Height (cm)
# mass: Weight (kg)
# hair_color,skin_color,eye_color: Hair, skin, and eye colors
# birth_year: Year born (BBY = Before Battle of Yavin)
# gender: male, female, hermaphrodite, or none.
# homeworld: Name of homeworld
# species: Name of species
# films: List of films the character appeared in
# vehicles: List of vehicles the character has piloted
# starships: List of starships the character has piloted
 
data(starwars)
starwars
class(starwars)

# é possível transformar um data frame em tibble
data(mtcars)
mtcars
tibble::as_tibble(mtcars)

mtcars_tbl <- as_tibble(mtcars)
class(mtcars_tbl)
class(mtcars)
mtcars_tbl[1:3, ]

# criar um tibble
tibble(x = 1:5, y = 1, z = x ^ 2 + y)

tribble(
  ~x, ~y,  ~z,
  "a", 2,  3.6,
  "b", 1,  8.5
)

# trabalhando com muitos dados
flights
dplyr::glimpse(flights)
print(flights, n = 20)
# print(flights, n = Inf)

flights_df <- as.data.frame(flights)
dim(flights_df)
names(flights_df)
head(flights_df)
head(flights_df, 8)
flights_df

# ------------------------------
## magrittr pipe %>% and base-R pipe |>

# traditional code
# fácil para ler, mas demorado para escrever
sample_mtcars <- sample(mtcars$mpg, 10000, replace = TRUE)
density_mtcars <- density(sample_mtcars, kernel = "gaussian")
plot(density_mtcars, col = "red", main = "density of mpg (bootstrap)")

# traditional code, compact version
# fácil para escrever e difícil para ler
plot(density(sample(mtcars$mpg, size = 10000, replace = TRUE), kernel = "gaussian"), col = "red", main = "density of mpg (bootstrap)")

# steps:
# 1 Resample from mtcars$mpg
# 2 Perform a kernel estimation of its distribution
# 3 Plot the estimated density function

# pipe (magrittr) style
mtcars$mpg %>%
  sample(size = 10000, replace = TRUE) %>%
  density(kernel = "gaussian") %>%
  plot(col = "red", main = "density of mpg (bootstrap)")

# pipe (base-R) style
mtcars$mpg |>
  sample(size = 10000, replace = TRUE) |>
  density(kernel = "gaussian") |>
  plot(col = "red", main = "density of mpg (bootstrap)")

# tradicional
mean(mtcars$mpg)

# pipe
mtcars$mpg |>
    mean()

mtcars$mpg |> 
    mean() |> 
    log()

log(mean(mtcars$mpg))

# forma fácil de escrever e difícil de ler
sqrt(mean(1:30))

# forma pipe
1:30 |> mean() |> sqrt()
c(1:30, 40) |> mean() |> sqrt()


# ------------------------------
# Part 2: dplyr basic

# Introduction to dplyr
# https://dplyr.tidyverse.org/articles/dplyr.html

# ----------
# dplyr             
#
# Single table verbs
# dplyr aims to provide a function for each basic verb of data manipulation. These verbs can be organised into three categories based on the component of the dataset that they work with:
# 
# Rows:
#   filter() chooses rows based on column values.
#   slice() chooses rows based on location.
#   arrange() changes the order of the rows.
#
# Columns:
#   select() changes whether or not a column is included.
#   rename() changes the name of columns.
#   mutate() changes the values of columns and creates new columns.
#   relocate() changes the order of the columns.
#
# Groups of rows:
#   summarise() collapses a group into a single row.


# ---
# dica 1
# snippets no rstudio
# copiar o arquivo snippets em:
#
# https://github.com/roneyfraga/vim-snippets/blob/master/snippets/r.snippets
#
# e colar no RStudio em 
# Glocal Option -> Code -> R
# agora basta pressionar o atalho e Tab


# ------------------------------
## Preparing the home

# loading packages
library(tibble)
library(dplyr)
library(nycflights13)   # apenas para carregar dados para exemplos

# load example data
data(starwars)      # dplyr example

?starwars
# Description: Starwars characters
# A tibble with 87 rows and 13 variables:
# name: Name of the character
# height: Height (cm)
# mass: Weight (kg)
# hair_color,skin_color,eye_color: Hair, skin, and eye colors
# birth_year: Year born (BBY = Before Battle of Yavin)
# gender: male, female, hermaphrodite, or none.
# homeworld: Name of homeworld
# species: Name of species
# films: List of films the character appeared in
# vehicles: List of vehicles the character has piloted
# starships: List of starships the character has piloted

# ------------------------------
## filter: select lines

glimpse(starwars)
dplyr::glimpse(starwars)

class(starwars)

# r-base
starwars[starwars$skin_color == "light" & starwars$eye_color == "brown", ]

# filter without pipe 
dplyr::filter(starwars, skin_color == "light", eye_color == "brown")

# dplyr with pipe 
starwars |> dplyr::filter(skin_color == "light", eye_color == "brown")

# better indentation
starwars |> 
    dplyr::filter(skin_color == "light", eye_color == "brown") 

starwars |> 
    dplyr::filter(skin_color == "light", eye_color == "brown") |>
    dplyr::select(name, height, mass, skin_color, eye_color) |>
    dplyr::rename(peso = mass) |>
    dplyr::mutate(altura_metros = height / 100) 

# forma Roney
starwars |> 
    dplyr::filter(skin_color == "light", eye_color == "brown") |>
    dplyr::select(name, height, mass, skin_color, eye_color) |>
    dplyr::rename(peso = mass) |>
    dplyr::mutate(altura_metros = height / 100) ->
    nova_tabela1

# mesmo resultado
a = 1
a <- 1
1 -> a

nova_tabela2 <-
        starwars |> 
    dplyr::filter(skin_color == "light", eye_color == "brown") |>
    dplyr::select(name, height, mass, skin_color, eye_color) |>
    dplyr::rename(peso = mass) |>
    dplyr::mutate(altura_metros = height / 100) 


# ------------------------------
## arrange: reorder rows

starwars |> arrange(height, mass)

starwars |> 
    arrange(height, mass) |> 
    select(name, height, mass)

starwars |> 
    arrange(desc(height), mass) |> 
    select(name, height, mass)

starwars |> 
    dplyr::arrange(dplyr::desc(height), mass) |> 
    dplyr::select(name, height, mass) ->
    st

st
print(st, n = 20)
st |> print(n = 20)
st |> print(n = Inf)


# ------------------------------
## slice: choose rows

slice(starwars, 5:10)

starwars |> slice(5:10)

# head
starwars |> slice_head(n = 3)
starwars |> slice_head(n = 10) 

head(starwars, 3)

# tail
starwars |> slice_tail(n = 3)

# randomly selects rows
starwars |>  
    slice_sample(n = 5) |>  
    select(name, species, homeworld)

# randomly selects 12% of the rows
starwars |>  
    slice_sample(prop = 0.12) |>  
    select(name, species, homeworld)

starwars |>  
    slice_sample(prop = 0.05) |>  
    select(name, species, homeworld)

?slice_sample

# slice_min() and slice_max() select rows with highest or lowest values of a variable. Note that we first must choose only the values which are not NA.
starwars |> 
    dplyr::filter(!is.na(height)) |> 
    slice_max(height, n = 3) |>  
    select(name, species, homeworld, height)

# ------------------------------
## select: select columns

starwars |> glimpse()
names(starwars)

starwars |> select(hair_color, skin_color, eye_color)

starwars |> select(hair_color:eye_color)
starwars |> select(hair_color:gender)

starwars |> select(!(hair_color:eye_color))

starwars |> select(ends_with("color"))

# existem caminhos sólidos no base-R, contudo dplyr é mais conveniente
# utilizando expressões regulares (regex)
a <- grep('color$', names(starwars))
starwars |> select(a)

starwars |> select(!(ends_with("color")))

starwars |> select(contains("color"))

starwars |> 
    select(contains("color"), everything()) ->
    st2

starwars |> 
    select(contains("color"), everything()) |> 
    glimpse()

# select works great with: starts_with(), ends_with(), matches(), contains(), everything()

# select and rename: select() drops all the variables not explicitly mentioned
starwars |>     
    select(home_world = homeworld)

# rename keeps all variables 
starwars |> 
    dplyr::rename(home_world = homeworld) |> 
    dplyr::glimpse()

starwars |> 
    dplyr::rename(personagem = name, altura = height) |> 
    dplyr::glimpse()

# ------------------------------
## mutate: add new columns

mutate(starwars, height_m = height / 100)

starwars |> 
    dplyr::mutate(height = height / 100) |>
    dplyr::select(name, height) 

starwars |>
    mutate(height_m = height / 100) |>
    select(name, height_m, height, everything())

starwars |>
    mutate(height_m = height / 100) |>
    select(name, height_m, height, everything()) |> 
    glimpse()

# mutate allows you to refer to columns that you’ve just created
starwars |>
    mutate(
           height_m = height / 100,
           BMI = mass / (height_m^2)
           ) |>
    select(name, height_m, BMI) |>
    slice_max(BMI, n = 10)

# If you only want to keep the new variables, use transmute():
starwars |>
    transmute(
              height_m = height / 100,
              BMI = mass / (height_m^2)
    )

starwars |>
    transmute(height_m = height / 100, BMI = mass / (height_m^2)) 

# ------------------------------
## relocate: change column order

starwars |> glimpse()

starwars |> 
    relocate(sex:homeworld, .before = height) 

starwars |> 
    relocate(sex:homeworld, .before = height) |> 
    glimpse()

starwars |> 
    relocate(sex:homeworld, .after = height) |> 
    glimpse()

starwars |> 
    relocate(ends_with('color'), .before = name) |>
    glimpse()

starwars |> 
    relocate(contains('color'), .after = name) |>
    glimpse()

starwars |> 
    relocate(contains('color')) ->
    starwars

starwars |> glimpse()


# ------------------------------
## summarise: summarise values 

# It collapses a data frame to a single row.
starwars |> 
    summarise(height = mean(height, na.rm = TRUE))

# R-base way
mean(starwars$height, na.rm = T)

# It’s not that useful until we learn the group_by() verb.
starwars |> 
    mutate(height_m = height / 100) |> 
    group_by(sex) |> 
    summarise(height_mean = mean(height_m, na.rm = TRUE),
              height_max = max(height_m, na.rm = TRUE),
              height_min = min(height_m, na.rm = TRUE),
              n = n())

starwars |> count(sex)

# mean
aggregate(starwars$height, list(sex = starwars$sex), mean, na.rm = T)

# max
aggregate(starwars$height, list(sex = starwars$sex), max, na.rm = T)

# applying filter before group_by
starwars |> 
    dplyr::filter(!is.na(height)) |> 
    dplyr::filter(!is.na(sex)) |> 
    mutate(height_m = height / 100) |> 
    group_by(sex) |> 
    summarise(height_mean = mean(height_m),
              height_max = max(height_m),
              height_min = min(height_m),
              group_size = n()) |> 
    arrange(desc(height_mean))

# group_by only does nothing
starwars |> group_by(sex)  



# ------------------------------
## Grouped data
#
# https://dplyr.tidyverse.org/articles/grouping.html

# group_by(): it takes a data frame and one or more variables to group by:
by_species <- starwars |> group_by(species)

table(starwars$species)
cbind(table(starwars$species))
starwars |> count(species, sort = T)

starwars |> 
    group_by(species) |>
    summarise(height_mean = mean(height, na.rm = T)) ->
    tt

#-----------
# off-topic: import and export 

write.csv(tt, file = 'rawfiles/tt.csv')
write.csv2(tt, file = 'rawfiles/tt2.csv', row.names = F)
write.table(tt, file = 'rawfiles/tt3.txt', sep = '|', quote = F, row.names = F)

rio::export(tt, file = 'rawfiles/tt4.xlsx')
rio::export(tt, file = 'rawfiles/tt4.dta')
rio::export(tt, file = 'rawfiles/tt4.csv')
rio::export(tt, file = 'rawfiles/tt4.txt')
rio::export(tt, file = 'rawfiles/tt4.txt')
readr::write_csv(tt, 'rawfiles/tt4.txt')

tt = rio::import('rawfiles/tt4.xlsx')  
tt <- rio::import('rawfiles/tt4.xlsx')  

rio::import('tt4.xlsx')  |>
    tibble::as_tibble() ->
    tt
# off-topic: import and export 
#-----------

sum(starwars$height, na.rm = T)
summary(starwars$height, na.rm = T)

starwars |> 
    group_by(species) -> 
    by_species

starwars |> 
    group_by(sex,gender) -> 
    by_sex_gender

# use tally() to count the number of rows in each group
by_species |> tally()
by_species |> tally(sort = T)

by_sex_gender |> tally(sort = TRUE)

starwars |> 
    group_by(sex, gender) |> 
    tally(sort = T)   

starwars |> 
   group_by(sex, gender) |> 
   summarise(height_mean = mean(height, na.rm = T), 
             height_max = max(height, na.rm = T),
             height_min = min(height, na.rm = T),
              n = n()) ->

# As well as grouping by existing variables, you can group by any function of existing variables. This is equivalent to performing a mutate() before the group_by():
bmi_breaks <- c(0, 18.5, 25, 30, Inf)

starwars |>
    select(name, mass, height) |>
    mutate(bmi_cat = mass / (height / 100)^2)  |> 
    mutate(bmi_cat_cut = cut(bmi_cat, breaks = bmi_breaks))  |> 
    group_by(bmi_cat_cut) |> 
    summarise(total = n(), 
              bmi_medio = mean(bmi_cat, na.rm = T), 
              bmi_max = max(bmi_cat, na.rm = T))

starwars |>
    select(name, mass, height) |>
    mutate(bmi_cat = cut(mass / (height / 100)^2, breaks = bmi_breaks)) |>  
    group_by(bmi_cat) |> 
    tally()

starwars |>
    select(name, mass, height) |>
    mutate(bmi_cat = cut(mass / (height / 100)^2, breaks = c(0, 10, 40, Inf))) |>  
    group_by(bmi_cat) |> 
    tally()

starwars |>
  group_by(bmi_cat = cut(mass / (height / 100)^2, breaks = bmi_breaks)) |>  
  tally()

# group_keys: it has one row for each group and one column for each grouping variable:
starwars |> 
    group_by(species) |> 
    group_keys()

starwars |> 
    group_by(species) |> 
    group_keys() |> 
    print(n = 30)

starwars |> 
    group_by(species) |> 
    group_keys() |> 
    pull(species)

starwars |> 
    group_by(sex,gender) |> 
    group_keys()

# group_indices: you can see which group each row belongs
starwars |> 
    group_by(species) |> 
    group_indices()

# group_vars: if you just want the names of the grouping variables
starwars |> 
    group_by(sex,gender) |> 
    group_vars()

# ungroup:  removing groups
starwars |> 
    group_by(sex, gender) |> 
    summarise(n = n())  |>
    arrange(desc(n))

starwars |> 
    group_by(sex, gender) |>    
    tally(sort = TRUE) ->
    sw

sw |> ungroup(sex,gender)

# summarise 
starwars |> 
    group_by(species) |> 
    summarise(qtde = n(), height = mean(height, na.rm = TRUE))

# select(), rename(), and relocate() after group_by keeps groups nme
starwars |> 
    group_by(species) |> 
    select(mass)

# ungroup to exit group_by 
starwars |> 
    group_by(species) |> 
    ungroup(species) |> 
    select(mass)

# slice in groups: we can select the first observation within each species
starwars |> 
    group_by(species) |> 
    relocate(species) |> 
    slice(1)

# select top 2 lines of each group
starwars |> 
    group_by(species) |> 
    slice(1:2) |> 
    select(species, name, homeworld) |> 
    print(n = 30)

# slice_min: to select the smallest n values of a variable
starwars |> 
    group_by(species) |> 
    dplyr::filter(!is.na(height)) |> 
    slice_min(height, n = 2) |> 
    select(height, name, species, homeworld) |> 
    print(n = 30)

# cur_group_id
starwars |> 
    group_by(species) |> 
    arrange(species) |> 
    select(name, species, homeworld) |> 
    mutate(id = cur_group_id())


# ------------------------------
## Two-table verbs
#
# Wickham and Grolemund (2016) R for data science
# CHAPTER 10 Relational Data with dplyr
#
# https://dplyr.tidyverse.org/articles/two-table.html
# https://bookdown.org/roy_schumacher/r4ds/relational-data.html

library(nycflights13)

data(flights)           # nycflights13 example
data(airlines)          # nycflights13 example
data(weather)           # nycflights13 example
data(planes)            # nycflights13 example
data(airports)          # nycflights13 example

flights

# Drop unimportant variables so it's easier to understand the join results
flights |> 
    select(year:day, hour, origin, dest, tailnum, carrier) -> 
    flights2

airlines |> print(n = Inf)

names(airlines);names(flights2)

merge(flights2, airlines) |> 
    as_tibble() -> 
    a

# results
left_join(flights2, airlines)

flights2 |> 
    left_join(airlines) 

flights2 |> 
    left_join(weather) -> 
    a

left_join(flights2, weather)

flights2 |> left_join(weather) |> glimpse()

flights2 |> left_join(planes, by = "tailnum")
flights2 |> left_join(planes, by = "tailnum") |> glimpse()

flights2 |> left_join(airports, c("dest" = "faa"))
flights2 |> left_join(airports, c("dest" = "faa")) |> glimpse()

# Types of join
# 
df1 <- tibble(x = c(1, 2), y = 2:1)
df2 <- tibble(x = c(3, 1), a = 10, b = "a")

df1 |> left_join(df2)
df1 |> right_join(df2)
df1 |> inner_join(df2)
df1 |> full_join(df2)

df1 <- tibble(x = c(1, 2, 3, 3, 4), y = 1)
df2 <- tibble(x = c(1, 3, 3), a = c(10, 20, 30), b = c('a', 'b', 'c'))

df1 |> left_join(df2)
df1 |> right_join(df2)
df1 |> inner_join(df2)
df1 |> full_join(df2)

df1 |>
    distinct(.keep_all = TRUE) |>
    left_join(df2) 

flights2 |> count(carrier)
    
flights2 |> 
    group_by(carrier) |> 
    tally(sort = T)

flights2 |> 
    left_join(airlines) |>     
    group_by(name, month) |> 
    summarise(qtde = n()) |> 
    arrange(month, desc(qtde))



# ------------------------------
# Part 3: tidyr basic

# Livro PDF
# Wickham and Grolemund (2016) R for data science
# CHAPTER 9 Tidy Data with tidyr

# Livro digital
# CHAPTER 12 Tidy Data 
# https://bookdown.org/roy_schumacher/r4ds/tidy-data.html

# The goal of tidyr is to help you create tidy data. Tidy data is data where:

#     Every column is variable.
#     Every row is an observation.
#     Every cell is a single value.

# Each dataset shows the same values of four variables, country,
# year, population, and cases (tuberculosis), but each dataset organizes the values in a
# different way

table1 # only tidy
table2
table3
table4a
table4b

## pivot_longer(), antigo gather()

table4a

table4a |> 
  gather(`1999`, `2000`, key = "year", value = "cases")

# nova nomeclatura
table4a |> 
    pivot_longer(c(`1999`, `2000`), 
                 names_to = "year", 
                 values_to = "cases") ->
        t4a
    

table4b |> 
    pivot_longer(c(`1999`, `2000`), 
                 names_to = "year", 
                 values_to = "population") ->
    t4b

dplyr::left_join(t4a, t4b) 


## pivot_wider(), antigo spreading()

table2

spread(table2, key = type, value = count)

table2 |>
    pivot_wider(names_from = 'type', 
                values_from = 'count')

## separate 
# pulls apart one column into multiple columns, by splitting wherever a separator character appears

table3 |> 
    separate(rate, into = c("cases", "population"))

table3 |> 
    separate(rate, into = c("cases", "population"), sep = "/")

table3 |> 
    separate(rate, into = c("cases", "population"), sep = "/", convert = T)

table3 |> 
    separate(year, into = c("century", "year"), sep = 2)

## separate_rows

table3

table3 |> 
    separate_rows(rate, sep = "/")

separate_rows(table3, rate, sep = "/")

## unite
# it combines multiple columns into a single column

table5 |> 
    unite(new, century, year)

table5 |> 
    unite(new, century, year, sep = '') |>
    dplyr::mutate(new = as.numeric(new)) 

## missing values

# Surprisingly, a value can be missing in one of two possible ways:
#     Explicitly, i.e. flagged with NA.
#     Implicitly, i.e. simply not present in the data.

stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

stocks
# There are two missing values in this dataset:
#     The return for the fourth quarter of 2015 is explicitly missing, because the cell where its value should be instead contains NA.
#     The return for the first quarter of 2016 is implicitly missing, because it simply does not appear in the dataset.

stocks |> 
  complete(year, qtr)

# fill()
# It takes a set of columns where you want missing values to be replaced by the most recent 
# non-missing value (sometimes called last observation carried forward)
reatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)

reatment

reatment |> 
    fill(person)

# replace_na()
# Replace NAs with specified values

df <- tibble(x = c(1, 2, NA), y = c("a", NA, "b"))

df |> 
    replace_na(list(x = 0, y = "unknown"))

df |> 
    dplyr::mutate(x = replace_na(x, 0))

df |> 
    dplyr::mutate(x = replace_na(x, 0), 
                  y2 = replace_na(y, 'unknown'))

# drop_na()
# Drop rows containing missing values

df |> drop_na()
df |> drop_na(x)

vars <- "y"
df |> drop_na(x, any_of(vars))

vars2 <- c("y",'d')
df |> drop_na(x, any_of(vars2))

## estudo de caso
# The tidyr::who dataset contains tuberculosis (TB) cases broken down by year, 
# country, age, gender, and diagnosis method. The data comes from the 2014 
# World Health Organization Global Tuberculosis Report, available at http://www.who.int/tb/country/data/download/en
who

who |>
    pivot_longer(new_sp_m014:newrel_f65, 
                 names_to = 'code', 
                 values_to = 'value', 
                 values_drop_na = T) |> 
    mutate(code = stringr::str_replace(code, "newrel", "new_rel")) |>
    separate(code, c("new", "var", "sexage")) |>
    # select(-new, -iso2, -iso3) |>
    separate(sexage, c("sex", "age"), sep = 1)



# ------------------------------
# Part 4: dplyr advanced

# across()
# case_when()
# rowwise()

# --------
## across()
iris |>
    tibble::as_tibble() ->
    iris_tbl

# duas variáveis específicas
iris_tbl |> 
    mutate(across(c(Sepal.Length, Sepal.Width), round))

# variáveis por posição
iris_tbl |>
    mutate(across(c(1, 2), round))

# intervalor misto
iris_tbl |>
    mutate(across(1:Sepal.Width, round))

iris_tbl |>
    mutate(across(where(is.double) & !c(Petal.Length, Petal.Width), round))

# A purrr-style formula
iris_tbl |>
    group_by(Species) |>
    summarise(across(starts_with("Sepal"), ~ mean(.x, na.rm = TRUE)))

# A named list of functions
iris_tbl |>
    group_by(Species) |>
    summarise(across(starts_with("Sepal"), list(mean = mean, sd = sd)))

# Use the .names argument to control the output names
iris_tbl |>
    group_by(Species) |>
    summarise(across(starts_with("Sepal"), mean, .names = "mean_{.col}"))

iris_tbl |>
    group_by(Species) |>
    summarise(across(starts_with("Sepal"), list(mean = mean, sd = sd), .names = "{.col}.{.fn}"))

# When the list is not named, .fn is replaced by the function's position
iris_tbl |>
    group_by(Species) |>
    summarise(across(starts_with("Sepal"), list(mean, sd), .names = "{.col}.fn{.fn}"))

iris_tbl |>
    group_by(Species) |>
    summarise(across(starts_with("Sepal"), list(mean, sd), .names = "nova_var_{.col}_{.fn}"))

# across() returns a data frame, which can be used as input of another function
df <- data.frame(
                 x1  = c(1, 2, NA), 
                 x2  = c(4, NA, 6), 
                 y   = c("a", "b", "c"))

df |>
    mutate(x_complete = complete.cases(across(starts_with("x"))))

df |>
    filter(complete.cases(across(starts_with("x"))))

# if_any() and if_all() 
iris_tbl |>
    filter(if_any(ends_with("Width"), ~ . > 4))

iris_tbl |>
    filter(if_all(ends_with("Width"), ~ . > 2))

# --------
# case_when()

x <- 1:50

4 %% 2
5 %% 2
10 %% 3
11 %% 3
12 %% 3

case_when(
    x %% 35 == 0 ~ "fizz buzz",
    x %% 5 == 0 ~ "fizz",
    x %% 7 == 0 ~ "buzz",
    TRUE ~ as.character(x)
)

# Like an if statement, the arguments are evaluated in order, so you must
# proceed from the most specific to the most general. This won't work:
case_when(
    TRUE ~ as.character(x),
    x %%  5 == 0 ~ "fizz",
    x %%  7 == 0 ~ "buzz",
    x %% 35 == 0 ~ "fizz buzz"
)

# If none of the cases match, NA is used:
case_when(
    x %%  5 == 0 ~ "fizz",
    x %%  7 == 0 ~ "buzz",
    x %% 35 == 0 ~ "fizz buzz"
)

# Note that NA values in the vector x do not get special treatment. If you want
# to explicitly handle NA values you can use the `is.na` function:
x[2:4] <- NA_real_

case_when(
    x %% 35 == 0 ~ "fizz buzz",
    x %% 5 == 0 ~ "fizz",
    x %% 7 == 0 ~ "buzz",
    is.na(x) ~ "nope",
    TRUE ~ as.character(x)
)

# All RHS values need to be of the same type. Inconsistent types will throw an error.
# This applies also to NA values used in RHS: NA is logical, use
# typed values like NA_real_, NA_complex, NA_character_, NA_integer_ as appropriate.
case_when(
    x %% 35 == 0 ~ NA_character_,
    x %% 5 == 0 ~ "fizz",
    x %% 7 == 0 ~ "buzz",
    TRUE ~ as.character(x)
)
case_when(
    x %% 35 == 0 ~ 35,
    x %% 5 == 0 ~ 5,
    x %% 7 == 0 ~ 7,
    TRUE ~ NA_real_
)

# case_when() evaluates all RHS expressions, and then constructs its
# result by extracting the selected (via the LHS expressions) parts.
# In particular NaNs are produced in this case:
y <- seq(-2, 2, by = .5)

case_when(
    y >= 0 ~ sqrt(y),
    TRUE   ~ y
)

# This throws an error as NA is logical not numeric
try(case_when(
    x %% 35 == 0 ~ 35,
    x %% 5 == 0 ~ 5,
    x %% 7 == 0 ~ 7,
TRUE ~ NA
))

# case_when is particularly useful inside mutate when you want to
# create a new variable that relies on a complex combination of existing
# variables
starwars |>
    select(name:mass, gender, species) |>
    mutate(
      type = case_when(
        height > 200 | mass > 200 ~ "large",
        species == "Droid"        ~ "robot",
        TRUE                      ~ "other"
      )
    )


# `case_when()` ignores `NULL` inputs. This is useful when you'd
# like to use a pattern only under certain conditions. Here we'll
# take advantage of the fact that `if` returns `NULL` when there is
# no `else` clause:


# --------
# rowwise()

fruits <- tribble(
  ~"fruit", ~"height_1", ~"height_2", ~"height_3", ~"width", ~"weight",
  "Banana", 4, 4.2, 3.5, 1, 0.5,
  "Strawberry", 1, .9, 1.2, 1, .25,
  "Pineapple", 18, 17.7, 19.2, 6, 3)

fruits

# mean across all values in all rows
fruits |> 
    mutate(height_mean = mean(c(height_1, height_2, height_3))) 

# válido pois as frutas não se repetem, mas perigoso
fruits |> 
    group_by(fruit) |>
    mutate(height_mean = mean(c(height_1, height_2, height_3))) 

# mean across all values in each row
fruits |> 
    rowwise(fruit) |> 
    mutate(height_mean = mean(c(height_1, height_2, height_3)))

# per-row summary statistics
df <- tibble(id = 1:6, w = 10:15, x = 20:25, y = 30:35, z = 40:45)
df

df |> 
    rowwise(id) ->
    rf

# mutate to add new column for each row
rf |> 
    mutate(total = sum(c(w, x, y, z)))

# wrong way
df |> 
    mutate(total = sum(c(w, x, y, z)))

# summarize without mutate
rf |> 
    summarise(total = sum(c(w, x, y, z)), .groups= "drop")

# with across()
rf |> 
    mutate(total = sum(c_across(w:z)))

# ‘c_across()’ is designed to work with ‘rowwise()’ to make it easy to perform row-wise aggregations.
rf |>   
    mutate(total = sum(c_across(where(is.numeric))))

# If we want to use our fruits example... 
fruits |> 
    rowwise(fruit) |> 
    mutate(height_mean = mean(c_across(contains("height"))))

rf |>                                           #our row-wise data frame
    mutate(total = sum(c_across(w:z))) |>       #total each row
    ungroup() |>                                # ungroup the rows
    mutate(across(w:z, ~ .x / total))           # the .x represents each column


# ------------------------------
# Part 5: tidyr advanced
#
# Nested data

# A nested data frame is a data frame where one (or more) columns is a 
# list of data frames. You can create simple nested data frames by hand:

# create

storms |> count(name, sort = T)

storms |> 
    group_by(name) |>
    nest() ->
    storms_n

storms_n
storms_n$idade  <- 1:214

storms_n |> 
    dplyr::relocate(name, idade) 

storms |> 
    nest(data = c(year:long)) ->
    storms_n

# reshape nested data

# unnest() Turn each element of a list-column into a row
storms_n |> unnest(data)

# unnest_longer() Turn each element of a list-column into a row
starwars |>
    select(name, films) |>
    unnest_longer(films)

# unnest_wider() Turn each element of a list-column into a regular column
starwars |> 
    select(name, films) |>
    unnest_wider(films)

# hoist()  Selectively pull list components out into their own top-level columns
starwars |>
    select(name, films) |>
    hoist(films, first_film = 1, second_film = 2)

# transform nested data

# dplyr::rowwise() 
storms_n |>
    rowwise() |>
    mutate(n = nrow(data))

storms_n |>
    rowwise() |>
    mutate(n = list(dim(data)))

storms_n |>
    rowwise() |>
    mutate(n = list(dim(data))) |>
    unnest_longer(n) |>
    filter(name == 'Amy') |>
    unnest_longer(data) ->
    amy

starwars |>
    rowwise() |> 
    mutate(transport = list(append(vehicles, starships))) |>
    select(name, transport) |>
    unnest_longer(transport)

# -----
## Rectangling 
# Rectangling is the art and craft of taking a deeply nested list 
# (often sourced from wild caught JSON or XML) and taming it into a 
# tidy data set of rows and columns. 

# https://tidyr.tidyverse.org/articles/rectangle.html

# tópico bonus
# útil quando os alunos estudarem lista 
# ótimo combo com o pacote purrr

library(repurrrsive) 

users <- tibble(user = gh_users)

users[[1]]

names(users$user[[1]])

users |> unnest_wider(user)

users |> 
    hoist(user, 
          followers = "followers", 
          login = "login", 
          url = "html_url")


repos <- tibble(repo = gh_repos)

repos[[1]]

repos |> 
    unnest_longer(repo) ->
    repos

repos |> 
    hoist(repo,
          login = c("owner", "login"), 
          name = "name", 
          homepage = "homepage", 
          watchers = "watchers_count")

repos |> 
    hoist(repo, owner = "owner") |> 
    unnest_wider(owner)

tibble(repo = gh_repos) |> 
    unnest_auto(repo) |>
    unnest_auto(repo)
