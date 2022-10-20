#region Introduction
Write-Host "Hello!" -ForegroundColor DarkGreen
Write-Host ""
Write-Host "This script was created by AdminVin, and the purpose of it is to remove all bloatware from your Windows 10 Installation." -ForegroundColor DarkGreen
Write-Host "This has been updated for Windows 10 - Update 21H2." -ForegroundColor DarkGreen
Write-Host ""
Write-Host "Updated 2022-10-18" -ForegroundColor DarkGreen
Write-Host ""
#endregion

### Elevating Powershell Script with Administrative Rights
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


### Diagnostics
Write-Output "1. Diagnostics"
# Verbose Status Messaging
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value "1"


### Applications
Write-Output "2. Applications"
## Metro Apps
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
Get-AppxPackage -AllUsers "*cell*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Microsoft.Windows.CloudExperienceHost*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.CommsPhone*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.ConnectivityStore*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*FeedbackHub*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.WindowsFeedbackHub*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.GetHelp*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Getstarted*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Messaging*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MiracastView*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Microsoft3DViewer*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MicrosoftOfficeHub*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MicrosoftPowerBIForWindows*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MixedReality.Portal*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.NetworkSpeedTest*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Office.Sway*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.OneConnect*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.People*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Print3D*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MicrosoftSolitaire*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.SkypeApp*" | Remove-AppxPackage
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
Get-AppxPackage -AllUsers "*DisneyMagicKingdoms*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*DrawboardPDF*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Duolingo-LearnLanguagesforFree*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*EclipseManager*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Facebook*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*FarmVille2CountryEscape*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*fitbit*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*FitbitCoach*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Flipboard*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*HiddenCity*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Hulu*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*iHeartRadio*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Keeper*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*LinkedInforWindows*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*MarchofEmpires*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*NYTCrossword*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*OneCalendar*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*PandoraMediaInc*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*PhototasticCollage*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*PicsArt-PhotoStudio*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*PolarrPhotoEditorAcademicEdition*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*RoyalRevolt*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Shazam*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Sidia.LiveWallpaper*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*SlingTV*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "*Speed" | Remove-AppxPackage
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


## One Drive
<# OMITTED FROM REMOVAL #>

## Microsoft Edge
Write-Host "Microsoft Edge" -ForegroundColor YELLOW
## Services
Get-Service "edgeupdate" | Stop-Service
Get-Service "edgeupdate" | Set-Service -StartupType Disabled
Get-Service "edgeupdatem" | Stop-Service
Get-Service "edgeupdatem" | Set-Service -StartupType Disabled
Write-Host "Disabled Microsoft Edge - Auto Update Services" -ForegroundColor YELLOW
## Scheduled Tasks
Get-Scheduledtask "*edge*" -erroraction silentlycontinue | Disable-ScheduledTask
Write-Host "Disabled Microsoft Edge - Auto Start (Scheduled Task)" -ForegroundColor YELLOW
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
Write-Host "Disabled Microsoft Edge - Auto Start (Startup Entry)" -ForegroundColor YELLOW
# Tracking
Set-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Name "DoNotTrack" -Value "1"
Write-Host "Disabled Microsoft Edge - Tracking" -ForegroundColor YELLOW


Write-Output "3. Schedule Tasks"
### Schedule Tasks
Get-Scheduledtask "Proxy" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "SmartScreenSpecific" -ErrorAction SilentlyContinue | Disable-ScheduledTask
Get-Scheduledtask "Microsoft Compatibility Appraiser" -erroraction silentlycontinue | Disable-ScheduledTask
Get-Scheduledtask "Consolidator" -erroraction silentlycontinue | Disable-ScheduledTask
Get-Scheduledtask "KernelCeipTask" -erroraction silentlycontinue | Disable-ScheduledTask
Get-Scheduledtask "UsbCeip" -erroraction silentlycontinue | Disable-ScheduledTask
Get-Scheduledtask "Microsoft-Windows-DiskDiagnosticDataCollector" -erroraction silentlycontinue | Disable-ScheduledTask
Get-Scheduledtask "GatherNetworkInfo" -erroraction silentlycontinue | Disable-ScheduledTask
Get-Scheduledtask "QueueReporting" -erroraction silentlycontinue | Disable-ScheduledTask


Write-Output "4. Services"
# Disable Services that are not needed
Get-Service Diagtrack,Fax,PhoneSvc,WMPNetworkSvc,DmwApPushService,WpcMonSvc -erroraction silentlycontinue | Stop-Service -passthru | Set-Service -StartupType Disabled


Write-Output "5. Windows Features/Built-In"
# Advertisements - Disable ads in File Explorer
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Value "0"


Write-Output "5.1 Windows Features - Cortana"
# Cortana - Disable "Microsoft from getting to know you"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" -Name "Enabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Input\TIPC" -Name "Enabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "HistoryViewEnabled" -Value "0"
# Cortana - Disable Lockscreen suggestions, and rotating pictures
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value "0"
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Value "0"
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenOverlayEnabled" -Value "0"
# Cortana - 'Activity Feed' in Start Menu
Set-Itemproperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableActivityFeed' -value '0'


Write-Output "5.2 Windows Features - Feedback/Privacy"
# Feedback/Privacy - Prompts Disabled
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value "0"
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds" -Value "0"
# Feedback/Privacy - Feedback Notifications
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value "1"
# Feedback/Privacy - Turn off Application Telemetry			
## (InTune Required) Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Value "0"			
# Feedback/Privacy - Disable Inventory Collector			
## (InTune Required) Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableInventory" -Value "1"
# Disable Steps Recorder
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Value "1"
# Disable Windows Tips			
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableSoftLanding" -Value "1"
# Disable "Consumer Experiences"
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value "1"	
# Data Collection and Preview Builds / Set Telemetry to basic (switches to 1:basic for W10Pro and lower, disabled altogether by disabling service anyways)			
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value "0"
# Disable Pre-Release Features and Settings			
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -Name "EnableConfigFlighting" -Value "0"


