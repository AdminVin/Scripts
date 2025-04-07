## Workaround for Scheduled Tasks not running PS Scripts Properly
# Requires PowerShell 5.1 (PSScheduledJob module)

# --- Create/Register ---
$JobName = "Users - Disable Expired"
$trigger = New-JobTrigger -Daily -At "4:00PM"
$cred = Get-Credential
Register-ScheduledJob -Name $JobName `
    -FilePath "C:\Scripts\$JobName.ps1" `
    -Credential $cred `
    -Trigger $trigger

# --- Delete ---
Unregister-ScheduledJob -Name $JobName

# --- Start Manually (Background Execution) ---
Start-Job -ScriptBlock { & "C:\Scripts\Users - Disable Expired.ps1" }
# Alternative: Open script in PowerShell ISE and run interactively

# --- View Running Jobs ---
Get-Job | Where-Object { $_.State -eq 'Running' }

<#
Example Output:
Id     Name     PSJobTypeName  State    HasMoreData  Location   Command
--     ----     -------------  -----    -----------  --------   -------
3      Job3     BackgroundJob  Running  True         localhost  & "C:\Scripts\Users - ...
#>

# --- Stop Specific Running Job ---
Stop-Job -Name "Job3"
# Or: Stop-Job -Id 3

# Clear Job Log
Get-Job | Remove-Job