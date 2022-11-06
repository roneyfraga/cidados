# class 01 
# 2019-07-15
# Pietro Basttiston

# ------------------------------
# importar bibliotecas

# importar pandas e para acessar qq função fazer pandas.read_csv()
import pandas

# importa com um apelido
# para acessar as funções fazer: np_read.csv()
import pandas as pd

# importa todos os objetos do pacote pandas, inclusive funções intermediárias
# não precisar de pandas para acessar a função, exemplo: read_csv()
from pandas import *

# importar apenas uma função específica
# importar apenas read_csv de pandas, mantém o namespace limpo
from pandas import read_csv

# o conceito de funções é chamado de module
# criar uma pasta com códigos de python com a pasta __init__py
# todas as funções .py serão importadas

# para fazer deteach() equivalente R
# deixar de considerar as funções de determinada library
del(pd)

# ------------------------------
# help 

# python original help
help(len)

# ipython help
len?

# This notation works for just about anything, including object methods
# equivalente ao c() do R
L = [1, 2, 3]
L.insert?

# or even objects themselves
L?

# this will even work for functions or other objects you create yourself! 
def square(a):
     "Return the square of a."
     return a ** 2

square?

# Accessing Source Code with `??`

square??

# código em C, não mostra muita coisa
len??

# ------------------------------
# python version

from platform import python_version
python_version()

# ------------------------------
# comments

# comentário simples com '#'

"""
comment in 
multiple 
lines
"""

""" pode ser utilizado tb para escerver 
strings in múltiplas linhas """

# ------------------------------
# strings multiplication

# + é igual concatenar a string

nyname = "Roney"

nyname + nyname

# não funciona
nyname * nyname

# ------------------------------
# increment 

# i += i +1

a = 5
a += 1
a

b = 5
b += b
b

name = 'Ivette'
name *= 3
name

# ------------------------------
# functions

print(a)

len(name)


# ------------------------------
# fundamentals structures

# list
l = [1,3,5]
l

l[0]

# contando do final para o início
l[-2]

list(name)
name[0]
name[1]


# ------------------------------
# object oriented programming 

# atributtes
# methods
## class

l.append(100)

# encontrar o índice específico
l.index(3)
l.index(100)

# adicionar lista na lista
l.extend([4,6,8,10])

# adicionar 200 na posição 3
l.insert(3,200)

# listas podem hospedar diferentes tipos de dados
l.append('Roney')
l
type(l[0])
type(l[9])


# ------------------------------
# arguments in functions

b = 'teste'
print(a,b, sep=",")

# ------------------------------
# dicts
# {Chave1 : Valor1, Chave2:Valor2}

# lista com rótulos = `Dictionaries`
# começam com `{}` a ordem dos valores não é mantida

language = {'Pietro':'Python','Ivette':'R','Tania':'Stata'}
language
language['Ivette']

# pode hospedar qq coisa
language = {'Pietro':'Python','Ivette':'R','Tania':'Stata',2:5}

# converter as chaves em lista
list(language)

# olhar para valores
language.values()


# ------------------------------
# tuple

# um tipo de lista que permite alteração dos elementos 

# esse tipo é muito útil para construir dicionários 
# inicia com ()

t = (1,2,3)

len(t)

t[-1]

# funciona
t + t
t * 3

a = [1,2,3]
a * 3


# ------------------------------
# sets

# {}
# se não tiver : é um set e não um dicts

s = {1,2,2,2,3,4,4,5}
s
# os valores duplicados são removidos

# set can be changed 
s.add(5)

s.remove(5)


# ------------------------------
# operators

# comparações

a == b

4 < 5

# list
[1,2,3] == [1,3,2]

# set
{1,2,3} == {1,3,2}

l = [1,2,3]

4 in l

'R' in name

# for dics in look to the key
1 in {1:2,4:5}
2 in {1:2,4:5}

1 in l and 2 in l
1 in l or 2 in l

# casting to boolean
i = 10

i > 20 or i

# transformar em booleano
bool(10)
bool(-1)
bool(1.4)
bool(0.0)

bool([])
bool([1])
bool([[]])

bool('')
bool('teste')
bool([''])

# false = zero, empty
# true = anything else

# ------------------------------
# conditions

user = 'Pietro'

if user == 'Pietro':
    print('Hello Pietro')


user = 'Pietro'
if user == 'Pietro':
    print('Hello Pietro')
else:
    print('Who are you?')

# elif
# intermediário condicional do if, antes do else

a = 10
if(a>10):
    print("Value of a is greater than 10")
else:
    print("Value of a is 10")


# ------------------------------
# loops

for person in ['Pietro','Ivette']:
    print('Hello',person)

# a variável irá armazenar a última ocorrência
person

for letter in 'Roney':
    print(letter)
     
# ranger
# números do loop
range(10)
list(range(10))
range(5,10)
list(range(5,10))

for i in range(10):
    print(i**2)

# vector[from:to]
# é utilizado para visualizar valores, não para criar

# loop pouco eficiente
for i in range(1000):
    if i < 10:
        print(i**2)

# evitar que o loop se repita
for i in range(1000):
    if i < 10:
        print(i**2)
    else: 
        break

