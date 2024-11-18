## Functions
function Remove-ItemRecursively {
    param (
        [string]$Path
    )
    
    Get-ChildItem -Path $Path -Recurse -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
}

## Capture free space before cleanup
$FreeSpaceBefore = (Get-PSDrive -Name C).Free / 1GB
Write-Host "Disk Space Free (before): $("{0:N2} GB" -f $FreeSpaceBefore)" -ForegroundColor Green

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
# Service Pack Backups / Superseded Updates / Replaced Componets
dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

## Capture free space after cleanup
$FreeSpaceAfter = (Get-PSDrive -Name C).Free / 1GB
Write-Host "Disk Space Free (after): $("{0:N2} GB" -f $FreeSpaceAfter)" -ForegroundColor Green

## Calculate and display space freed
Write-Host "Actual Space Freed: $("{0:N2} GB" -f ($FreeSpaceAfter - $FreeSpaceBefore))" -ForegroundColor Green
#