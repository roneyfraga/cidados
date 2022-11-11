
# função para transformar dados do Lattes em arquivos formato RIS
writeRisLattes <- function(x, filename = 'papers.ris', append = T, citationName = F, tableLattes = 'ArtigosPublicados') {

  filename2 <- strsplit(filename, split = '\\.') 
  filename_ext <- filename2[[1]][length(filename2[[1]])]

  if (filename_ext != 'ris') {
    stop("The file extention must be '.ris'", call. = FALSE)
  }

  if (!is.logical(append)) {
    stop("'append' must be logical (TRUE or FALSE)", call. = FALSE)
  }

  if (!is.logical(citationName)) {
    stop("'citationName' must be logical (TRUE or FALSE)", call. = FALSE)
  }

  if (!any(tableLattes == c('ArtigosPublicados'))) {
    stop("'tableLattes' must be a table present in Lattes, see getLattes package", call. = FALSE)
  }

  if (append != T) write("", file = filename, append = F)

  if (tableLattes == 'ArtigosPublicados') {

    for (i in 1:nrow(x)) {

      write("TY  - JOUR", file = filename, append = T)
      write(paste0("TI  - ", x$titulo_do_artigo[i]), file = filename, append = T)
      write(paste0("PY  - ", x$ano_do_artigo[i]), file = filename, append = T)
      write(paste0("T2  - ", x$titulo_do_periodico_ou_revista[i]), file = filename, append = T)
      write(paste0("SN  - ", x$issn[i]), file = filename, append = T)

      if (citationName == F) { 
        for (k in seq_along(x$autores[[i]]$nome_completo_do_autor)) { write(paste0("AU  - ", x$autores[[i]]$nome_completo_do_autor[k]), file = filename, append = T)}
      } else { 
        for (k in 1:nrow(x$autores[[i]])) { write(paste0("AU  - ", strsplit(x$autores[[i]][k, 'nome_para_citacao'], split = ';')[[1]][1]), file = filename, append = T)}
      }

      write(paste0("VL  - ", x$volume[i]), file = filename, append = T)
      write(paste0("IS  - ", x$serie[i]), file = filename, append = T)
      write(paste0("DO  - ", x$doi[i]), file = filename, append = T)
      write(paste0("SP  - ", x$pagina_inicial[i]), file = filename, append = T)
      write(paste0("EP  - ", x$pagina_final[i]), file = filename, append = T)
      write(paste0("UR  - ", x$home_page_do_trabalho[i]), file = filename, append = T)
      write(paste0("LA  - ", x$idioma[i]), file = filename, append = T)
      write("ER  - \n", file = filename, append = T)
    }
  }
}

