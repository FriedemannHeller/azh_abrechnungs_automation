# utils_pdf.R
# PDF-Verarbeitung

order_pdfs <- function(pdf_files, desired_order) {
  if (!length(pdf_files)) return(character())
  names <- norm_pdf_name(pdf_files)
  used <- logical(length(pdf_files))
  ordered <- character()
  for (d in desired_order) {
    idx <- which(names == d & !used)
    if (length(idx)) {
      ordered <- c(ordered, pdf_files[idx[1]])
      used[idx[1]] <- TRUE
    }
  }
  remaining <- pdf_files[!used]
  if (length(remaining)) {
    rem_names <- norm_pdf_name(remaining)
    ordered <- c(ordered, remaining[order(rem_names)])
  }
  ordered
}

merge_pdfs <- function(pdf_files, output_path) {
  if (length(pdf_files) == 0) stop("No PDF files to merge")
  qpdf::pdf_combine(input = pdf_files, output = output_path)
  output_path
}

