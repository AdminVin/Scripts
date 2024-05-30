# Temporary Files
# Temp - User
Remove-Item -Path "$env:TEMP\*" -Recurse -Force
# Temp - Windows
function Remove-ItemRecursively {
    param (
        [string]$Path
    )
    
    Get-ChildItem -Path $Path -Recurse -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
}
Remove-ItemRecursively -Path "C:\Windows\Temp\*"

# SoftwareDistribution
Stop-Service -Name wuauserv
Rename-Item -Path "C:\Windows\SoftwareDistribution" -NewName "SoftwareDistribution.old"
Remove-Item -Path "C:\Windows\SoftwareDistribution.old" -Recurse -Force -Confirm:$false
Start-Service -Name wuauserv
# WinSxS
# Service Pack Files
dism.exe /online /cleanup-image /spsuperseded /hidesp
# Orphaned Components
dism.exe /online /Cleanup-Image /SPSuperseded
# WinSxS
dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase