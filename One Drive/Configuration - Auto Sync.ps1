<# 
When creating this with a GPO, create a BAT file and use the code below.
Powershell.exe -ExecutionPolicy Bypass -File "\\SERVER\SHARE\PowerShell_Script.ps1"
GPO (Computer > Startup Script)
#>
# Tenant ID can be located Portal.Azure.com > Azure Active Directory > Overview
$TenantGUID = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

#region OneDrive - Auto Sync Desktop, Documents, and Pictures
# Source: https://learn.microsoft.com/en-us/sharepoint/use-group-policy#silently-move-windows-known-folders-to-onedrive
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive' -Name 'KFMSilentOptIn' -Value $TenantGUID -PropertyType String -Force -ErrorAction SilentlyContinue;
#endregion

#region Preliminary Checks
# Re-Enable One Drive Usage/Syncing (if previously disabled)
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC' -Value '0' -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null;
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value "0" -ErrorAction SilentlyContinue | Out-Null;
#endregion