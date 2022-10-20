# Add "Open with Command Prompt" to right click menu
New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR
if((Test-Path -LiteralPath "HKCR:\Directory\Shell\CMDMenu") -ne $true) {  New-Item "HKCR:\Directory\Shell\CMDMenu" -Force | Out-Null};
New-ItemProperty -LiteralPath "HKCR:\Directory\Shell\CMDMenu" -Name "(Default)" -Value "Open with Command Prompt (Admin)" -Force  | Out-Null
Set-ItemProperty -LiteralPath "HKCR:\Directory\Shell\CMDMenu" -Name "(Default)" -Value "Open with Command Prompt (Admin)" -Force | Out-Null
if((Test-Path -LiteralPath "HKCR:\Directory\Shell\CMDMenu\command") -ne $true) {  New-Item "HKCR:\Directory\Shell\CMDMenu\command" -Force -ErrorAction SilentlyContinue };
Set-ItemProperty -LiteralPath "HKCR:\Directory\Shell\CMDMenu\command" -Name "(Default)" -Value 'cmd.exe /s /k pushd "%V"' -Force | Out-Null
Remove-PSDrive HKCR