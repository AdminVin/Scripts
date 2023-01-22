# Error Handling
$ErrorActionPreference = "SilentlyContinue"

# Print Server FQDN
$PrintServer = "SERVER.DOMAIN.LOCAL"

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -force -ea SilentlyContinue };
# Permit Non-Administrators to Install Printers
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "RestrictDriverInstallationToAdministrators" -Value "0" -PropertyType DWord -Force 
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "Restricted" -Value "1" -PropertyType DWord -Force 
# Enable Trusted Server List
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "TrustedServers" -Value "1" -PropertyType DWord -Force 
# Trusted Servers
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "ServerList" -Value $PrintServer -PropertyType String -Force 
# Disable Warning with Elevation
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "NoWarningNoElevationOnInstall" -Value "1" -PropertyType DWord -Force 
#
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "UpdatePromptSettings" -Value "0" -PropertyType DWord -Force 
# Users can only point and print to machines in their forest
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "InForest" -Value "0" -PropertyType DWord -Force 

# Source: https://anthonyfontanez.com/index.php/2021/08/12/printnightmare-point-and-print/