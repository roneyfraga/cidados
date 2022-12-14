# ------------------------------------------------------------
# 
# File Name: cidados_aula02.R
#
# Purpose: Ciência de Dados para Economistas - Faculdade de Economia UFMT
#
# inspired and adapted from 
# 'Introduction to Social Network Analysis with R'
# by Michal Bojanowski
# 'R para cientistas sociais' 
# by Jakson Alves de Aquino
# 'Programming in R' 
# by Thomas Girke
# 
# Creation Date: 2016-04-30
# Last Modified: 2022-09-01_12:25 
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

# vetor (revisão)
# matriz
# data frame
# lista
# table, aggregate, reshape, merge


# ------------------------------
# vetores

vector(mode = "character", length = 5)
vector(mode = "numeric", length = 7)
vector(mode = "logical", length = 4)

# função básica para criar vetores com valores pré - determinados é c(), abreviatura de concatenate
c("Marx", "Weber", "Durkheim")
c(5, 3, 11, 6, 1, 4)
c(TRUE, FALSE, TRUE, TRUE, FALSE)
 
a <- c(5, 3, 11, 6, 1, 4)
a
a = c(5, 3, 11, 6, 1, 4)
a
b <- 1:8 
b

# criar vetor como uma sequência
# seq() from to by
seq(10, 100, 5)
seq(from = 10, to = 100, by = 5)
seq(from = 1, to = 2, by = 0.02)

# criar vetor via repetição
# rep() elemento repetição
rep('roney', 30)
rep(2, 4)

# levels
codigo <- c(23, 22, 23, 23, 22, 22, 23, 22)
uf <- factor(codigo, levels = c(22, 23), labels = c("Piaui", "Ceara"))
uf

# nomeando itens
idh05 <- c(0.677, 0.742, 0.723, 0.683, 0.718, 0.718, 0.703, 0.738, 0.742)
names(idh05)
names(idh05) <- c("AL", "BA", "CE", "MA", "PB", "PE", "PI", "RN", "SE")
idh05
names(idh05)

# obtendo informações de um vetor
length(idh05)
str(idh05)

# estatísticas descritivas
summary(idh05)
mean(idh05)
median(idh05)
min(idh05)
max(idh05)
quantile(idh05)

class(idh05)
is.numeric(idh05)

# convertendo vetores
a <- c(TRUE, FALSE, TRUE, FALSE)
a <- as.character(c(TRUE, FALSE, TRUE, FALSE))
as.character(c(1, 3.4, - 5.6, 9))
as.numeric(c(TRUE, FALSE, TRUE, FALSE))
as.numeric(c("1.3", "1.4", "1.7"))

is.character(a)
is.logical(a)

# Índices: obtendo e modificando valores
x <- c(4, 8, 2, 6, 7, 1, 8, 1, 2)
y <- c(6, 7, 3, 4, 1, 5, 2, 8, 9)
z <- c("a", "b", "c", "d", "e", "f", "g", "h", "i")
x[3]
y[2]
x[c(1, 3, 5)]
z[1:4]
z[1]

y < 5

i <- y < 5
i = y < 5
i
y[i]
y[!i]
z[i]
x[i]

names(x) <- z
x
x["b"]
x['b']
x[c("b", "d", "g")]
x[- 1]
x[- c(1, 2, 3)]
x[3] <- 11
x['c'] <- NA
x
x['c'] <- 11
x[c("b", "d", "g")] <- 0
x
is.na(x)
x[is.na(x)]
x[!(is.na(x))]


# Operações
x <- c(5, 2, 4, 3, 2) 
y <- c(1, 3, 2, 5, 2) 
x + y
x - y
x > y
x[x > y]
x[x < y]
x == y
x[x == y]
x != y
x[x != y]
y + 1

# erro ao trabalhar com vetores com dimensões distintas 
x <- c(1, 5, 7)
y <- c(1, 2, 3, 4, 5, 6, 7) 
x + y


#------------------------------ 
# Matrizes

# juntar colunas
x <- c(7, 9, 8, 10, 1)
y <- c(9, 8, 10, 9, 3)
z <- c(10, 9, 9, 9, 2)
cbind(x, y, z)

# juntar linhas
rbind(x, y, z)

