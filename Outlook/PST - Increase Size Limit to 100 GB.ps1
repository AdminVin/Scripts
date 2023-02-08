$ErrorActionPreference = "SilentlyContinue"

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Office\16.0\Outlook\PST") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Office\16.0\Outlook\PST" -Force }
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Office\15.0\Outlook\PST") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Office\15.0\Outlook\PST" -Force }
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Office\14.0\Outlook\PST") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Office\14.0\Outlook\PST" -Force }
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Office\12.0\Outlook\PST") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Office\12.0\Outlook\PST" -Force }
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Office\11.0\Outlook\PST") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Office\11.0\Outlook\PST" -Force }
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Office\16.0\Outlook\PST' -Name 'WarnLargeFileSize' -Value 464512 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Office\16.0\Outlook\PST' -Name 'MaxLargeFileSize' -Value 1057792 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Office\15.0\Outlook\PST' -Name 'WarnLargeFileSize' -Value 464512 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Office\15.0\Outlook\PST' -Name 'MaxLargeFileSize' -Value 1057792 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Office\14.0\Outlook\PST' -Name 'WarnLargeFileSize' -Value 464512 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Office\14.0\Outlook\PST' -Name 'MaxLargeFileSize' -Value 1057792 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Office\12.0\Outlook\PST' -Name 'WarnLargeFileSize' -Value 464512 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Office\12.0\Outlook\PST' -Name 'MaxLargeFileSize' -Value 1057792 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Office\11.0\Outlook\PST' -Name 'WarnLargeFileSize' -Value 464512 -PropertyType DWord -Force 
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Office\11.0\Outlook\PST' -Name 'MaxLargeFileSize' -Value 1057792 -PropertyType DWord -Force 
