#region Introduction
Write-Host "Hello!" -ForegroundColor DarkGreen
Write-Host ""
Write-Host "This script was created by AdminVin, and the purpose of it is to remove all bloatware from your Windows 11 Installation." -ForegroundColor DarkGreen
Write-Host "This has been updated for Windows 11 - Update 22H2." -ForegroundColor DarkGreen
Write-Host ""
Write-Host "Updated 2022-10-24" -ForegroundColor DarkGreen
Write-Host ""
Write-Host ""
#endregion


<#############################################################################################################################>
#region 1.0 Elevate PowerShell Session
Write-Host "1.0 Elevating Powershell Session with Administrative Rights" -ForegroundColor Green
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
#endregion


<#############################################################################################################################>
#region 2.0 Diagnostics
Write-Host "2.0 Diagnostics" -ForegroundColor Green
# Verbose Status Messaging
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value "1"
Write-Host "2.1 Verbose Status Messaging Enabled" -ForegroundColor Green
#endregion


<#############################################################################################################################>
#region 3.0 Applications
# 3.1 Metro Apps
Write-Host "3.1 Metro Apps" -ForegroundColor Green
<# Old method of removal #>
# Get-AppxPackage -AllUsers | where-object {$_.name -notlike "*Store*" -and $_.name -notlike "*Calculator*" -and $_.name -notlike "Microsoft.Windows.Photos*" -and $_.name -notlike "Microsoft.WindowsSoundRecorder*" -and $_.name -notlike "Microsoft.Paint*" -and $_.name -notlike "Microsoft.MSPaint*" -and $_.name -notlike "Microsoft.ScreenSketch*" -and $_.name -notlike "Microsoft.WindowsCamera*" -and $_.name -notlike "microsoft.windowscommunicationsapps*"<# Mail App#> -and $_.name -notlike "*Weather*" -and $_.name -notlike "Microsoft.Office.OneNote*" -and $_.name -notlike "*Note*" -and $_.name -notlike "*xbox*" -and $_.name -notlike "*OneDrive*" -and $_.name -notlike "Microsoft.WindowsAlarms*" -and $_.name -notlike "*Terminal*" -and $_.name -notlike "Microsoft.Net.*" -and $_.name -notlike "*Edge*" -and $_.name -notlike "Microsoft.UI*" -and $_.name -notlike "Microsoft.OOBE*" -and $_.name -notlike "Microsoft.VC*" -and $_.name -notlike "Microsoft.VC*" -and $_.name -notlike "Windows.Print*" -and $_.name -notlike "Microsoft.HEVCVideo*" -and $_.name -notlike "Microsoft.HEIFImage*" -and $_.name -notlike "Microsoft.Web*" -and $_.name -notlike "Microsoft.MPEG*" -and $_.name -notlike "Microsoft.VP9*" -and $_.name -notlike "Microsoft.MicrosoftSolitaire*" -and $_.name -notlike "Microsoft.QuickAssist*" -and $_.name -notlike "Microsoft.Wallet*" -and $_.name -notlike "Microsoft.Windows*" -and $_.name -notlike "Windows*" -and $_.name -notlike "*nVidia*"  -and $_.name -notlike "*AMD*" -and $_.name -notlike "*ASUS*" -and $_.name -notlike "*Armoury*" -and $_.name -notlike "*MSI*" -and $_.name -notlike "*EVGA*" -and $_.name -notlike "*Intel*" -and $_.name -notlike "*Adobe*" -and $_.name -notlike "*Spotify*"} | Remove-AppxPackage -ErrorAction SilentlyContinue

