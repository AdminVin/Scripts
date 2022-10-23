#region Introduction
Write-Host "Hello!" -ForegroundColor DarkGreen
Write-Host ""
Write-Host "This script was created by AdminVin, and the purpose of it is to remove all bloatware from your Windows 11 Installation." -ForegroundColor DarkGreen
Write-Host "This has been updated for Windows 11 - Update 22H2." -ForegroundColor DarkGreen
Write-Host ""
Write-Host "Updated 2022-10-23" -ForegroundColor DarkGreen
Write-Host ""
#endregion


<#############################################################################################################################>
#region 1.0 Elevate PowerShell Session
Write-Host "1.0 Elevating Powershell Session with Administrative Rights" -ForegroundColor YELLOW
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
#endregion


<#############################################################################################################################>
#region 2.0 Diagnostics
Write-Host "2.0 Diagnostics" -ForegroundColor YELLOW
# Verbose Status Messaging
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value "1"
#endregion


<#############################################################################################################################>
#region 3.0 Applications
# 3.1 Metro Apps
Write-Host "3.1 Metro Apps" -ForegroundColor YELLOW
<# Old method of removal #>
# Get-AppxPackage -AllUsers | where-object {$_.name -notlike "*Store*" -and $_.name -notlike "*Calculator*" -and $_.name -notlike "Microsoft.Windows.Photos*" -and $_.name -notlike "Microsoft.WindowsSoundRecorder*" -and $_.name -notlike "Microsoft.Paint*" -and $_.name -notlike "Microsoft.MSPaint*" -and $_.name -notlike "Microsoft.ScreenSketch*" -and $_.name -notlike "Microsoft.WindowsCamera*" -and $_.name -notlike "microsoft.windowscommunicationsapps*"<# Mail App#> -and $_.name -notlike "*Weather*" -and $_.name -notlike "Microsoft.Office.OneNote*" -and $_.name -notlike "*Note*" -and $_.name -notlike "*xbox*" -and $_.name -notlike "*OneDrive*" -and $_.name -notlike "Microsoft.WindowsAlarms*" -and $_.name -notlike "*Terminal*" -and $_.name -notlike "Microsoft.Net.*" -and $_.name -notlike "*Edge*" -and $_.name -notlike "Microsoft.UI*" -and $_.name -notlike "Microsoft.OOBE*" -and $_.name -notlike "Microsoft.VC*" -and $_.name -notlike "Microsoft.VC*" -and $_.name -notlike "Windows.Print*" -and $_.name -notlike "Microsoft.HEVCVideo*" -and $_.name -notlike "Microsoft.HEIFImage*" -and $_.name -notlike "Microsoft.Web*" -and $_.name -notlike "Microsoft.MPEG*" -and $_.name -notlike "Microsoft.VP9*" -and $_.name -notlike "Microsoft.MicrosoftSolitaire*" -and $_.name -notlike "Microsoft.QuickAssist*" -and $_.name -notlike "Microsoft.Wallet*" -and $_.name -notlike "Microsoft.Windows*" -and $_.name -notlike "Windows*" -and $_.name -notlike "*nVidia*"  -and $_.name -notlike "*AMD*" -and $_.name -notlike "*ASUS*" -and $_.name -notlike "*Armoury*" -and $_.name -notlike "*MSI*" -and $_.name -notlike "*EVGA*" -and $_.name -notlike "*Intel*" -and $_.name -notlike "*Adobe*" -and $_.name -notlike "*Spotify*"} | Remove-AppxPackage -ErrorAction SilentlyContinue

<# New Method for Metro Apps Removal #>
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
Write-Host "3.2 Applications" -ForegroundColor YELLOW