# menos eficiente, ele não imprime mas roda todos os loops
for i in range(1000):
    if i >= 10:
        continue
    print(i**2)

# while
i = 1
while i**2 < 1000:
    print(i**2)
    i += 1

# obs.: o implemento += faz o while ser mais flexível em Python que em R

# % resto, o que sobra de uma divisão
10 % 3
9 % 3

for i in range(10):
    for j in range(1,i):
        if i % j == 0:
            print(i)


# efeitos do range
range(2*10)
list(range(2*10))
range(2**3)
list(range(2**3))

# ------------------------------
# functions

# sem qualquer argumento
def say_hello():
    print('Hello')

say_hello()

# com argumento
def say_hello(name):
    print('Hello',name)

say_hello('Roney')

# ela só roda com o argumento sendo explicitado
say_hello()

# se usar o argumento com '' a função passa a funcionar com e sem argumento
def say_hello(name=''):
    print('Hello',name)

say_hello('Roney')
say_hello()

def say_hello(name, language='English'):
    name = name.capitalize()
    if language == 'Portuguese':
        print('Bom dia', name)
    elif language == 'English':
        print('Hello',name)
    else:
        print('Language unknown')

say_hello('roney', language='Portuguese')
say_hello('roney', language='English')
say_hello('roney', language='')
say_hello('roney')

# the return argument stop the function
def add_together(a,b):
    return a + b
    print('hello')

add_together(3,5)

# print hello does not work, because the return
# usar return pode ser útil para retornar a primeira ocorrência
# uma segunda forma de parar a execução, como o break 


# boas páticas, comentar no início

def say_hello(name, language='English'):
    """
    This functions says hello to "name"
    Arguments: 
    """
    name = name.capitalize()
    if language == 'Portuguese':
        print('Bom dia', name)
    elif language == 'English':
        print('Hello',name)
    else:
        print('Language unknown')

say_hello?

# sphinx 
# forma de gerar códigos para documentação de funções e classes 
# é um software externo, não compensa para meu próprio código


# ----------
# duck typing

# como checar o tipo de variável para ser executada corretamente em funções

def add_together(a,b):
    return a + b

add_together(3,4.5)

add_together('Roney','Fraga')


def multiply_together(a,b):
    return a * b

# não vai executar, pois, não é número
multiply_together('Roney','Fraga')

# somar 
def add_all(s):
    total = 0
    for element in s:
        total += element
        return total

# ------------------------------
# importing modules
import math

math.log(3)

from math import log

log(3)

# o conceito de funções é chamado de module
# criar uma pasta com códigos de python com a pasta __init__.py
# todas as funções .py serão importadas
# colocar o arquivo __init__.py na pasta para o python vai carregar os arquivos automaticamente

# ------------------------------
# openning a file

# como não fazer
with open('data/quotes.csv') as a_file:
    cotent = a_file.read()


# lista no Python permite colocar várias tipos de variáveis, como texto, número, etc.
# numpy é a forma de trabalhar só com um tipo de dado, permitindo vetorização
# array é nome desse tipo de vetor
# numpy é muito eficiente quanto a tempo de processamento
# numpy é ótimo para trabalhar apenas com dados numéricos

import numpy as np

a = np.array([3,15,2,4])
a
a * 4
a.mean()
a.max()

# posso colocar diferentes redes como dimensões de uma lista no python ou como um array
# a lista é mais direto e simples, pois, ela aceita qualquer tipo de dado

# pandas é otimizado para dados
# 
import pandas as pd

pop = pd.Series([1,3,5], index=['Italy','Spain','Brazil'])

# o número das linhas são nomes
pop.loc['Italy']


# pandas data frame
gdp = pd.Series([10,333,544], index=['Italy','Spain','Brazil'])

# criando um data frame a partir de um dicionário (dics) 
# nesse caso a ordem dos valores e das key  não importa, pandas faz um merge
df = pd.DataFrame({'population': pop, 'GDP pc': gdp})

df.loc[:,'population']

df['population']

df['GDP'] = df['population'] * df['GDP pc']

df

df.mean()
df.std()

prices = {'car':1000,
        'bread':0.2,
        'house':10000}

data = pd.DataFrame({2010: prices})

data[2011] = data[2010] * 1.03
data['2011 ou mais'] = data[2010] * 1.03

data

# nomes de colunas e indexes podem ter '' ou não, ser numéricos ou textuais
# para saber qual o padrão fazer:
data.columns
data.index

# lendo dados de arquivos externos
data = pd.read_csv('quotes.csv')

# determinar para uma coluna ser index
data.set_index('time')

# é possível fazer index de mais de uma coluna
data.set_index(['time','ticker'])

import pandas as pd
import pandas_datareader.data as web
import matplotlib

# lendo dados de exemplo
apple = web.DataReader('aapl','yahoo','2018-07-01','2019-06-30')
google = web.DataReader('googl','yahoo','2018-07-01','2019-06-30')

data = pd.concat({'apple' : apple, 'google' : google})

# gerando gráficos
data.loc['apple'][['High','Low']].plot()
data[['High','Low']].plot()

# salvar o gráfico 
import matplotlib.pyplot
matplotlib.pyplot.savefig('test_graph.pdf')

