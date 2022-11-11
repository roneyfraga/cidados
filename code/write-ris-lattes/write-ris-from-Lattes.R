
source('utils.R')

# importar dados obtidos pelo pacote getLattes
artigos <- readRDS('artigos.rds') 

# nomes
names(artigos)

# linhas e colunas
dim(artigos)

# primeiras linhas
head(artigos)

# com nome nomes de citação, ex: BUAINAIN, Antonio Marcio
writeRisLattes(artigos, filename = 'papers_nome_citacao.ris', citationName = T)

# com nome completo do autor, ex: Antonio Marcio Buainain
writeRisLattes(artigos, filename = 'papers_nome_completo.ris', append = F, citationName = F)


