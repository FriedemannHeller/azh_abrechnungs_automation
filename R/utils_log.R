# utils_log.R
# Logging-Helferfunktionen

ensure_dir <- function(path) {
  if (!fs::dir_exists(path)) {
    fs::dir_create(path, recurse = TRUE)
  }
}

ts <- function() {
  format(Sys.time(), "%Y-%m-%d %H:%M:%S")
}

init_log <- function(log_dir) {
  ensure_dir(log_dir)
  file <- fs::path(log_dir, glue::glue("log_{format(Sys.time(), '%Y-%m-%d_%H-%M-%S')}.txt"))
  writeLines(glue::glue("[{ts()}] [INFO] Log initialized"), file)
  file
}

write_log <- function(log_file, message, type = "INFO") {
  line <- glue::glue("[{ts()}] [{type}] {message}")
  write(line, log_file, append = TRUE)
}

prune_logs <- function(log_dir, keep = 30) {
  files <- fs::dir_ls(log_dir, glob = "log_*.txt", type = "file")
  if (length(files) <= keep) return()
  info <- fs::file_info(files)
  files_to_delete <- files[order(info$modification_time, decreasing = TRUE)][(keep + 1):length(files)]
  fs::file_delete(files_to_delete)
}

close_log <- function(log_file, open_after = FALSE, max_logs = 30) {
  write_log(log_file, "Run finished", type = "INFO")
  prune_logs(fs::path_dir(log_file), max_logs)
  if (open_after) {
    sys <- Sys.info()[["sysname"]]
    if (sys == "Windows") {
      shell.exec(log_file)
    } else {
      utils::file.show(log_file)
    }
  }
}

