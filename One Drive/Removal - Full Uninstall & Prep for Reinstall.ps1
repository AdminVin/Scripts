## Close OneDrive (if running in background)
taskkill /f /im OneDrive.exe
taskkill /f /im FileCoAuth.exe

## Official Removal
# x86
Start-Process -FilePath "$Env:WinDir\System32\OneDriveSetup.exe" -WorkingDirectory "$Env:WinDir\System32\" -ArgumentList "/uninstall" -ErrorAction SilentlyContinue
# x64
Start-Process -FilePath "$Env:WinDir\SysWOW64\OneDriveSetup.exe" -WorkingDirectory "$Env:WinDir\SysWOW64\" -ArgumentList "/uninstall" -ErrorAction SilentlyContinue

## Files Cleanup
# File Explorer - Navigation Bar
if((Test-Path -LiteralPath "HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}") -ne $true) {  New-Item "HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force -ErrorAction SilentlyContinue | Out-Null };
New-ItemProperty -LiteralPath 'HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Name '(default)' -Value 'OneDrive' -PropertyType String -Force -ErrorAction SilentlyContinue | Out-Null;
New-ItemProperty -LiteralPath 'HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Name 'System.IsPinnedToNameSpaceTree' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null;
# AppData / Local
Remove-Item -Path "$env:localappdata\OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue
# ProgramData
Remove-Item -Path "$env:programdata\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue 
# Shortcuts
Remove-Item -Path "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -Force -ErrorAction SilentlyContinue
# Program Files
Remove-Item -LiteralPath "C:\Program Files (x86)\Microsoft OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath "C:\Program Files\Microsoft OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue

## Scheduled Tasks
Get-ScheduledTask "*OneDrive*" | Unregister-ScheduledTask -Confirm:$false -ErrorAction SilentlyContinue

## Services
$ODUPdaterService = Get-WmiObject -Class Win32_Service -Filter "Name='OneDrive Updater Service'"
$ODUPdaterService.delete() | Out-Null

## Registry
# Remove Previous Accounts/Sync Options
Remove-Item -LiteralPath "HKCU:\Software\Microsoft\OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue
# Remove previously set One Drive settings
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue
# Remove Right Click Menu Context Options
Remove-Item -LiteralPath "HKLM:\SYSTEM\CurrentControlSet\Services\FileSyncHelper" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue
# Remove from 'Default' user account
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload "hku\Default"

## Enable File Sync (if somehow disabled)
if (-not (Test-Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
    New-Item -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Force | Out-Null
}
# DisableFileSync
New-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSync" -Value "0" -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSync" -Value "0" | Out-Null
# DisableFileSyncNGSC
New-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value "0" -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value "0" | Out-Null
