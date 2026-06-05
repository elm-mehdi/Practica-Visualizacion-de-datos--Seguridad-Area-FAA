library(dplyr)

data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]

data <- data %>%
  mutate(
    `Flight Phase` = ifelse(`Flight Phase` == "", "DESCONOCIDO", `Flight Phase`)
  )


result <- data %>%
  group_by(`Flight Phase`) %>%
  summarise(
    Total_Incidentes = n(),
    Total_Fallecidos = sum(`Total Fatalities`, na.rm = TRUE)
  ) %>%
  arrange(desc(Total_Incidentes))


write.csv2(
  result,
  file = "C:/Users/mehdi/Downloads/result.csv",
  row.names = FALSE,
  quote = TRUE
)

