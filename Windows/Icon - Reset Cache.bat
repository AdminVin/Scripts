:: Created by: Shawn Brink
:: http://www.sevenforums.com
:: Tutorial:  http://www.sevenforums.com/tutorials/49819-icon-cache-rebuild.html

:: Fixes icons that will not display the correct icon File

@echo off
set iconcache=%localappdata%\IconCache.db

echo The Explorer process must be killed to delete the Icon DB. 
echo.
echo Please SAVE ALL OPEN WORK before continuing.
echo.
pause
echo.
If exist "%iconcache%" goto delID
echo.
echo Icon DB has already been deleted. 
echo.
pause
exit /B

:delID
echo Attempting to delete Icon DB...
echo.
taskkill /IM explorer.exe /F 
del "%iconcache%" /A
echo.
echo Icon DB has been successfully deleted.
echo.
start explorer.exe
pause
exit /B