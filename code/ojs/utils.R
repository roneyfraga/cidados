
getIssues <- function(url) {

    print(url)

    read_html(url) %>>% 
        html_nodes(xpath = '//*[@id="issues"]') %>>%
        html_nodes('a') %>>% 
        html_attr("href") %>>% 
        (unique(.)) %>>% 
        (. -> page1)

    pages <- c(url, page1[grepl('Page', page1)])

    as.list(pages)

    resultado <- list()

    for(i in seq_along(pages)) {

        read_html(pages[[i]]) %>>% 
            html_nodes(xpath = '//*[@id="issues"]') %>>%
            html_nodes('a') %>>% 
            html_attr("href") %>>% 
            (unique(.)) %>>% 
            (. -> issues)

        resultado[[i]] <- issues[!grepl('Page', issues)]

    }

    return(paste0(unlist(resultado), '/showToc'))

}


getSummaries <- function(url) {

    print(url)

    read_html(url) %>>% 
        html_nodes('.tocArticle')  %>>% 
        html_nodes('.tocTitle')  %>>% 
        html_nodes('a') %>>% 
        html_attr('href') 
}

getPapersInfo <- function(url) {

    print(url)

    artigo <- read_html(url)

    artigo %>>% 
        html_nodes(xpath = '//*[@id="articleTitle"]') %>>%
        html_text %>>% 
        (. -> articleTitle)

    artigo %>>% 
        html_nodes(xpath = '//*[@id="authorString"]') %>>%
        html_text %>>% 
        (. -> authorString)

    artigo %>>% 
        html_nodes(xpath = '//*[@id="articleAbstract"]') %>>%
        html_text %>>% 
        (. -> articleAbstract)

    artigo %>>% 
        html_nodes(xpath = '//*[@id="articleSubject"]') %>>%
        html_text %>>% 
        (. -> articleSubject)
    articleSubject <- ifelse(length(articleSubject) == 0, 'No Keywords', articleSubject)

    artigo %>>% 
        html_nodes(xpath = '//*[@id="pub-id::doi"]') %>>%
        html_text %>>% 
        (. -> doi)
    doi <- ifelse(length(doi) == 0, 'No DOI', doi)

    artigo %>>% 
        html_nodes(xpath = '//*[@id="breadcrumb"]') %>>%
        html_text %>>%   
        (. -> issue)

    data.frame(articleTitle, 
               authorString, 
               articleAbstract, 
               articleSubject, 
               doi,
               issue) %>>% 
    tbl_df

}

