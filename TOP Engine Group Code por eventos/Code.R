library(dplyr) 

data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]

data$`Engine Group Code` <- as.character(data$`Engine Group Code`)

data$`Engine Group Code`[is.na(data$`Engine Group Code`) | data$`Engine Group Code` == ""] <- "DESCONOCIDO"


top_15_engine_group <- data %>%
  group_by(`Engine Group Code`) %>%
  summarise(
    Incidentes = n(),
    Fallecidos = sum(`Total Fatalities`, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(Incidentes)) %>%
  head(15)


print(top_15_engine_group)


write.csv2(
  top_15_engine_group,
  file = "C:/Users/mehdi/Downloads/top_15_engine_group_code.csv",
  row.names = FALSE,
  quote = TRUE
)
