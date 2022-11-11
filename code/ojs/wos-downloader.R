
library(rio)
library(pipeR)
library(tidyverse)
library(httr)
library(xml2)
library(rvest)

source('utils.R')

# ------------------------------------------------------------
# Análise Econômica

url = 'https://seer.ufrgs.br/AnaliseEconomica/issue/archive'

# ------------------------------
# getIssues
issues <- getIssues(url)

# ------------------------------
# getSummary
summaries <- lapply(issues,getSummaries)
summaries <- unlist(summaries)

# ------------------------------
# getPapersInfo
papers <- lapply(summaries[1:5],getPapersInfo) 

papers %>>% 
    bind_rows() %>>% 
    glimpse
    (export(.,"AnaliseEconomica.rds"))


# ------------------------------------------------------------
# Brazilian Review of Econometrics

url = 'http://bibliotecadigital.fgv.br/ojs/index.php/bre/issue/archive'
issues <- getIssues(url)
summaries <- lapply(issues,getSummaries)
summaries <- unlist(summaries)
papers <- lapply(summaries,getPapersInfo) 
papers %>>% 
    bind_rows() %>>% 
    (export(.,"BrazilianReviewEconometrics.rds"))

getPapersInfo(summaries[[1]]) %>>% glimpse()

# ------------------------------------------------------------
# Revista de Economia Contemporânea
url = 'https://revistas.ufrj.br/index.php/rec/issue/archive'
issues <- getIssues(url)
summaries <- lapply(issues,getSummaries)
summaries <- unlist(summaries)
papers <- lapply(summaries,getPapersInfo) 
papers %>>% 
    bind_rows() %>>% 
    (export(.,"RevistaEconomiaContemporanea.rds"))


# ------------------------------------------------------------
# Brazilian Review of Finance

url = 'http://bibliotecadigital.fgv.br/ojs/index.php/rbfin/issue/archive'
issues <- getIssues(url)
summaries <- lapply(issues,getSummaries)
summaries <- unlist(summaries)
papers <- lapply(summaries,getPapersInfo) 
papers %>>% 
    bind_rows() %>>% 
    (export(.,"BrazilianReviewFinance.rds"))


# ------------------------------------------------------------
# Economia e Sociedade

# TODO

url = 'https://periodicos.sbu.unicamp.br/ojs/index.php/ecos/issue/archive'
issues <- getIssues(url)
summaries <- lapply(issues,getSummaries)
summaries <- unlist(summaries)
papers <- lapply(summaries,getPapersInfo) 
papers %>>% 
    bind_rows() %>>% 
    (export(.,"EconomiaSociedade.rds"))


# ------------------------------------------------------------
# Estudos Economicos

# TODO

url = 'http://www.revistas.usp.br/ee/issue/archive'
issues <- getIssues(url)
summaries <- lapply(issues,getSummaries)
summaries <- unlist(summaries)
papers <- lapply(summaries,getPapersInfo) 
papers %>>% 
    bind_rows() %>>% 
    (export(.,"EstudosEconomicos.rds")


# ------------------------------------------------------------
# Nova Economia

# TODO

url = 'https://revistas.face.ufmg.br/index.php/novaeconomia/issue/archive'
issues <- getIssues(url)
summaries <- lapply(issues,getSummaries)
summaries <- unlist(summaries)
papers <- lapply(summaries,getPapersInfo) 
papers %>>% 
    bind_rows() %>>% 
    (export(.,"NovaEconomia.rds")


# ------------------------------------------------------------
# Pesquisa e Planejamento Econômico

# TODO

url = 'http://ppe.ipea.gov.br/index.php/ppe/issue/archive'
issues <- getIssues(url)
summaries <- lapply(issues,getSummaries)
summaries <- unlist(summaries)
papers <- lapply(summaries,getPapersInfo) 
papers %>>% 
    bind_rows() %>>% 
    (export(.,"PesquisaPlanejamentoEconomico.rds")
