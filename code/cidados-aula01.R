# ------------------------------------------------------------
# 
# File Name: cidados_aula01.R
# 
# Purpose: Ciência de Dados para Economistas - Faculdade de Economia UFMT
#
# inspired and adapted from 'Introduction to Social Network Analysis with R'
# by Michal Bojanowski 
# and the text book 'R para cientistas sociais'
# by Jakson Alves de Aquino
# 
# Creation Date: 2016-04-23
# Last Modified: Mon 05 Oct 2020 01:30:43 
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

# Introduction to R
# vetor
# matriz
# data frame


# objetivo da aula é compreender as seguintes operações
data(mtcars)
mtcars
summary(mtcars$mpg)
summary(mtcars[mtcars$carb == 4, 'mpg'])
write.table(mtcars, file = 'mtcars.csv', sep = ';', col.names = TRUE, row.names = TRUE)
mtcars <- read.table(file = 'mtcars.csv', sep = ';', header = TRUE)


# ------------------------------
# use R as calculator
1 + 1
4 * 8
25 * (4 - 2)
5^3
15 / (10 / 2)
log(1)
sin(pi / 2)^2

# + soma 
# - subtração
# / divisão 
# * multiplicação
# ^ exponenciação 

# > maior que
# < menor que
# >= maior ou igual a
# <= menor ou igual a
# & e
# | ou
# == igual a
# ! não
# != diferente 

5 != 5
5 == 5
5 >= 4
(2 & 3) < 5
(2 | 3) <= 3
2 & 3 < 1
(3 + 1) * (6 - 1) ^ 2
3 + 1 * 6 - 1 ^ 2


# ------------------------------
# objects 

a = 1
b = 2
a * b

a <- 1
b <- 2
a * b

a = c(2,3)
a <- c(2,3)
a

a >= 2
c(2,3) > 2
a + 1
c(2,4:8)

letters
LETTERS
ms <- 'Ana'
ms

mandioca_square1 = c('Yasmin', 'Ana')
mandioca_square3 = c("Yasmin", "Ana")

mandioca_square1 == mandioca_square3

tolower(toupper(mandioca_square1))

a <- toupper(mandioca_square1)
b <- tolower(a)

# veremos no futuro: pipe
mandioca_square1 |>
    toupper() |>
    tolower() |>
    nchar()

mandioca_square1 <- toupper(mandioca_square1)
mandioca_square1

mandioca_square1 == mandioca_square3

mandioca_square1 <- tolower(mandioca_square1)

mandioca_square2  <- c('Yasmin', 'Ana')

x = c(1, 2, 3, 4, 5, 6, 7, 8, 9)
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
y <- 1:9

y ^ 2
x / 2

a <- 3
b <- 5
a * b

a = 3
b = 5
a * b


# ------------------------------
# save objects 

data(mtcars)
mtcars

# na forma nativa do R
# 'save()', 'load()'  e save.image()

# salvar apenas 'x' no arquivo 'x.rda' no diretório rawfiles
save(mtcars, file = "data/mtcars.rda")

# salvando ambos, 'x' e 'y' no arquivo 'xy.rda'
save(x, y, file = "data/xy.rda") 

# salvar apenas 'x' no arquivo 'x.rds'
saveRDS(x, 'data/qualquer_nome.rds')

# é possível salvar x e y em arquivos '.rds'?
saveRDS(x, y, 'data/x.rds')

# listar os objetos que estão no workspace (espaço de trabalho)
ls()

# remover todos os objetos visíveis do workspace
rm(a)
rm(x, y)
rm(list = ls())

# verificar se resta algum objeto no workspace
ls()

# carregar o objeto 'x' no formato '.rda'
load("xy.rda")  
ls()
x
y

# remover apenas o objeto 'x'
rm(x)         

# carregar os objetos 'x' e 'y' salvos em 'ly.rda'
load("data/xy.rda")  
ls()

