@ECHO OFF
PowerShell.exe -NoProfile -Command "& {Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dpn0.ps1""' -Verb RunAs}"
if NOT ["%errorlevel%"]==["0"] (
    PAUSE
    exit /b %errorlevel%
)
