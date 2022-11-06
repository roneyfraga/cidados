
# ----------
# básico

1 + 1
2 + 2
2 * 2
4 / 2

"Hello World"
print("Hello World")

# adiciona nova linha na tela
println("Hello World")

# ; ponto e vírgula no final do comando não mostra o resultado
2 * 2;

# resetar o ambiente de trabalho
workspace()


# ----------
# pacotes

# habilitar instalador de pacotes
using Pkg

# instalar pacotes DataFrames
Pkg.add("DataFrames")

# habilitar  DataFrames
using DataFrames

# sintax Pkg.[comando]
# exemplo
DataFrames.groupby


# ----------
# help

# help com ?[comando]
?sort
?DataFrames
?DataFrames.describe

# ] para entrar no help do pacote Pkg
]

# help retorna todas as funções
help    

# ?[função] retorna o help da função de determinado pacote
?rm     

# backspace retorna para o help geral do julia
`backspace`


# ----------
# unicode

# \alpha \beta \pi 

α = 2
β = 3

α * β

π


# ----------
# variáveis

nova_var = "Hello World"

# podem ser atualizadas
nova_var = "Hello World - version updated "

nova_var2 = "Algum texto"

nova_var * nova_var2

# tipo de variável
typeof(nova_var)
typeof(α)


# ----------
# operadores aritiméticos

# ordem: / * + -
2 + 5 - 6 / 2 * 3

(2 + 5) - (6 / 2) * 3

6 / 2 * 3


# ----------
# comentários

# para uma única linha, ou 

 """ para 
 várias 
 linhas, 
 até terminar com
 """

#= 
ou mesmo
uma 
forma 
mais 
simples
=#


# ----------
# forma correta de nomear variáveis

# variáveis devem começar com letras
a = "essa é uma variável"

a1 = "também um um bom nome"

# var_name@ não é permitido

# quote, e outros nomes reservados não são permitidos


# ----------
# Arrays 

# arrays são escritos com: [,]
a1 = [1, 2, 3, 4, 5]

# float
a2 = [1, 2.0, 3, 4, 5]

s1 = ["I", "Love", "Julia"]

s1[1]
s1[2]
s1[3]

# merge
[a1, a2]

# array de funções
f1 = [print, println, printstyled]

# mistura tipos
a3 = [1, 2.0, "Julia"]

# determinar o tipo
type_int = Int64[1, 2, 3, 4, 5]
type_string = String["I", "Love", "Julia"]

# duas dimensões
array_2d = [1 2 3 4; 5 6 7 8]

# selecinar sub-arrays
array_2d[:,2]
array_2d[1,:]

array_rand = rand(3)
array_rand_2d = rand(3, 3)


# ----------
# ranges

1:10
collect(1:10)

# início, intervalor, fim
collect(1.5:.5:5.5)
collect(1:10:100)
collect(0:10:100)
collect(100:-20:0)

# selecionando o segundo elemento
collect(100:-20:0)[2]

collect(100:-20:0)[end-1]
collect(100:-20:0)[begin:3]
collect(100:-20:0)[1:3]


# ----------
# tuples

# () parêntesis
t1 = (1, 2, 3, 4, 5)

# arrays in [] 
a1 = [1, 2, 3, 4, 5]

# imutáveis, diferente de arrays
a1[2] = 20
a1

# erro
t1[2] = 20

# duas dimensões
t2 = ((1, 2), (3, 4))

# acessar tuples de duas dimensões
t2[1][2]

# merge
t3 = (aa = (1, 2), bb = (3, 4))
t4 = (cc = (5, 6))

(t3, t4)


# ----------
# dictionary

# pares de chaves e valores: eficientes

# key são strings
# values são intinger
Cars = Dict("Car1" => 1000, "Car2" => 2000, "Car3" => 3000)

Cars["Car1"]

# forma alternativa 
Cars2 = Dict(:Car1 => 1000, :Car2 => 2000, :Car3 => 3000)

Cars2[:Car1]

# determinado dicionário tem uma chave?
haskey(Cars2, :Car3)
haskey(Cars2, :Car4)

delete!(Cars2, :Car1)
keys(Cars2)
values(Cars2)
merge(Cars, Cars2)


# ----------
# sets

# não aceita elementos duplicados, e não importa a ordem

sports_brands = Set(["Adidas", "Nike" , "Puma", "Rebook"]) 

in("HRX", sports_brands)
in("Puma", sports_brands)

sports_brands_new = Set(["Adidas", "Nike" , "HRX", "Rebook"]) 

union(sports_brands, sports_brands_new)
intersect(sports_brands, sports_brands_new)
setdiff(sports_brands, sports_brands_new)

push!(sports_brands, "marca_adicionada")


# ----------
# date and time

using Dates

now()
today()

data = Date(2000, 2, 5) # YYYY-MM-DD
data_hora = DateTime(2000, 2, 5, 10, 15, 25) # YYYY-MM-DD-HH:MM:SS

# extrair parte da data
year(data_hora)
month(data_hora)
day(data_hora)
hour(data_hora)
minute(data_hora)
second(data_hora)
dayofyear(data_hora)
dayname(data_hora)

Dates.format(data, "yy-mm-dd")

# ou 
formato = Dates.format("yy-mm-dd") 
Dates.format(data, "yy-mm-dd")

# time zone
now(UTC)


# ----------
# conditionals

a = 10

