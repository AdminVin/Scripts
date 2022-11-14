if((Test-Path -LiteralPath "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail") -ne $true) {  New-Item "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Force -ErrorAction SilentlyContinue | Out-Null };
# Enable Safe Sender Import
New-ItemProperty -LiteralPath 'HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail' -Name 'JunkMailImportLists' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null;
# Define Location of List
$SafeSenderListPath = '\\SERVER\SHARE\SafeSendersList_Global.txt'
New-ItemProperty -LiteralPath 'HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail' -Name 'junkmailsafesendersfile' -Value $SafeSenderListPath -PropertyType String -Force -ErrorAction SilentlyContinue | Out-Null;
Set-ItemProperty -LiteralPath 'HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail' -Name 'junkmailsafesendersfile' -Value $SafeSenderListPath -Force -ErrorAction SilentlyContinue | Out-Null;