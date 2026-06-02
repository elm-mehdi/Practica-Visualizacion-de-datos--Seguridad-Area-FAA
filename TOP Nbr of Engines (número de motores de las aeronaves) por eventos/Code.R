data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]


data$`Nbr of Engines`[is.na(data$`Nbr of Engines`) | data$`Nbr of Engines` == ""] <- "DESCONOCIDO"


data_filtered <- data[data$`Nbr of Engines` %in% c("1", "2", "3", "4"), ]


incidentes_by_nbr_engines <- table(data_filtered$`Nbr of Engines`)


print(incidentes_by_nbr_engines)


write.csv2(
  as.data.frame(incidentes_by_nbr_engines),
  file = "C:/Users/mehdi/Downloads/incidentes_por_nbr_of_engines.csv",
  row.names = FALSE,
  quote = TRUE
)
