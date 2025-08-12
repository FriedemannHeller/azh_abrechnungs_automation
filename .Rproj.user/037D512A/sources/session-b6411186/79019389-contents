# run.R
# Hauptworkflow für die Abrechnungs-Automatisierung

source("config.R")
source("R/utils_log.R")
source("R/utils_file.R")
source("R/utils_pdf.R")

installed_or_install(c("fs","stringr","glue","qpdf","lubridate"))

lapply(cfg$paths, ensure_dir)
log_file <- init_log(cfg$paths$logs)
on.exit(close_log(log_file, cfg$open_log_after_run), add = TRUE)

write_log(log_file, glue::glue("Start in {getwd()} mit R {R.version.string}"))
write_log(log_file, glue::glue("Konfiguration: process_all_zips={cfg$process_all_zips}, log_level={cfg$log_level}"))

zips <- get_zip_files(cfg$paths$input)
if (nrow(zips) == 0) {
  write_log(log_file, "Keine ZIP-Dateien gefunden", type = "INFO")
  quit(save = "no")
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
  output_name <- glue::glue("{format(d, '%Y_%m_%d')}_Abrechnung_azh.pdf")
  out_path <- unique_path(fs::path(cfg$paths$export, output_name))
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

write_log(log_file, "Run abgeschlossen")
