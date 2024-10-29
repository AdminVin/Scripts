# Error Handling
$ErrorActionPreference = "SilentlyContinue"

# Print Server FQDNs
$PrintServers = @("SERVER", "SERVER.EBNET.LOCAL")

# Printer Classes to Allow Installation Without Admin Rights
$AllowedClasses = @("{4658ee7e-f050-11d1-b6bd-00c04fa372a7}", "{4d36e979-e325-11ce-bfc1-08002be10318}", "{1ed2bbf9-11f0-4084-b21f-ad83a8e6dcdc}")

# Ensure PointAndPrint Registry Path Exists
$PointAndPrintPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
if ((Test-Path -LiteralPath $PointAndPrintPath) -ne $true) {
    New-Item -Path $PointAndPrintPath | Out-Null
}

# Permit Non-Administrators to Install Printers
New-ItemProperty -LiteralPath $PointAndPrintPath -Name "RestrictDriverInstallationToAdministrators" -Value 0 -PropertyType DWord -Force

# Enable Restrictions and Trusted Server List
New-ItemProperty -LiteralPath $PointAndPrintPath -Name "Restricted" -Value 1 -PropertyType DWord -Force
New-ItemProperty -LiteralPath $PointAndPrintPath -Name "TrustedServers" -Value 1 -PropertyType DWord -Force

# Trusted Servers
New-ItemProperty -LiteralPath $PointAndPrintPath -Name "ServerList" -Value $PrintServers -PropertyType MultiString -Force

# Disable Warning with Elevation
New-ItemProperty -LiteralPath $PointAndPrintPath -Name "NoWarningNoElevationOnInstall" -Value 1 -PropertyType DWord -Force

# Permit Installs of Printer by UNC Path from Trusted Servers
New-ItemProperty -LiteralPath $PointAndPrintPath -Name "UpdatePromptSettings" -Value 2 -PropertyType DWord -Force

# Users can only point and print to machines in their forest
New-ItemProperty -LiteralPath $PointAndPrintPath -Name "InForest" -Value 0 -PropertyType DWord -Force

# Set Allowed Printer Classes
$AllowedClassesPath = "$PointAndPrintPath\AllowedDriverClassGUIDs"
if ((Test-Path -LiteralPath $AllowedClassesPath) -ne $true) {
    New-Item -Path $AllowedClassesPath | Out-Null
}

foreach ($classGUID in $AllowedClasses) {
    New-ItemProperty -LiteralPath $AllowedClassesPath -Name $classGUID -Value 1 -PropertyType DWord -Force
}

# Permit User (Non-Admin) Installation of Drivers
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverInstall\Restrictions" -Name "AllowUserDeviceInstall" -Value 1 -PropertyType DWORD -Force

# Source: https://anthonyfontanez.com/index.php/2021/08/12/printnightmare-point-and-print/