# if ?
a > 10 ? "Yes" : "No"

a >= 10 ? "Yes" : "No"

b = 20

# or ||
a >= 10 || b < 20

# and &&    
a >= 10 && b < 20
a >= 10 && b <= 20

if a > 10
    print("a é maior que 10")
elseif a < 10
    print("a é menor que 10")
else
    print("a é igual a 10")
end

country = "Brazil"

if country == "Brazil" 
    print("mencionou Brazil")
else
    print("falou errado")
end


# ----------
# loops

for i in sports_brands
    print(i, " ")
end

for i in sports_brands
    println(i)
end

for i in ["Adidas", "Puma", "Nike"]
    println(i)
end

for i in "Adidas"
    println(i)
end

for i in (1:9)
    println(i)
end

for range in (1:9)
    @show range
end

for i in 1:10
    j = i * 10
    println("$(j) é multiplicação entre $(i) e 10")
end

# encontrar números primos
for i in 1:10
    if i % 2 == 0
        continue
    end
    println(i)
end

a = 1

while a < 10
    println(a)
    a += 1
end


# ----------
# comprehensions

# loops escritos de forma mais eficiente
x = [i for i in 1:10]

x = [i * 2 for i in 1:10]

x = [i^2 for i in 1:10]

# salvar como Set
s = Set([i for i in 1:10])

# gerando dicionário com chaves para números
alphabet = Dict(string(Char(x1 + 64)) => x1 for x1 in 1:26)

# tupple array generated with comprehensions
[(x, y) for x in 1:3, y in 1:2]

[x for x in 1:10 if x%2 ==0]


# ----------
# working with strings

s1 = "I love Julia"

length(s1)
lastindex(s1)

s1[4]
s1[3:6]

# combinar strings
"Love" * "Julia"

"Love" ^ 5

string("Love ", "Julia")

# dividir string
split(s1)
split(s1, "e")
split(s1, "")

parse(Int64, "100")
parse(Float64, "100.5")

# encontrar
# aspas simples
in('I', s1)

occursin("love", s1)

findfirst("l", s1)
findfirst("love", s1)
s1 = replace(s1, "love" => "adore")


# ----------
# functions

# forma compacta
f(x) = x * x
f(10)

# forma compacta
f(x, y) = x * 2 - y
f(10, 12)

# forma padrão
function multiply(x, y)
    return x * y
end

multiply(2, 4)

function convert_meter_to_inch(val)
    return val * 39.37
end

convert_meter_to_inch(1.5)

function convert_meter_to_inch(val, name = "Patron")
    if name == "Patron"
        println("Value for name is not supplied")
    else 
        println("Hi..", name, " The conversion value is ")
    end
        return val * 39.37
end

convert_meter_to_inch(2.3)
convert_meter_to_inch(2.3, "Teteti")


# ----------
# formatting numbers and strings

using Printf

name = "Teteti"

# não imprimir
name = "Teteti";

@printf("Hello %s", name)
@sprintf("Hello %s", name)

ch = 'i'
@printf("%c", ch)

x = 100
@printf("Value of x is %d", x)

y = 100.5
@printf("Value of x is %f", y)

# contrar número de casas decimais
@printf("Value of x is %.2f", y)

# transformar em notação científica
z = 1243987234
@printf("%e", z)
@printf("%.2e", z)


# ----------
# working with real word files .csv

using Pkg

# instalar
Pkg.add("CSV")

using CSV
using DataFrames

mtcars = CSV.read("mtcars.csv", DataFrame)
typeof(mtcars)

names(mtcars)
size(mtcars)


# ----------
# DataFrames

mtcars.gear
mtcars.mpg
mtcars[:, "mpg"]
mtcars[:, 2:5]
mtcars[:, [2, 4, 6]]
mtcars[1:6, [1, 2, 4, 6]]

DataFrame(x = [1, 2, 3], y = 4:6, z = 9)
DataFrame([(x = 1, y = 2), (x = 3, y = 4)])
DataFrame("x" => [1, 2], "y" => [3, 4])
DataFrame(x = Int[], y = Float64[])

# o "." ponto, indicar aplicar para todas as linhas
mtcars[mtcars.mpg .>= 30, :]

# reshape pivot_[longer or wider]
stack()
unstack()

sort(mtcars, :mpg)
nrow(mtcars)
ncol(mtcars)
names(mtcars)

# NA
dropmissing()
alowmissing()
disasalowmissing()
completecases()

# summarize data
combine(mtcars, :mpg => sum)
combine(mtcars, :mpg => sum => :mpg_sum)
transform()

# combine data sets
innerjoin()
leftjoin()
rightjoin()
outerjoin()
semijoin()
antijoin()
vcat()
hcat()


# ----------
# estatísticas descritivas

describe(mtcars)
describe(mtcars, :mean, :std)


# ----------
# files ystem
pwd()
readdir()
mkdir()
cd()
mkpath()
isdir()


# ----------
# pipe

using Pkg
using Pipe: @pipe # para evitar conflito com Base.Pipe
using CSV
using DataFrames

a1 = [1, 2, 3, 4, 5]

@pipe a1 |> sum()

sum(a1)

mtcars = CSV.read("mtcars.csv", DataFrame)

# group data sets e pipe |>
@pipe mtcars |>
    filter(:cyl => == ("6"), _) |>
    groupby(mtcars, :gear) |>
    combine(_, :mpg => sum)