# Default W11 Bloatware
Get-AppxPackage -AllUsers "Microsoft.3DBuilder*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.549981C3F5F10*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Appconnector*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.BingFinance*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.BingFoodAndDrink*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.BingHealthAndFitness*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.BingNews*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.BingSports*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.BingTranslator*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.BingTravel*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.CommsPhone*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.ConnectivityStore*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.WindowsFeedbackHub*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.GetHelp*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Getstarted*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Messaging*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Microsoft3DViewer*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MicrosoftOfficeHub*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MicrosoftPowerBIForWindows*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MixedReality.Portal*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.NetworkSpeedTest*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Office.Sway*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.OneConnect*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.People*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Print3D*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.SkypeApp*" | Remove-AppxPackage
# Remove "Chat" icon from Taskbar for free edition of "Teams"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarMn /t REG_DWORD /d 0
Get-AppxPackage -AllUsers "MicrosoftTeams*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Todos*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Wallet*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Whiteboard*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.WindowsMaps*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.WindowsPhone*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.WindowsReadingList*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.YourPhone*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.ZuneMusic*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.ZuneVideo*" | Remove-AppxPackage
# Third Party General Bloatware
Get-AppxPackage -AllUsers "*ACGMediaPlayer*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*ActiproSoftwareLLC*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*AdobePhotoshopExpress*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Amazon.com.Amazon*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Asphalt8Airborne*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*AutodeskSketchBook*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*BubbleWitch3Saga*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*CaesarsSlotsFreeCasino*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*CandyCrush*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*COOKINGFEVER*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*CyberLinkMediaSuiteEssentials*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Disney*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*DrawboardPDF*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Duolingo-LearnLanguagesforFree*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*EclipseManager*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Facebook*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*FarmVille2CountryEscape*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*FitbitCoach*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Flipboard*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*HiddenCity*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Hulu*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*iHeartRadio*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Instagram*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Keeper*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Kindle*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*LinkedInforWindows*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*MarchofEmpires*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*NYTCrossword*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*OneCalendar*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*PandoraMediaInc*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*PhototasticCollage*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*PicsArt-PhotoStudio*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*PolarrPhotoEditorAcademicEdition*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Prime*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*RoyalRevolt*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Shazam*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Sidia.LiveWallpaper*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*SlingTV*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Speed" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*SpotifyAB.SpotifyMusic*" | Remove-AppxPackage # W11 Branded Spotify
Get-AppxPackage -AllUsers "*Sway*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*TuneInRadio*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Twitter*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Viber*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*WinZipUniversal*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Wunderlist*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*XING*" | Remove-AppxPackage
# Samsung Bloatware
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.1412377A9806A*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.NewVoiceNote*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCoLtd.SamsungNotes*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCoLtd.SamsungFlux*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.StudioPlus*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungWelcome*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungUpdate*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungSecurity1.2*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungScreenRecording*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungQuickSearch*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungPCCleaner*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungCloudBluetoothSync*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.PCGallery*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.OnlineSupportSService*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "4AE8B7C2.BOOKING.COMPARTNERAPPSAMSUNGEDITION*" | Remove-AppxPackage

# Disable SILENT installs of new Apps
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContentEnabled" -Value "0"
# Start Menu Application suggestions
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value "0"
# Disable future installs/re-installs of factory/OEM Metro Apps
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OEMPreInstalledAppsEnabled" -Value "0"

# 3.2 Applications
Write-Host "3.2 Applications" -ForegroundColor Green

# 3.2.1 Edge
Write-Host "3.2.1 Microsoft Edge" -ForegroundColor Green
## Services
Get-Service "edgeupdate" | Stop-Service | Out-Null
Get-Service "edgeupdate" | Set-Service -StartupType Disabled | Out-Null
Get-Service "edgeupdatem" | Stop-Service | Out-Null
Get-Service "edgeupdatem" | Set-Service -StartupType Disabled | Out-Null
Write-Host "3.2.1 Disabled Microsoft Edge - Auto Update Services" -ForegroundColor Green
## Scheduled Tasks
Get-Scheduledtask "*edge*" -erroraction silentlycontinue | Disable-ScheduledTask | Out-Null
Write-Host "3.2.1 Disabled Microsoft Edge - Auto Start (Scheduled Task)" -ForegroundColor Green
## Auto Start
Set-Location HKLM:
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft" -Force -ErrorAction SilentlyContinue | Out-Null};
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge" -Force -ErrorAction SilentlyContinue | Out-Null};
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Force -ErrorAction SilentlyContinue | Out-Null};
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Name "AllowPrelaunch" -Value "0" -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
Set-Location HKCU:
Set-Location "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run\"
Remove-ItemProperty -Path. -Name "*MicrosoftEdge*" -Force -ErrorAction SilentlyContinue | Out-Null
Set-Location "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
Remove-ItemProperty -Path. -Name "*MicrosoftEdge*" -Force -ErrorAction SilentlyContinue | Out-Null
Set-Location C:/
Write-Host "3.2.1 Disabled Microsoft Edge - Auto Start (Startup Entry)" -ForegroundColor Green
# Tracking
Set-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main' -Name 'DoNotTrack' -Value '1'
Write-Host "3.2.1 Disabled Microsoft Edge - Tracking" -ForegroundColor Green

