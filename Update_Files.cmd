@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

echo ===========================
echo =       App By Will      =
echo ===========================

set REPO_URL=https://raw.githubusercontent.com/WillowScriptsHub/SecList/main

set FILES=Start_Proxy.cmd Stop_Proxy.cmd proxies.csv Update_Files.cmd

for %%F in (%FILES%) do (
    echo Проверка файла %%F ...
    set TEMP_FILE=%TEMP%\%%F

    powershell -Command ^
      "Invoke-WebRequest -Uri '%REPO_URL%/%%F' -OutFile '%TEMP_FILE%' -UseBasicParsing"

    if not exist "%%F" (
        echo Файл %%F отсутствует, копируем новый...
        move /Y "%TEMP_FILE%" "%%F"
        echo %%F обновлен.
    ) else (
        for /f "usebackq" %%L in (`powershell -Command "(Get-FileHash -Algorithm SHA256 '%%F').Hash"`) do set LOCAL_HASH=%%L
        for /f "usebackq" %%R in (`powershell -Command "(Get-FileHash -Algorithm SHA256 '%TEMP_FILE%').Hash"`) do set REMOTE_HASH=%%R

        if "!LOCAL_HASH!" neq "!REMOTE_HASH!" (
            echo Файл %%F отличается, обновляем...
            move /Y "%TEMP_FILE%" "%%F"
            echo %%F обновлен.
        ) else (
            echo Файл %%F без изменений.
            del /f /q "%TEMP_FILE%"
        )
    )
)

echo Обновление завершено.
pause
