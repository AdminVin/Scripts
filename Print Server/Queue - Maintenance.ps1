$PrintServer = "SERVER"
$DaysUntilExpiration = 5

# Remove errored print jobs
Get-Printer -ComputerName $PrintServer | Get-PrintJob | Where-Object { $_.JobStatus -like "*Error*" } | Remove-PrintJob

# Remove expired print jobs
Get-Printer -ComputerName $PrintServer | Get-PrintJob | Where-Object { $_.SubmittedTime -le (Get-Date).AddDays(-$DaysUntilExpiration) } | Remove-PrintJob

# Restart Print Spooler and PaperCut — stop dependents first, then Spooler
Stop-Service "PCPrintProvider" -Force -ErrorAction SilentlyContinue
Stop-Service "Spooler" -Force -ErrorAction SilentlyContinue

# Wait until Spooler is fully stopped before restarting
$timeout = 30
$elapsed = 0
while ((Get-Service "Spooler").Status -ne "Stopped" -and $elapsed -lt $timeout) {
    Start-Sleep 1
    $elapsed++
}

Start-Service "Spooler"
Start-Service "PCPrintProvider"