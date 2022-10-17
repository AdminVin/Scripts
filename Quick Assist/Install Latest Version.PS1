#region Notes
# 2022-08-10 - Remove the existing version and install the latest of Quick Assist

<# 
When creating this with a GPO, create a BAT file and use the code below.
Powershell.exe -ExecutionPolicy Bypass -File "\\SERVER\SHARE\PowerShell_Script.ps1"
#>
#endregion


#region Remove Old Version
Remove-WindowsCapability -Online -Name 'App.Support.QuickAssist~~~~0.0.1.0' -ErrorAction 'SilentlyContinue'
#endregion


#region Verification
# Verify old version was removed
Get-WindowsCapability -Name *QuickAssist* -Online
#endregion


#region Install New Version
Add-AppxProvisionedPackage -online -SkipLicense -PackagePath '\MicrosoftCorporationII.QuickAssist.AppxBundle'
#endregion