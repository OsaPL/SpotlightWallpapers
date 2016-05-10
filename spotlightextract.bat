:: By Osa__PL, feel free to modify, share. Just give me some credit if you do so. Thanks!!
:: Copying contents, to a foler
@ECHO OFF
MD %CD%\Spotlight\
xcopy %LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets %CD%\Spotlight /E /Y
cd %CD%\Spotlight\
ren * *.jpg
:: Removing any duplicate stuff
setlocal enabledelayedexpansion
for /r %%F in (*.) do (
    set name=%%~dpnF.jpg
    if exist !name! (
        fc/b %%F !name! > nul
        if errorlevel 1 (
            echo Warning: %%F and !name! both exist but are not identical.
        ) else (
            DEL %%F
        )
    )
)
:: Cleaning for useless app icons, most of them keeps under 80 kb
for /f  "usebackq delims=;" %%A in (`dir /b *.jpg`) do If %%~zA LSS 81920 del "%%A"
:: Sorting them using ImageMagick (checks if it is installeds)
WHERE identify
IF %ERRORLEVEL% NEQ 0 goto:eof
MD %CD%\Vertical\
MD %CD%\Landscape\
FOR /F "tokens=1-3 delims=+" %%A in ('identify -format "%%w+%%h+%%f\r\n" *.jpg') DO (
    ECHO %%A,%%B,%%C
    IF %%A GEQ %%B move %cd%\%%C %cd%\Landscape
    IF %%A LEQ %%B move %cd%\%%C %cd%\Vertical
)