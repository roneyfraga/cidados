
# https://youtu.be/vmEHCJofslg

import pandas as pd

df = pd.read_csv('data/pokemon_data.csv')
# df = pd.read_excel('data/pokemon_data.xlsx')
# df = pd.read_csv('data/pokemon_data.txt', delimiter='\t')

# head and tail
print(df.tail(5))

print(df.head(5))

df.head(5)
df.tail(5)

# read headers
df.columns

# coluna específica
df.Name
df['Name']
df[['Name']]

# colunas específicas e linhas específicas
df['Name'][0:5]
df[['Name','Type 1','HP']][0:5]

# linha específica
df.iloc[0:3]

# ler de um local específico
# seleciona linhas e colunas por índice
df.iloc[2,1]
df.iloc[0:6, 1:5]

# loc torna um pandas.DataFrame igual a um R::dataframe
# seleciona linhas e coluns por nome
df.loc[ df.HP > 50, ['Name', 'Type 1', 'HP', 'Speed']]

df.loc[0:5, ['Name', 'Type 1', 'HP', 'Speed']]

df.loc[df['Type 1']=='Fire'][0:5]

# estatísticas básicas  
df.describe()

# sorting
df.sort_values('Name', ascending=False)
df.sort_values(['Type 1', 'HP'], ascending=True)
df.sort_values(['Type 1', 'HP'], ascending=[1,0])

# making changes to the data
df['Total'] = df['HP'] + df['Attack'] + df['Defense']
df.Total = df.HP + df.Attack + df.Defense

# deletar uma coluna
df = df.drop(columns=['Total'])

# somar as colunas 4 até a 9 para todas as linhas
df['Total'] = df.iloc[:,4:9].sum(axis=1) 

# mudar a ordem das colunas
cols = df.columns.values
[cols[0:4], cols[4:13]]
df = df[cols[0:4], cols[4:11]]

# salvar um data frame
df.to_csv('modified.csv')
df.to_csv('modified.csv', index=False)
df.to_csv('modified.csv', index=False, sep='\t')

df.to_excel('modified.xlsx', index=False)

# filtering data
df.loc[(df['Type 1'] == 'Grass') & (df['Type 2'] == 'Poison')]
df.loc[(df['Type 1'] == 'Grass') | (df['Type 2'] == 'Poison')]
df.loc[(df['Type 1'] == 'Grass') & (df['Type 2'] == 'Poison') & (df['HP'] >70)]

