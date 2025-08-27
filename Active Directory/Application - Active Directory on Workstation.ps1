#> WSUS Disable (Temporarily)
# Disable WSUS (if applicable)
$currentWU = Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"-Name "UseWUServer"| Select-Object -ExpandProperty UseWUServer
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"-Name "UseWUServer"-Value 0
Restart-Service wuauserv

# Enable WSUS (if applicable)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"-Name "UseWUServer"-Value $currentWU
Restart-Service wuauserv



#> Active Directory (Core / Server)
Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0