# ------------------------------------------------------------
# 
# File Name: cidados_aula05.R
#
# Purpose: Ciência de Dados para Economistas - Faculdade de Economia UFMT
# 
# Creation Date: 2020-10-30
# Last Modified: 2022-10-20 
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


# Parte 1: desempenho na importacação e exportação de dados
# Parte 2: sintax do pacote data.table
# Parte 3: pacotes dtplyr e tidyfast
# Parte 4: microdados: bare metal OR blazingly fast _way


# ------------------------------
## Parte 1: desempenho na importacação e exportação de dados

library(tidyverse) 
library(rio)
library(data.table) 
library(tictoc)


# Configuração do meu computador
# OS: Manjaro 21.2.5 Qonos
# CPU: AMD Ryzen 9 5900X 12-Core @ 24x 3.7GHz
# GPU: AMD/ATI Ellesmere [Radeon RX 570]
# RAM: 128 GB 
# SSD1: 480 GB for Operacional System 
# SSD2: raid0 2 TB for Data


# --- import

# importação dos dados do censo demográfico (csv e rds)
# https://www.ibge.gov.br/estatisticas/sociais/populacao/9662-censo-demografico-2010.html?=&t=microdados
br2010_csv <- '/mnt/raid0/Pesquisa/Censo 2010/Brasil/br2010.csv' # 12 GB
br2010_rds <- '/mnt/raid0/Pesquisa/Censo 2010/Brasil/br2010.rds' # 950 MB

tictoc::tic()
br2010 <- data.table::fread(br2010_csv)
tictoc::toc()
# 5.101 sec

tictoc::tic()
br2010b <- rio::import(br2010_rds)
tictoc::toc()
# 52.156 sec

tictoc::tic()
br2010c <- read_csv(br2010_csv)
tictoc::toc()
# R travou e fechou  

# --- export
tictoc::tic()
data.table::fwrite(br2010, '~/br2010.csv')
tictoc::toc()
# 7.899 sec

tictoc::tic()
rio::export(br2010b, '~/br2010.rds')
tictoc::toc()
# 321.775 sec | 5.36 min

tictoc::tic()
write_csv(br2010b, '~/br2010_baser.csv')
tictoc::toc()
# 27 sec 

# ---  
# conclusão: caminho mais rápido para importar exportar dados é o data.table
#
# salvar um csv no data.table::fwrite() é 46 vezes mais rápido que um saveRDS() nativo do R
# salvar um csv no data.table::fwrite() é ~= 4 vezes mais rápido que um write_csv() nativo do R
#
# ler um csv com data.table::fread() é ~= 10 vezes mais rápido que um readRDS() nativo do R
# o R travou tentando ler o csv com read_csv() 
# --- 




# ------------------------------
## Parte 2: pacote data.table

library(data.table)

# ---------------------
# full performance benchmarking
# https://h2oai.github.io/db-benchmark/

# resume benchmarking
# https://www.ritchievink.com/blog/2021/02/28/i-wrote-one-of-the-fastest-dataframe-libraries/

# comporando: dplyr | data.table | pandas | DataFrames.jl | Arrow | Spark | Polars | etc

# ---------------------
# see oficial page
# https://rdatatable.gitlab.io/data.table/

DT <- data.table::as.data.table(iris)

# DT[ i,  j,  by ] # + extra arguments
#     |   |   |
#     |   |    -------> grouped by what?
#     |    -------> what to do?
#      ---> on which rows?

DT[Petal.Width > 1.0, mean(Petal.Length), by = Species]
DT[Petal.Width > 1.0, mean(Petal.Length)]


# ---------------------
# tutorial básico
# https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html

input <- if (file.exists("flights14.csv")) {
    "flights14.csv"
} else {
    "https://raw.githubusercontent.com/Rdatatable/data.table/master/vignettes/flights14.csv"
}

flights <- data.table::fread(input) 
class(flights)
dim(flights)

# Get all the flights with “JFK” as the origin airport in the month of June
ans <- flights[origin == "JFK" & month == 6L]
head(ans)

# %chin% special operator, similar to %in% but faster 
ans <- flights[carrier %chin% c('AA', 'AS', 'B6')]
head(ans)

# Get the first two rows from flights.
ans <- flights[1:2]
ans

# Sort flights first by column origin in ascending order, and then by dest in descending order:
ans <- flights[order(origin, -dest)]
head(ans)

