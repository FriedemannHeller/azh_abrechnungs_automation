# Abrechnungs-Automatisierung

Dieses Projekt verarbeitet ZIP-Archive mit Abrechnungs-PDFs und erzeugt eine zusammengeführte Datei.

## Projektstruktur
- **run.R** – Hauptworkflow
- **config.R** – Konfiguration der Pfade und Optionen
- **R/** – Hilfsfunktionen (`utils_*`)
- **run.bat** – Windows-Launcher
- Verzeichnisse: `input/`, `export/`, `archive/`, `logs/`, `temp/`

## Ablauf
1. ZIP-Dateien werden aus `input/` gelesen.
2. PDFs werden temporär entpackt und nach definiertem Muster sortiert.
3. Die PDFs werden zu einer Datei `yyyy_mm_dd_Abrechnung_azh.pdf` zusammengeführt und in `export/` abgelegt.
4. Verarbeitete ZIPs werden nach `archive/` verschoben, Logs liegen in `logs/`.

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