# 3.2.2 OneDrive
# Close OneDrive (if running in background)
taskkill /f /im OneDrive.exe
# File Explorer - Remove
if((Test-Path -LiteralPath "HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}") -ne $true) {  New-Item "HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force -ErrorAction SilentlyContinue | Out-Null };
New-ItemProperty -LiteralPath 'HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Name '(default)' -Value 'OneDrive' -PropertyType String -Force -ErrorAction SilentlyContinue | Out-Null;
New-ItemProperty -LiteralPath 'HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Name 'System.IsPinnedToNameSpaceTree' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null;
# File Sync - Disable		
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSync" -Value "1" | Out-Null
# Removal - x86
%SystemRoot%\System32\OneDriveSetup.exe /uninstall
# Removal - x64
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
# Misc - Leftovers
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\OneDriveTemp"
# Misc - Prevent New User Accounts installone OneDrive
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload "hku\Default"
# Shorcut - Start Menu Removal
Remove-Item -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"
Write-Host "3.2.2 OneDrive Removed" -ForegroundColor Green

# 3.3 Widgets
winget uninstall --Name "Windows web experience pack" --accept-source-agreements
Write-Host "3.3 Widgets Removal" -ForegroundColor Green
#endregion


<#############################################################################################################################>
#region 4.0 Services and Scheduled Tasks
# Services
Write-Host "4.1 Services" -ForegroundColor Green
# Bing Downloaded Maps Manager
Get-Service "MapsBroker" | Stop-Service | Out-Null
Get-Service "MapsBroker" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Bing Downloaded Maps Manager" -ForegroundColor Green
# Bluetooth (Setting to Manual in the event BT is used.)
Get-Service "BTAGService" | Stop-Service | Out-Null
Get-Service "BTAGService" | Set-Service -StartupType Manual | Out-Null
Get-Service "bthserv" | Stop-Service | Out-Null
Get-Service "bthserv" | Set-Service -StartupType Manual | Out-Null
Write-Host "Set to Manual: Bluetooth" -ForegroundColor Green
# Celluar Time
Get-Service "autotimesvc" | Stop-Service | Out-Null
Get-Service "autotimesvc" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Celluar Time" -ForegroundColor Green
# Parental Controls
Get-Service "WpcMonSvc" | Stop-Service | Out-Null
Get-Service "WpcMonSvc" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Parental Controls" -ForegroundColor Green
# Phone Service
Get-Service "PhoneSvc" | Stop-Service | Out-Null
Get-Service "PhoneSvc" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Phone Service" -ForegroundColor Green
# Portable Device Enumerator Service
Get-Service "WPDBusEnum" | Stop-Service | Out-Null
Get-Service "WPDBusEnum" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Portable Device Enumeration Service" -ForegroundColor Green
# Program Compatibility Assistant Service
Get-Service "PcaSvc" | Stop-Service | Out-Null
Get-Service "PcaSvc" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Program Compatibility Assistant Service" -ForegroundColor Green
# Remote Registry
Get-Service "RemoteRegistry" | Stop-Service | Out-Null
Get-Service "RemoteRegistry" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Remote Registry (Security Increased)" -ForegroundColor Green
# Retail Demo
Get-Service "RetailDemo" | Stop-Service | Out-Null
Get-Service "RetailDemo" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Retail Demo" -ForegroundColor Green
# Themes
Get-Service "Themes" | Stop-Service | Out-Null
Get-Service "Themes" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Touch Keyboard and Handwritting Panel" -ForegroundColor Green
# Windows Insider Service
Get-Service "wisvc" | Stop-Service | Out-Null
Get-Service "wisvc" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Windows Insider Service" -ForegroundColor Green
# Windows Mobile Hotspot Service
Get-Service "icssvc" | Stop-Service | Out-Null
Get-Service "icssvc" | Set-Service -StartupType Disabled | Out-Null
Write-Host "Disabled: Windows Mobile Hotspot Service" -ForegroundColor Green

# Scheduled Tasks
Write-Host "4.2 Scheduled Tasks" -ForegroundColor Green
Get-Scheduledtask "Proxy" -ErrorAction SilentlyContinue | Disable-ScheduledTask | Out-Null
Get-Scheduledtask "SmartScreenSpecific" -ErrorAction SilentlyContinue | Disable-ScheduledTask | Out-Null
Get-Scheduledtask "Microsoft Compatibility Appraiser" -ErrorAction SilentlyContinue | Disable-ScheduledTask | Out-Null
Get-Scheduledtask "Consolidator" -ErrorAction SilentlyContinue | Disable-ScheduledTask | Out-Null
Get-Scheduledtask "KernelCeipTask" -ErrorAction SilentlyContinue | Disable-ScheduledTask | Out-Null
Get-Scheduledtask "UsbCeip" -ErrorAction SilentlyContinue | Disable-ScheduledTask | Out-Null
Get-Scheduledtask "Microsoft-Windows-DiskDiagnosticDataCollector" -ErrorAction SilentlyContinue | Disable-ScheduledTask | Out-Null
Get-Scheduledtask "GatherNetworkInfo" -ErrorAction SilentlyContinue | Disable-ScheduledTask | Out-Null
Get-Scheduledtask "QueueReporting" -ErrorAction SilentlyContinue | Disable-ScheduledTask | Out-Null
Get-Scheduledtask "UpdateLibrary" -ErrorAction SilentlyContinue | Disable-ScheduledTask | Out-Null
#endregion


<#############################################################################################################################>
#region 5.0 Quality of Life
Write-Host "5.0 Quality of Life" -ForegroundColor Green
# Take Ownership (Right Click Menu)
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\runas") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\*\shell\runas" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\runas\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\*\shell\runas\command" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\runas") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\runas" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\runas\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\runas\command" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas' -Name '(default)' -Value 'Take Ownership' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas' -Name 'NoWorkingDirectory' -Value '' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas\command' -Name '(default)' -Value 'cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas\command' -Name 'IsolatedCommand' -Value 'cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas' -Name '(default)' -Value 'Take Ownership' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas' -Name 'NoWorkingDirectory' -Value '' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas\command' -Name '(default)' -Value 'cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas\command' -Name 'IsolatedCommand' -Value 'cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t' -PropertyType String -Force -ErrorAction SilentlyContinue;
Write-Host "5.1 Windows: Adding File/Folder Take Ownership (Right Click Context Menu)" -ForegroundColor Green

