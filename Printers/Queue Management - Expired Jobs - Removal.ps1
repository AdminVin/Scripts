# Print Server
$PrintServer = "EBPRINT1"
# Jobs expire in five days
$ExpiredPrintJobs = (Get-Date).AddDays(-5)
# Print Spooler must be running from the system this is being run from.


<# 
# View Expired Print Jobs
Get-Printer -ComputerName $PrintServer | Get-Printjob | Where-Object {$_.SubmittedTime -le $ExpiredPrintJobs } | Select-Object @{name="Name";expression={$_.printerName}}, @{name="Submitted Time";expression={$_.SubmittedTime}}, jobstatus, PrinterName, @{name="Document Name";expression={$_.documentname}} | Sort-Object -Property jobstatus -Descending
#>

# Remove Expired Print Jobs
Get-Printer -ComputerName $PrintServer | Get-Printjob | Where-Object {$_.SubmittedTime -le $ExpiredPrintJobs } | Remove-PrintJob
# Restart Print Spooler/Papercut
Invoke-Command -ComputerName EBPRINT1 -Scriptblock {Stop-Service "Spooler" -Force;Stop-Service "PCPrintProvider";Start-Sleep 5;Start-Service "Spooler";Start-Service "PCPrintProvider"}