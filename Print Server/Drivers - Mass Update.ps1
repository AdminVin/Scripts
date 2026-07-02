#######################################
#> VIEW - Existing/Installed Drivers <#
#######################################
$Drivers = Get-PrinterDriver | Where-Object Name -like "HP Universal Printing PCL 6*"

$Drivers | Select-Object `
    Manufacturer,
    Name,
    PrinterEnvironment,
    @{Name='Count';Expression={
        (Get-Printer |
            Where-Object DriverName -eq $_.Name |
            Measure-Object).Count
    }} | Format-Table -AutoSize


############################################
#> UPDATE - Old to newly installed driver <#
############################################
$OldDrivers = @(
    "HP Universal Printing PCL 6 (v7.2.0)",
    "HP Universal Printing PCL 6 (v7.9.0)"
)

$NewDriver = "HP Universal Printing PCL 6 (v8.2.0)"

Get-Printer |
Where-Object { $_.DriverName -in $OldDrivers } |
ForEach-Object {
    Write-Host "Updating $($_.Name)"
    rundll32 printui.dll,PrintUIEntry /Xs /n "$($_.Name)" DriverName "$NewDriver"
}


###############################
#> VERIFY - Duplex is ON/OFF <#
###############################

# Exact Name
Get-Printer |
Where-Object { $_.DriverName -eq "HP Universal Printing PCL 6 (v8.2.0)" } |
ForEach-Object {
    $cfg = Get-PrintConfiguration -PrinterName $_.Name
    [PSCustomObject]@{
        Name          = $_.Name
        DuplexingMode = $cfg.DuplexingMode
    }
} | Format-Table -AutoSize

# Partial Wildcard
Get-Printer |
Where-Object { $_.DriverName -like "*Ricoh*" } |
ForEach-Object {
    $cfg = Get-PrintConfiguration -PrinterName $_.Name
    [PSCustomObject]@{
        Name          = $_.Name
        Driver        = $_.DriverName
        DuplexingMode = $cfg.DuplexingMode
    }
} | Format-Table -AutoSize