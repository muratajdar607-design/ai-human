@echo off
setlocal
cd /d "%~dp0"
where py >nul 2>nul
if not errorlevel 1 (
  py -3.11 -c "import sys; sys.exit(sys.version_info[:2] != (3, 11))" >nul 2>nul
  if not errorlevel 1 (
    py -3.11 -X utf8 scripts\manage.py setup %*
    exit /b
  )
)
where python >nul 2>nul
if not errorlevel 1 (
  python -c "import sys; sys.exit(sys.version_info[:2] != (3, 11))" >nul 2>nul
  if not errorlevel 1 (
    python -X utf8 scripts\manage.py setup %*
    exit /b
  )
)
echo Python 3.11 is required. Install it from python.org, then run setup.bat again.
exit /b 1
