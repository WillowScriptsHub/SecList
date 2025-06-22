@echo off
chcp 65001 >nul

echo ===========================
echo =      App By Will       =
echo ===========================

echo Отключение системного прокси...

powershell -ExecutionPolicy Bypass -Command ^
  "$reg='HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings';" ^
  "Set-ItemProperty -Path $reg -Name ProxyEnable -Value 0;" ^
  "Remove-ItemProperty -Path $reg -Name ProxyServer -ErrorAction SilentlyContinue;"

echo Прокси отключён.
pause
