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

close_log <- function(log_file, open_after = FALSE) {
  write_log(log_file, "Run finished", type = "INFO")
  if (open_after) {
    sys <- Sys.info()[["sysname"]]
    if (sys == "Windows") {
      shell.exec(log_file)
    } else {
      utils::file.show(log_file)
    }
  }
}