# Select arr_delay column, but return it as a vector.
ans <- flights[, arr_delay]
head(ans)

# Select column and return DT: caminho 1
ans <- flights[, list(arr_delay)]
head(ans)

# Select column and return DT: caminho 2
ans <- flights[, .(arr_delay, dep_delay)]
head(ans)

# Select column and return DT: caminho 3
ans <- flights[, c('arr_delay', 'dep_delay')]
head(ans)

# Select column and return DT: caminho 4
# .. operator, global
select_cols <- c("arr_delay", "dep_delay")
flights[, ..select_cols]

# Select columns named in a variable using with = FALSE
flights[, select_cols, with = FALSE] 

# Select both arr_delay and dep_delay columns and rename them to delay_arr and delay_dep.
ans <- flights[, .(delay_arr = arr_delay, delay_dep = dep_delay)]
head(ans) 

# How many trips have had total delay < 0?
ans <- flights[, sum((arr_delay + dep_delay) < 0)]
ans

# Calculate the average arrival and departure delay for all flights with “JFK” as the origin airport in the month of June.
ans <- flights[origin == "JFK" & month == 6L, 
               .(m_arr = mean(arr_delay), 
                 m_dep = mean(dep_delay))]
ans

# How many trips have been made in 2014 from “JFK” airport in the month of June?
ans <- flights[origin == "JFK" & month == 6L, length(dest)]
ans

# Special symbol .N:
# .N is a special built-in variable that holds the number of observations in the current group. It is particularly useful when combined with by as we’ll see in the next section. In the absence of group by operations, it simply returns the number of rows in the subset.
ans <- flights[origin == "JFK" & month == 6L, .N]
ans

# Agregations
ans <- flights[, .(.N), by = .(origin)]
ans

# How can we calculate the number of trips for each origin airport for carrier code "AA"
ans <- flights[carrier == "AA", .N, by = origin]
ans

# How can we get the total number of trips for each origin, dest pair for carrier code "AA"?
ans <- flights[carrier == "AA", .N, by = .(origin, dest)]
head(ans)

# and order
flights[carrier == "AA", .N, by = .(origin, dest)][order(-N)]

# So how can we directly order by all the grouping variables?
ans <- flights[carrier == "AA", 
               .(mean(arr_delay), mean(dep_delay)), 
               keyby = .(origin, dest, month)]
ans

# order
ans[order(V1, V2)]

# Can by accept expressions as well or does it just take columns?
# Yes it does. As an example, if we would like to find out how many flights started late but arrived early (or on time), started and arrived late etc…
ans <- flights[, .N, .(dep_delay > 0, arr_delay > 0)]
ans

# Special symbol .SD:
# data.table provides a special symbol, called .SD. It stands for Subset of Data. 
DT
DT[, print(.SD), by = Species]

# .SDcols
flights[carrier == "AA",                       ## Only on trips with carrier "AA"
        lapply(.SD, mean),                     ## compute the mean
        by = .(origin, dest, month),           ## for every 'origin,dest,month'
        .SDcols = c("arr_delay", "dep_delay")] ## for just those specified in .SDcols

# How can we return the first two rows for each month?
ans <- flights[, head(.SD, 2), by = month]
head(ans)

# :=
# walrus operator, atribuição dentro de um DT
flights[, atrasou := ifelse(arr_delay > 10, 'Sim', 'Não')]
flights[, teste := 'testando']
flights

# deletar variável
flights[, - c('teste', 'atrasou')]
flights[, teste := NULL]
flights[, atrasou := NULL]
flights


# ------------------------------
## Parte 3: pacotes dtplyr e tidyfast

# sintax do dplyr com objetos data.table

# data.table vs dplyr
# https://atrebas.github.io/post/2019-03-03-datatable-dplyr/

# material oficial
# https://dtplyr.tidyverse.org/

# tidyfast
# https://tysonbarrett.com/tidyfast/

# tradutor dplyr sintax para data.table sintax
library(tidyverse) 
library(dtplyr)          # dplyr equivalente  
library(tidyfast)        # tidyr equivalente (também existe tidytable)
library(rio) 
library(data.table) 
library(microbenchmark) 
library(bench)
library(tictoc) 

df <- data.frame(a = 1:5, b = 1:5, c = 1:5, d = 1:5)
dt <- dtplyr::lazy_dt(df)

