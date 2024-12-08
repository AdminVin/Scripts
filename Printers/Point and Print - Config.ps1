## Variables
# Error Handling
$ErrorActionPreference = "SilentlyContinue"
# Print Servers
$PrintServers = @("SERVER", "SERVER.DOMAIN.LOCAL")
# Printer Classes
$AllowedClasses = @("{4658ee7e-f050-11d1-b6bd-00c04fa372a7}", "{4d36e979-e325-11ce-bfc1-08002be10318}", "{1ed2bbf9-11f0-4084-b21f-ad83a8e6dcdc}")
# Registry Paths
$RegistryPaths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverInstall\Restrictions",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DevicePath",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
)
foreach ($path in $RegistryPaths) {
    if (-not (Test-Path -LiteralPath $path)) {
        New-Item -Path $path -Force | Out-Null
    }
}
$PointAndPrintPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint"


## Functions
function Set-OrCreateProperty {
    param (
        [string]$Path,
        [string]$Name,
        [Object]$Value,
        [string]$PropertyType
    )

    if ((Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue) -ne $null) {
        Set-ItemProperty -Path $Path -Name $Name -Value $Value
    } else {
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $PropertyType -Force
    }
}


## Process
# Point and Print - Enable
Set-OrCreateProperty -Path $PointAndPrintPath -Name "Restricted" -Value 1 -PropertyType DWord
Set-OrCreateProperty -Path $PointAndPrintPath -Name "TrustedServers" -Value 1 -PropertyType DWord
# Point and Print - Trusted Servers
Set-OrCreateProperty -Path $PointAndPrintPath -Name "ServerList" -Value $PrintServers -PropertyType MultiString
Set-OrCreateProperty -Path $PointAndPrintPath -Name "PointAndPrintServerList" -Value $PrintServers -PropertyType MultiString
Set-OrCreateProperty -Path $PointAndPrintPath -Name "InForest" -Value 1 -PropertyType DWord
# Printer Drivers - Suppresses security warnings/elevation prompts during the installation of printer drivers from a trusted print server.
Set-OrCreateProperty -Path $PointAndPrintPath -Name "NoWarningNoElevationOnInstall" -Value 1 -PropertyType DWord
# Printer Drivers - No prompt to users, if the driver is changed on the trusted print server and needs to be updated.
Set-OrCreateProperty -Path $PointAndPrintPath -Name "UpdatePromptSettings" -Value 2 -PropertyType DWord
# Permit User (Non-Admin) Installation of Drivers from trusted print server.
Set-OrCreateProperty -Path $PointAndPrintPath -Name "RestrictDriverInstallationToAdministrators" -Value 0 -PropertyType DWord
# Device Drivers - Users (Non-Admin/Administrators) are permited to install device drivers. [1 - Non Admins | 2 - Administrators Only]
Set-OrCreateProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverInstall\Restrictions" -Name "AllowUserDeviceInstall" -Value 1 -PropertyType DWORD
# Printer Driver Classes - Allow
$AllowedClassesPath = "$PointAndPrintPath\AllowedDriverClassGUIDs"
if (-not (Test-Path -LiteralPath $AllowedClassesPath)) {
    New-Item -Path $AllowedClassesPath | Out-Null
}
foreach ($classGUID in $AllowedClasses) {
    Set-OrCreateProperty -Path $AllowedClassesPath -Name $classGUID -Value 1 -PropertyType DWord
}
# Shortcut - Add "Devices & Printers" back to Windows 10/11 Start Menu
$ShortcutPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("CommonPrograms"), "Devices & Printers.lnk")
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}"
$Shortcut.Save()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($WshShell) | Out-Null
# Log - Complete
New-Item -Path "C:\ProgramData\EBPS\Printers" -ItemType Directory -Force | Out-Null
$timestamp = (Get-Date).ToString("MM/dd/yy hh:mm tt")
"Point and Print Config added at $timestamp" | Out-File -FilePath "C:\ProgramData\EBPS\Printers\PointPrintConfig.txt" -Force