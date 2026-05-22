# ============================================
# WSUS Maintenance Script
# Run on Local WSUS Server
# Schedule: Weekly (Sunday 2:00 AM recommended)
# ============================================

$LogFile       = "C:\WSUS_Maintenance\Logs\WSUS-Maintenance_$(Get-Date -Format 'yyyy-MM-dd').log"
$PS5           = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
$WIDPipe       = "\\.\pipe\MICROSOFT##WID\tsql\query"
$ps5ScriptPath = "C:\WSUS_Maintenance\wsus_api_tasks.ps1"

New-Item -ItemType Directory -Path "C:\WSUS_Maintenance\Logs" -Force | Out-Null

# Must be defined before anything tries to call it
function Write-Log {
    param([string]$Message)
    $entry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
    Write-Host $entry
    Add-Content -Path $LogFile -Value $entry
}

# ============================================
# Auto-locate or install sqlcmd.exe
# ============================================
$SqlCmd = Get-Command sqlcmd.exe -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source

if (-not $SqlCmd) {
    $SqlCmd = Get-ChildItem -Path "C:\Program Files\", "C:\Program Files (x86)\" `
        -Recurse -Filter "sqlcmd.exe" -ErrorAction SilentlyContinue |
        Select-Object -First 1 -ExpandProperty FullName
}

if (-not $SqlCmd) {
    Write-Log "INFO: sqlcmd.exe not found. Attempting install via winget..."
    try {
        winget install Microsoft.Sqlcmd --accept-source-agreements --accept-package-agreements --silent
        $SqlCmd = Get-ChildItem -Path "C:\Program Files\", "C:\Program Files (x86)\" `
            -Recurse -Filter "sqlcmd.exe" -ErrorAction SilentlyContinue |
            Select-Object -First 1 -ExpandProperty FullName

        if ($SqlCmd) {
            Write-Log "INFO: sqlcmd.exe installed and found at $SqlCmd"
        } else {
            Write-Log "ERROR: sqlcmd.exe install appeared to succeed but binary not found. Skipping DB steps."
            $SqlCmd = $null
        }
    } catch {
        Write-Log "ERROR: Failed to install sqlcmd.exe via winget. Skipping DB steps. $_"
        $SqlCmd = $null
    }
} else {
    Write-Log "INFO: sqlcmd.exe found at $SqlCmd"
}

# ============================================
# STEPS 1 & 2 - WSUS API (runs under PS 5.1)
# ============================================
Write-Log "START: Writing PS5.1 script for WSUS API tasks..."