dt
dt |> dplyr::show_query()
dt |> dplyr::select(a:b) |> dplyr::show_query()
dt |> dplyr::select(a:b) 
dt |> dplyr::select(a:b) |> tibble::as_tibble() 

dt |> dplyr::select(a:b) |> dplyr::filter(a <= 3) |> dplyr::arrange(desc(b)) 
dt |> dplyr::select(a:b) |> dplyr::filter(a <= 3) |> dplyr::arrange(desc(b)) |> dplyr::show_query()

dt |> dplyr::arrange(a, b, c)
dt |> dplyr::select(a:b)
dt |> dplyr::summarise(a = mean(a)) 
dt |> dplyr::transmute(a2 = a * 2) 
dt |> dplyr::mutate(a2 = a * 2, b2 = b * 2)
dt |> dplyr::mutate(a2 = a * 2, b2 = b * 2, a4 = a2 * 2)
dt |> dplyr::transmute(a2 = a * 2, b2 = b * 2, a4 = a2 * 2)
dt |> dplyr::rename(x = a, y = b)
dt |> dplyr::distinct() 
dt |> dplyr::distinct(a, b) 
dt |> dplyr::distinct(a, b, .keep_all = TRUE) 
dt |> dplyr::distinct(c = a + b) 
dt |> dplyr::distinct(c = a + b, .keep_all = TRUE) 

dt2 <- dtplyr::lazy_dt(data.frame(a = 1))
dt |> dplyr::inner_join(dt2, by = "a") 
dt |> dplyr::right_join(dt2, by = "a")
dt |> dplyr::left_join(dt2, by = "a")
dt |> dplyr::anti_join(dt2, by = "a")
dt |> dplyr::full_join(dt2, by = "a") 
dt |> dplyr::full_join(dt2, by = "a") |> dplyr::show_query()

dt |> dplyr::group_by(a) |> dplyr::summarise(b = mean(b))
dt |> dplyr::group_by(a, arrange = FALSE) |> dplyr::summarise(b = mean(b))
dt |> dplyr::group_by(a) |> dplyr::filter(b < mean(b))

dt |> dplyr::filter(a == 1) |> dplyr::select(-a)

dt3 <- dtplyr::lazy_dt(data.frame(x = 1, y = 2))
dt4 <- dtplyr::lazy_dt(data.frame(x = 1, a = 2, b = 3, c = 4, d = 5, e = 7))

dt3 |> 
  dplyr::left_join(dt4) |> 
  dplyr::select(x, a:c) 

dt |> dplyr::mutate(a2 = a * 2, b2 = b * 2) 

# ----------
# benchmark lattes dados gerais

# data.frame
dg_original <- data.table::fread('/mnt/raid0/Pesquisa/lattes_2020/lattes_tables/DadosGerais.csv') 
dg_original
dim(dg_original)

# data.frame
dg_df <- dg_original[1:1000000, ] |> as.data.frame() 

# tibble
dg_tb <- tibble::as_tibble(dg_df) 

# data.table dtplyr
dg_lazy_dt <- dtplyr::lazy_dt(dg_df)

# data.table original
dg_dt <- data.table::as.data.table(dg_df)

# select and arrange
microbenchmark::microbenchmark(
    data_frame = dg_df[order(dg_df$nome_completo), c('nome_completo', 'pais_de_nascimento', 'data_atualizacao', 'id')], 
    data_tibble = dg_tb |> dplyr::select(nome_completo, pais_de_nascimento, data_atualizacao, id) |> dplyr::arrange(nome_completo),  
    data_table_lazy_dt = dg_lazy_dt |> dplyr::select(nome_completo, pais_de_nascimento, data_atualizacao, id) |> dplyr::arrange(nome_completo),
    data_table_orig = dg_dt[, .(nome_completo, pais_de_nascimento, data_atualizacao, id)][order(nome_completo)],
    times = 2 
)

# Unit: milliseconds
#                expr          min           lq         mean       median           uq          max neval cld
#          data_frame 15942.813793 15942.813793 16187.456176 16187.456176 16432.098559 16432.098559     2  b 
#         data_tibble 17886.188947 17886.188947 18185.199119 18185.199119 18484.209291 18484.209291     2   c
#  data_table_lazy_dt     2.583712     2.583712     3.424582     3.424582     4.265453     4.265453     2 a  
#     data_table_orig   930.093906   930.093906   932.617333   932.617333   935.140760   935.140760     2 a  


