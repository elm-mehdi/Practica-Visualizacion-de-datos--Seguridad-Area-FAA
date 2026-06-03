library(dplyr) 

data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]

fatalidades_by_certificate <- data %>%
  group_by(`PIC Certificate Type`) %>%
  summarise(`Total Fatalities` = sum(`Total Fatalities`, na.rm = TRUE)) %>%
  arrange(desc(`Total Fatalities`))

write.csv2(
  fatalidades_by_certificate,
  file = "C:/Users/mehdi/Downloads/fatalidades_by_certificate.csv",
  row.names = FALSE,
  quote = TRUE
)
