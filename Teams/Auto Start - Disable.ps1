# Disable Teams from Auto Starting on Login
Remove-Item -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\com.squirrel.Teams.Teams" -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run\TeamsMachineInstaller" -Force -ErrorAction SilentlyContinue