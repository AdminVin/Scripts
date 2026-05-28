<# 2026-03-12 - McAfee Removal
- Download "McAfee Cleanup Utility.7z" and "PsExec.exe", and extract contents on server share.
- Update $NetworkPath to point to "mccleanup.exe"
#>

$McAfeePaths = @('HKLM:\SOFTWARE', 'HKLM:\SOFTWARE\WOW6432Node') | ForEach-Object {
    Get-ChildItem -Path $_ -ErrorAction SilentlyContinue |
        Where-Object { $_.PSChildName -like '*McAfee*' } |
        Select-Object -ExpandProperty PSPath
}

if ($McAfeePaths) {

    # Registry fixes to disable protection
    foreach ($Base in $McAfeePaths) {
        foreach ($Key in Get-ChildItem -Path $Base -Recurse -ErrorAction SilentlyContinue) {
            try {
                $RegKey = Get-Item -Path $Key.PSPath
                foreach ($Value in $RegKey.GetValueNames()) {
                    if ($Value -like '*SelfProtection*' -or $Value -like '*SafetyFramework*' -or $Value -like '*OAS*' -or $Value -like '*SpywareEntitled*') {
                        Set-ItemProperty -Path $Key.PSPath -Name $Value -Value 0 -Force
                        Write-Host "Set $Value = 0 -> $($Key.PSPath)"
                    } elseif ($Value -like '*DScannersOverride*') {
                        $Current = $RegKey.GetValue($Value)
                        if ($Current -is [array]) {
                            $New = $Current | ForEach-Object { $_ -replace '\|true','|false' }
                            Set-ItemProperty -Path $Key.PSPath -Name $Value -Value $New -Force
                            Write-Host "Set $Value MULTI_SZ true -> false -> $($Key.PSPath)"
                        }
                    }
                }
            } catch {}
        }
    }

    # Scheduled Task to run cleanup on next boot
    $TaskName = "RemoveMcAfeePostReboot"
    $TempScript = "C:\Windows\Temp\RemoveMcAfeePostReboot.ps1"
    Remove-Item -Path $TempScript -Force -ErrorAction SilentlyContinue
    $ScriptContent = @"
if (Test-Connection -ComputerName SERVER -Quiet -Count 1) {

    `$PsExecPath = '\\SERVER\gpo\McAfee - Settings\psexec.exe'
    `$McAfeeCleanupPath = '\\SERVER\gpo\McAfee - Settings\McAfee Cleanup Utility\mccleanup.exe'
    `$McAfeeServices = Get-Service -DisplayName 'McAfee*' -ErrorAction SilentlyContinue

    foreach (`$Service in `$McAfeeServices) {
        Write-Host "Processing Service: `$(`$Service.Name)" -ForegroundColor Green
        Start-Process -FilePath `$PsExecPath -ArgumentList "-accepteula -s taskkill /F /T /FI `"SERVICES eq `$(`$Service.Name)`"" -Wait -NoNewWindow
        Start-Process -FilePath `$PsExecPath -ArgumentList "-accepteula -s sc.exe stop `"`$(`$Service.Name)`"" -Wait -NoNewWindow
        Start-Process -FilePath `$PsExecPath -ArgumentList "-accepteula -s sc.exe delete `"`$(`$Service.Name)`"" -Wait -NoNewWindow
    }

    Start-Process -FilePath `$PsExecPath -ArgumentList "-accepteula -s `"`$McAfeeCleanupPath`"" -Wait -NoNewWindow

    Unregister-ScheduledTask -TaskName 'RemoveMcAfeePostReboot' -Confirm:`$false
    Remove-Item -Path 'C:\Windows\Temp\RemoveMcAfeePostReboot.ps1' -Force
}
"@
    $ScriptContent | Out-File -FilePath $TempScript -Encoding UTF8

    $Action    = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File `"$TempScript`""
    $Trigger   = New-ScheduledTaskTrigger -AtStartup -RandomDelay (New-TimeSpan -Seconds 60)
    $Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest
    Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Principal $Principal -Force

}