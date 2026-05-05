Stop-Service -Name Spooler -Force
Remove-Item "$env:SystemRoot\System32\spool\PRINTERS\*.shd" -ErrorAction SilentlyContinue
Remove-Item "$env:SystemRoot\System32\spool\PRINTERS\*.spl" -ErrorAction SilentlyContinue
Start-Service -Name Spooler