# nomes das colunas e nomes das linhas
m <- cbind(x, y, z)
m
colnames(m) <- c("Matematica", "Portugues", "Historia")
rownames(m) <- c("Helena", "Jose", "Maria", "Francisco", "Macunaima")

m
class(m)

# índices em uma matriz

# M[linhas, colunas]

m[5, 3]
m[1:3, 2]
m[1:3, c(1, 3)]
m[c(1, 4), 1]
m["Maria", c("Portugues", "Matematica")]
m[, "Historia"]
m[, ]
m["Macunaima", "Portugues"] <- 4
m["Macunaima", "Portugues"] = 4
m[5, 2] <- 4

m
m[, 1]
m[, 1] == 10

m[m[, 1] == 10, ]

nerd = m[, 1] == 10
m[nerd, ]

class(m)

rownames(m) <- c("Helena da Silva", "Jose Miranda", "Maria do Rosario", "Francisco Augusto", "Macunaima Matinho")
m

rownames(m) <- toupper(rownames(m))
m

# objeto[linhas, colunas]
# nomes das linhas e colunas
# 

#------------------------------ 
# data frame

# carregar uma base de dados padrão do R
data(mtcars)
mtcars
ls()

# help para descrobrir quais são as variáveis
?mtcars
help('mtcars')
# [, 1] mpg Miles / (US) gallon      
# [, 2] cyl Number of cylinders      
# [, 3] disp Displacement (cu.in.)     
# [, 4] hp Gross horsepower       
# [, 5] drat Rear axle ratio       
# [, 6] wt Weight (1000 lbs)      
# [, 7] qsec 1 / 4 mile time       
# [, 8] vs Engine (0 = V - shaped, 1 = straight)  
# [, 9] am Transmission (0 = automatic, 1 = manual) 
# [, 10] gear Number of forward gears     
# [, 11] carb Number of carburetors     

# 3 formas de escrever a mesma função
head(mtcars)
head(mtcars, n = 6)
head(mtcars, 6)

tail(mtcars, 6)
str(mtcars)

# other usefull functions on data frames:
nrow(mtcars)  # number of rows
ncol(mtcars)  # number of columns
names(mtcars) # names of the variables
head(mtcars)  # first 6 observations
head(mtcars, 2) # first 2 observations
tail(mtcars)  # last 6 observations
dim(mtcars)

### Referring to individual variables with '$'
mtcars$mpg
mtcars$mpg * 2

mtcars$mpg
mtcars[, 'mpg']
mtcars[, 1]

# mtcars[linhas, colunas ]
mtcars
mtcars[, ]
mtcars[1, 1]
mtcars[1, 1:3]
mtcars[1, c(1, 2, 3)]
mtcars[1, c(3, 2, 3)]
mtcars[1, c(1:3, 5)]
mtcars[, 'mpg']
mtcars[1:3, 'mpg']
mtcars[1:3, 1]

mtcars[14:18, ]

mtcars[14:18, 2:5]
mtcars[14:18, c('cyl', 'disp', 'hp', 
    'drat')]

mtcars['Fiat 128', c('cyl', 'disp', 'hp', 'drat')]
mtcars['Fiat 128', 2:5]

mtcars[c(1, 5, 8), ]
mtcars[c(1, 5, 8), 2:5]
mtcars[c(8, 1, 5), c(5, 2)]
mtcars[c('Fiat 128', 'Toyota Corolla'), 2:5]


# selecionar variáveis (colunas) e observações (linhas)
# dataframe[linhas, colunas]
# dataframe[nome ou número, nome ou número]

?sort
help('sort')

mtcars$mpg
sort(mtcars$mpg)
sort(mtcars$mpg, decreasing = FALSE)

sort(mtcars$mpg, decreasing = TRUE)

mtcars
mtcars$mpg
mtcars[, 'mpg']
mtcars[, 1]

mtcars[1:3, 1:7]

mtcars[1:3, 1:7]
mtcars[c(1, 3), c(1, 7)]

# ordenando toda a tabela
sort(mtcars$mpg)
order(mtcars$mpg)

mtcars[c(15, 16, 24, 7), ]

6 == 6
mtcars$cyl == 6
mtcars[mtcars$cyl == 6, ] 

