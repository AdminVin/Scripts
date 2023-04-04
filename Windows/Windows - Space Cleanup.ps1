# Temporary Files
Remove-Item -Path "$env:TEMP\*" -Recurse -Force
Remove-Item -Path "$env:windir\Temp\*" -Recurse -Force

# Windows Update
Stop-Service -Name wuauserv
Rename-Item -Path "$env:systemroot\SoftwareDistribution" -NewName "SoftwareDistribution.old"
Remove-Item -Path "$env:systemroot\SoftwareDistribution.old" -Recurse -Force -Confirm:$false
Start-Service -Name wuauserv

# WinSxS (Windows Side by Side)
# Service Pack Files
dism /online /cleanup-image /spsuperseded /hidesp
# Orphaned Componets
dism.exe /online /Cleanup-Image /SPSuperseded
# WinSxS
dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase