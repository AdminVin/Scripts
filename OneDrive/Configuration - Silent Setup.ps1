<# 
When creating this with a GPO, create a BAT file and use the code below.
Powershell.exe -ExecutionPolicy Bypass -File "\\SERVER\SHARE\PowerShell_Script.ps1"
GPO (User > Login Script)
#>
$ErrorActionPreference = "SilentlyContinue"

#region Tenant Information
# Tenant ID can be located Portal.Azure.com > Azure Active Directory > Overview
$TenantGUID = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
#endregion

#region OneDrive
###############################################################
#  Re-Enable One Drive Usage/Syncing (if previously disabled) #
###############################################################
if (-not (Test-Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
    New-Item -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Force | Out-Null
}
New-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSync" -Value "0" -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSync" -Value "0" | Out-Null
New-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value "0" -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value "0" | Out-Null

########################
## Silently Configure ##
########################
$HKLMregistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive" # Path to HKLM keys
$DiskSizeregistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\DiskSpaceCheckThresholdMB"# Path to max disk size key
if(!(Test-Path $HKLMregistryPath)){New-Item -Path $HKLMregistryPath -Force}
if(!(Test-Path $DiskSizeregistryPath)){New-Item -Path $DiskSizeregistryPath -Force}
New-ItemProperty -Path $HKLMregistryPath -Name "SilentAccountConfig" -Value "1" -PropertyType DWORD -Force | Out-Null #Enable silent account configuration
New-ItemProperty -Path $DiskSizeregistryPath -Name $TenantGUID -Value "102400" -PropertyType DWORD -Force | Out-Null #Set max OneDrive threshold before prompting
#########################################################################################################################################################
# Sync Desktop, Documents, and Pictures (https://learn.microsoft.com/en-us/sharepoint/use-group-policy#silently-move-windows-known-folders-to-onedrive) #
#########################################################################################################################################################
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive" -Force }
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive' -Name 'KFMSilentOptIn' -Value $TenantGUID -PropertyType String -Force
##################################################################################
# Disable Syncing of Shortcuts Filetypes [Applications (.lnk) & Internet (.url)] #
##################################################################################
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\EnableODIgnoreListFromGPO") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\EnableODIgnoreListFromGPO" -force -ea SilentlyContinue }
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\EnableODIgnoreListFromGPO' -Name '*.lnk' -Value '*.lnk' -PropertyType String -Force 
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\EnableODIgnoreListFromGPO' -Name '*.url' -Value '*.url' -PropertyType String -Force 
#############################
# Cleanup Desktop Shortcuts #
#############################
Remove-Item -Path "$env:USERPROFILE\OneDrive - COMPANY\Desktop\" -Recurse -Confirm:$False -Include "*Copy*.lnk" | Out-Null
Remove-Item -Path "$env:USERPROFILE\OneDrive - COMPANY\Desktop\" -Recurse -Confirm:$False -Include "*Copy*.url" | Out-Null
#endregion