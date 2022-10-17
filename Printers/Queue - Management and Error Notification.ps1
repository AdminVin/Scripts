#region Settings
#Varibles
$Date = Get-Date
$ComputerNames = @("SERVER")
#endregion

#region Check Printers
<# Legacy Configuration
Invoke-Command -ComputerName EBPRINT1 -ScriptBlock {Get-WMIObject Win32_PerfFormattedData_Spooler_PrintQueue | Where-Object {($_.Name -ne "PaperCut") -AND ($_.JobErrors -gt "0")} | Select-Object Name, @{Expression={$_.jobs};Label="CurrentJobs"}, JobErrors, TotalJobsPrinted | Format-Table -AutoSize}
#>

Write-Host "Queriying ALL printers on $ComputerNames at $Date" -ForegroundColor DarkYellow
ForEach($ComputerName in $ComputerNames)
{Get-Printer -ComputerName $ComputerName | ForEach-Object {Get-PrintJob -PrinterName $_.Name -ComputerName $ComputerName | Where-Object { $_.JobStatus -like '*Error*'}}}
#endregion

#region Email

#endregion