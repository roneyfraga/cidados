
library(jsonlite) 
library(purrr) 
library(dplyr) 
library(rio) 

jsonlite::fromJSON('exemplo.json') ->
    pcf

#---------------
# desistentes
lista2dfdesistentes <- function(x) {x |> purrr::pluck('desistentes') |> as.data.frame() |> tibble::as_tibble()}

pcf[['rooms']] |>
    purrr::map(purrr::safely(lista2dfdesistentes)) |>
    purrr::map(purrr::pluck('result')) |>
    purrr::discard(is.null) ->
    desistentes

desistentes |> 
    purrr::map(function(x) gsub('^.*questao', 'questao', names(x))) |>
    purrr::map(function(x) gsub('_.*$', '', x)) |>
    purrr::map(function(x) gsub('[[:upper:]].*\\.', '', x)) |>
    purrr::map(function(x) gsub('[[:upper:]].*$', '', x)) |>
    purrr::map(function(x) ifelse(nchar(x) == 0, 'a_deletar', x)) |>
    purrr::map(function(x) gsub('ended', 'endedAt', x)) |>
    purrr::map(function(x) gsub('\\.', '', x)) ->
    desistentes_nomes

desistentes_nomes |> 
    unlist() |> 
    tibble::as_tibble() |> 
    dplyr::count(value, sort = F) |> 
    print(n = Inf)

desistentes2 <- desistentes

for (i in seq_along(desistentes2)) { 
    names(desistentes2[[i]]) <- desistentes_nomes[[i]]
    desistentes2[[i]]$id <- names(desistentes2[i])
}

desistentes2 |> 
    dplyr::bind_rows() |> 
    dplyr::relocate(id, endedAt, questao01:questao09b) |>
    dplyr::relocate(questao07d, .after = questao07c) |>
    dplyr::select(- a_deletar) ->
    desistentes_df

rio::export(desistentes_df, 'desistentes.xlsx') 

#---------------
# aderidos

lista2dfaderidos <- function(x) {x |> purrr::pluck('aderidos') |> as.data.frame() |> tibble::as_tibble()}

pcf[['rooms']] |>
    purrr::map(purrr::safely(lista2dfaderidos)) |>
    purrr::map(purrr::pluck('result')) |>
    purrr::discard(is.null) ->
    aderidos

aderidos |> 
    purrr::map(function(x) gsub('^.*questao', 'questao', names(x))) |>
    purrr::map(function(x) gsub('_.*$', '', x)) |>
    purrr::map(function(x) gsub('[[:upper:]].*\\.', '', x)) |>
    purrr::map(function(x) gsub('[[:upper:]].*$', '', x)) |>
    purrr::map(function(x) ifelse(nchar(x) == 0, 'a_deletar', x)) |>
    purrr::map(function(x) gsub('ended', 'endedAt', x)) |>
    purrr::map(function(x) gsub('\\.', '', x)) ->
    aderidos_nomes

unlist(aderidos_nomes) |> 
    tibble::as_tibble() |> 
    count(value, sort = T) |> 
    slice(1:129) |>
    dplyr::filter(value != 'a_deletar') |> 
    dplyr::pull(value) ->
    var_names

aderidos2 <- aderidos

for (i in seq_along(aderidos2)) { 

    names(aderidos2[[i]]) <- aderidos_nomes[[i]]

    aderidos2[[i]]$id <- names(aderidos2[i])

    aderidos2[[i]] <- aderidos2[[i]][, colnames(aderidos2[[i]]) %in% c('id', var_names)]
}

aderidos2 |> 
    dplyr::bind_rows() |>
    dplyr::mutate(situacao = 'aderidos') |> 
    dplyr::relocate(situacao, id, sort(var_names)) ->
    aderidos_df

aderidos_df |> 
    dplyr::select(situacao, id, endedAt, dplyr::contains('questao43')) |>
    tidyr::drop_na() |>
    dplyr::distinct(.keep_all = TRUE) |>
    dplyr::arrange(id, questao43a) ->
    aderidos_questao43

aderidos_df |> 
    dplyr::select(situacao, id, endedAt, dplyr::contains('questao49')) |>
    tidyr::drop_na() |>
    dplyr::distinct(.keep_all = TRUE) |>
    dplyr::arrange(id, questao49a) ->
    aderidos_questao49

