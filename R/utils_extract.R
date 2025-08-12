# utils_extract.R
# Funktionen zum Extrahieren von Metadaten (Kundennummer) aus PDFs.

# Voraussetzung: Paket 'pdftools'

# find_overview_pdf(dir)
#   Sucht die "Übersicht_zur_Abrechnung*.pdf" im Verzeichnis 'dir'.
#   Berücksichtigt Umlaute-/ASCII-Varianten, case-insensitive.
#   Gibt Pfad oder NA zurück.
find_overview_pdf <- function(dir) {
  files <- fs::dir_ls(dir, type = "file", glob = "*.pdf")
  names <- fs::path_file(files)
  pattern <- "(?i)^(übersicht|uebersicht|ubersicht)_zur_abrechnung.*\\.pdf$"
  match <- files[stringr::str_detect(names, pattern)]
  if (length(match)) match[1] else NA_character_
}

# extract_kundennummer_from_pdf(pdf_path)
#   Liest Seite 1 als Text und extrahiert via Regex die Kundennummer.
#   Gibt gefundene Kundennummer (String) oder NA zurück.
extract_kundennummer_from_pdf <- function(pdf_path) {
  text <- tryCatch(pdftools::pdf_text(pdf_path)[1], error = function(e) "")
  pattern <- "(?:Kundennummer|KUNDENNUMMER)\\s*[:：]\\s*(0A4\\d+)"
  res <- stringr::str_match(text, pattern)[,2]
  if (length(res) && !is.na(res[1])) res[1] else NA_character_
}

# extract_kundennummer(dir)
#   1) Versuche über find_overview_pdf(dir)
#   2) Fallback: gehe alle PDFs im 'dir' durch und nimm den ersten Treffer.
#   3) Gibt List(kundennummer, used_fallback) zurück.
extract_kundennummer <- function(dir) {
  overview <- find_overview_pdf(dir)
  if (!is.na(overview)) {
    knr <- extract_kundennummer_from_pdf(overview)
    if (!is.na(knr)) {
      return(list(kundennummer = knr, used_fallback = FALSE))
    }
  }
  pdfs <- list_pdfs(dir)
  if (length(pdfs)) {
    for (p in pdfs) {
      knr <- extract_kundennummer_from_pdf(p)
      if (!is.na(knr)) {
        return(list(kundennummer = knr, used_fallback = TRUE))
      }
    }
  }
  list(kundennummer = NA_character_, used_fallback = TRUE)
}
