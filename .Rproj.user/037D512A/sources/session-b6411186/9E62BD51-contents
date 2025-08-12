# Abrechnungs-Automatisierung

Dieses Projekt verarbeitet ZIP-Archive mit Abrechnungs-PDFs und erzeugt eine zusammengeführte Datei.

## Ablauf
1. ZIP-Dateien werden aus `input/` gelesen.
2. PDFs werden temporär entpackt und nach definiertem Muster sortiert.
3. Die PDFs werden zu einer Datei `yyyy_mm_dd_Abrechnung_azh.pdf` zusammengeführt und in `export/` abgelegt.
4. Verarbeitete ZIPs werden nach `archive/` verschoben, Logs liegen in `logs/`.

## Ausführung
- **In RStudio:** `source("run.R")`
- **Konsole/Doppelklick:** `Rscript run.R`

Benötigte Pakete werden automatisch installiert. Einstellungen (Ordner, Reihenfolge, Log-Optionen) finden sich in `config.R`.
