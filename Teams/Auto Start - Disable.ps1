# Disable Teams from Auto Starting on Login
# User
Remove-ItemProperty -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "com.squirrel.Teams.Teams" -Force -ErrorAction SilentlyContinue
# Machine
Remove-ItemProperty -LiteralPath "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" -Name "TeamsMachineInstaller" -Force -ErrorAction SilentlyContinue