order(mtcars$mpg)
mtcars[order(mtcars$mpg), ]
mtcars[order(mtcars$mpg, decreasing = TRUE), ]


# Mean 
mean(mtcars$mpg)
mean(mtcars[, 'mpg'])
mean(mtcars[, 1])

mean(mtcars$mpg[1:10])

table(mtcars$cyl)
table(mtcars[, 'cyl'])
table(mtcars[, 2])

table(mtcars[, 2], mtcars[, 'gear'])

table(mtcars$cyl, mtcars$gear)
addmargins(table(mtcars$cyl, mtcars$gear))

rownames(mtcars)

# milhas por galão
# Uma milha é igual a 1, 61 km
# Um galão é igual a 3, 79 litros
# 1, 61 ÷ 3, 79 = 0, 425. Isto significa que 0, 425 km / l é igual a 1 mpg
# para obter kml a partir de mpg basta multiplicar mpg * 0, 425

mtcars$mpg * 0.425

mtcars$kml <- mtcars$mpg * 0.425
mtcars$kml = mtcars$mpg * 0.425

mtcars$dai <- NA
mtcars$dai <- 'dai mestrado'
mtcars$dai <- NULL
mtcars <- mtcars[, names(mtcars) != 'dai']
head(mtcars)

names(mtcars)[names(mtcars) != 'dai']

mtcars[order(mtcars$kml), ]

mtcars <- mtcars[order(mtcars$kml, decreasing = TRUE), ]

write.csv(mtcars, 'mtcars.csv', sep = ', ')
write.csv2(mtcars, 'mtcars.csv', sep = ';')
write.table(mtcars, 'mtcars.txt')
#------------------------------ 

library(dplyr)

mtcars |> 
 tibble::as_tibble() |> 
 dplyr::select(mpg, cyl, disp, gear) |> 
 dplyr::filter(cyl == 4) |> 
 dplyr::arrange(mpg) |> 
 dplyr::rename(gear2 = gear) |> 
 dplyr::mutate(kml = mpg * 0.425) |> 
 dplyr::group_by(gear2) |> 
 dplyr::summarise(kml = mean(kml)) 


#------------------------------ 
# lista

numeros = 1:3
letras = c("a", "b", "c", "d")
logico = c(TRUE, FALSE)

list(numeros, letras, logico)

l <- list(numeros, letras, logico)

lista = list(mtcars = mtcars, iris = iris, lmin = letters, lmai = LETTERS)
names(lista)
length(lista)
lista[[2]][1:3, ]
lista[['iris']][1:3, ]

list(lista, l)

lista <- list(numeros = 1:3, 
              letras = c("a", "b", "c", "d"), 
              logico = c(TRUE, FALSE))
lista

names(lista)
length(lista)

lista[1]
lista[[1]]
lista[[1]][[2]]

lista[2]
lista[[2]]
lista["letras"]
lista[["letras"]]
lista$letras

lista$letras[1]
lista$letras[3:4]


lista[3]
lista[1:2]
lista[c(1, 3)]

lista

lista[[2]]
class(lista[[2]]) 
toupper(lista[[2]])

lista[2]
class(lista[2]) 
toupper(lista[2])

names(lista)
lista$letras
class(lista$letras) 
toupper(lista$letras)

lista[["letras"]]
class(lista[["letras"]]) 
toupper(lista[["letras"]])

lista["letras"]
class(lista["letras"]) 
toupper(lista["letras"])

# acessar a lista
# - posição do elemento [1]
# - nome do elemento ['nome']
# - [] retorna uma sub - lista
# - [[]] retorna o próprio elemento
# - $nome_do_elemento 
lista
lista[2]
lista[[2]]

names(lista)
lista['letras']
lista[['letras']]

lista$letras

#nomes com espaço para nomear variáveis
lst <- list(c("aa", "bb", "cc"), c(1, 2, 3, 4), c(1.1, 1.2, 1.3))
names(lst) <- c("Texto", "Inteiros", "Numeros reais")
lst
lst$Texto
lst[['Texto']]

lst$Inteiros
lst[['Inteiros']]

lst$`Numeros reais`
lst[['Numeros reais']]