# carregar o objeto 'x' no formato '.rds'
readRDS("data/qualquer_nome.rds")  
x <- readRDS("data/qualquer_nome.rds")  
ls()

# salvar tudo que esta no workspace
save.image('data/Alunos_Mestrado.rda')



# ------------------------------
# encontrar e mudar o diretório de trabalho
# 
# obtendo o atual diretório de trabalho do R
# getwd()
# dir()
# setwd()

getwd()

setwd('/home/roney/')
dir()

setwd('~/OneDrive/Rworkspace/2020 CiDados Mestrado')
getwd()

CiDados <- "/home/roney/OneDrive/Rworkspace/2020 CiDados Mestrado"

# listar os arquidos do diretório de trabalho
dir()

# mudando o diretório de trabalho do R
# setwd("/home/roney/Sync/")
# setwd("~/Sync/")

# padrão Windows
# setwd("C:\Documentos\Minha\Pasta")

getwd()

read.csv(file = '/home/roney/OneDrive/Rworkspace/2020 CiDados Graduacao/data/mtcars.csv', sep = ';')

carros <- read.csv(file = '~/OneDrive/Rworkspace/2020 CiDados Mestrado/data/mtcars.csv', sep = ';')

ls()

x
y
CiDados
carros

getwd()
setwd('/home/roney/OneDrive/Rworkspace/2020 CiDados Mestrado')
dir()


# ------------------------------
# help - como obter ajuda?
# 
help("mean")
?mean          

x <- c(1:9)
mean(x)
mean(1:9)

y <- c(1:9,NA)
mean(y)
mean(y, na.rm=TRUE)

x
quantile(x, probs = c(.1, 0.25, .5, .75), na.rm = FALSE)
quantile(y, probs = c(.1, 0.25, .5, .75), na.rm = TRUE)


# buscar por 'mean' nas páginas help
help.search("mean")
# o mesmo que help.search("mean")
??mean               

# obter os argumentos da função 'mean'
args(mean)

# o manual completo do R e dos pacotes adicionais instalados pode se acessado
# com a função help.start()
help.start()

# quando não lembramos do nome exato de uma função
apropos('mean')
apropos('read')

# obter ajuda na internet a partir do próprio R
RSiteSearch("social network analysis")

# obter um exemplo de alguma função
example('mean')

# se você for falar com alguém sobre seu código que esta dando erro
# leve essa informação que irá ajudar na busca pela solução
sessionInfo()


# ------------------------------
# Pacotes

# instalar o pacote
# é necessário instalar o pacote apenas uma fez em seu computador
install.packages('getLattes')

# carregar o pacote
# toda vez que o R for inicializado é necessário carregar os pacotes
library(getLattes)

# obter as principais informações sobre um pacote
# "getLattes"
library(help = "getLattes")
# ou 
help(package = "getLattes")

getAtuacoesProfissionais('.xml')

# ------------------------------
# Tipos de dados

# tudo no R é vetor

# numeric
numerico <- 1:9
(numerico <- 1:9)
is.numeric(numerico)
is.numeric('olá')
is.character('olá')
is.numeric('1')
as.numeric('1')
as.numeric('a')

# date
Sys.Date()
(today <- Sys.Date())
is.character(today)

is.character(as.character(today))

today |>
    as.character() |>
    is.character()

today |>
    as.character() |>
    class()

format(today, "%d %b %y")  
format(today, "%d %b %Y")  
today
class(today)

# factor
letters
LETTERS
fator <- factor(letters[3:1])
fator2 <- factor(c(letters[3:1], letters[2:3]))
fator2 <- factor(c('c', 'b', 'a', 'b', 'c'))
a = c('b', 'a', 'b', 'c')
factor(a)

fator3 <- factor(1:4)
is.factor(fator2)
is.factor(fator3)

# text
texto <- 'algum texto será inserido'
texto <- "algum texto será inserido"
is.character(texto)
class(texto)

