
library(tidyverse)
library(archive)
library(janitor)

caged_download <- function(competencia = 'FOR',
                           ano = 2020,
                           mes = c('01', '02'),
                           dir_download = '.') {

    if (!(competencia == c('FOR', 'MOV', 'EXC'))) {
        stop("Competencia deve ser FOR, MOV ou EXC", call. = FALSE)
    }

    if (class(ano) != 'numeric') {
        stop("ano deve ser numérico", call. = FALSE)
    }

    if (nchar(mes[1]) != 2) {
        stop("mes deve estar no formato: 01, 02, 03, 04, 05 ...", call. = FALSE)
    }

    if (class(mes) != 'character') {
        stop("mes deve ser character no formato: 01, 02, 03, 04, 05 ...", call. = FALSE)
    }

    for (i in seq_along(competencia)) {

        for (j in seq_along(ano)) {

            for (k in seq_along(mes)) {

                cat('baixando', paste0("CAGED", competencia[i], ano[j], mes[k], '.7z'), '\n')

                tryCatch({
                    download.file(
                                  paste0("ftp://ftp.mtps.gov.br/pdet/microdados/NOVO%20CAGED/",
                                         ano[j], '/', ano[j], mes[k],
                                         "/CAGED", competencia[i], ano[j],
                                         mes[k],
                                         ".7z"),
                                  quiet = TRUE,
                                  destfile = paste0(dir_download, "CAGED", competencia[i], ano[j], mes[k], '.7z'),
                                  mode = "wb")},
                         error = function(err) { warning("file could not be downloaded") })

                cat(paste0(dir_download, "CAGED", competencia[i], ano[j], mes[k], '.7z'), 'baixado', '\n')

    }}}
}

meses <- formatC(1:12, width = 2, flag = '0')

# dir_download_caged <- 'C://Users//FE-UFMT//Downloads//'
dir_download_caged <- '~/Downloads'

caged_download(competencia = 'FOR',
               ano = '2021',
               mes = meses,
               dir_download = dir_download_caged)
