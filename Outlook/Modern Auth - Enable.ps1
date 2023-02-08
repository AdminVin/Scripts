$ErrorActionPreference = "SilentlyContinue"

if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Identity") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Identity" -Force }
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Exchange") -ne $true) { New-Item "HKCU:\SOFTWARE\Microsoft\Exchange" -Force }
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Identity' -Name 'Version' -Value 1 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Identity' -Name 'EnableADAL' -Value 1 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Exchange' -Name 'AlwaysUseMSOAuthForAutoDiscover' -Value 1 -PropertyType DWord -Force 