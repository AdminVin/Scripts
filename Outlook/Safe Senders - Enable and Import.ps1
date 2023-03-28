$ErrorActionPreference = "SilentlyContinue"
$SafeSenderListPath = "\\SERVER\SHARE\SafeSendersList_Global.txt"

if((Test-Path -LiteralPath "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail") -ne $true) {New-Item "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Force}
# Enable Safe Sender Import
New-ItemProperty -LiteralPath "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "JunkMailImportLists" -Value "1" -PropertyType DWord -Force
Set-ItemProperty -LiteralPath "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "JunkMailImportLists" -Value "1" -Force
# Define Location of List
New-ItemProperty -LiteralPath "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "junkmailsafesendersfile" -Value $SafeSenderListPath -PropertyType "String" -Force
Set-ItemProperty -LiteralPath "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "junkmailsafesendersfile" -Value $SafeSenderListPath -Force