<# 
When creating this with a GPO, create a BAT file and use the code below.
Powershell.exe -ExecutionPolicy Bypass -File "\\SERVER\SHARE\PowerShell_Script.ps1"
GPO (Computer > Startup Script)
#>

#region OneDrive - Auto Sync Desktop, Documents, and Pictures
# Source: https://learn.microsoft.com/en-us/sharepoint/use-group-policy#silently-move-windows-known-folders-to-onedrive
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive" -Force -ErrorAction SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive' -Name 'KFMSilentOptIn' -Value $TenantGUID -PropertyType String -Force -ErrorAction SilentlyContinue;
#endregion