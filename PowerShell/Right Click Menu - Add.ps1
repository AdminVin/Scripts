# Add "Open with Powershell" to right click menu
New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR
if((Test-Path -LiteralPath "HKCR:\Directory\Shell\PowershellMenu") -ne $true) {  New-Item "HKCR:\Directory\Shell\PowershellMenu" -Force | Out-Null};
New-ItemProperty -LiteralPath "HKCR:\Directory\Shell\PowershellMenu" -Name "(Default)" -Value "Open with PowerShell (Admin)" -Force  | Out-Null
Set-ItemProperty -LiteralPath "HKCR:\Directory\Shell\PowershellMenu" -Name "(Default)" -Value "Open with PowerShell (Admin)" -Force | Out-Null
if((Test-Path -LiteralPath "HKCR:\Directory\Shell\PowershellMenu\command") -ne $true) {  New-Item "HKCR:\Directory\Shell\PowershellMenu\command" -Force -ErrorAction SilentlyContinue };
Set-ItemProperty -LiteralPath "HKCR:\Directory\Shell\PowershellMenu\command" -Name "(Default)" -Value "C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -NoExit -Command Set-Location -LiteralPath '%L'" -Force | Out-Null
Remove-PSDrive HKCR