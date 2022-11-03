<# 
When creating this with a GPO, create a BAT file and use the code below.
Powershell.exe -ExecutionPolicy Bypass -File "\\SERVER\SHARE\PowerShell_Script.ps1"
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

#region OneDrive - Force Auto Start on Login
$ODAutoRunPath = "C:\Users\$env:username\AppData\Local\Microsoft\OneDrive\OneDrive.exe"
$ODSwitch = " /background"
$ODAutoRun = $ODAutoRunPath + $ODSwitch

if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Force -ErrorAction SilentlyContinue | Out-Null };
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name 'OneDrive' -Value $ODAutoRun -PropertyType String -Force -ErrorAction SilentlyContinue | Out-Null;
#endregion