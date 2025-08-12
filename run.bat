@echo off
REM ===============================================
REM Launcher für Abrechnungs-Automatisierung (Windows)
REM Startet run.R und öffnet danach das neueste Log
REM ===============================================

REM Zum Ordner wechseln, in dem das Skript liegt
cd /d "%~dp0"

REM Prüfen, ob Rscript im PATH ist
where Rscript.exe >nul 2>&1
if %errorlevel%==0 (
  Rscript run.R
) else (
  REM Falls nicht im PATH, typische Installationspfade durchsuchen
  for /d %%D in ("C:\Program Files\R\R-*") do (
    if exist "%%D\bin\Rscript.exe" (
      "%%D\bin\Rscript.exe" run.R
      goto openlog
    )
  )
  echo Rscript wurde nicht gefunden.
  echo Bitte R installieren: https://cran.r-project.org/
  pause
  goto end
)

:openlog
REM Neueste Log-Datei im logs-Ordner öffnen (falls vorhanden)
set "logdir=logs"
if exist "%logdir%" (
  for /f "delims=" %%F in ('dir /b /a-d /o-d "%logdir%\*.txt" 2^>nul') do (
    start "" "%logdir%\%%F"
    goto end
  )
)
goto end

:end
