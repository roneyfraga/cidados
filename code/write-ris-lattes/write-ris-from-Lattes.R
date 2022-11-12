
# carregar função writeRisLattes()
source('utils.R') 

artigos <- readRDS('artigos.rds') 

# com nome nomes de citação, ex: BUAINAIN, Antonio Marcio
writeRisLattes(artigos, 
               filename = 'artigos_nome_citacao.ris', 
               citationName = T,
               append = F,
               tableLattes = 'ArtigosPublicados')

# com nome completo do autor, ex: Antonio Marcio Buainain
writeRisLattes(artigos, 
               filename = 'artigos_nome_citacao.ris', 
               citationName = T, 
               append = F,
               tableLattes = 'ArtigosPublicados')

livros <- readRDS('livros.rds') 

writeRisLattes(livros, 
               filename = 'livros.ris', 
               append = F, 
               citationName = T, 
               tableLattes = 'Livros')

capitulos_livros <- readRDS('capitulos_livros.rds') 

writeRisLattes(capitulos_livros, 
               filename = 'capitulos_livros.ris', 
               append = T,
               citationName = F, 
               tableLattes = 'CapitulosLivros')


