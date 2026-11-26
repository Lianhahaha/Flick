@echo off
setlocal
cd /d "%~dp0reelmimic"
curl -sf -m 2 http://localhost:4318/api/health >nul 2>&1
if not errorlevel 1 (
  start "" http://localhost:4318
  exit /b 0
)
call start.bat
