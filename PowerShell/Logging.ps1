#region Varibles
$LogFile = "Logging.txt"
$Date = Get-Date
#endregion


#region Process
# Run/Display in PowerShell Session
$Date
# No Display and ONLY Log output in text file $LogFile
$Date | Out-File -Append -FilePath $LogFile
# Seperator between entries
"#################################################################################################" | Out-File -Append -FilePath $LogFile
#endregion