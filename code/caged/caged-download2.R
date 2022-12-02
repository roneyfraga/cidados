
#install.packages("tidyverse")
#install.packages("archive")

library(tidyverse)
library(archive)
library(janitor)

# Dowload CAGEDFOR #
# getwd()
# setwd('C:/caged')

## Definindo partes variáveis do universo possível de links

competencias <- c('MOV', 'FOR', 'EXC')
anos <- 2020:2022  # futuramente analisar anos disponiveis no site automáticamente
meses <- formatC(1:12, width = 2, flag = '0')

## Aplicando Loop de comando

for(i in seq_along(competencias)){
 
  for(j in seq_along(anos)){
   
    for(k in seq_along(meses)){
     
      cat(competencias[i], anos[j], 'mês', meses[k], '\n')
     
      tryCatch({
        download.file(
          paste0("ftp://ftp.mtps.gov.br/pdet/microdados/NOVO%20CAGED/",
                 anos[j], '/', anos[j], meses[k],
                 "/CAGED", competencias[i], anos[j],
                 meses[k],
                 ".7z"),
          quiet = TRUE,
          destfile = paste0("CAGED", competencias[i], anos[j], meses[k], '.7z'),
          mode = "wb")},
        error = function(err) { warning("file could not be downloaded") })
    }}}

# Lendo e Unindo os arquivos de mesma natureza #

for(k in seq_along(competencias)){
 
  # cagedxxx_baixadas <- fs::dir_ls(glob = "CAGEDXXX*.7z$")
 
  assign(tolower(paste0('caged', competencias[k], '_baixadas')),
         fs::dir_ls(glob = paste0('CAGED', competencias[k], '*.7z$')))
 
  # cagedmov_lista <- list()
 
  assign(tolower(paste0('caged', competencias[k], '_lista')),
         list())
}

## Não correr arquivo ################### como funcionou para 1 competencia

cagedmov_baixadas <-
  fs::dir_ls(glob = "CAGEDMOV*.7z$")  #realizado

cagedmov_lista <- list()              #realizado

for(i in seq_along(cagedmov_baixadas)){
 
  cat('Lendo periodo', i, '\n')
  readr::read_csv2(archive::archive_read(cagedmov_baixadas[i])) |>
    janitor::clean_names() |>
    dplyr::filter(uf == 51) ->
    cagedfor_lista[[i]]
}
####### Não correr arquivo ############################################

# tentativa sucedida # objetivo consolidar em 1 tiblle MOV FOR EXC

arquivos_caged <-
  function(entrada) {
 
  if(!any(entrada == c('MOV', 'FOR', 'EXC'))) {
    stop("Competencia deve ser FOR, MOV ou EXC", call. = FALSE)
  }
 
  caminho_dos_arquivos <- get(paste0('caged', tolower(entrada), '_baixadas'))
  lista_arquivos_periodo <- vector(mode = 'list', length = length(caminho_dos_arquivos))
 
  for(l in seq_along(caminho_dos_arquivos)) {
     
    cat('Carregando arquivo', caminho_dos_arquivos[l],
        ' | loop', l, 'de', length(caminho_dos_arquivos), '\n')
   
    readr::read_csv2(archive::archive_read(caminho_dos_arquivos[l])) |>
      janitor::clean_names() |>
      dplyr::filter(uf == 51) ->
      lista_arquivos_periodo[[l]]
  }
 
  names(lista_arquivos_periodo) <- gsub('.7z', '', as.character(caminho_dos_arquivos))
 
  return(lista_arquivos_periodo)
}

a = arquivos_caged('EXC')
a
