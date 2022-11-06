
library(tidyverse) 

read.csv('RES_ping.csv') |>
    tibble::as_tibble() |>
    dplyr::slice(1:80000) ->
    pings

pings$periodo <- as.Date(pings$periodo)

pings$status <- NA
pings[pings$online == TRUE, 'status']  <- 'online'
pings[pings$online == FALSE, 'status']  <- 'offline'
pings$online <- NULL

pings |> 
    dplyr::group_by(periodo) |> 
    dplyr::count(status) -> 
    pings2

ggplot(pings2, aes(x = periodo, y = n)) + 
    geom_col(aes(fill = status), width = .8) +
    scale_y_continuous(limits = c(0, 1440), breaks = seq(0, 1440, by = 60)) +
    scale_x_date(date_breaks = "2 days") +
    xlab("Dia") + 
    ylab("Número de pings") +
    theme(
          axis.text.x = element_text(angle = 90, hjust = 1, size = 12),
          axis.text.y = element_text(angle = 0, vjust = 0.4, hjust = 1, size = 12),
          panel.grid.major.x = element_blank(),
          legend.position = "none",
          panel.background = element_rect(fill = "white", colour = "grey50")
   ) 

ggsave('pings_res.png')

