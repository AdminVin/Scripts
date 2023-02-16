# Print Server
$PrintServer = "SERVER_NAME"
# Print Spooler must be running on the remote system running this script.

# Remove Expired Print Jobs
Get-Printer -ComputerName $PrintServer | Get-Printjob | Where-Object {$_.jobstatus -like "*Error*" } | Remove-PrintJob
# Restart Print Spooler
Invoke-Command -ComputerName $PrintServer -Scriptblock {Stop-Service "Spooler" -Force;Start-Sleep 5;Start-Service "Spooler";}