Write-Output "5.3 Windows Features - Start Menu"
# People - Removal of icon in system tray
Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -Name 'PeopleBand' -Value '0'
# Windows Action Center - Removal of Notifcations / Icon from system tray
Set-ItemProperty -LiteralPath 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'DisableNotificationCenter' -Value '0'
# Delay time on menu displaying / Animation
Set-Itemproperty -path 'HKCU:\Control Panel\Desktop' -Name 'MenuShowDelay' -value '50'
# Disable Internet Searches in Start (Bing)
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value "1"
# Disable Cortana
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;


Write-Output "5.4 Windows Features - Misc"
# Remove 3D Objects From My Computer
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -force;
Remove-Item -LiteralPath "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -force;
# Drive Letters in front of Drive Label in Explorer
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowDriveLettersFirst' -Value 4 -PropertyType DWord -Force -ea SilentlyContinue;
# Take Ownership to right click context menu
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\runas") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\*\shell\runas" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\runas\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\*\shell\runas\command" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\runas") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\runas" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\runas\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\runas\command" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas' -Name '(default)' -Value 'Take Ownership' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas' -Name 'NoWorkingDirectory' -Value '' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas\command' -Name '(default)' -Value 'cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas\command' -Name 'IsolatedCommand' -Value 'cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas' -Name '(default)' -Value 'Take Ownership' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas' -Name 'NoWorkingDirectory' -Value '' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas\command' -Name '(default)' -Value 'cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas\command' -Name 'IsolatedCommand' -Value 'cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t' -PropertyType String -Force -ea SilentlyContinue;
# Faster Shutdown
if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SYSTEM\CurrentControlSet\Control") -ne $true) {  New-Item "HKLM:\SYSTEM\CurrentControlSet\Control" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'ForegroundLockTimeout' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'HungAppTimeout' -Value '400' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'WaitToKillAppTimeout' -Value '500' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control' -Name 'WaitToKillServiceTimeout' -Value '500' -PropertyType String -Force -ea SilentlyContinue;
# Add "Open with Powershell" to right click menu
New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR
if((Test-Path -LiteralPath "HKCR:\Directory\Shell\PowershellMenu") -ne $true) {  New-Item "HKCR:\Directory\Shell\PowershellMenu" -Force | Out-Null};
New-ItemProperty -LiteralPath "HKCR:\Directory\Shell\PowershellMenu" -Name "(Default)" -Value "Open with PowerShell (Admin)" -Force  | Out-Null
Set-ItemProperty -LiteralPath "HKCR:\Directory\Shell\PowershellMenu" -Name "(Default)" -Value "Open with PowerShell (Admin)" -Force | Out-Null
if((Test-Path -LiteralPath "HKCR:\Directory\Shell\PowershellMenu\command") -ne $true) {  New-Item "HKCR:\Directory\Shell\PowershellMenu\command" -Force -ErrorAction SilentlyContinue };
Set-ItemProperty -LiteralPath "HKCR:\Directory\Shell\PowershellMenu\command" -Name "(Default)" -Value "C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -NoExit -Command Set-Location -LiteralPath '%L'" -Force | Out-Null
Remove-PSDrive HKCR
# Add "Open with Command Prompt" to right click menu
New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR
if((Test-Path -LiteralPath "HKCR:\Directory\Shell\CMDMenu") -ne $true) {  New-Item "HKCR:\Directory\Shell\CMDMenu" -Force | Out-Null};
New-ItemProperty -LiteralPath "HKCR:\Directory\Shell\CMDMenu" -Name "(Default)" -Value "Open with Command Prompt (Admin)" -Force  | Out-Null
Set-ItemProperty -LiteralPath "HKCR:\Directory\Shell\CMDMenu" -Name "(Default)" -Value "Open with Command Prompt (Admin)" -Force | Out-Null
if((Test-Path -LiteralPath "HKCR:\Directory\Shell\CMDMenu\command") -ne $true) {  New-Item "HKCR:\Directory\Shell\CMDMenu\command" -Force -ErrorAction SilentlyContinue };
Set-ItemProperty -LiteralPath "HKCR:\Directory\Shell\CMDMenu\command" -Name "(Default)" -Value 'cmd.exe /s /k pushd "%V"' -Force | Out-Null
Remove-PSDrive HKCR


Write-Output "6. Performance"
### Peformance
## Power Settings
# Monitor Screen Timeout
Powercfg /Change monitor-timeout-ac 15
Powercfg /Change monitor-timeout-dc 15
# PC Sleep Timeout
Powercfg /Change standby-timeout-ac 0
Powercfg /Change standby-timeout-dc 60
# Disable Hard Drive from turning off
powercfg /Change -disk-timeout-dc 0
powercfg /Change -disk-timeout-ac 0
# Hibernate Disable
powercfg /Change -hibernate-timeout-ac 0
powercfg /Change -hibernate-timeout-dc 0
powercfg -h off


## Windows Responsiveness (Foreground/Background Task Balancing)
# Default Value, tested with using 6-10 and caused abnormal freezing.
# Set-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl' -Name 'Win32PrioritySeparation' -Value '2'



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
Write-Output ""
Write-Output "***************************************************"
Write-Output "* RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT! *"
Write-Output "***************************************************"
pause