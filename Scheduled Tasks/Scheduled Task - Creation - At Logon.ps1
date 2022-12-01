# Specify the command and argument
#$action = New-ScheduledTaskAction -Execute 'cmd.exe' -Argument '/c C:\Temp\start.cmd'
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "Remove-Item 'C:\Users\$env:username\temp'"

### Use Powershell instead
# $action = New-ScheduledTaskAction -Execute 'Powershell.exe' `
#
#   -Argument '-NoProfile -WindowStyle Hidden -command "& {get-eventlog -logname Application -After ((get-date).AddDays(-1)) | Export-Csv -Path c:\fso\applog.csv -Force -NoTypeInformation}"'
###

# Set the trigger to be at any user logon
$trigger =  New-ScheduledTaskTrigger -AtLogOn

# Specifies that Task Scheduler uses the Local Service account to run tasks, and that the Local Service account uses the Service Account logon. The command assigns the **ScheduledTaskPrincipal** object to the $STPrin variable.
$STPrin = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount

# Create the scheduled task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "StartCMD" -Description "Start the CMD as admin" -Principal $STPrin

## Delete the scheduled Task
# Unregister-ScheduledTask -TaskName StartCMD -Confirm:$False
##