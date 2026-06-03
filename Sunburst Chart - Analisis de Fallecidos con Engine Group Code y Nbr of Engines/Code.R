library(dplyr)

data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]

data <- data %>%
  mutate(
    `Engine Group Code` = ifelse(
      is.na(`Engine Group Code`) | `Engine Group Code` == "",
      "DESCONOCIDO",
      as.character(`Engine Group Code`)
    )
  )


top_engines <- data %>%
  group_by(`Engine Group Code`) %>%
  summarise(fatal = sum(`Total Fatalities`), .groups = "drop") %>%
  arrange(desc(fatal)) %>%
  slice_head(n = 10) %>%
  pull(`Engine Group Code`)


sunburst_engine <- data %>%
  filter(`Engine Group Code` %in% top_engines) %>%
  group_by(tipo_de_motor = `Engine Group Code`, target = `Nbr of Engines`) %>%
  summarise(Fallecidos = sum(`Total Fatalities`), .groups = "drop") %>%
  filter(Fallecidos > 0)

write.csv2(
  sunburst_engine,
  file = "C:/Users/mehdi/Downloads/sunburst_engine.csv",
  row.names = FALSE,
  quote = TRUE
)
