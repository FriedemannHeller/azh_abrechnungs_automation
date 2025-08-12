# config.R
# Konfigurationen für die Abrechnungs-Automatisierung

cfg <- list(
  paths = list(
    input = "input",
    temp = "temp",
    export = "export",
    archive = "archive",
    logs = "logs"
  ),
  pdf_desired_order = c(
    "Absetzungen",
    "Betriebswirtschaftliche_Auswertung",
    "Einzelpositionsliste",
    "Kassenübersicht",
    "Positionsstatistik",
    "Rechnung",
    "Übersicht_zur_Abrechnung"
  ),
  open_log_after_run = FALSE,
  process_all_zips = TRUE,
  zip_name_prefix = "Anhang_",
  output_name_format = "yyyy_mm_dd_Abrechnung_azh.pdf",
  log_level = "INFO"
)

