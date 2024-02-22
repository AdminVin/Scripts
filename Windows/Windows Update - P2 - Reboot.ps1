## Setup Notes
# Login to server > Scheduled Tasks > Create New Task (not basic)
# Schedule:  Thurs/Friday @ 1 AM 
# Action > New
#       Program/Script: Point to PS7 (C:\Program Files\PowerShell\7\pwsh.exe)
#         Argument: -ExecutionPolicy Bypass -File "UNC or Local Path to this PS Script."

# Reboot Check
$rebootRequired = $false
if (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired") {
    $rebootRequired = $true
}

# Reboot PC
if ($rebootRequired) {
    # Reboot required.
    $Directory = "C:\ProgramData\EBPS\WindowsUpdates"
    $File = Join-Path -Path $Directory -ChildPath "RebootNeeded.txt"
    if (-not (Test-Path $Directory)) {
        New-Item -ItemType Directory -Path $Directory -Force
    }
    New-Item -ItemType File -Path $File -Force | Out-Null
    Restart-Computer -Force
}