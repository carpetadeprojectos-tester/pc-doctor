@echo off
echo ============================================
echo   PC DOCTOR - Diagnostico de sistema
echo ============================================
echo.
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%%~dp0pcdoctor.ps1"
echo.
echo === Fin del diagnostico. Presiona una tecla para salir. ===
pause >nul
