
New-Object -ComObject Wscript.Shell | Set-Variable -Name "Shortcut to App" -Value $_.CreateShortcut("C:\path\to\shortcut.lnk")