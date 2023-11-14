## Simple Script
# Name
$TaskName = "Remove Directory"
# Action
#$action = New-ScheduledTaskAction -Execute 'cmd.exe' -Argument '/c C:\Temp\start.cmd'
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "Remove-Item 'C:\Users\$env:username\temp'"
# Trigger
$trigger =  New-ScheduledTaskTrigger -AtLogOn
# Permissions
## Specifies that Task Scheduler uses the Local Service account to run tasks, and that the Local Service account uses the Service Account logon. 
## The command assigns the **ScheduledTaskPrincipal** object to the $STPrin variable.
## If this should be run on the user account, omit "-Principal $STPrin" from line 15.
$STPrin = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
# Create the scheduled task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $TaskName -Description "Start the CMD as admin" -Principal $STPrin

# Delete the Scheduled Task
Unregister-ScheduledTask -TaskName StartCMD -Confirm:$False


## Complex Script
# Name
$TaskName = "Windows 11 - Start Bar Alignment"
# Script
$scriptBlock = {
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value "0" -Type Dword -Force | Out-Null
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value "0" -Force | Out-Null
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_Layout' -Value "1" -PropertyType DWord -Force | Out-Null
    Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_Layout' -Value "1" -Force | Out-Null
}
# Trigger
$trigger = New-ScheduledTaskTrigger -AtLogOn
# Action
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $scriptBlock
# Register Scheduled Task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $TaskName -Force