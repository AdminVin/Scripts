# Updated: 2021-08-06


###- Elevating Powershell Script with Administrative Rights
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

###- Changing Powershell Execution Policy (Temporarily)
Set-ExecutionPolicy Unrestricted

echo "1. Diagnostics"
###- Diagnostics
#- Verbose Status Messaging
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value "1"

echo "2. Applications"
###- Applications

##- Metro Apps
#- Removal of Metro Apps that are bloatware
Get-AppxPackage *3d* | Remove-AppxPackage
Get-AppxPackage *bingnews* | Remove-AppxPackage
Get-AppxPackage *bingsports* | Remove-AppxPackage
Get-AppxPackage *bingfinance* | Remove-AppxPackage
Get-AppxPackage *bingtravel* | Remove-AppxPackage
Get-AppxPackage *connect* | Remove-AppxPackage
Get-AppxPackage *feedback* | Remove-AppxPackage
Get-AppxPackage *flip* | Remove-AppxPackage
Get-AppxPackage *food* | Remove-AppxPackage
Get-AppxPackage *getstarted* | Remove-AppxPackage
Get-AppxPackage *skype* | Remove-AppxPackage
Get-AppxPackage *health* | Remove-AppxPackage
Get-AppxPackage *maps* | Remove-AppxPackage
Get-AppxPackage *music* | Remove-AppxPackage
# Remove Office Metro App
Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage
Get-AppxPackage *Phone* | Remove-AppxPackage
Get-AppxPackage *PhoneC* | Remove-AppxPackage
Get-AppxPackage *Scan* | Remove-AppxPackage
Get-AppxPackage *twitter* | Remove-AppxPackage
Get-AppxPackage *sol* | Remove-AppxPackage
Get-AppxPackage *money*| Remove-AppxPackage
Get-AppxPackage *companion* | Remove-AppxPackage
Get-AppxPackage *sway*| Remove-AppxPackage
Get-AppxPackage *wi-fi* | Remove-AppxPackage
Get-AppxPackage *cell* | Remove-AppxPackage
Get-AppxPackage *facebook* | Remove-AppxPackage
Get-AppxPackage *drawboard* | Remove-AppxPackage
Get-AppxPackage *candy* | Remove-AppxPackage
Get-AppxPackage *asphault* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MinecraftUWP* | Remove-AppxPackage
Get-AppxPackage *flaregamesGmbH.RoyalRevolt* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Windows.People* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Print3d* | Remove-AppxPackage
Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Wallet* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MiracastView* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Advertising* | Remove-AppxPackage
Get-AppxPackage *Microsoft.People* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Print* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Windows.Cortana* | Remove-AppxPackage
Get-AppxPackage *fitbit* | Remove-AppxPackage
Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage
Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage
Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage
Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage
# Remove "Groove Music"
Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage
Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage
# Remove Solitare
Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage
# Remove Mobile Plans
Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage
# Remove Feedback Hub
Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage
# Remove "My Phone"
Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage
# Remove "Connect"
Get-AppxPackage *Microsoft.Windows.CloudExperienceHost* | Remove-AppxPackage
# Remove "Microsoft Whiteboard"
Get-AppxPackage *Microsoft.Whiteboard* | Remove-AppxPackage
#- Removing All other Apps, except Microsoft Store, Calculator, Camera, Mail/Calendar, Photo Viewer, Sound Recorder, Snipping Tool/Snip & Sketch, and Weather
Get-AppxPackage -AllUsers | where-object {$_.name -notlike "*Store*" -and $_.name -notlike "*Calculator*" -and $_.name -notlike "*Microsoft.Windows.Photos*" -and $_.name -notlike "*Microsoft.WindowsSoundRecorder*" -and $_.name -notlike "*Microsoft.MSPaint*" -and $_.name -notlike "*Microsoft.ScreenSketch*" -and $_.name -notlike "*Microsoft.WindowsCamera*" -and $_.name -notlike "*microsoft.windowscommunicationsapps*" -and $_.name -notlike "*Microsoft.BingWeather*" -and $_.name -notlike "*Nvidia*" -and $_.name -notlike "*ASUS*" -and $_.name -notlike "*Armoury*" -and $_.name -notlike "*MSI*" -and $_.name -notlike "*EVGA*" -and $_.name -notlike "*Intel*" -and $_.name -notlike "*Microsoft.Office.OneNote*" -and $_.name -notlike "*Microsoft.MicrosoftStickyNotes*"  -and $_.name -notlike "*ASUS*" -and $_.name -notlike "*AMD*"} | Remove-AppxPackage -erroraction silentlycontinue

#- Disable SILENT installs of new Apps
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContentEnabled" -Value "0"
#- Start Menu Application suggestions
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value "0"
#- Disable future installs/re-installs of factory/OEM Metro Apps
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OEMPreInstalledAppsEnabled" -Value "0"


##- One Drive
<# Old Method
#- Hide Icon in Explorer
Set-ItemProperty -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Name "System.IsPinnedToNameSpaceTree" -Value "0"
#- Prevent usage of OneDrive			
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value "1"
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSync" -Value "1"
#- Remove OneDrive
#- Kill Task
taskkill /f /im OneDrive.exe
#- 32 Bit Installs
%SystemRoot%\System32\OneDriveSetup.exe /uninstall
#- 64 Bit Installs
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
#>

##- Microsoft Edge
#- Always send do not track			
Set-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main' -Name 'DoNotTrack' -Value '1'

echo "3. Schedule Tasks"
###- Schedule Tasks
#- Remove tasks that are not needed/bloatware
Get-Scheduledtask "SmartScreenSpecific","Microsoft Compatibility Appraiser","Consolidator","KernelCeipTask","UsbCeip","Microsoft-Windows-DiskDiagnosticDataCollector", "GatherNetworkInfo","QueueReporting" -erroraction silentlycontinue | Disable-scheduledtask 
# Testing Schedule Tasks
Get-Scheduledtask "Proxy" -erroraction silentlycontinue | Disable-scheduledtask 


