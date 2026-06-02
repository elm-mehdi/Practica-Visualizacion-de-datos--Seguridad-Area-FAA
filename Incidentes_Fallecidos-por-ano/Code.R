library(lubridate)
library(dplyr) 
library(stringr)

data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)
data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]



incidentes_fatalities_por_ano <- data %>%
  mutate(Year = ifelse(as.numeric(str_sub(`Local Event Date`, -2)) >= 70,
                       paste0("19", str_sub(`Local Event Date`, -2)),
                       paste0("20", str_sub(`Local Event Date`, -2)))) %>%
  group_by(Year) %>%
  summarise(Total_incidentes = n(),
            `Total Fatalities` = sum(`Total Fatalities`, na.rm = TRUE)) %>%
  arrange(Year)


write.csv2(
  incidentes_fatalities_por_ano,
  file = "C:/Users/mehdi/Downloads/incidents_fatalities_by_year.csv",
  row.names = FALSE,
  quote = TRUE
)
