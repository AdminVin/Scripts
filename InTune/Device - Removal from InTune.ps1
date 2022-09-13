#region Notes
# This is how to force remove a device from InTune by the "Azure AD Device ID"
# Azure AD Device ID: Portal.Azure.com > InTune > Devices > All Devices > Search for device name > Select "Hardware" 
# Source: https://docs.microsoft.com/en-us/powershell/module/msonline/remove-msoldevice?view=azureadps-1.0
#endregion


#region Process Removal
# Connect with Global Admin/InTune Administrator
Connect-MsolService
# Removal
Remove-MsolDevice -deviceid "AZURE_AD_DEVICE_ID" -Force
#endregion