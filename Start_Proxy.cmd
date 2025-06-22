@echo off
chcp 65001 >nul

echo ===========================
echo =      App By Will       =
echo ===========================

setlocal enabledelayedexpansion

REM Чтение первой строки из proxies.csv (пропуск заголовка)
for /f "skip=1 tokens=1-7 delims=;" %%A in (proxies.csv) do (
    set "ip=%%B"
    set "port=%%C"
    goto :set_proxy
)

:set_proxy
echo Установка системного HTTP-прокси: %ip%:%port%

REM Установка системного прокси (WinHTTP)
powershell -ExecutionPolicy Bypass -Command ^
  "$reg='HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings';" ^
  "Set-ItemProperty -Path $reg -Name ProxyEnable -Value 1;" ^
  "Set-ItemProperty -Path $reg -Name ProxyServer -Value '%ip%:%port%'"

echo Готово.
pause
