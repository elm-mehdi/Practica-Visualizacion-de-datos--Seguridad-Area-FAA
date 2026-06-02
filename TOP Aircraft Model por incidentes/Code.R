library(dplyr) 

data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]


data$`Aircraft Model` <- as.character(data$`Aircraft Model`)


data$`Aircraft Make`[is.na(data$`Aircraft Make`) | data$`Aircraft Make` == ""] <- "DESCONOCIDO"
data$`Aircraft Model`[is.na(data$`Aircraft Model`) | data$`Aircraft Model` == ""] <- "DESCONOCIDO"


top_15_aircraft_model <- data %>%
  group_by(`Aircraft Make`, `Aircraft Model`) %>%
  summarise(
    Incidentes = n(),
    Fallecidos = sum(`Total Fatalities`, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(Incidentes)) %>%
  head(15)

print(top_15_aircraft_model)


write.csv2(
  top_15_aircraft_model,
  file = "C:/Users/mehdi/Downloads/top_15_aircraft_model_ por_incidentes_con_fabricantes.csv",
  row.names = FALSE,
  quote = TRUE
)
