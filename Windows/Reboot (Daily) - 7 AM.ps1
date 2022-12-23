$DailyReboot = Get-ScheduledTask | Where-Object {$_.TaskName -like "Reboot (Daily)"}

if($DailyReboot) {
    Write-Host "Task Exists. Skipping!"
 } else {
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "shutdown -r -t 0"
    $trigger =  New-ScheduledTaskTrigger -Daily -At 7:30AM
    $STPrin = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Reboot (Daily)" -Description "Scheduled daily reboot at 7:30 AM." -Principal $STPrin
 }