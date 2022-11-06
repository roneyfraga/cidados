
library(RCurl)

dataf <- data.frame(periodo = Sys.time(), online = url.exists("http://periodicoscientificos.ufmt.br"))

write.table(dataf, "RES_ping.csv", sep = ",", col.names = !file.exists("RES_ping.csv"), append = T, row.names = F)

library(lubridate)
x <- Sys.time()
tz(x) <- "America/Cuiaba"

