## Capture free space before cleanup
$FreeSpaceBefore = (Get-PSDrive -Name C).Free / 1GB
Write-Host "Disk Space Free (before): $("{0:N2} GB" -f $FreeSpaceBefore)" -ForegroundColor Green

## Functions
function Remove-ItemRecursively {
    param (
        [string]$Path
    )
    
    Get-ChildItem -Path $Path -Recurse -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
}

function Clear-BrowserCaches {
    $UserProfiles = Get-ChildItem "C:\Users" -Directory | Where-Object {
        $_.Name -notin @("All Users","Default","Default User","Public")
    }

    foreach ($UserProfile in $UserProfiles) {
        # IE / Legacy Edge
        Remove-Item "$($UserProfile.FullName)\AppData\Local\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue

        # Chromium Edge (all profiles)
        Get-ChildItem "$($UserProfile.FullName)\AppData\Local\Microsoft\Edge\User Data" -Directory -ErrorAction SilentlyContinue |
            ForEach-Object { Remove-Item "$($_.FullName)\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue }

        # Chrome (all profiles)
        Get-ChildItem "$($UserProfile.FullName)\AppData\Local\Google\Chrome\User Data" -Directory -ErrorAction SilentlyContinue |
            ForEach-Object { Remove-Item "$($_.FullName)\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue }

        # Firefox (all profiles)
        Get-ChildItem "$($UserProfile.FullName)\AppData\Local\Mozilla\Firefox\Profiles" -Directory -ErrorAction SilentlyContinue |
            ForEach-Object { Remove-Item "$($_.FullName)\cache2\*" -Recurse -Force -ErrorAction SilentlyContinue }
    }
}

## Browser Cache
Clear-BrowserCaches

## Error Reporting
Remove-ItemRecursively -Path "C:\ProgramData\Microsoft\Windows\WER\*"

## Prefetch
Remove-ItemRecursively -Path "C:\Windows\Prefetch\*"

## Temporary Files
# Temp - User
Remove-ItemRecursively -Path "$env:TEMP\*" -Recurse -Force
# Temp - Windowspu
Remove-ItemRecursively -Path "C:\Windows\Temp\*"

## Windows Update
#> SoftwareDistribution
Stop-Service -Name wuauserv
if (Test-Path "C:\Windows\SoftwareDistribution.old") {
    cmd.exe /c rd /s /q "C:\Windows\SoftwareDistribution.old"
}   # Remove any .old variations of 'SoftwareDistribution'
Rename-Item -Path "C:\Windows\SoftwareDistribution" -NewName "SoftwareDistribution.old"
cmd.exe /c rd /s /q "C:\Windows\SoftwareDistribution.old"
Start-Service -Name wuauserv
#> WinSxS (Service Pack Backups / Superseded Updates / Replaced Componets)
dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

## Windows.old
if (Test-Path "C:\Windows.old") {
    cmd.exe /c rd /s /q "C:\Windows.old"
}

## Space
#> Capture free space after cleanup
$FreeSpaceAfter = (Get-PSDrive -Name C).Free / 1GB
Write-Host "Disk Space Free (after): $("{0:N2} GB" -f $FreeSpaceAfter)" -ForegroundColor Green
#> Calculate and display space freed
Write-Host "Actual Space Freed: $("{0:N2} GB" -f ($FreeSpaceAfter - $FreeSpaceBefore))" -ForegroundColor Green
#