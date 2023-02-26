<# 
When creating this with a GPO, create a BAT file and use the code below.
Powershell.exe -ExecutionPolicy Bypass -File "\\SERVER\SHARE\PowerShell_Script.ps1"
GPO (Computer > Startup Script)
#>
#region Tenant Information
# Tenant ID can be located Portal.Azure.com > Azure Active Directory > Overview
$TenantGUID = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
#endregion

## Misc Settings
# OneDrive - Auto Sync Desktop, Documents, and Pictures
# Source: https://learn.microsoft.com/en-us/sharepoint/use-group-policy#silently-move-windows-known-folders-to-onedrive
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive' -Name 'KFMSilentOptIn' -Value $TenantGUID -PropertyType String -Force -ErrorAction SilentlyContinue;

# Re-Enable One Drive Usage/Syncing (if previously disabled)
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC' -Value '0' -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null;
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value "0" -ErrorAction SilentlyContinue | Out-Null;

# Disable Syncing of Shortcuts Filetypes [Applications (.lnk) & Internet (.url)]
# Useful for when shortcuts are pushed out via InTune or GPO and OneDrive will duplicate shortcuts if they are logging into multiple PCs.
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\EnableODIgnoreListFromGPO") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\EnableODIgnoreListFromGPO" -force -ea SilentlyContinue }
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\EnableODIgnoreListFromGPO' -Name '*.lnk' -Value '*.lnk' -PropertyType String -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\EnableODIgnoreListFromGPO' -Name '*.url' -Value '*.url' -PropertyType String -Force -ErrorAction SilentlyContinue