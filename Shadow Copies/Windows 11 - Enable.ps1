# Requires: Administrator privileges and PowerShell 7

# --- Config ---
$vssDrive = "C:"
$maxSize = "10%"
$taskName = "ShadowCopies(7AM12PM4PM)"
$startTime = "07:00"

# --- Enable Shadow Storage via vssadmin (safe to re-run) ---
Write-Host "Configuring Shadow Storage on $vssDrive"
Start-Process -FilePath "vssadmin.exe" -ArgumentList "Add ShadowStorage /For=$vssDrive /On=$vssDrive /MaxSize=$maxSize" -Wait -Verb RunAs

# --- Create scheduled task using schtasks.exe with repeat every 5 hours ---
$cmd = "vssadmin create shadow /for=$vssDrive"
$quotedCmd = "`"cmd.exe /c $cmd`""

# Delete existing task if exists
schtasks.exe /Delete /TN $taskName /F *> $null

# Create new task
schtasks.exe /Create /TN $taskName /TR $quotedCmd /SC DAILY /ST $startTime /RI 300 /DU 015:00 /RL HIGHEST /F

Write-Host "`n✅ Scheduled Task '$taskName' created."
Write-Host "It will run at 7 AM, 12 PM, and 4 PM daily to create shadow copies for $vssDrive."