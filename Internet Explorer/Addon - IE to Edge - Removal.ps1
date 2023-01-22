$IEAddon = Get-ScheduledTask | Where-Object {$_.TaskName -like "Internet Explorer - IEtoEDGE Removal"}

if($IEAddon) {
    Write-Host "Task Exists"
 } else {
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "Get-ChildItem -Path 'C:\Program Files (x86)\Microsoft\Edge\Application' -Recurse -Filter 'BHO' | Remove-Item -Force -Recurse"
    $trigger =  New-ScheduledTaskTrigger -AtLogOn
    $STPrin = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Internet Explorer - IEtoEDGE Removal" -Description "Removes the Internet Explorer Addon IEtoEDGE.  This will permit the use of Internet Explorer." -Principal $STPrin
 }