aderidos_df |> 
    dplyr::select(situacao, id, endedAt, dplyr::contains('questao53')) |>
    tidyr::drop_na() |>
    dplyr::distinct(.keep_all = TRUE) |>
    dplyr::arrange(id, questao53a) ->
    aderidos_questao53

aderidos_df |> 
    dplyr::select(situacao, id, endedAt, dplyr::contains('questao56')) |>
    tidyr::drop_na() |>
    dplyr::distinct(.keep_all = TRUE) |>
    dplyr::arrange(id, questao56a) ->
    aderidos_questao56

aderidos_df |> 
    dplyr::select(situacao, id, endedAt, dplyr::contains('questao57')) |>
    tidyr::drop_na() |>
    dplyr::distinct(.keep_all = TRUE) |>
    dplyr::arrange(id, questao57a) ->
    aderidos_questao57

# eliminar questões com linhas duplicadas
names(aderidos_df) |>
    {\(x) x[!grepl('questao43*', x)] }() |>
    {\(x) x[!grepl('questao49*', x)] }() |>
    {\(x) x[!grepl('questao53*', x)] }() |>
    {\(x) x[!grepl('questao56*', x)] }() |>
    {\(x) x[!grepl('questao57*', x)] }() ->
    questoes_para_manter

aderidos_df |>
    dplyr::select(questoes_para_manter) |>
    dplyr::distinct(situacao, id, endedAt, .keep_all = TRUE) ->
    aderidos2_df

l <- list(aderidos = aderidos2_df,
          questao43 = aderidos_questao43, 
          questao49 = aderidos_questao49, 
          questao53 = aderidos_questao53, 
          questao56 = aderidos_questao56, 
          questao57 = aderidos_questao57) 

openxlsx::write.xlsx(l, file = "aderidos.xlsx", asTable = T)

# rio::export(aderidos_df, 'pcf_aderidos_13_09.xlsx') 

#---------------
# nao aderidos

lista2dfnaoaderidos <- function(x) {x |> purrr::pluck('nao_aderidos') |> as.data.frame() |> tibble::as_tibble()}

pcf[['rooms']] |>
    purrr::map(purrr::safely(lista2dfnaoaderidos)) |>
    purrr::map(purrr::pluck('result')) |>
    purrr::discard(is.null) ->
    naoaderidos

naoaderidos |> 
    purrr::map(function(x) gsub('^.*questao', 'questao', names(x))) |>
    purrr::map(function(x) gsub('_.*$', '', x)) |>
    purrr::map(function(x) gsub('[[:upper:]].*\\.', '', x)) |>
    purrr::map(function(x) gsub('[[:upper:]].*$', '', x)) |>
    purrr::map(function(x) ifelse(nchar(x) == 0, 'a_deletar', x)) |>
    purrr::map(function(x) gsub('ended', 'endedAt', x)) |>
    purrr::map(function(x) gsub('\\.', '', x)) ->
    naoaderidos_nomes

unlist(naoaderidos_nomes) |> 
    tibble::as_tibble() |> 
    count(value, sort = T) |> 
    slice(1:22) |>
    dplyr::filter(value != 'a_deletar') |> 
    dplyr::pull(value) |>
    sort() ->
    var_names

naoaderidos2 <- naoaderidos

for (i in seq_along(naoaderidos2)) { 

    names(naoaderidos2[[i]]) <- naoaderidos_nomes[[i]]

    naoaderidos2[[i]]$id <- names(naoaderidos2[i])

    naoaderidos2[[i]] <- naoaderidos2[[i]][, colnames(naoaderidos2[[i]]) %in% c('id', var_names)]

    naoaderidos2[[i]] <- naoaderidos2[[i]] |> mutate_if(is.logical, as.character)

}

naoaderidos2 |> 
    dplyr::bind_rows() |>
    dplyr::mutate(situacao = 'naoaderidos') |> 
    dplyr::relocate(situacao, id, sort(var_names)) ->
    naoaderidos_df

rio::export(naoaderidos_df, 'naoaderidos.xlsx') 

