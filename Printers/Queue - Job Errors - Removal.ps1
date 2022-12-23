# Print Server
$PrintServer = "SERVER_NAME"
# Print Spooler must be running on the remote system running this script.

<#
# View Expired Print Jobs
Get-Printer -ComputerName $PrintServer | Get-Printjob | Where-Object {$_.jobstatus -like "*Error*" } | Select-Object @{name="Name";expression={$_.printerName}}, @{name="Submitted Time";expression={$_.SubmittedTime}}, jobstatus, PrinterName, @{name="Document Name";expression={$_.documentname}} | Sort-Object -Property jobstatus -Descending
#>

# Remove Expired Print Jobs
Get-Printer -ComputerName $PrintServer | Get-Printjob | Where-Object {$_.jobstatus -like "*Error*" } | Remove-PrintJob
# Restart Print Spooler
Invoke-Command -ComputerName $PrintServer -Scriptblock {Stop-Service "Spooler" -Force;Start-Sleep 5;Start-Service "Spooler";}