# Restore Classic W10 right click menu
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
Write-Host "5.2 Windows: Restored W10 Right Click Context Menu" -ForegroundColor Green

# Add "Open with Powershell (Admin)" to right click menu
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin\command" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin\command" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin\command" -Force -ErrorAction SilentlyContinue };
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Classes\LibraryFolder\Background\shell\PowerShellAsAdmin" -Force;
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin' -Name '(default)' -Value 'Open with PowerShell (Admin)' -PropertyType String -Force -ErrorAction SilentlyContinue;
Remove-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin' -Name 'Extended' -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin' -Name 'HasLUAShield' -Value '' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin' -Name 'Icon' -Value 'powershell.exe' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin\command' -Name '(default)' -Value 'powershell -WindowStyle Hidden -NoProfile -Command "Start-Process -Verb RunAs powershell.exe -ArgumentList \"-NoExit -Command Push-Location \\\"\"%V/\\\"\"\"' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin' -Name '(default)' -Value 'Open with PowerShell (Admin)' -PropertyType String -Force -ErrorAction SilentlyContinue;
Remove-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin' -Name 'Extended' -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin' -Name 'HasLUAShield' -Value '' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin' -Name 'Icon' -Value 'powershell.exe' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin\command' -Name '(default)' -Value 'powershell -WindowStyle Hidden -NoProfile -Command "Start-Process -Verb RunAs powershell.exe -ArgumentList \"-NoExit -Command Push-Location \\\"\"%V/\\\"\"\"' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin' -Name '(default)' -Value 'Open with PowerShell (Admin)' -PropertyType String -Force -ErrorAction SilentlyContinue;
Remove-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin' -Name 'Extended' -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin' -Name 'HasLUAShield' -Value '' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin' -Name 'Icon' -Value 'powershell.exe' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin\command' -Name '(default)' -Value 'powershell -WindowStyle Hidden -NoProfile -Command "Start-Process -Verb RunAs powershell.exe -ArgumentList \"-NoExit -Command Push-Location \\\"\"%V/\\\"\"\"' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLinkedConnections' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue;
Write-Host "5.3 Explorer: Added 'Open with PowerShell (Admin)' to right click menu" -ForegroundColor Green