echo "4. Services"
###- Services
#- Disable Services that are not needed
Get-Service Diagtrack,Fax,OneSyncSvc,PhoneSvc,WMPNetworkSvc,DmwApPushService,WpcMonSvc -erroraction silentlycontinue | stop-service -passthru | set-service -startuptype disabled


echo "5. Windows Features"
###- Windows Features/Built-In
##- Advertisements
#- Disable ads in File Explorer
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Value "0"

echo "5.1 Windows Features - Cortana"
##- Cortana
#- Disable "Microsoft from getting to know you"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" -Name "Enabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Input\TIPC" -Name "Enabled" -Value "0"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "HistoryViewEnabled" -Value "0"
#- Disable Lockscreen suggestions, and rotating pictures
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value "0"
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Value "0"
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenOverlayEnabled" -Value "0"
#- Disable Cortana 'Activity Feed' in Start Menu
Set-Itemproperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableActivityFeed' -value '0'

echo "5.2 Windows Features - Privacy"
##- Feedback/Privacy
#- Prompts Disabled
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value "0"
Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds" -Value "0"
#- Feedback Notifications
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value "1"
#- Turn off Application Telemetry			
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Value "0"			
#- Disable Inventory Collector			
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableInventory" -Value "1"
#- Disable Steps Recorder
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Value "1"
#- Disable Windows Tips			
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableSoftLanding" -Value "1"
#- Disable "Consumer Experiences"
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value "1"	
#- Data Collection and Preview Builds / Set Telemetry to basic (switches to 1:basic for W10Pro and lower, disabled altogether by disabling service anyways)			
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value "0"
#- Disable Pre-Release Features and Settings			
Set-Itemproperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -Name "EnableConfigFlighting" -Value "0"


echo "5.3 Windows Features - Start Menu"
##- People
#- Removal of icon in system tray
Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -Name 'PeopleBand' -Value '0'


##- Windows Action Center
#- Removal of Notifcations / Icon from system tray
Set-ItemProperty -LiteralPath 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'DisableNotificationCenter' -Value '0'


#- Delay time on menu displaying / Animation
Set-Itemproperty -path 'HKCU:\Control Panel\Desktop' -Name 'MenuShowDelay' -value '100'

#- Disable Internet Searches in Start (Bing)
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value "1"

#- Disable Cortana
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;


echo "5.4 Windows Features - Misc"
#- Remove 3D Objects From My Computer
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -force;
Remove-Item -LiteralPath "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -force;

#- Drive Letters in front of Drive Label in Explorer
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowDriveLettersFirst' -Value 4 -PropertyType DWord -Force -ea SilentlyContinue;

#- Take Ownership to right click context menu
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

#- Faster Shutdown
if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SYSTEM\CurrentControlSet\Control") -ne $true) {  New-Item "HKLM:\SYSTEM\CurrentControlSet\Control" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'ForegroundLockTimeout' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'HungAppTimeout' -Value '400' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'WaitToKillAppTimeout' -Value '500' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control' -Name 'WaitToKillServiceTimeout' -Value '500' -PropertyType String -Force -ea SilentlyContinue;

<# This section is a work in progress, the values do not set correctly and have to be manually set in sysdm.cpl > Performance
##- Windows Visual Effects / Performance (sysdm.cpl > Advanced > Performance > Settings)
#- Set to Custom
Set-Itemproperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' -Name 'VisualFXSetting' -value '3'
#- Custom Graphic Settings
$Path = "HKCU:\Control Panel\Desktop"
$AttrName = "UserPreferencesMask"
Set-ItemProperty -Path $Path -Name $AttrName -Value ([byte[]](0x90,0x32,0x07,0x80,0x10,0x00,0x00,0x00))
#- Set to Custom Visual Settings
Set-Itemproperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' -Name 'VisualFXSetting' -value '3'
#- Animate windows when minimizing and maximizing
Set-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Value '0'
#- Animations in the taskbar
Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAnimations' -Value '0'
#- Enable Peak
Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\DWM' -Name 'EnableAeroPeek' -Value '1'
#- Save taskbar thumbnail previews
Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\DWM' -Name 'AlwaysHibernateThumbnails' -Value '0'
#- Show thumbnails instead of icons
Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'IconsOnly' -Value '0'
#- Show translucent selection rectangle
Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ListviewAlphaSelect' -Value '0'
#- Show window contents while dragging
Set-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'DragFullWindows' -Value '1'
#- Smooth edges of screen fonts
Set-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'FontSmoothing' -Value '2'
#- Use drop shadows for icon labels on the desktop
Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ListviewShadow' -Value '1'
#>

echo "6. Performance"
###- Peformance
##- Power Settings
#- Monitor Screen Timeout
Powercfg /Change monitor-timeout-ac 15
Powercfg /Change monitor-timeout-dc 15
#- PC Sleep Timeout
Powercfg /Change standby-timeout-ac 0
Powercfg /Change standby-timeout-dc 60
#- Disable Hard Drive from turning off
powercfg /Change -disk-timeout-dc 0
powercfg /Change -disk-timeout-ac 0
#- Hibernate Disable
powercfg /Change -hibernate-timeout-ac 0
powercfg /Change -hibernate-timeout-dc 0
powercfg -h off


##- Windows Responsiveness (Foreground/Background Task Balancing)
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



###- Restoring Powershell Execution Policy to 'Restricted'
Set-ExecutionPolicy Restricted



###- Notify User
cls
echo "***************************************************"
echo "* RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT! *"
echo "***************************************************"
pause