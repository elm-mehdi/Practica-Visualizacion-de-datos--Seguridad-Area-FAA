data <- read.csv2(
  "C:/Users/mehdi/Downloads/faa_incidents_data.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

data <- data[, !duplicated(colnames(data)) & colnames(data) != ""]

data$`Aircraft Make`[is.na(data$`Aircraft Make`) | data$`Aircraft Make` == ""] <- "UNKNOWN"

incidente_counts <- table(data$`Aircraft Make`)
top_15_manufacturers <- sort(incidente_counts, decreasing = TRUE)[1:15]

Fallecidos <- data[data$`Total Fatalities` > 0, ]
fatal_counts <- table(Fallecidos$`Aircraft Make`)

results <- data.frame(
  Aircraft_Make = names(top_15_manufacturers),
  Incidentes = as.numeric(top_15_manufacturers),
  Fallecidos = as.numeric(fatal_counts[names(top_15_manufacturers)])
)

results[is.na(results)] <- 0

cat("Top 15  fabricantes par incidentes y Fallecidos ---\n")

print(results)

write.csv2(
  results,
  file = "C:/Users/mehdi/Downloads/top_15_fabricantes_incidentes_Fatalidades.csv",
  row.names = FALSE,
  quote = TRUE
)
