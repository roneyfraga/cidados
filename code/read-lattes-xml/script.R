
library(getLattes) 
library(dplyr)
library(purrr) 
library(xml2) 
library(openxlsx) 

zips_xmls <- list.files('xmls/', full.names = T, pattern = '.zip')
length(zips_xmls)

### para um único currículo

curriculo <- xml2::read_xml(zips_xmls[[1]])

getDadosGerais(curriculo)
getArtigosPublicados(curriculo)
getAreasAtuacao(curriculo)
getAtuacoesProfissionais(curriculo)
getBancasDoutorado(curriculo)
getBancasGraduacao(curriculo)
getBancasMestrado(curriculo)
getCapitulosLivros(curriculo)
getDadosGerais(curriculo)
getEnderecoProfissional(curriculo)
getEventosCongressos(curriculo)
getFormacaoDoutorado(curriculo)
getFormacaoMestrado(curriculo)
getFormacaoGraduacao(curriculo)
getIdiomas(curriculo)
getLinhaPesquisa(curriculo)
getLivrosPublicados(curriculo)
getOrganizacaoEventos(curriculo)
getOrientacoesDoutorado(curriculo)
getOrientacoesMestrado(curriculo)
getOrientacoesPosDoutorado(curriculo)
getOutrasProducoesTecnicas(curriculo)
getParticipacaoProjeto(curriculo)
getProducaoTecnica(curriculo)

### para vários currículos

zips_xmls |>
    purrr::map(safely(read_xml)) |> 
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) ->
    curriculos

curriculos |>
    purrr::map(safely(getDadosGerais)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    dados_gerais

curriculos |>
    purrr::map(safely(getArtigosPublicados)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    artigos_publicados

curriculos |>
    purrr::map(safely(getAreasAtuacao)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    areas_atuacao

curriculos |>
    purrr::map(safely(getAtuacoesProfissionais)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    atuacoes_profissionais

curriculos |>
    purrr::map(safely(getBancasDoutorado)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    bancas_doutorado

curriculos |>
    purrr::map(safely(getBancasGraduacao)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    bancas_graduacao

curriculos |>
    purrr::map(safely(getBancasMestrado)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    bancas_mestrado

curriculos |>
    purrr::map(safely(getCapitulosLivros)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    capitulos_livros

curriculos |>
    purrr::map(safely(getEnderecoProfissional)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    endereco_profissional

curriculos |>
    purrr::map(safely(getEventosCongressos)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    eventos_congressos

curriculos |>
    purrr::map(safely(getFormacaoDoutorado)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    formacao_doutorado

curriculos |>
    purrr::map(safely(getFormacaoMestrado)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    formacao_mestrado

curriculos |>
    purrr::map(safely(getFormacaoGraduacao)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    formacao_graduacao

curriculos |>
    purrr::map(safely(getIdiomas)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    idiomas

curriculos |>
    purrr::map(safely(getLinhaPesquisa)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    linha_pesquisa

curriculos |>
    purrr::map(safely(getLivrosPublicados)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    livros_publicados

curriculos |>
    purrr::map(safely(getOrganizacaoEventos)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    organizacao_eventos

curriculos |>
    purrr::map(safely(getOrientacoesDoutorado)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    orientacoes_doutorado

curriculos |>
    purrr::map(safely(getOrientacoesMestrado)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    orientacoes_mestrado

curriculos |>
    purrr::map(safely(getOrientacoesPosDoutorado)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    orientacoes_posdoutorado

curriculos |>
    purrr::map(safely(getOutrasProducoesTecnicas)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    outras_producoes_tecnicas

curriculos |>
    purrr::map(safely(getParticipacaoProjeto)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    participacao_projeto

curriculos |>
    purrr::map(safely(getProducaoTecnica)) |>
    purrr::map(pluck, 'result') |>
    purrr::discard(is.null) |>
    dplyr::bind_rows() ->
    producao_tecnica

lista_df <- list(dados_gerais, artigos_publicados, areas_atuacao, 
                 atuacoes_profissionais, bancas_doutorado, bancas_graduacao, 
                 bancas_mestrado, capitulos_livros, endereco_profissional, 
                 eventos_congressos, formacao_doutorado, formacao_mestrado, 
                 formacao_graduacao, idiomas, linha_pesquisa, livros_publicados, 
                 organizacao_eventos, orientacoes_doutorado, orientacoes_mestrado,
                 orientacoes_posdoutorado, outras_producoes_tecnicas, 
                 participacao_projeto, producao_tecnica)

names(lista_df) <- c('dados_gerais', 'artigos_publicados', 'areas_atuacao', 
                 'atuacoes_profissionais', 'bancas_doutorado', 'bancas_graduacao', 
                 'bancas_mestrado', 'capitulos_livros', 'endereco_profissional', 
                 'eventos_congressos', 'formacao_doutorado', 'formacao_mestrado', 
                 'formacao_graduacao', 'idiomas', 'linha_pesquisa', 'livros_publicados', 
                 'organizacao_eventos', 'orientacoes_doutorado', 'orientacoes_mestrado',
                 'orientacoes_posdoutorado', 'outras_producoes_tecnicas', 
                 'participacao_projeto', 'producao_tecnica')

lista_df |>
    purrr::map(function(x) x |> dplyr::select(!where(is.list))) ->
    lista_df2

openxlsx::write.xlsx(lista_df2, file = "lattes_excel.xlsx", overwrite = T, asTable = T)

# testar erros aqui
# for (i in seq_along(lista_df2)) {
#     print(names(lista_df2)[i])
#     openxlsx::write.xlsx(lista_df2[[i]], file = "~/Downloads/lattes_excel.xlsx", overwrite = T, asTable = T)
# }
