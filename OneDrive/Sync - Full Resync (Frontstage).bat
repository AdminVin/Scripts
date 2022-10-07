@echo off
mode con cols=20 lines=1 & color 0f
%localappdata%\Microsoft\OneDrive\onedrive.exe /reset
C:\Program Files (x86)\Microsoft OneDrive\onedrive.exe /reset
start %LOCALAPPDATA%\Microsoft\OneDrive\OneDrive.exe /background
cls