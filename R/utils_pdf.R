# utils_pdf.R
# Hilfsfunktionen für PDF-Verarbeitung.
# Aufgaben:
# - Reihenfolge der PDFs bestimmen
# - Mehrere PDFs zu einer zusammenführen
#
# Diese Funktionen sorgen dafür, dass die PDFs im gewünschten Ablauf
# zu einer Datei kombiniert werden, z. B. "yyyy_mm_dd_Abrechnung_azh.pdf".

# Funktion: order_pdfs(pdf_files, desired_order)
#   Sortiert eine Liste von PDF-Dateipfaden so, dass sie der gewünschten Reihenfolge entsprechen.
#   desired_order ist ein Vektor mit Dateinamen oder Teilen davon.

# Funktion: merge_pdfs(pdf_files, output_path)
#   Führt die PDFs in der angegebenen Reihenfolge zusammen und speichert sie unter output_path.
#   Nutzt dafür z. B. das Paket qpdf oder pdftools.
