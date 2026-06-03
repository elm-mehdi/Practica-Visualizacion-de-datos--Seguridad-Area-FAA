library(dplyr) 

data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]


data <- data %>%
  mutate(`Flight Conduct Code` = ifelse(is.na(`Flight Conduct Code`) | `Flight Conduct Code` == "" | `Flight Conduct Code` == " ", "UNKNOWN", `Flight Conduct Code`))


top_7_fatalidades <- data %>%
  group_by(`Flight Conduct Code`) %>%
  summarise(total_fallecidos = sum(`Total Fatalities`, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(total_fallecidos)) %>%
  slice_head(n = 7)


top_7_incidentes <- data %>%
  group_by(`Flight Conduct Code`) %>%
  summarise(total_incidentes = n(), .groups = "drop") %>%
  arrange(desc(total_incidentes)) %>%
  slice_head(n = 7)


top_7_combinado <- bind_rows(
  mutate(top_7_fatalidades, Type = "Fallecidos"),
  mutate(top_7_incidentes, Type = "Incidentes")
)
print(top_7_combinado)

write.csv2(
  top_7_combinado,
  file = "C:/Users/mehdi/Downloads/top_7_flight_conduct_codes.csv",
  row.names = FALSE,
  quote = TRUE
)