# ----------
# data.table import text files

# olhar para os dados, primeiras 10 linhas 
a <- data.table::fread('flights14.csv', nrows = 10)
a

# selecionar colunas ao importar
data.table::fread('flights14.csv', select = c('year', 'month', 'day', 'distance', 'carrier'))

# excluir colunas
data.table::fread('flights14.csv', drop = c(4, 6))

# filter com grep nativo do Linux 
data.table::fread('grep AA flights14.csv')

# filter com nomes das colunas
data.table::fread('grep AA flights14.csv', col.names = names(a))

# filter AE e DL
data.table::fread("grep ⁻E 'AA|DL' flights14.csv", col.names = names(a))

# %in% but faster
dt <- data.table::fread('flights14.csv')
dt[carrier %chin% c('AE', 'DL')]

# classe das colunas
data.table::fread('flights14.csv', 
                  colClasses = c(year = "character", 
                                 month = "character", 
                                 day = "character")) |> 
    dplyr::glimpse()

# ler zip sem unzip
data.table::fread(cmd = 'unzip -cq flights14.zip') 

# ler arquivo e depois transormar com setDT
df <- data.table::setDT(readxl::read_excel('flights14.xlsx'))

# ou
df <- readxl::read_excel('flights14.xlsx')

data.table::setDT(df)

dt <- dtplyr::lazy_dt(df) 

# threads
getDTthreads(verbose = TRUE)

# ----------
# tidyfast

#Tidy data is data where:
#
#     Every column is variable.
#     Every row is an observation.
#     Every cell is a single value.


dt <- data.table(
   x = rnorm(1e5),
   y = runif(1e5),
   grp = sample(1L:5L, 1e5, replace = TRUE),
   nested1 = lapply(1:10, sample, 10, replace = TRUE),
   nested2 = lapply(c("thing1", "thing2"), sample, 10, replace = TRUE),
   id = 1:1e5)

dt

nested <- tidyfast::dt_nest(dt, grp)
nested

# Nesting and Unnesting
tidyfast::dt_unnest(nested, col = data)
tidyfast::dt_hoist(dt, nested1, nested2)

# Pivoting
billboard <- tidyr::billboard

billboard |>
    tidyfast::dt_pivot_longer(cols = c(-artist, -track, -date.entered), 
                              names_to = "week", values_to = "rank") ->
    longer

longer |> 
    tidyfast::dt_pivot_wider(names_from = week, values_from = rank) ->
    wider

wider[, .(artist, track, wk1, wk2)]

# If Else
x <- rnorm(1e6)

medianx <- median(x)

tidyfast::dt_case_when(x < medianx ~ "low", 
                       x >= medianx ~ "high", 
                       is.na(x) ~ "unknown") ->
    x_cat

dplyr::case_when(x < medianx ~ "low", 
                 x >= medianx ~ "high", 
                 is.na(x) ~ "unknown") ->
x_cat_dplyr 

data.table::fifelse(x < medianx, "low", 
                    data.table::fifelse(x >= medianx, "high", 
                                        data.table::fifelse(is.na(x), "unknown", NA_character_))) ->
    x_cat_fif

identical(x_cat, x_cat_dplyr)
identical(x_cat, x_cat_fif)

# Fill
x <- 1:10

data.table(x = x, y = shift(x, 2L), 
           z = shift(x, -2L), 
           a = sample(c(rep(NA, 10), x), 10), 
           id = sample(1:3, 10, replace = TRUE)) ->
    dt_with_nas

tidyfast::dt_fill(dt_with_nas, y, z, a)
tidyfast::dt_fill(dt_with_nas, y, z, a, id = list(id))
tidyfast::dt_fill(dt_with_nas, y, z, a, id = list(id), .direction = "downup")

x <- 1:1e6

data.table(x = x, y = shift(x, 10L), 
           z = shift(x, -10L), 
           a = sample(c(rep(NA, 10), x), 10), 
           id = sample(1:3, 10, replace = TRUE)) -> 
    dt3 
df3 <- data.frame(dt3)

bench::mark(tidyr::fill(dplyr::group_by(df3, id), x, y), 
            tidyfast::dt_fill(dt3, x, y, id = list(id)), 
            check = FALSE, 
            iterations = 50) ->
    marks3 

