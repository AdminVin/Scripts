# Print Server
$PrintServer = "SERVER_NAME"
# Jobs expiration time length
$ExpiredPrintJobs = (Get-Date).AddDays(-5)
# Print Spooler must be running on the remote system running this script.

<# 
# View Expired Print Jobs
Get-Printer -ComputerName $PrintServer | Get-Printjob | Where-Object {$_.SubmittedTime -le $ExpiredPrintJobs } | Select-Object @{name="Name";expression={$_.printerName}}, @{name="Submitted Time";expression={$_.SubmittedTime}}, jobstatus, PrinterName, @{name="Document Name";expression={$_.documentname}} | Sort-Object -Property jobstatus -Descending
#>

# Remove Expired Print Jobs
Get-Printer -ComputerName $PrintServer | Get-Printjob | Where-Object {$_.SubmittedTime -le $ExpiredPrintJobs } | Remove-PrintJob
# Restart Print Spooler/Papercut
Invoke-Command -ComputerName $PrintServer -Scriptblock {Stop-Service "Spooler" -Force;Start-Sleep 5;Start-Service "Spooler"}