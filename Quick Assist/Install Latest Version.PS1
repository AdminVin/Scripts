#region Notes
# 2022-08-10 - Remove the existing version and install the latest of Quick Assist
#endregion


#region Remove Old Version
<# Fallback Unistall
$checkQuickAssist = 
Get-WindowsCapability -online |
where-object {$_.name -like "*QuickAssist*"}

if($checkQuickAssist.state -eq 'Installed'){
    try{
        Remove-WindowsCapability -online -name $checkQuickAssist.name -ErrorAction Stop
    }
    catch{
        $error[0].Exception.Message
    }
}
#>
Remove-WindowsCapability -Online -Name 'App.Support.QuickAssist~~~~0.0.1.0' -ErrorAction 'SilentlyContinue'
#endregion


#region Verification
# Verify old version was removed
Get-WindowsCapability -Name *QuickAssist* -Online

#endregion


#region Install New Version
Add-AppxProvisionedPackage -online -SkipLicense -PackagePath '\MicrosoftCorporationII.QuickAssist.AppxBundle'

#endregion