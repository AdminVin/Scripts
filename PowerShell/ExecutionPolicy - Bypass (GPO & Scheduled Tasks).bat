:: This configuration can be used for group policy and scheduled tasks.
:: Point your scheduled task to the .BAT file with the line below.
Powershell.exe -ExecutionPolicy Bypass -File "\\SERVER\Scripts\YourPowershellScript.ps1"