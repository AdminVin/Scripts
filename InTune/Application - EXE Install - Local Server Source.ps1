## Varibles
# App Name (No Spaces)
$AppName = "7ZIP"
# Local Server Hosting App Installer
$Server = "FILESERVER"
# App Installer
$AppSetup = "\\FILESERVER.DOMAIN.LOCAL\Applications\7ZIP\911inform Installer v1.1.exe"
# App Installer Arguments (To find arguments for your executable refer to official documentation or in CLI use the switch /?)
$AppArguments = "/NORESTART"
# App Installed Executable
$AppInstalledPath = "C:\Program Files\7-Zip\7zFM.exe"
# Do Not Modify
$ErrorActionPreference = "SilentlyContinue"
$AppSTask = "$AppName-Install"
$AppSTaskInstalled = Get-ScheduledTask | Where-Object TaskName -eq "$AppSTask" | Select-Object -First 1

## Setup & Installation
# Check if App is installed, and if not install scheduled task to PC; App will be installed on the next login.
if($AppInstalledPath) {
    Write-Host "$AppName NOT detected, installing scheduled task." -ForegroundColor Red
    if($AppSTaskInstalled) {
        Write-Host "Scheduled task detected, skipping." -ForegroundColor Yellow
        } else {
        Write-Host "Scheduled task NOT detected, installing." -ForegroundColor Green
        $action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "if((Test-Connection -ComputerName $Server -Count 1 -Quiet) -like '$True') { if('!$AppInstalledPath') { Start-Process '$AppSetup' -ArgumentList '$AppArguments';Start-Sleep 300;Disable-ScheduledTask -TaskName '$AppSTask' } } ELSE { Write-Host 'Server Offline.'}"
        $trigger = New-ScheduledTaskTrigger -AtLogOn
        $STPrin = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
        Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $AppSTask -Description "This scheduled task will install $AppName on the computer, and then get disabled." -Principal $STPrin | Out-Null
        }
} else {
    Write-Host "$AppName detected, disabling scheduled task (if enabled)." -ForegroundColor Green
    Disable-ScheduledTask -TaskName "$AppSTask" | Out-Null

 }