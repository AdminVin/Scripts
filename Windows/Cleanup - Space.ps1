## Capture free space before cleanup
$FreeSpaceBefore = (Get-PSDrive -Name C).Free / 1GB
Write-Host "Disk Space Free (before): $("{0:N2} GB" -f $FreeSpaceBefore)" -ForegroundColor Green

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
# Temp - Windowspu
Remove-ItemRecursively -Path "C:\Windows\Temp\*"

## Windows Update
# SoftwareDistribution
Stop-Service -Name wuauserv
if (Test-Path "C:\Windows\SoftwareDistribution.old") {
    Remove-Item -Path "C:\Windows\SoftwareDistribution.old" -Recurse -Force -ErrorAction SilentlyContinue
    if (Test-Path "C:\Windows\SoftwareDistribution.old") {
        Write-Host "Forcing removal of SoftwareDistribution.old via system process..."
        cmd.exe /c rd /s /q "C:\Windows\SoftwareDistribution.old"
    }
}
Rename-Item -Path "C:\Windows\SoftwareDistribution" -NewName "SoftwareDistribution.old"
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