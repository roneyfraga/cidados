
library(tidyverse)
library(archive)
library(janitor)
library(fs)

diretorio_de_destino <- '~/Downloads/'

anos <- 2020:2022
meses <- formatC(1:12, width = 2, flag = "0")

for (i in seq_along(anos)) {

    for (j in seq_along(meses)) {

        cat('baixando ano', anos[i], 'mês', meses[j], '\n')

        tryCatch({
            download.file(
                          paste0("ftp://ftp.mtps.gov.br/pdet/microdados/NOVO%20CAGED/",
                                 anos[i], '/', anos[i], meses[j],
                                 "/CAGEDFOR", anos[i],
                                 meses[j],
                                 ".7z"),
                          quiet = TRUE,
                          destfile = paste0(diretorio_de_destino, "CAGEDFOR", anos[i], meses[j], '.7z'),
                          mode = "wb")},
                 error = function(err) { warning("file could not be downloaded") })
}}

fs::dir_ls(path = diretorio_de_destino, glob = "*.7z$") -> 
    cagedfor_baixadas

cagedfor_lista <- list()

for (i in seq_along(cagedfor_baixadas)) {
 
  cat('lendo mês', i, '\n')
 
  readr::read_csv2(archive::archive_read(cagedfor_baixadas[i])) |>
    janitor::clean_names() ->
    cagedfor_lista[[i]]
 
}

dplyr::bind_rows(cagedfor_lista) -> 
    cagedfor 


