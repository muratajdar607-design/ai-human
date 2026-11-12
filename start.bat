@echo off
setlocal
cd /d "%~dp0"
call setup.bat
if errorlevel 1 (
  echo Setup failed. Correct the error and run start.bat again.
  pause
  exit /b 1
)
".venv\Scripts\python.exe" -X utf8 scripts\manage.py run %*
if errorlevel 1 pause
