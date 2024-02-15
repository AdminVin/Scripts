if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\runas") -ne $true) {New-Item "HKLM:\SOFTWARE\Classes\*\shell\runas" -Force | Out-Null}
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\runas\command") -ne $true) {New-Item "HKLM:\SOFTWARE\Classes\*\shell\runas\command" -Force | Out-Null}
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\runas") -ne $true) {New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\runas" -Force | Out-Null}
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\runas\command") -ne $true) {New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\runas\command" -Force | Out-Null}
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas' -Name '(default)' -Value 'Take Ownership' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas' -Name 'NoWorkingDirectory' -Value "" -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas\command' -Name '(default)' -Value 'cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas\command' -Name 'IsolatedCommand' -Value 'cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas' -Name '(default)' -Value 'Take Ownership' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas' -Name 'NoWorkingDirectory' -Value "" -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas\command' -Name '(default)' -Value 'cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas\command' -Name 'IsolatedCommand' -Value 'cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\runas\' -Name 'Icon' -Value 'imageres.dll,-5311' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\runas' -Name 'Icon' -Value 'imageres.dll,-5311' -PropertyType String -Force | Out-Null