@'
[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | Out-Null
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer('localhost', $false, 8530)
$updates = $wsus.GetUpdates()

# Step 1a - Decline Superseded Updates
$superseded = $updates | Where-Object { $_.IsSuperseded -eq $true -and $_.IsDeclined -eq $false }
Write-Host "STEP1a: Found $($superseded.Count) superseded updates to decline."
foreach ($update in $superseded) { $update.Decline() }
Write-Host "STEP1a: DONE - Superseded updates declined."

# Step 1b - Decline ARM64 Updates
$arm64 = $updates | Where-Object { $_.Title -match '\bARM64\b' -and -not $_.IsDeclined }
Write-Host "STEP1b: Found $($arm64.Count) ARM64 updates to decline."
foreach ($update in $arm64) {
    $update.Decline()
    Write-Host "  Declined: $($update.Title)"
}
Write-Host "STEP1b: DONE"

# Step 1c - Decline EOL Windows 10 Versions
# All versions before 22H2
$eolWin10Versions = @('1507','1511','1607','1703','1709','1803','1809','1903','1909','2004','20H2','21H1','21H2')
$eolWin10Pattern  = ($eolWin10Versions | ForEach-Object { '\b' + $_ + '\b' }) -join '|'

$eolWin10Updates = $updates | Where-Object {
    $_.Title -match $eolWin10Pattern -and
    $_.Title -match 'Windows 10' -and
    -not $_.IsDeclined
}
Write-Host "STEP1c: Found $($eolWin10Updates.Count) EOL Windows 10 updates to decline."
foreach ($update in $eolWin10Updates) {
    $update.Decline()
    Write-Host "  Declined: $($update.Title)"
}
Write-Host "STEP1c: DONE"

# Step 1d - Decline EOL Windows 11 Versions
# Declining 21H2 and 22H2 only - 23H2, 24H2 and 25H2 are allowed through
$eolWin11Versions = @('21H2','22H2')
$eolWin11Pattern  = ($eolWin11Versions | ForEach-Object { '\b' + $_ + '\b' }) -join '|'

$eolWin11Updates = $updates | Where-Object {
    $_.Title -match $eolWin11Pattern -and
    $_.Title -match 'Windows 11' -and
    -not $_.IsDeclined
}
Write-Host "STEP1d: Found $($eolWin11Updates.Count) EOL Windows 11 updates to decline."
foreach ($update in $eolWin11Updates) {
    $update.Decline()
    Write-Host "  Declined: $($update.Title)"
}
Write-Host "STEP1d: DONE"

# Step 1e - Decline Edge Dev/Beta Updates
$edge = $updates | Where-Object {
    ($_.Title -like "Microsoft Edge-Dev*" -or $_.Title -like "Microsoft Edge-Beta*") -and -not $_.IsDeclined
}
Write-Host "STEP1e: Found $($edge.Count) Edge Dev/Beta updates to decline."
foreach ($update in $edge) {
    $update.Decline()
    Write-Host "  Declined: $($update.Title)"
}
Write-Host "STEP1e: DONE"

# Step 2 - Cleanup Wizard
$cleanupScope = New-Object Microsoft.UpdateServices.Administration.CleanupScope
$cleanupScope.DeclineExpiredUpdates       = $true
$cleanupScope.DeclineSupersededUpdates    = $true
$cleanupScope.CleanupObsoleteUpdates      = $true
$cleanupScope.CleanupUnneededContentFiles = $true
$cleanupScope.CleanupObsoleteComputers    = $true
$cleanupScope.CompressUpdates             = $true

$cleanupManager = $wsus.GetCleanupManager()
$result = $cleanupManager.PerformCleanup($cleanupScope)
Write-Host "STEP2: DONE - Disk space freed: $($result.DiskSpaceFreed) bytes"
'@ | Set-Content -Path $ps5ScriptPath -Encoding UTF8

Write-Log "START: Launching PS5.1 for WSUS API tasks..."
try {
    $output = & $PS5 -NonInteractive -NoProfile -ExecutionPolicy Bypass -File $ps5ScriptPath 2>&1
    $output | ForEach-Object { Write-Log "$_" }
} catch {
    Write-Log "ERROR (Steps 1-2): $_"
}

# ============================================
# STEP 3 - Re-index SUSDB
# ============================================
if ($SqlCmd) {
    Write-Log "START: Re-indexing SUSDB..."
    try {
        $reindexQuery = @"
USE SUSDB;
EXEC sp_msforeachtable 'ALTER INDEX ALL ON ? REBUILD';
EXEC sp_updatestats;
"@
        $reindexQuery | & $SqlCmd -S $WIDPipe -E 2>&1 | ForEach-Object { Write-Log "$_" }
        Write-Log "DONE: Re-index complete."
    } catch {
        Write-Log "ERROR (Step 3): $_"
    }
} else {
    Write-Log "SKIPPED: Step 3 - sqlcmd.exe not available."
}

# ============================================
# STEP 4 - Shrink SUSDB
# ============================================
if ($SqlCmd) {
    Write-Log "START: Shrinking SUSDB..."
    try {
        $shrinkQuery = @"
USE SUSDB;
DBCC SHRINKDATABASE (SUSDB, 10);
"@
        $shrinkQuery | & $SqlCmd -S $WIDPipe -E 2>&1 | ForEach-Object { Write-Log "$_" }
        Write-Log "DONE: Shrink complete."
    } catch {
        Write-Log "ERROR (Step 4): $_"
    }
} else {
    Write-Log "SKIPPED: Step 4 - sqlcmd.exe not available."
}

# ============================================
# STEP 5 - Clean up old logs (keep 30 days)
# ============================================
Write-Log "START: Pruning logs older than 30 days..."
Get-ChildItem "C:\WSUS_Maintenance\Logs\*.log" |
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } |
    Remove-Item -Force
Write-Log "DONE: Log cleanup complete."

Write-Log "====== WSUS Maintenance Finished ======"