# 3.2.1 Edge
Write-Host "3.2.1 Microsoft Edge" -ForegroundColor YELLOW
## Services
Get-Service "edgeupdate" | Stop-Service
Get-Service "edgeupdate" | Set-Service -StartupType Disabled
Get-Service "edgeupdatem" | Stop-Service
Get-Service "edgeupdatem" | Set-Service -StartupType Disabled
Write-Host "3.2.1 Disabled Microsoft Edge - Auto Update Services" -ForegroundColor YELLOW
## Scheduled Tasks
Get-Scheduledtask "*edge*" -erroraction silentlycontinue | Disable-ScheduledTask
Write-Host "3.2.1 Disabled Microsoft Edge - Auto Start (Scheduled Task)" -ForegroundColor YELLOW
## Auto Start
Set-Location HKLM:
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft" -Force -ErrorAction SilentlyContinue | Out-Null};
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge" -Force -ErrorAction SilentlyContinue | Out-Null};
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Force -ErrorAction SilentlyContinue | Out-Null};
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Name "AllowPrelaunch" -Value "0" -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
Set-Location HKCU:
Set-Location "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run\"
Remove-ItemProperty -Path. -Name "*MicrosoftEdge*" -Force | Out-Null
Set-Location "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
Remove-ItemProperty -Path. -Name "*MicrosoftEdge*" -Force | Out-Null
Set-Location C:/
Write-Host "3.2.1 Disabled Microsoft Edge - Auto Start (Startup Entry)" -ForegroundColor YELLOW
# Tracking
Set-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main' -Name 'DoNotTrack' -Value '1'
Write-Host "3.2.1 Disabled Microsoft Edge - Tracking" -ForegroundColor YELLOW

# 3.2.2 Cortana
Write-Host "3.2.2 Cortana" -ForegroundColor YELLOW
# Disable Web Searching from Start Menu
Set-Location HKCU:
New-Item -Path .\SOFTWARE\Policies\Microsoft\Windows\Explorer
New-ItemProperty -Path ".\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value "1"
Set-Location C:/
Write-Host "3.2.2 Disabled Cortana Web Search" -ForegroundColor YELLOW

# 3.3 Widgets
winget uninstall --Name "Windows web experience pack" --accept-source-agreements
Write-Host "3.3 Widgets Removal" -ForegroundColor YELLOW

# 3.4 OneDrive
# Close OneDrive (if running in background)
taskkill /f /im OneDrive.exe
# OneDrive - Remove from left hand side navigation
Set-ItemProperty -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Name "System.IsPinnedToNameSpaceTree" -Value "0"
# One Drive - Disable File Sync		
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSync" -Value "1"
# Remove OneDrive - x86
%SystemRoot%\System32\OneDriveSetup.exe /uninstall
# Remove OneDrive - x64
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
# Uninstall OneDrive
if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
    & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
}
if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
    & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
}
# Disable OneDrive via Group Policies
force-mkdir "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive"
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" 1
# Removing OneDrive Leftovers
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\OneDriveTemp"
# Remove OneDrive from explorer sidebar
New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR"
mkdir -Force "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
Set-ItemProperty "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" "System.IsPinnedToNameSpaceTree" 0
mkdir -Force "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
Set-ItemProperty "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" "System.IsPinnedToNameSpaceTree" 0
Remove-PSDrive "HKCR"
# Removing run option for new Users
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload "hku\Default"
# Removing Start Menu Entry
Remove-Item -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"
Write-Host "3.4 OneDrive Removed" -ForegroundColor YELLOW
#endregion


