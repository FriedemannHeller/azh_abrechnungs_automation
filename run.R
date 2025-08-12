# run.R
# Hauptworkflow für die Abrechnungs-Automatisierung

source("config.R")
source("R/utils_log.R")
source("R/utils_file.R")
source("R/utils_pdf.R")
source("R/utils_extract.R")

installed_or_install(c("fs","stringr","glue","qpdf","lubridate","pdftools"))

lapply(cfg$paths, ensure_dir)
log_file <- init_log(cfg$paths$logs)
on.exit(close_log(log_file, cfg$open_log_after_run), add = TRUE)

write_log(log_file, glue::glue("Start in {getwd()} mit R {R.version.string}"))
write_log(log_file, glue::glue("Konfiguration: process_all_zips={cfg$process_all_zips}, log_level={cfg$log_level}"))

zips <- get_zip_files(cfg$paths$input)
if (nrow(zips) == 0) {
  write_log(log_file, "Keine ZIP-Dateien gefunden", type = "INFO")
  if (interactive()) {
    stop("Keine ZIP-Dateien gefunden")  # Beendet nur den aktuellen Lauf
  } else {
    quit(save = "no", status = 0)       # Für Batch-Skripte
  }
}


if (!cfg$process_all_zips) {
  zips <- zips[which.max(zips$mtime), , drop = FALSE]
}

for (i in seq_len(nrow(zips))) {
  zip_path <- zips$path[i]
  write_log(log_file, glue::glue("Verarbeite {zip_path}"))
  d <- extract_date_from_filename(zips$name[i], cfg$zip_name_prefix)
  if (is.na(d)) {
    write_log(log_file, glue::glue("Kein Datum in {zips$name[i]} gefunden"), type = "WARN")
    next
  }
  run_id <- format(Sys.time(), "%Y%m%d-%H%M%S-%OS3")
  work_dir <- fs::path(cfg$paths$temp, run_id)
  ensure_dir(work_dir)
  pdfs <- tryCatch(unzip_to(zip_path, work_dir),
                   error = function(e) {
                     write_log(log_file, glue::glue("Fehler beim Entpacken: {e$message}"), type = "ERROR")
                     character()
                   })
  if (length(pdfs) == 0) {
    write_log(log_file, "Keine PDFs entpackt", type = "WARN")
    clean_dir(work_dir)
    next
  }
  ordered <- order_pdfs(pdfs, cfg$pdf_desired_order)
  res <- extract_kundennummer(work_dir)
  kundennr <- res$kundennummer
  if (res$used_fallback) {
    write_log(log_file, "kundennummer not found in overview PDF; using fallback scan", type = "WARN")
  }
  if (!is.na(kundennr)) {
    write_log(log_file, glue::glue("Extracted kundennummer: {kundennr}"))
    row <- cfg$kunde_map[cfg$kunde_map$kundennummer == kundennr, , drop = FALSE]
    if (nrow(row) == 1) {
      filiale <- row$filiale[1]
      ks <- row$kostenstelle[1]
      write_log(log_file, glue::glue("Matched filiale={filiale}, kostenstelle={ks}"))
    } else {
      filiale <- NA
      ks <- NA
      write_log(log_file, "kundennummer not in mapping; using kundennummer only", type = "INFO")
    }
  } else {
    write_log(log_file, "kundennummer could not be extracted; using fallback filename", type = "WARN")
    filiale <- NA
    ks <- NA
  }
  date_str <- format(d, "%Y_%m_%d")
  if (!is.na(kundennr) && !is.na(filiale) && !is.na(ks)) {
    output_name <- glue::glue("{date_str}_{ks}_{filiale}_{kundennr}_Abrechnung_azh.pdf")
  } else if (!is.na(kundennr)) {
    output_name <- glue::glue("{date_str}_{kundennr}_Abrechnung_azh.pdf")
  } else {
    output_name <- glue::glue("{date_str}_Abrechnung_azh.pdf")
  }
  output_name <- gsub("\\s+", "_", output_name)
  out_path <- unique_path(fs::path(cfg$paths$export, output_name))
  write_log(log_file, glue::glue("Finaler Exportpfad: {out_path}"))
  ok <- tryCatch({
    merge_pdfs(ordered, out_path)
    TRUE
  }, error = function(e) {
    write_log(log_file, glue::glue("Fehler beim Zusammenführen: {e$message}"), type = "ERROR")
    FALSE
  })
  if (ok) {
    size <- fs::file_info(out_path)$size
    write_log(log_file, glue::glue("Ergebnis gespeichert: {out_path} ({length(ordered)} PDFs, {round(size/1024,2)} KB)"))
    tryCatch(move_file_unique(zip_path, cfg$paths$archive),
             error = function(e) write_log(log_file, glue::glue("Archivieren fehlgeschlagen: {e$message}"), type = "ERROR"))
  }
  tryCatch(clean_dir(work_dir),
           error = function(e) write_log(log_file, glue::glue("Cleanup fehlgeschlagen: {e$message}"), type = "WARN"))
}

tryCatch(clean_dir(cfg$paths$temp),
         error = function(e) write_log(log_file, glue::glue("Temp cleanup failed: {e$message}"), type = "WARN"))

write_log(log_file, "Run abgeschlossen")
