library(dplyr)

data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]

data$`Aircraft Make` <- as.character(data$`Aircraft Make`)
data$`Aircraft Model` <- as.character(data$`Aircraft Model`)
data$`Aircraft Series` <- as.character(data$`Aircraft Series`)

data$`Aircraft Make`[is.na(data$`Aircraft Make`) | data$`Aircraft Make` == ""] <- "UNKNOWN"
data$`Aircraft Model`[is.na(data$`Aircraft Model`) | data$`Aircraft Model` == ""] <- "UNKNOWN"
data$`Aircraft Series`[is.na(data$`Aircraft Series`) | data$`Aircraft Series` == ""] <- "UNKNOWN"

jerarquia_counts <- count(
  data,
  `Aircraft Make`, `Aircraft Model`, `Aircraft Series`,
  name = "Incidentes"
)

fatalidades_counts <- aggregate(
  `Total Fatalities` ~ `Aircraft Make` + `Aircraft Model` + `Aircraft Series`,
  data = data,
  FUN = function(x) sum(x, na.rm = TRUE)
)

jerarquia_data <- merge(
  jerarquia_counts,
  fatalidades_counts,
  by = c("Aircraft Make", "Aircraft Model", "Aircraft Series"),
  all.x = TRUE
)

jerarquia_data$`Total Fatalities`[is.na(jerarquia_data$`Total Fatalities`)] <- 0

colnames(jerarquia_data) <- c(
  "Aircraft_Make",
  "Aircraft_Model",
  "Aircraft_Series",
  "Incidentes",
  "Fallecidos"
)

write.csv2(
  jerarquia_data,
  file = "C:/Users/mehdi/Downloads/jerarquia_completo_incidentes_fallecidos.csv",
  row.names = FALSE,
  quote = TRUE
)

head(jerarquia_data, 10)
