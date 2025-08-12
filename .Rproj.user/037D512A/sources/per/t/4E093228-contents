# utils_file.R
# Hilfsfunktionen für Datei- und Ordneroperationen.
# Aufgaben:
# - ZIP-Dateien im input-Ordner finden
# - Datum aus Dateinamen auslesen
# - ZIP-Dateien entpacken
# - Dateien verschieben (z. B. ZIP ins Archiv)
# - Temporäre Ordner leeren
#
# Diese Funktionen kapseln den Dateizugriff, damit run.R nur die
# Workflow-Logik enthält und kein Low-Level-Dateihandling.

# Funktion: get_zip_files(input_dir)
#   Gibt eine Liste aller ZIP-Dateien im angegebenen Ordner zurück, optional nach Datum sortiert.

# Funktion: extract_date_from_filename(filename)
#   Extrahiert das Datum im Format dd.mm.yyyy aus einem Dateinamen (z. B. "Anhang_10.07.2025.zip")
#   und gibt es als Date-Objekt zurück.

# Funktion: unzip_files(zip_path, extract_dir)
#   Entpackt alle Dateien aus der ZIP in den angegebenen Ordner.

# Funktion: move_file(src, dest)
#   Verschiebt eine Datei von A nach B (inkl. Erstellen des Zielordners falls nötig).

# Funktion: clean_temp_dir(temp_dir)
#   Löscht alle Dateien im Temp-Ordner.
