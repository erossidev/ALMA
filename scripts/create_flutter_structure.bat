@echo off

echo ======================================
echo   Creazione struttura Flutter ALMA
echo ======================================

cd /d "%~dp0..\app\lib"

mkdir core
mkdir core\config
mkdir core\services
mkdir core\theme
mkdir core\utils

mkdir features
mkdir features\chat
mkdir features\memory
mkdir features\profile
mkdir features\settings

mkdir shared
mkdir shared\models
mkdir shared\widgets

echo.
echo Struttura creata con successo!
pause