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
  output_name_format_fallback = "yyyy_mm_dd_Abrechnung_azh.pdf",
  kunde_map = data.frame(
    kundennummer = c("0A40890","0A40985","0A40986","0A40991","0A41056"),
    filiale      = c("Schwaikheim","Neuhausen","Winterbach","Berglen","Weissach"),
    kostenstelle = c("KS100","KS300","KS200","KS400","KS500"),
    stringsAsFactors = FALSE
  ),
  log_level = "INFO"
)

