# utils_file.R
# Datei- und Ordnerfunktionen

installed_or_install <- function(pkgs) {
  to_install <- pkgs[!sapply(pkgs, requireNamespace, quietly = TRUE)]
  if (length(to_install)) {
    if (requireNamespace("pak", quietly = TRUE)) {
      pak::pkg_install(to_install)
    } else {
      install.packages(to_install)
    }
  }
  invisible(lapply(pkgs, library, character.only = TRUE))
}

get_zip_files <- function(input_dir) {
  ensure_dir(input_dir)
  files <- fs::dir_ls(input_dir, glob = "*.zip", type = "file")
  info <- fs::file_info(files)
  df <- data.frame(
    path = files,
    name = fs::path_file(files),
    mtime = info$modification_time,
    stringsAsFactors = FALSE
  )
  df[order(df$mtime), , drop = FALSE]
}

extract_date_from_filename <- function(filename, prefix = "Anhang_") {
  date_str <- stringr::str_extract(filename, "\u005cd{2}\.\u005cd{2}\.\u005cd{4}")
  if (is.na(date_str)) return(NA)
  parsed <- suppressWarnings(lubridate::dmy(date_str))
  if (is.na(parsed)) NA else parsed
}

unzip_to <- function(zip_path, extract_dir) {
  ensure_dir(extract_dir)
  files <- utils::unzip(zip_path, exdir = extract_dir)
  pdfs <- files[stringr::str_detect(tolower(files), "\\.pdf$")]
  fs::path_abs(pdfs)
}

clean_dir <- function(dir) {
  if (!fs::dir_exists(dir)) return()
  contents <- fs::dir_ls(dir, all = TRUE)
  if (length(contents) == 0) return()
  files <- contents[fs::is_file(contents)]
  dirs <- contents[fs::is_dir(contents)]
  if (length(files)) fs::file_delete(files)
  if (length(dirs)) fs::dir_delete(dirs)
}

unique_path <- function(path) {
  if (!fs::file_exists(path)) return(path)
  base <- tools::file_path_sans_ext(path)
  ext <- fs::path_ext(path)
  i <- 1
  repeat {
    candidate <- glue::glue("{base} ({i}).{ext}")
    if (!fs::file_exists(candidate)) return(candidate)
    i <- i + 1
  }
}

move_file_unique <- function(src, dest_dir) {
  ensure_dir(dest_dir)
  dest <- fs::path(dest_dir, fs::path_file(src))
  dest <- unique_path(dest)
  fs::file_move(src, dest)
  dest
}

norm_pdf_name <- function(path) {
  tools::file_path_sans_ext(fs::path_file(path))
}

