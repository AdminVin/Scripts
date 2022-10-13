#region Varibles
$LogFile = "Logging.txt"
$Date = Get-Date
#endregion


#region Process
# Run/Display in PowerShell Session
$Date
# Log output in text file $LogFile
$Date | Out-File -Append -FilePath $LogFile
#endregion