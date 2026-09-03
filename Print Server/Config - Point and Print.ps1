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
function Set-Registry {
    param (
        [string]$Path,
        [string]$Name,
        [Object]$Value,
        [string]$PropertyType
    )
    $key = Get-Item -LiteralPath $Path -ErrorAction SilentlyContinue
    if ($key -and ($key.GetValueNames() -contains $Name)) {
        if ($key.GetValueKind($Name).ToString() -ne $PropertyType) {
            Remove-ItemProperty -Path $Path -Name $Name -Force -ErrorAction SilentlyContinue
        }
    }
    New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $PropertyType -Force | Out-Null
}

## Cleanup - Remove leftovers from previous (broken) deployments
# Bogus value that did nothing under PointAndPrint
Remove-ItemProperty -Path $PointAndPrintPath -Name "PointAndPrintServerList" -Force -ErrorAction SilentlyContinue

## Process
# Point and Print - Enable
Set-Registry -Path $PointAndPrintPath -Name "Restricted" -Value 1 -PropertyType DWord
Set-Registry -Path $PointAndPrintPath -Name "TrustedServers" -Value 1 -PropertyType DWord
# Point and Print - Trusted Servers
# ServerList must be REG_SZ, semicolon-delimited — not REG_MULTI_SZ
Set-Registry -Path $PointAndPrintPath -Name "ServerList" -Value ($PrintServers -join ';') -PropertyType String
Set-Registry -Path $PointAndPrintPath -Name "InForest" -Value 1 -PropertyType DWord
# Printer Drivers - Suppresses security warnings/elevation prompts during the installation of printer drivers from a trusted print server.
Set-Registry -Path $PointAndPrintPath -Name "NoWarningNoElevationOnInstall" -Value 1 -PropertyType DWord
# Printer Drivers - No prompt to users, if the driver is changed on the trusted print server and needs to be updated.
Set-Registry -Path $PointAndPrintPath -Name "UpdatePromptSettings" -Value 2 -PropertyType DWord
# Permit User (Non-Admin) Installation of Drivers from trusted print server.
Set-Registry -Path $PointAndPrintPath -Name "RestrictDriverInstallationToAdministrators" -Value 0 -PropertyType DWord
# Device Drivers - Users (Non-Admin/Administrators) are permited to install device drivers. [1 - Non Admins | 2 - Administrators Only]
Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverInstall\Restrictions" -Name "AllowUserDeviceInstall" -Value 1 -PropertyType DWord

# Package Point and Print - Approved Servers (governs v4/package-aware/class drivers)
$PackagePointAndPrintPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PackagePointAndPrint"
$PackageListPath = "$PackagePointAndPrintPath\ListofServers"
foreach ($path in @($PackagePointAndPrintPath, $PackageListPath)) {
    if (-not (Test-Path -LiteralPath $path)) {
        New-Item -Path $path -Force | Out-Null
    }
}
Set-Registry -Path $PackagePointAndPrintPath -Name "PackagePointAndPrintServerList" -Value 1 -PropertyType DWord
foreach ($server in $PrintServers) {
    Set-Registry -Path $PackageListPath -Name $server -Value $server -PropertyType String
}

# Printer Driver Classes - Allow
$AllowedClassesPath = "$PointAndPrintPath\AllowedDriverClassGUIDs"
if (-not (Test-Path -LiteralPath $AllowedClassesPath)) {
    New-Item -Path $AllowedClassesPath -Force | Out-Null
}
foreach ($classGUID in $AllowedClasses) {
    Set-Registry -Path $AllowedClassesPath -Name $classGUID -Value 1 -PropertyType DWord
}

# Restart Spooler - Ensure corrected policy values are picked up immediately
Restart-Service -Name Spooler -Force -ErrorAction SilentlyContinue

# Log - Complete
New-Item -Path "C:\ProgramData\EBPS\Printers" -ItemType Directory -Force | Out-Null
$timestamp = (Get-Date).ToString("MM/dd/yy hh:mm tt")
"Point and Print Config added at $timestamp" | Out-File -FilePath "C:\ProgramData\EBPS\Printers\PointPrintConfig.txt" -Force