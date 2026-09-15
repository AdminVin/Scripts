<#
Closes OneDrive, renames its sync database file(s) to .old, and relaunches
OneDrive so it rebuilds a fresh SyncEngineDatabase.db.

Only touches metadata under %localappdata%\Microsoft\OneDrive\settings.
Does not touch synced files on disk.
#>

$ErrorActionPreference = 'Stop'

function Write-Step($msg) { Write-Host "`n[*] $msg" -ForegroundColor Cyan }

# 1. Close OneDrive completely
Write-Step "Stopping OneDrive..."
Get-Process OneDrive -ErrorAction SilentlyContinue | Stop-Process -Force

$timeoutSec = 30
$waited = 0
while ((Get-Process OneDrive -ErrorAction SilentlyContinue) -and $waited -lt $timeoutSec) {
    Start-Sleep -Seconds 1
    $waited++
}
if (Get-Process OneDrive -ErrorAction SilentlyContinue) {
    throw "OneDrive did not close after $timeoutSec seconds. Aborting."
}
Write-Host "    OneDrive is closed." -ForegroundColor Green

# 2. Find every account settings folder and rename its sync database
$settingsRoot = "$env:LOCALAPPDATA\Microsoft\OneDrive\settings"
$accountFolders = Get-ChildItem -Path $settingsRoot -Directory -ErrorAction SilentlyContinue

if (-not $accountFolders) {
    throw "No OneDrive account settings folders found under $settingsRoot"
}

$dbFileNames = @(
    'SyncEngineDatabase.db',
    'SyncEngineDatabase.db-wal',
    'SyncEngineDatabase.db-shm'
)

Write-Step "Renaming sync database files to .old..."
$renamed = @()

foreach ($folder in $accountFolders) {
    foreach ($name in $dbFileNames) {
        $fullPath = Join-Path $folder.FullName $name
        if (Test-Path $fullPath) {
            $oldPath = "$fullPath.old"
            if (Test-Path $oldPath) {
                Remove-Item $oldPath -Force
            }
            Rename-Item -Path $fullPath -NewName (Split-Path $oldPath -Leaf) -Force
            $renamed += $oldPath
            Write-Host "    Renamed: $fullPath -> $oldPath" -ForegroundColor Yellow
        }
    }
}

if ($renamed.Count -eq 0) {
    Write-Warning "No SyncEngineDatabase.db files were found to rename."
} else {
    Write-Host "`n[*] Renamed $($renamed.Count) file(s)." -ForegroundColor Cyan
}

# 3. Relaunch OneDrive
Write-Step "Relaunching OneDrive..."
$oneDriveExe = "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe"
if (-not (Test-Path $oneDriveExe)) {
    $oneDriveExe = "$env:ProgramFiles\Microsoft OneDrive\OneDrive.exe"
}
if (-not (Test-Path $oneDriveExe)) {
    $oneDriveExe = "${env:ProgramFiles(x86)}\Microsoft OneDrive\OneDrive.exe"
}
if (-not (Test-Path $oneDriveExe)) {
    throw "Could not find OneDrive.exe to relaunch. Start it manually."
}
Start-Process -FilePath $oneDriveExe
Write-Host "    OneDrive relaunched from: $oneDriveExe" -ForegroundColor Green

Write-Host "`nDone. OneDrive will rebuild a fresh SyncEngineDatabase.db as it reconnects." -ForegroundColor Green
if ($renamed.Count -gt 0) {
    Write-Host "Renamed files (for rollback if needed):"
    $renamed | ForEach-Object { Write-Host "  $_" }
}
