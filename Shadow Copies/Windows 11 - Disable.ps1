# Requires: Administrator privileges and PowerShell 7

# Delete Scheduled Task
schtasks.exe /Delete /TN "ShadowCopies(7AM12PM4PM)" /F

# Delete Shadow Storage (Wipes snapshots)
Start-Process -FilePath "vssadmin.exe" -ArgumentList "delete shadowstorage /for=C: /on=C: /quiet" -Wait -Verb RunAs

Write-Host "`n🧹 Shadow copy schedule and storage removed from C:"