# Separate
# The dt_separate() function is still under heavy development

# Count and Uncount
counted <- tidyfast::dt_count(dt, grp)
counted

uncounted <- tidyfast::dt_uncount(counted, N)
uncounted[]



# ------------------------------
# Parte 4: microdados: bare metal OR blazingly fast _way

library(tidyverse) 
library(dtplyr)          # dplyr equivalente  
library(tidyfast)        # tidyr equivalente (também existe tidytable)
library(data.table) 


# censo da educação superior
ces_curso_csv <- '/mnt/raid0/Pesquisa/microdados_censo_da_educacao_superior_2020/dados/MICRODADOS_CADASTRO_CURSOS_2020.CSV' # 182 MB
ces_ies_csv <- '/mnt/raid0/Pesquisa/microdados_censo_da_educacao_superior_2020/dados/MICRODADOS_CADASTRO_IES_2020.CSV' # 1 MB

data.table::fread(ces_curso_csv, nrows = 1, select = 1:7)

read.table(ces_curso_csv, header = T, sep = ';', nrows = 1) |>
    dplyr::select(1:7) 

# --- problema de enconding: 
# 'Educação' vira 'Educa\xe7\xe3o'
# 'Água' vira '\xc1gua'

# descrobrir encode no terminal do linux e macOS
# > file -i MICRODADOS_CADASTRO_CURSOS_2020.CSV

# rio::import() utiliza o data.table::fread() para ler arquivos csv 
tictoc::tic()
data.table::fread(ces_curso_csv, encoding = 'Latin-1') |>
    janitor::clean_names() |>
    dtplyr::lazy_dt() -> 
    curso
tictoc::toc()

data.table::fread(ces_ies_csv, encoding = 'Latin-1') |>
    janitor::clean_names() |>
    dtplyr::lazy_dt() -> 
    ies

# ---
# solução nativa do R: fileEncoding = 'iso-8859-1'
read.table(ces_curso_csv, header = T, sep = ';', nrows = 1, fileEncoding = 'iso-8859-1') |>
    dplyr::select(1:7) 
# ---

class(curso)
class(ies)

ies |> dplyr::select(co_ies, no_ies, sg_ies) 

curso |> 
    dplyr::select(nu_ano_censo, no_regiao, no_uf, no_municipio, 
                  in_capital, tp_rede, co_ies, no_cine_rotulo) |>
    dplyr::filter(no_uf == 'Mato Grosso') 

# existe mais de uma linha por curso?
curso |> 
    dplyr::filter(no_uf == 'Mato Grosso') |>
    dplyr::count(co_ies, co_cine_rotulo, sort = T)

# centros de ensino e cursos
curso |> 
    dplyr::filter(no_uf == 'Mato Grosso') |>
    dplyr::select(nu_ano_censo, no_regiao, no_uf, no_municipio, 
                  in_capital, tp_organizacao_academica, tp_categoria_administrativa,
                  tp_rede, co_ies, co_cine_rotulo, no_cine_rotulo) |>
    dplyr::left_join(ies |> dplyr::select(co_ies, no_ies, sg_ies)) |>
    dplyr::count(no_ies, no_cine_rotulo, sort = T) |>
    dplyr::select(- n) |> 
    dplyr::show_query()
    tibble::as_tibble() ->
    t1

t1 |>
    dplyr::filter(grepl('universidade federal de mato grosso', ignore.case = T, no_ies)) |>
    print(n = Inf)

t1 |> dplyr::count(no_ies, sort = T) 
t1 |> dplyr::count(no_cine_rotulo, sort = T) 

# ---- censo populacional 2010
#
br2010_csv <- '/mnt/raid0/Pesquisa/Censo 2010/Brasil/br2010.csv' # 12 GB

tictoc::tic()
data.table::fread(br2010_csv) |> 
    janitor::clean_names() |> 
    dtplyr::lazy_dt() ->
    br2010
tictoc::toc()

tictoc::tic()
br2010 |> 
    dplyr::group_by(v1001, v0601) |>
    dplyr::summarise(qtde_pessoas = n()) |>
    dplyr::rename(regiao = v1001, sexo = v0601) |>
    tibble::as_tibble() |>
    print(n = Inf)
tictoc::toc()
# 7.54