# Disable 'High Precision Event Timer' to prevent input lag on older games
bcdedit /deletevalue useplatformclock
bcdedit /set disabledynamictick yes
Write-Host "5.4 Disabled 'High Precision Event Timer' (Formerly Multimedia Timer)" -ForegroundColor Green

if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SYSTEM\CurrentControlSet\Control") -ne $true) {  New-Item "HKLM:\SYSTEM\CurrentControlSet\Control" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath "HKCU:\Control Panel\Desktop" -Name 'ForegroundLockTimeout' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath "HKCU:\Control Panel\Desktop" -Name 'HungAppTimeout' -Value '400' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath "HKCU:\Control Panel\Desktop" -Name 'WaitToKillAppTimeout' -Value '500' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control' -Name 'WaitToKillServiceTimeout' -Value '500' -PropertyType String -Force -ErrorAction SilentlyContinue;
Write-Host "5.5 Windows: Enabled Faster Shutdown" -ForegroundColor Green

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Force -ErrorAction SilentlyContinue | Out-Null };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowDriveLettersFirst' -Value 4 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null;
Write-Host "5.6 Explorer: Drive letters PRE drive label [Example: '(C:) Windows vs. Windows (C:)]'" -ForegroundColor Green

if((Test-Path -LiteralPath "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Mouse") -ne $true) {  New-Item "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Mouse" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Mouse' -Name 'MouseSpeed' -Value '0' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Mouse' -Name 'MouseThreshold1' -Value '0' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Mouse' -Name 'MouseThreshold2' -Value '0' -PropertyType String -Force -ErrorAction SilentlyContinue;
if((Test-Path -LiteralPath "HKCU:\Control Panel\Mouse") -ne $true) {  New-Item "HKCU:\Control Panel\Mouse" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Mouse") -ne $true) {  New-Item "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Mouse" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseSensitivity' -Value '10' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'SmoothMouseXCurve' -Value "([byte[]](0x	00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x	C0,0xCC,0x0C,0x00,0x00,0x00,0x00,0x00,0x	80,0x99,0x19,0x00,0x00,0x00,0x00,0x00,0x	40,0x66,0x26,0x00,0x00,0x00,0x00,0x00,0x	00,0x33,0x33,0x00,0x00,0x00,0x00,0x00))" -PropertyType Binary -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'SmoothMouseYCurve' -Value "([byte[]](0x	00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x	00,0x00,0x38,0x00,0x00,0x00,0x00,0x00,0x	00,0x00,0x70,0x00,0x00,0x00,0x00,0x00,0x	00,0x00,0xA8,0x00,0x00,0x00,0x00,0x00,0x	00,0x00,0xE0,0x00,0x00,0x00,0x00,0x00))" -PropertyType Binary -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Mouse' -Name 'MouseSpeed' -Value '0' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Mouse' -Name 'MouseThreshold1' -Value '0' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Mouse' -Name 'MouseThreshold2' -Value '0' -PropertyType String -Force -ErrorAction SilentlyContinue;
Write-Host "5.7 Mouse: MarkC's Acceleration Fix (Source: http://donewmouseaccel.blogspot.com/)" -ForegroundColor Green

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0"
Write-Host "5.8 UAC: Disabled Prompt" -ForegroundColor Green

if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -force -ErrorAction SilentlyContinue | Out-Null };
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null;
Write-Host "5.9 Explorer: Launch with 'This PC' instead of 'Most Recent'" -ForegroundColor Green

Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Force -ErrorAction SilentlyContinue | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -PropertyType "Dword" -Name "TaskbarAl" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.10 Start Menu: Alignment - Left" -ForegroundColor Green

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -name "fDenyTSConnections" -value "0" -Force | Out-Null
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "5.11 Remote Desktop: Enabled" -ForegroundColor Green

Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" -Name "Discord" -Force -ErrorAction SilentlyContinue | Out-Null
Write-host "5.12 Discord: Disabled Auto Start" -ForegroundColor Green

Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Force -ErrorAction SilentlyContinue | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -PropertyType "Dword" -Name "ToastEnabled" -Value "0" | Out-Null
Write-host "5.13 Windows: Disabled Toast Notifications" -ForegroundColor Green

New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -PropertyType "Dword" -Name "ShowTaskViewButton" -Value "0" -ErrorAction SilentlyContinue | Out-Null
Write-host "5.14 Taskbar: Removed 'Task View' Button" -ForegroundColor Green

Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchBoxTaskbarMode" -Value "0" -Type "DWord" -Force | Out-Null
Write-host "5.15 Taskbar: Removed 'Search' Button" -ForegroundColor Green

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value "0" | Out-Null
Write-Host "5.16 Explorer: Display File Extensions" -ForegroundColor Green

if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Value "0" -PropertyType "DWord" -Force -ErrorAction SilentlyContinue | Out-Null;
Write-Host "5.17 Explorer: Disabled 'Recent Files' in Explorer" -ForegroundColor Green

if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null;
Write-Host "5.18 Explorer: Disabled 'Recent Folders' in Quick Access" -ForegroundColor Green

if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_TrackDocs' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null;
Write-Host "5.19 Explorer: Disabled Recent Files/Folders in Start Menu and Explorer" -ForegroundColor Green

if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop\WindowMetrics") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop\WindowMetrics" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Value '0' -PropertyType String -Force -ErrorAction SilentlyContinue | Out-Null;
Write-Host "5.20 Explorer: Disabled Explorer Animations" -ForegroundColor Green
#endregion


<#############################################################################################################################>
#region 6.0 Performance
Write-Host "6.0 Performance" -ForegroundColor Green
# Delay time on menu displaying / Animation
Set-Itemproperty -path "HKCU:\Control Panel\Desktop" -Name 'MenuShowDelay' -value '50'
Write-Host "6.1 Start Menu Responsiveness" -ForegroundColor Green
# Power Settings
Write-Host "6.2 Power Settings" -ForegroundColor Green
# Monitor Screen Timeout
Powercfg /Change monitor-timeout-ac 15
Powercfg /Change monitor-timeout-dc 15
Write-Host "6.2.1 Power Settings: Monitor" -ForegroundColor Green
# PC Sleep Timeout
Powercfg /Change standby-timeout-ac 0
Powercfg /Change standby-timeout-dc 60
Write-Host "6.2.2 Power Settings: PC" -ForegroundColor Green
# Disable Hard Drive from turning off
powercfg /Change -disk-timeout-dc 0
powercfg /Change -disk-timeout-ac 0
Write-Host "6.2.3 Power Settings: Hard Drive" -ForegroundColor Green
# Hibernate Disable
powercfg /Change -hibernate-timeout-ac 0
powercfg /Change -hibernate-timeout-dc 0
powercfg -h off
Write-Host "6.2.4 Power Settings: Hibernate" -ForegroundColor Green
#endregion


<#############################################################################################################################>
#region 7.0 Privacy
Write-Host "7.0 Privacy" -ForegroundColor Green
# App Permissions
Write-Host "7.1 App Permissions" -ForegroundColor Green
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -ErrorAction SilentlyContinue
Set-Location HKLM:
New-Item -Path ".SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -ErrorAction SilentlyContinue
New-ItemProperty -Path ".SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value "1" -ErrorAction SilentlyContinue
New-Item -Path ".\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -ErrorAction SilentlyContinue
New-ItemProperty -Path ".\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "EnableStatus" -Type DWord -Value "1" -ErrorAction SilentlyContinue
# App Diagnostics
Write-Host "7.2 App Diagnostics" -ForegroundColor Green
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Deny" -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Deny" -ErrorAction SilentlyContinue
#endregion


<#############################################################################################################################>
#region 8.0 Notify User to Reboot
Write-Host ""
Write-Host "*********************************************************" -ForegroundColor Red
Write-Host "*                                                       *" -ForegroundColor Red
Write-Host "* Restart your computer for the changes to take effect! *" -ForegroundColor Red
Write-Host "*                                                       *" -ForegroundColor Red
Write-Host "*********************************************************" -ForegroundColor Red
Write-Host ""
Write-Host "To get the latest version of this script visit:" -ForegroundColor Green
Write-Host "https://github.com/AdminVin/Scripts/" -ForegroundColor Green
Write-Host ""
Write-Host ""
Write-Host ""
pause
#endregion