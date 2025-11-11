## Space (before)
$FreeSpaceBefore = (Get-PSDrive -Name C).Free / 1GB

## Functions
function Remove-ItemRecursively {
    param (
        [string]$Path
    )

    if (Test-Path $Path) {
        Get-ChildItem -Path $Path -Recurse -Force -ErrorAction SilentlyContinue | 
            Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }
}

## Cleanup

    # User Profiles
    $UserProfiles = Get-ChildItem "C:\Users" -Directory | Where-Object {
        $_.Name -notin @("All Users","Default","Default User","Public")
    }

    foreach ($UserProfile in $UserProfiles) {
        # Microsoft Store App
        Remove-ItemRecursively -Path "$($UserProfile.FullName)\AppData\Local\Packages\*\TempState\*"

        # WebCache
        Remove-ItemRecursively -Path "$($UserProfile.FullName)\AppData\Local\Microsoft\Windows\WebCache\*"

        # Crash Dumps
        Remove-ItemRecursively -Path "$($UserProfile.FullName)\AppData\Local\CrashDumps\*"

        # Local Low
        Remove-ItemRecursively -Path "$($UserProfile.FullName)\AppData\LocalLow\Temp\*"

        Write-Host "Finished cleaning: $($UserProfile.FullName)" -ForegroundColor Green
    }

    # System
        # Error Reporting
        Remove-ItemRecursively -Path "C:\ProgramData\Microsoft\Windows\WER\*"

        # Prefetch
        Remove-ItemRecursively -Path "C:\Windows\Prefetch\*"

        # Microsoft Store Cache
        Remove-ItemRecursively -Path "C:\ProgramData\Microsoft\Windows\Caches\*"

        # Temporary Files
        Remove-ItemRecursively -Path "$env:TEMP\*" -Recurse -Force
        Remove-ItemRecursively -Path "C:\Windows\Temp\*"
        Remove-ItemRecursively -Path "C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp\*"
        Remove-ItemRecursively -Path "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp\*"
        Remove-ItemRecursively -Path "C:\Windows\System32\config\systemprofile\AppData\Local\Temp\*"

        # Windows Update
            # Windows Update - Stop
            Stop-Service -Name wuauserv    

            # SoftwareDistribution
            if (Test-Path "C:\Windows\SoftwareDistribution.old") {
                cmd.exe /c rd /s /q "C:\Windows\SoftwareDistribution.old"
            }   
            Rename-Item -Path "C:\Windows\SoftwareDistribution" -NewName "SoftwareDistribution.old"
            cmd.exe /c rd /s /q "C:\Windows\SoftwareDistribution.old"

            # Windows Update Internal Cache
            Remove-ItemRecursively -Path "C:\Windows\SoftwareDistribution\EventCache.v2\*"

            # CBS (logs from Windows Update and DISM)
            Remove-ItemRecursively -Path "C:\Windows\Logs\CBS\*"

            # DISM (operational logs)
            Remove-ItemRecursively -Path "C:\Windows\Logs\DISM\*"

            # Setup/Upgrade Logs
            Remove-ItemRecursively -Path "C:\Windows\Panther\*"

            # WinSxS (Service Pack Backups / Superseded Updates / Replaced Componets)
            try {
                dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
            } catch {
                Write-Warning "DISM cleanup failed: $_"
            }

            # Windows.old
            if (Test-Path "C:\Windows.old") {
                cmd.exe /c rd /s /q "C:\Windows.old"
            }

            # Windows Update - Start
            Start-Service -Name wuauserv

## Space (After)
$FreeSpaceAfter = (Get-PSDrive -Name C).Free / 1GB
#
Write-Host "Disk Space Free (before): $("{0:N2} GB" -f $FreeSpaceBefore)" -ForegroundColor Green
Write-Host "Disk Space Free (after): $("{0:N2} GB" -f $FreeSpaceAfter)" -ForegroundColor Green
Write-Host "Actual Space Freed: $("{0:N2} GB" -f ($FreeSpaceAfter - $FreeSpaceBefore))" -ForegroundColor Green
