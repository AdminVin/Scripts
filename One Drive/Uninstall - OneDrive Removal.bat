### OneDrive - Uninstall Tool
### Updated: 2021-10-26

## Kill Task
taskkill /f /im OneDrive.exe

## Uninstall Official
# x86
%SystemRoot%\System32\OneDriveSetup.exe /uninstall
# x64
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall

## Directory Cleanup
rename "%UserProfile%\OneDrive" "%UserProfile%\OneDrive.old"
rd "%LocalAppData%\Microsoft\OneDrive" /Q /S
rd "%ProgramData%\Microsoft OneDrive" /Q /S
rd "C:\OneDriveTemp" /Q /S

## Registry Cleanup
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload "hku\Default"

## Removing Shortcuts
rm -Force -ErrorAction SilentlyContinue "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"
