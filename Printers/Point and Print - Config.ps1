# Error Handling
$ErrorActionPreference = "SilentlyContinue"

# Print Server FQDNs
$PrintServers = @("SERVER", "SERVER.DOMAIN.LOCAL")

# Printer Classes to Allow Installation Without Admin Rights
$AllowedClasses = @("{4658ee7e-f050-11d1-b6bd-00c04fa372a7}", "{4d36e979-e325-11ce-bfc1-08002be10318}", "{1ed2bbf9-11f0-4084-b21f-ad83a8e6dcdc}")

# Ensure all necessary paths exist
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

# Helper function to set or create registry properties
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

# Set registry properties for PointAndPrint
$PointAndPrintPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
Set-OrCreateProperty -Path $PointAndPrintPath -Name "RestrictDriverInstallationToAdministrators" -Value 0 -PropertyType DWord
Set-OrCreateProperty -Path $PointAndPrintPath -Name "Restricted" -Value 1 -PropertyType DWord
Set-OrCreateProperty -Path $PointAndPrintPath -Name "TrustedServers" -Value 1 -PropertyType DWord
Set-OrCreateProperty -Path $PointAndPrintPath -Name "ServerList" -Value $PrintServers -PropertyType MultiString
Set-OrCreateProperty -Path $PointAndPrintPath -Name "NoWarningNoElevationOnInstall" -Value 1 -PropertyType DWord
Set-OrCreateProperty -Path $PointAndPrintPath -Name "UpdatePromptSettings" -Value 2 -PropertyType DWord
Set-OrCreateProperty -Path $PointAndPrintPath -Name "InForest" -Value 1 -PropertyType DWord
Set-OrCreateProperty -Path $PointAndPrintPath -Name "PointAndPrintServerList" -Value $PrintServers -PropertyType MultiString

# Set allowed printer classes under AllowedDriverClassGUIDs
$AllowedClassesPath = "$PointAndPrintPath\AllowedDriverClassGUIDs"
if (-not (Test-Path -LiteralPath $AllowedClassesPath)) {
    New-Item -Path $AllowedClassesPath | Out-Null
}

foreach ($classGUID in $AllowedClasses) {
    Set-OrCreateProperty -Path $AllowedClassesPath -Name $classGUID -Value 1 -PropertyType DWord
}

# Permit User (Non-Admin) Installation of Drivers
$DriverRestrictionsPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverInstall\Restrictions"
Set-OrCreateProperty -Path $DriverRestrictionsPath -Name "AllowUserDeviceInstall" -Value 1 -PropertyType DWORD

# Allow Automatic Printer Driver Downloads from Windows Update
$DevicePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DevicePath"
Set-ItemProperty -Path $DevicePath -Name "" -Value "%SystemRoot%\inf;%SystemRoot%\System32\DriverStore\FileRepository"

# Disable Admin Code Signature Validation for Drivers
$SystemPolicyPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
Set-OrCreateProperty -Path $SystemPolicyPath -Name "ValidateAdminCodeSignatures" -Value 0 -PropertyType DWORD

# Add "Devices & Printers" back to Windows 10/11 Start Menu
$ShortcutPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("CommonPrograms"), "Devices & Printers.lnk")
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}"
$Shortcut.Save()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($WshShell) | Out-Null

# Create Completion Log
New-Item -Path "C:\ProgramData\AV\Printers" -ItemType Directory -Force | Out-Null
$timestamp = (Get-Date).ToString("MM/dd/yy hh:mm tt")
"Point and Print Config added at $timestamp" | Out-File -FilePath "C:\ProgramData\AV\Printers\PointPrintConfig.txt" -Force