<#############################################################################################################################>
#region 4.0 Services and Scheduled Tasks
# Services
Write-Host "4.1 Services" -ForegroundColor YELLOW
# Bing Downloaded Maps Manager
Get-Service "MapsBroker" | Stop-Service
Get-Service "MapsBroker" | Set-Service -StartupType Disabled
Write-Host "Disabled: Bing Downloaded Maps Manager" -ForegroundColor DarkYellow
# Bluetooth (Setting to Manual in the event BT is used.)
Get-Service "BTAGService" | Stop-Service
Get-Service "BTAGService" | Set-Service -StartupType Manual
Get-Service "BluetoothUserService*" | Stop-Service
Get-Service "BluetoothUserService*" | Set-Service -StartupType Manual
Get-Service "bthserv" | Stop-Service
Get-Service "bthserv" | Set-Service -StartupType Manual
Write-Host "Set to Manual: Bluetooth" -ForegroundColor DarkYellow
# Celluar Time
Get-Service "autotimesvc" | Stop-Service
Get-Service "autotimesvc" | Set-Service -StartupType Disabled
Write-Host "Disabled: Celluar Time" -ForegroundColor DarkYellow
# Fax
Get-Service "Fax" | Stop-Service
Get-Service "Fax" | Set-Service -StartupType Disabled
Write-Host "Disabled: Fax" -ForegroundColor DarkYellow
# HomeGroup
Get-Service "HomeGroupListener" | Stop-Service
Get-Service "HomeGroupListener" | Set-Service -StartupType Disabled
Write-Host "Disabled: HomeGroup" -ForegroundColor DarkYellow
# Parental Controls
Get-Service "WpcMonSvc" | Stop-Service
Get-Service "WpcMonSvc" | Set-Service -StartupType Disabled
Write-Host "Disabled: Parental Controls" -ForegroundColor DarkYellow
# Phone Service
Get-Service "PhoneSvc" | Stop-Service
Get-Service "PhoneSvc" | Set-Service -StartupType Disabled
Write-Host "Disabled: Phone Service" -ForegroundColor DarkYellow
# Portable Device Enumerator Service
Get-Service "WPDBusEnum" | Stop-Service
Get-Service "WPDBusEnum" | Set-Service -StartupType Disabled
Write-Host "Disabled: Portable Device Enumeration Service" -ForegroundColor DarkYellow
# Program Compatibility Assistant Service
Get-Service "PcaSvc" | Stop-Service
Get-Service "PcaSvc" | Set-Service -StartupType Disabled
Write-Host "Disabled: Program Compatibility Assistant Service" -ForegroundColor DarkYellow
# Remote Registry
Get-Service "RemoteRegistry" | Stop-Service
Get-Service "RemoteRegistry" | Set-Service -StartupType Disabled
Write-Host "Disabled: Remote Registry (Security Increased)" -ForegroundColor DarkYellow
# Retail Demo
Get-Service "RetailDemo" | Stop-Service
Get-Service "RetailDemo" | Set-Service -StartupType Disabled
Write-Host "Disabled: Retail Demo" -ForegroundColor DarkYellow
# Themes
Get-Service "Themes" | Stop-Service
Get-Service "Themes" | Set-Service -StartupType Disabled
Write-Host "Disabled: Touch Keyboard and Handwritting Panel" -ForegroundColor DarkYellow
# Touch Keyboard and Handwriting Panel
Get-Service "TabletInputService" | Stop-Service
Get-Service "TabletInputService" | Set-Service -StartupType Disabled
Write-Host "Disabled: Touch Keyboard and Handwritting Panel" -ForegroundColor DarkYellow
# Windows Insider Service
Get-Service "wisvc" | Stop-Service
Get-Service "wisvc" | Set-Service -StartupType Disabled
Write-Host "Disabled: Windows Insider Service" -ForegroundColor DarkYellow
# Windows Mobile Hotspot Service
Get-Service "icssvc" | Stop-Service
Get-Service "icssvc" | Set-Service -StartupType Disabled
Write-Host "Disabled: Windows Mobile Hotspot Service" -ForegroundColor DarkYellow

# Scheduled Tasks
Write-Host "4.2 Scheduled Tasks" -ForegroundColor YELLOW
Get-Scheduledtask "Proxy" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "SmartScreenSpecific" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "Microsoft Compatibility Appraiser" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "Consolidator" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "KernelCeipTask" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "UsbCeip" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "Microsoft-Windows-DiskDiagnosticDataCollector" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "GatherNetworkInfo" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "QueueReporting" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "UpdateLibrary" -ErrorAction SilentlyContinue | Disable-ScheduledTask
#endregion


<#############################################################################################################################>
#region 5.0 Quality of Life
Write-Host "5.0 Quality of Life" -ForegroundColor YELLOW
-ErrorAction
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
Write-Host "5.1 Windows: Adding File/Folder Take Ownership (Right Click Context Menu)" -ForegroundColor YELLOW

# Restore Classic W10 right click menu
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
Write-Host "5.2 Windows: Restored W10 Right Click Context Menu" -ForegroundColor YELLOW

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
Write-Host "5.3 Explorer: Added 'Open with PowerShell (Admin)' to right click menu" -ForegroundColor YELLOW

# Disable 'High Precision Event Timer' to prevent input lag on older games
bcdedit /deletevalue useplatformclock
bcdedit /set disabledynamictick yes
Write-Host "5.4 Disabled 'High Precision Event Timer' (Formerly Multimedia Timer)" -ForegroundColor YELLOW