# logical
boba <- c(TRUE, FALSE, TRUE, TRUE)
boba <- c(T, F, T, T)
is.logical(boba)

is.logical(c('TRUE', 'FALSE', 'TRUE', 'TRUE'))
is.logical(c(TRUE, FALSE, TRUE, TRUE))

as.logical(c('TRUE', 'FALSE', 'TRUE', 'TRUE'))

is.numeric(c('1', '2', '3', '4'))
class(c('1', '2', '3', '4'))
is.character(c('1', '2', '3', '4'))
as.numeric(c('1', '2', '3', '4'))

# transformando os tipos de variáveis dados
as.numeric(fator3)
is.numeric(as.numeric(fator3))

is.numeric(c(1, 2, 3, 4, 5))
class(c(1, 2, 3, 4, 5))
as.character(c(1, 2, 3, 4, 5))

c('1', '2', '3', '4', '5')
class(c('1', '2', '3', '4', '5'))
as.numeric(c('1', '2', '3', '4', '5'))



# ------------------------------
# vetores

vector(mode = "character", length = 5)
vector(mode = "numeric", length = 7)
vector(mode = "logical", length = 4)

# função básica para criar vetores com valores pré-determinados é c(), abreviatura de concatenate
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
a = rep('roney', 30)
print(a)
write.table(a, 'arquivo_teste.txt')
rep(2, 4)

# levels
codigo <- c(23, 22, 23, 23, 22, 22, 23, 22)
uf <- factor(codigo, levels = c(22, 23), labels = c("Piaui", "Ceara"))
uf
table(uf)

# nomeando itens
idh05 <- c(0.677, 0.742, 0.723, 0.683, 0.718, 0.718, 0.703, 0.738, 0.742)
names(idh05)
names(idh05) <- c("AL", "BA", "CE", "MA", "PB", "PE", "PI", "RN", "SE")
idh05
names(idh05)

names(idh05) <- NULL
idh05

names(idh05) <- c("AL", "BA", "CE", "MA", "PB", "PE", "PI", "RN", "SE")
idh05

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

# convertendo vetores
a <- c(TRUE, FALSE, TRUE, FALSE)
a <- as.character(c(TRUE, FALSE, TRUE, FALSE))
as.character(c(1, 3.4, -5.6, 9))
as.numeric(c(TRUE, FALSE, TRUE, FALSE))
as.numeric(c("1.3", "1.4", "1.7"))

as.numeric(c("a", "b", "c"))

is.character(a)
is.logical(a)

# Índices: obtendo e modificando valores
x <- c(4, 8, 2, 6, 7, 1, 8, 1, 2)
y <- c(6, 7, 3, 4, 1, 5, 2, 8, 9)
z <- c("a", "b", "c", "d", "e", "f", "g", "h", "i")

x
y
z

x[3]
y[2]
x[c(1, 3, 5)] 
x[c(5, 1, 3)]
a = c(5, 1, 3)
a
x[a]

z[1:4]
z[1]
z[7]
z[c(2, 4, 6, 8)]

x[2] * 2
x * 2

y < 5

i <- y < 5
i = y < 5
i
y
y[i]
y[!i]

y
y > 5

y[y > 5]

y[y < 5]

y == 5
y[y == 5]

a <- letters
a[1:5]
a[a != 'a']
a[!(a == 'a')]

z[i]
x[i]

x[x == 2]
z

names(x) <- z
x
x["c"]
x['c']
x[c("b", "d", "g")]
x[-1]
x[-c(1, 2, 3)]

x
x[3]
x[3] <- 11

x['c'] <- 11
x[c("b", "d", "g")] <- 0
x

x[x == 0]
x[x != 0]

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

length(y)
length(x)

length(x[x == y])

x[x == y] |>
    length()

# erro ao trabalhar com vetores com dimensões distintas 
x <- c(1, 5, 7)
y <- c(1, 2, 3, 4, 5, 6, 7) 
x + y

