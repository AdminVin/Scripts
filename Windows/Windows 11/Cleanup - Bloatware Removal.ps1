#region Elevation Session
#- Elevating Powershell Script with Administrative Rights
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#- Changing Powershell Execution Policy (Temporarily)
Set-ExecutionPolicy Unrestricted
#endregion

#region Diagnostics
Write-Host "1. Diagnostics" -ForegroundColor YELLOW
#- Verbose Status Messaging
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value "1"
#endregion

#region Applications
Write-Host "2.0 Metro Apps" -ForegroundColor YELLOW
Get-AppxPackage -AllUsers | where-object {$_.name -notlike "*Store*" -and $_.name -notlike "*Calculator*" -and $_.name -notlike "*Microsoft.Windows.Photos*" -and $_.name -notlike "*Microsoft.WindowsSoundRecorder*" -and $_.name -notlike "*Microsoft.MSPaint*" -and $_.name -notlike "*Microsoft.ScreenSketch*" -and $_.name -notlike "*Microsoft.WindowsCamera*" -and $_.name -notlike "*microsoft.windowscommunicationsapps*" -and $_.name -notlike "*Microsoft.BingWeather*" -and $_.name -notlike "*Nvidia*" -and $_.name -notlike "*ASUS*" -and $_.name -notlike "*Armoury*" -and $_.name -notlike "*MSI*" -and $_.name -notlike "*EVGA*" -and $_.name -notlike "*Intel*" -and $_.name -notlike "*Microsoft.Office.OneNote*" -and $_.name -notlike "*Microsoft.MicrosoftStickyNotes*"  -and $_.name -notlike "*ASUS*" -and $_.name -notlike "*AMD*" -and $_.name -notlike "*OneDrive*"} | Remove-AppxPackage -erroraction silentlycontinue

Write-Host "2.1 Applications" -ForegroundColor YELLOW

Write-Host "2.1.1 Microsoft Edge" -ForegroundColor YELLOW
# Edge
net stop edgeupdate
net stop edgeupdatem
Get-Scheduledtask "edgeupdate,edgeupdatem" -erroraction silentlycontinue | Disable-ScheduledTask

#endregion