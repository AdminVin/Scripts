#region Introduction
Write-Host "Hello!" -ForegroundColor DarkGreen
Write-Host ""
Write-Host "This script was created by AdminVin, and the purpose of it is to remove all bloatware from your Windows 10 Installation." -ForegroundColor DarkGreen
Write-Host "This has been updated for Windows 10 - Update 22H2." -ForegroundColor DarkGreen
Write-Host ""
Write-Host "Updated 2022-10-24" -ForegroundColor DarkGreen
Write-Host ""
#endregion

<### Elevating Powershell Script with Administrative Rights ###>
Write-Host "1.0 Elevating Powershell Script with Administrative Rights" -ForegroundColor Green
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


<### Diagnostics ###>
Write-Host "2.0 Diagnostics" -ForegroundColor Green
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value "1"
Write-Host "2.1 Enabled Verbose Status Messaging" -ForegroundColor Green

<### Applications ###>
Write-Host "3.0 Applications" -ForegroundColor Green
Write-Host "3.1 Applications - Metro" -ForegroundColor Green
# Default Windows Bloatware
Get-AppxPackage -AllUsers "Microsoft.3DBuilder*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.549981C3F5F10*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.Appconnector*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.BingFinance*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.BingFoodAndDrink*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.BingHealthAndFitness*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.BingNews*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.BingSports*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.BingTranslator*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.BingTravel*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.CommsPhone*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.ConnectivityStore*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.WindowsFeedbackHub*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.GetHelp*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.Getstarted*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.Messaging*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.Microsoft3DViewer*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.MicrosoftOfficeHub*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.MicrosoftPowerBIForWindows*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.MixedReality.Portal*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.NetworkSpeedTest*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.Office.Sway*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.OneConnect*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.People*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.Print3D*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.SkypeApp*" | Remove-AppxPackage -ErrorAction SilentlyContinue
# Remove "Chat" icon from Taskbar for free edition of "Teams"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarMn /t REG_DWORD /d 0
Get-AppxPackage -AllUsers "MicrosoftTeams*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.Todos*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.Wallet*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.Whiteboard*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.WindowsMaps*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.WindowsPhone*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.WindowsReadingList*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.YourPhone*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.ZuneMusic*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "Microsoft.ZuneVideo*" | Remove-AppxPackage -ErrorAction SilentlyContinue
# Third Party General Bloatware
Get-AppxPackage -AllUsers "*ACGMediaPlayer*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*ActiproSoftwareLLC*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*AdobePhotoshopExpress*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Amazon.com.Amazon*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Asphalt8Airborne*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*AutodeskSketchBook*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*BubbleWitch3Saga*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*CaesarsSlotsFreeCasino*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*CandyCrush*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*COOKINGFEVER*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*CyberLinkMediaSuiteEssentials*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Disney*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*DrawboardPDF*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Duolingo-LearnLanguagesforFree*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*EclipseManager*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Facebook*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*FarmVille2CountryEscape*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*FitbitCoach*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Flipboard*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*HiddenCity*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Hulu*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*iHeartRadio*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Instagram*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Keeper*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Kindle*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*LinkedInforWindows*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*MarchofEmpires*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*NYTCrossword*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*OneCalendar*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*PandoraMediaInc*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*PhototasticCollage*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*PicsArt-PhotoStudio*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*PolarrPhotoEditorAcademicEdition*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Prime*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*RoyalRevolt*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Shazam*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Sidia.LiveWallpaper*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*SlingTV*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Speed" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*SpotifyAB.SpotifyMusic*" | Remove-AppxPackage -ErrorAction SilentlyContinue # W11 Branded Spotify
Get-AppxPackage -AllUsers "*Sway*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*TuneInRadio*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Twitter*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Viber*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*WinZipUniversal*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*Wunderlist*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "*XING*" | Remove-AppxPackage -ErrorAction SilentlyContinue
# Samsung Bloatware
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.1412377A9806A*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.NewVoiceNote*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCoLtd.SamsungNotes*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCoLtd.SamsungFlux*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.StudioPlus*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungWelcome*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungUpdate*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungSecurity1.2*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungScreenRecording*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungQuickSearch*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungPCCleaner*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.SamsungCloudBluetoothSync*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.PCGallery*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "SAMSUNGELECTRONICSCO.LTD.OnlineSupportSService*" | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUsers "4AE8B7C2.BOOKING.COMPARTNERAPPSAMSUNGEDITION*" | Remove-AppxPackage -ErrorAction SilentlyContinue

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

## 3.2.1 Microsoft Edge
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

## One Drive
Write-Host "3.2.2 OneDrive Removal - Skipped!" -ForegroundColor Yellow

<### Services and Scheduled Tasks ###>
Write-Host "3.0 Services and Scheduled Tasks" -ForegroundColor Green
Write-Host "3.1 Services" -ForegroundColor Green
Get-Service Diagtrack,Fax,PhoneSvc,WMPNetworkSvc,DmwApPushService,WpcMonSvc -ErrorAction SilentlyContinue | Stop-Service | Set-Service -StartupType Disabled

Write-Host "3.2 Scheduled Tasks" -ForegroundColor Green
Get-Scheduledtask "Proxy" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "SmartScreenSpecific" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "Microsoft Compatibility Appraiser" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "Consolidator" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "KernelCeipTask" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "UsbCeip" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "Microsoft-Windows-DiskDiagnosticDataCollector" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "GatherNetworkInfo" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "QueueReporting" -ErrorAction SilentlyContinue | Disable-ScheduledTask


 <### 5.0 Quality of Life###>
