## Functions
function Remove-ItemRecursively {
    param (
        [string]$Path
    )
    
    Get-ChildItem -Path $Path -Recurse -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
}

## Temporary Files
# Temp - User
Remove-ItemRecursively -Path "$env:TEMP\*" -Recurse -Force
# Temp - Windows
Remove-ItemRecursively -Path "C:\Windows\Temp\*"

## Windows Update
# SoftwareDistribution
Stop-Service -Name wuauserv
Rename-Item -Path "C:\Windows\SoftwareDistribution" -NewName "SoftwareDistribution.old"
Remove-ItemRecursively -Path "C:\Windows\SoftwareDistribution.old" -Recurse -Force -Confirm:$false
Start-Service -Name wuauserv
# WinSxS
# Service Pack Files
dism.exe /online /cleanup-image /spsuperseded /hidesp
# Orphaned Components
dism.exe /online /Cleanup-Image /SPSuperseded
# WinSxS
dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase