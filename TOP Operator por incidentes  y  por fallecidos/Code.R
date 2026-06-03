library(dplyr) 

data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]

top_15_operators_incidentes <- data %>%
  group_by(`Operator`) %>%
  summarise(
    Incidentes = n(),
    .groups = "drop"
  ) %>%
  arrange(desc(Incidentes)) %>%
  head(15)

write.csv2(
  top_15_operators_incidentes,
  file = "C:/Users/mehdi/Downloads/top_15_operators_incidentes.csv",
  row.names = FALSE,
  quote = TRUE
)

top_15_operators_fatalidades <- data %>%
  group_by(`Operator`) %>%
  summarise(
    Fallecidos = sum(`Total Fatalities`, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(Fallecidos)) %>%
  head(15)


write.csv2(
  top_15_operators_fatalidades,
  file = "C:/Users/mehdi/Downloads/top_15_operators_fatalidades.csv",
  row.names = FALSE,
  quote = TRUE
)
