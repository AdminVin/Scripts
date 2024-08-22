# Disable WSUS (if applicable)
$currentWU = Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"-Name "UseWUServer"| Select-Object -ExpandProperty UseWUServer
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"-Name "UseWUServer"-Value 0
Restart-Service wuauserv

# Install Active Directory
Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0

# Enable WSUS (if applicable)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"-Name "UseWUServer"-Value $currentWU
Restart-Service wuauserv