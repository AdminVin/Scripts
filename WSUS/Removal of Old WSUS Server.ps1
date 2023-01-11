$ErrorActionPreference = 'SilentlyContinue'
Remove-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Force -Name WUServer
Remove-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Force -Name TargetGroup
Remove-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Force -Name WUStatusServer
Remove-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Force -Name TargetGroupEnable
Set-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Value 0 -Force -Name UseWUServer
Set-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Value 0 -Force -Name NoAutoUpdate
Set-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate'    -Value 0 -force -Name DisableWindowsUpdateAccess
Restart-Service -Name wuauserv