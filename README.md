# Abrechnungs-Automatisierung

Dieses Projekt verarbeitet ZIP-Archive mit Abrechnungs-PDFs und erzeugt eine zusammengeführte Datei.

## Projektstruktur
- **run.R** – Hauptworkflow
- **config.R** – Pfade, Optionen und Kundennummer-Mapping
- **R/** – Hilfsfunktionen (`utils_*`)
- **run.bat** – Windows-Launcher
- Verzeichnisse: `input/`, `export/`, `archive/`, `logs/`, `temp/`

## Ablauf
1. ZIP-Dateien werden aus `input/` gelesen (standardmäßig alle; konfigurierbar).
2. Für jede ZIP wird das Datum aus dem Dateinamen extrahiert und der Inhalt nach `temp/` entpackt.
3. PDFs werden gemäß `pdf_desired_order` sortiert.
4. Die Kundennummer wird aus einer "Übersicht_zur_Abrechnung" (oder anderen PDFs) extrahiert und optional über `kunde_map` Filiale und Kostenstelle zugeordnet.
5. Die PDFs werden zu einer Datei `yyyy_mm_dd_[KS]_[Filiale]_[Kundennummer]_Abrechnung_azh.pdf` (Fallbacks ohne Mapping oder Kundennummer) zusammengeführt und in `export/` abgelegt.
6. Verarbeitete ZIPs werden nach `archive/` verschoben.
7. Temporäre Dateien werden bereinigt, Logs liegen in `logs/` (es bleiben nur die 30 neuesten).

## Konfiguration
`config.R` enthält:
- Pfade zu Arbeitsverzeichnissen
- `pdf_desired_order` zur Sortierung der PDFs
- `process_all_zips`, `zip_name_prefix` und `open_log_after_run`
- `kunde_map` für Filial- und Kostenstellen-Zuordnung zum Dateinamen
- `log_level` für die Ausgabe

## Installation
1. R installieren: [https://cran.r-project.org/](https://cran.r-project.org/)
   - Windows: "base" Installer herunterladen und mit Standard-Einstellungen installieren
   - Optional: RStudio für Entwicklung/Debugging
2. Repository klonen oder herunterladen

## Ausführung
- **In RStudio:** `source("run.R")`
- **Konsole:** `Rscript run.R`
- **Windows:** `run.bat` doppelklicken (öffnet danach das neueste Log)

Benötigte Pakete werden automatisch installiert. Einstellungen (Ordner, Reihenfolge, Log-Optionen) finden sich in `config.R`.

Nach jedem Lauf wird `temp/` geleert. Im Ordner `logs/` verbleiben nur die 30 aktuellsten Log-Dateien.