Write-Host "5.0 Quality of Life" -ForegroundColor Green

Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.1 Explorer: Disable Ads in File Explorer" -ForegroundColor Green

Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" -Name "Enabled" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Input\TIPC" -Name "Enabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "HistoryViewEnabled" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.2 Cortana - Disabled 'Microsoft from getting to know you'" -ForegroundColor Green

Set-Itemproperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableActivityFeed' -Value '0' -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.3 Cortana: Disabled 'Activity Feed' in Start Menu" -ForegroundColor Green

Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenOverlayEnabled" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.4 Windows: Disabled Lockscreen suggestions and rotating pictures" -ForegroundColor Green

Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value "1" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.5 Windows: Disabled Feedback Prompts" -ForegroundColor Green

Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Value "1" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.6 Windows: Disabled Troubleshooting 'Steps Recorder'" -ForegroundColor Green

Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableSoftLanding" -Value "1" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.7 Windows: Disabled Tips" -ForegroundColor Green

#Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Value "0"	
Write-Host "5.8 Windows: Disabled Application Telemetry - Skipped! Required by InTune." -ForegroundColor Yellow

#Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableInventory" -Value "1"
Write-Host "5.8 Windows: Disabled Inventory Collector - Skipped! Required by InTune." -ForegroundColor Yellow

Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value "1" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.9 Windows: Disabled Consumer Experiences" -ForegroundColor Green

Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -Name "EnableConfigFlighting" -Value "0" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.10 Windows: Disabled Pre-Release Features" -ForegroundColor Green

New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -Name 'PeopleBand' -PropertyType Dword -Value '0' -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -Name 'PeopleBand' -Value '0' -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.11 Start: Disabled 'People' in system tray" -ForegroundColor Green

Set-ItemProperty -LiteralPath 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'DisableNotificationCenter' -Value '0' -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "5.12 Start: Disabled 'Windows Action Center' in system tray" -ForegroundColor Green

Set-Itemproperty -path 'HKCU:\Control Panel\Desktop' -Name 'MenuShowDelay' -Value '50'
Write-Host "5.13 Start: Decreased Menu Animation Time" -ForegroundColor Green

Remove-Item -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Force -ErrorAction SilentlyContinue | Out-Null;
Remove-Item -LiteralPath "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Force -ErrorAction SilentlyContinue | Out-Null;
Write-Host "5.14 Windows: Removed '3D Objects' from File Explorer" -ForegroundColor Green

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowDriveLettersFirst' -Value 4 -PropertyType DWord -Force -ErrorAction SilentlyContinue;
Write-Host "5.15 File Explorer: Drive letters PRE drive label [Example: '(C:) Windows vs. Windows (C:)]'" -ForegroundColor Green

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
Write-Host "5.16 Windows: Adding File/Folder Take Ownership (Right Click Context Menu)" -ForegroundColor Green

if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SYSTEM\CurrentControlSet\Control") -ne $true) {  New-Item "HKLM:\SYSTEM\CurrentControlSet\Control" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'ForegroundLockTimeout' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'HungAppTimeout' -Value '400' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'WaitToKillAppTimeout' -Value '500' -PropertyType String -Force -ErrorAction SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control' -Name 'WaitToKillServiceTimeout' -Value '500' -PropertyType String -Force -ErrorAction SilentlyContinue;
Write-Host "5.17 Windows: Enabled Faster Shutdown" -ForegroundColor Green

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\Background\shell\PowerShellAsAdmin\command" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\PowerShellAsAdmin\command" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin" -Force -ErrorAction SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Drive\shell\PowerShellAsAdmin\command" -Force -ErrorAction SilentlyContinue };
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Classes\LibraryFolder\Background\shell\PowerShellAsAdmin" -force;
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
Write-Host "5.18 File Explorer: Added 'Open with PowerShell (Admin)' to right click menu" -ForegroundColor Green

if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -force -ErrorAction SilentlyContinue | Out-Null };
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null;
Write-Host "5.19 Explorer: Launch with 'This PC' instead of 'Most Recent'" -ForegroundColor Green


 <### 6.0 Performance ###>
Write-Host "6.0 Performance" -ForegroundColor Green
Powercfg /Change monitor-timeout-ac 15
Powercfg /Change monitor-timeout-dc 15
Write-Host "6.1 Sleep Settings: Monitor" -ForegroundColor Green
Powercfg /Change standby-timeout-ac 0
Powercfg /Change standby-timeout-dc 60
Write-Host "6.2 Sleep Settings: PC" -ForegroundColor Green
powercfg /Change -disk-timeout-dc 0
powercfg /Change -disk-timeout-ac 0
Write-Host "6.3 Sleep Settings: Hard Drive" -ForegroundColor Green
# Hibernate Disable
powercfg /Change -hibernate-timeout-ac 0
powercfg /Change -hibernate-timeout-dc 0
powercfg -h off
Write-Host "6.4 Sleep Settings: Hibernate" -ForegroundColor Green

###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################

### Notify User
Write-Host ""
Write-Host "***************************************************"
Write-Host "* RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT! *"
Write-Host "***************************************************"
pause