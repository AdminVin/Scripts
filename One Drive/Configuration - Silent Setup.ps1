<# 
When creating this with a GPO, create a BAT file and use the code below.
Powershell.exe -ExecutionPolicy Bypass -File "\\SERVER\SHARE\PowerShell_Script.ps1"
GPO (User > Login Script)
#>
#region Configure OneDrive to Silently Configure
$HKLMregistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive" # Path to HKLM keys
$DiskSizeregistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\DiskSpaceCheckThresholdMB"# Path to max disk size key
# Tenant ID can be located Portal.Azure.com > Azure Active Directory > Overview
$TenantGUID = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

if(!(Test-Path $HKLMregistryPath)){New-Item -Path $HKLMregistryPath -Force}
if(!(Test-Path $DiskSizeregistryPath)){New-Item -Path $DiskSizeregistryPath -Force}

New-ItemProperty -Path $HKLMregistryPath -Name "SilentAccountConfig" -Value "1" -PropertyType DWORD -Force | Out-Null #Enable silent account configuration
New-ItemProperty -Path $DiskSizeregistryPath -Name $TenantGUID -Value "102400" -PropertyType DWORD -Force | Out-Null #Set max OneDrive threshold before prompting
#endregion

#region OneDrive - FORCE Auto Start on Login
# Varibles
$ODAutoRunPath = "C:\Users\$env:username\AppData\Local\Microsoft\OneDrive\OneDrive.exe"
$ShortcutPath = "C:\Users\$env:username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\OneDrive.lnk"
# Set Shortcut to users OneDrive in startup. (C:\Users\USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup)
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$ODshortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$ODShortcut.TargetPath = $ODAutoRunPath
$ODshortcut.Save()
#endregion