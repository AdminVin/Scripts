# Source: https://support.microsoft.com/en-us/office/how-to-enable-and-disable-the-outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26
$ErrorActionPreference = "SilentlyContinue"

if((Test-Path -LiteralPath "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\calendar") -ne $true) {  New-Item "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\calendar" -Force}
New-ItemProperty -LiteralPath "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\calendar" -Name "restupdatesforcalendar" -Value "1" -PropertyType DWord -Force