if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SYSTEM\CurrentControlSet\Control") -ne $true) {  New-Item "HKLM:\SYSTEM\CurrentControlSet\Control" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath "HKCU:\Control Panel\Desktop" -Name 'ForegroundLockTimeout' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath "HKCU:\Control Panel\Desktop" -Name 'HungAppTimeout' -Value '400' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath "HKCU:\Control Panel\Desktop" -Name 'WaitToKillAppTimeout' -Value '500' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control' -Name 'WaitToKillServiceTimeout' -Value '500' -PropertyType String -Force -ErrorAction SilentlyContinue;
Write-Host "5.5 Windows: Enabled Faster Shutdown" -ForegroundColor YELLOW

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowDriveLettersFirst' -Value 4 -PropertyType DWord -Force -ErrorAction SilentlyContinue;
Write-Host "5.6 Explorer: Drive letters PRE drive label [Example: '(C:) Windows vs. Windows (C:)]'" -ForegroundColor YELLOW

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
Write-Host "5.7 Mouse: MarkC's Acceleration Fix (Source: http://donewmouseaccel.blogspot.com/)" -ForegroundColor YELLOW

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0"
Write-Host "5.8 UAC: Disabled Prompt" -ForegroundColor YELLOW

if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue;
Write-Host "5.9 Explorer: Launch with 'This PC' instead of 'Most Recent'" -ForegroundColor YELLOW

Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -PropertyType "Dword" -Name "TaskbarAl" -Value "0"
Write-Host "5.10 Start Menu: Alignment - Left" -ForegroundColor YELLOW

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -name "fDenyTSConnections" -value "0" -Force | Out-Null
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "5.11 Remote Desktop: Enabled" -ForegroundColor YELLOW

Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" -Name "Discord" -Force | Out-Null
Write-host "5.12 Discord: Disabled Auto Start" -ForegroundColor YELLOW

Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -PropertyType "Dword" -Name "ToastEnabled" -Value "0" | Out-Null
Write-host "5.13 Disabled Toast Notifications from Windows 11" -ForegroundColor YELLOW

New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -PropertyType "Dword" -Name "ShowTaskViewButton" -Value "0"
Write-host "5.14 Taskbar: Removed 'Task View' Button" -ForegroundColor YELLOW

Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchBoxTaskbarMode" -Value "0" -Type "DWord" -Force
Write-host "5.15 Taskbar: Removed 'Search' Button" -ForegroundColor YELLOW

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value "0"
Write-Host "5.16 Explorer: Display File Extensions" -ForegroundColor YELLOW
#endregion


<#############################################################################################################################>
#region 6.0 Performance
Write-Host "6.0 Performance" -ForegroundColor YELLOW
# Delay time on menu displaying / Animation
Set-Itemproperty -path "HKCU:\Control Panel\Desktop" -Name 'MenuShowDelay' -value '50'
Write-Host "6.1 Start Menu Responsiveness" -ForegroundColor YELLOW
# Power Settings
Write-Host "6.2 Power Settings" -ForegroundColor YELLOW
# Monitor Screen Timeout
Powercfg /Change monitor-timeout-ac 15
Powercfg /Change monitor-timeout-dc 15
Write-Host "6.2.1 Power Settings: Monitor" -ForegroundColor YELLOW
# PC Sleep Timeout
Powercfg /Change standby-timeout-ac 0
Powercfg /Change standby-timeout-dc 60
Write-Host "6.2.2 Power Settings: PC" -ForegroundColor YELLOW
# Disable Hard Drive from turning off
powercfg /Change -disk-timeout-dc 0
powercfg /Change -disk-timeout-ac 0
Write-Host "6.2.3 Power Settings: Hard Drive" -ForegroundColor YELLOW
# Hibernate Disable
powercfg /Change -hibernate-timeout-ac 0
powercfg /Change -hibernate-timeout-dc 0
powercfg -h off
Write-Host "6.2.4 Power Settings: Hibernate" -ForegroundColor YELLOW
#endregion


<#############################################################################################################################>
#region 7.0 Privacy
Write-Host "7.0 Privacy" -ForegroundColor YELLOW
# App Permissions
Write-Host "7.1 App Permissions" -ForegroundColor YELLOW
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -ErrorAction SilentlyContinue
Set-Location HKLM:
New-Item -Path ".SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -ErrorAction SilentlyContinue
New-ItemProperty -Path ".SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value "1" -ErrorAction SilentlyContinue
New-Item -Path ".\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -ErrorAction SilentlyContinue
New-ItemProperty -Path ".\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "EnableStatus" -Type DWord -Value "1" -ErrorAction SilentlyContinue
# App Diagnostics
Write-Host "7.2 App Diagnostics" -ForegroundColor YELLOW
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
Write-Host "To get the latest version of this script visit:" -ForegroundColor Yellow
Write-Host "https://github.com/AdminVin/Scripts/" -ForegroundColor Yellow
Write-Host ""
Write-Host ""
Write-Host ""
pause
#endregion