library(dplyr) 

data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]


data <- data %>%
  mutate(
    `Aircraft Damage` = ifelse(
      is.na(`Aircraft Damage`) |
      trimws(`Aircraft Damage`) == "",
      "DESCONOCIDO",
      `Aircraft Damage`
    )
  )
top10_phase <- data %>%
  group_by(`Flight Phase`) %>%
  summarise(
    fatalities = sum(`Total Fatalities`, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(fatalities)) %>%
  slice_head(n = 10) %>%
  pull(`Flight Phase`)

sankey_flourish <- data %>%
  filter(`Flight Phase` %in% top10_phase) %>%
  group_by(
    `Flight Phase`,
    `Aircraft Make`,
    `Aircraft Damage`
  ) %>%
  summarise(
    Fatalities = sum(`Total Fatalities`, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  filter(
    Fatalities > 0,
    !is.na(`Aircraft Make`),
    !is.na(`Aircraft Damage`)
  ) %>%
  arrange(desc(Fatalities))

write.csv2(
  sankey_flourish,
  file = "C:/Users/mehdi/Downloads/sankey.csv",
  row.names = FALSE,
  quote = TRUE
)
