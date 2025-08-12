==============================================
 Abrechnungs-Automatisierung – Quickstart
==============================================

Dieses Tool verarbeitet automatisch ZIP-Abrechnungen:
1. ZIP-Datei entpacken
2. PDFs in richtiger Reihenfolge zusammenführen
3. Datei nach Datum, Kostenstelle, Filiale & Kundennummer benennen
4. Ergebnis in "export/" speichern
5. Original-ZIP in "archive/" verschieben
6. Pro Lauf wird ein Log in "logs/" erstellt

----------------------------------------------
 Voraussetzungen
----------------------------------------------
- Windows 10/11 oder macOS
- Installiertes R (https://cran.r-project.org/)
- Internetzugang für die automatische Paketinstallation beim ersten Start

----------------------------------------------
 So geht's (Windows)
----------------------------------------------
1. Lege deine ZIP-Abrechnungen in den Ordner "input/"
   (z. B. "Anhang_10.07.2025.zip")
2. Doppelklicke auf "run.bat"
3. Warten, bis das Script fertig ist
4. Am Ende öffnet sich:
   - Die Log-Datei mit allen Verarbeitungsschritten
   - Der "export/"-Ordner mit den fertigen PDFs

----------------------------------------------
 So geht's (macOS)
----------------------------------------------
1. Lege deine ZIP-Abrechnungen in den Ordner "input/"
2. Mache "run.command" einmalig ausführbar:
     chmod +x run.command
3. Doppelklicke auf "run.command"
4. Am Ende öffnet sich:
   - Die Log-Datei
   - Der "export/"-Ordner

----------------------------------------------
 Hinweise
----------------------------------------------
- Mehrere ZIPs im Ordner "input/" werden nacheinander verarbeitet
- Fehlende Standard-PDFs werden ignoriert
- Zusätzliche PDFs werden am Ende angehängt
- Bei mehreren ZIPs mit gleichem Datum werden eindeutige Dateinamen erzeugt
- Alle Pfade sind relativ zum Projektordner
- Logs finden sich in "logs/", Archivierte ZIPs in "archive/"

----------------------------------------------
 Support
----------------------------------------------
Bei Fragen oder Problemen bitte Friedemann kontaktieren.