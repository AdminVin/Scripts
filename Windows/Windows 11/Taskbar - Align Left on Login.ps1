$TaskName = "Windows 11 - Start Bar Alignment"

$scriptBlock = {
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value "0" -Type Dword -Force | Out-Null
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value "0" -Force | Out-Null
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_Layout' -Value "1" -PropertyType DWord -Force | Out-Null
    Set-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_Layout' -Value "1" -Force | Out-Null
}

$trigger = New-ScheduledTaskTrigger -AtLogOn

$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $scriptBlock

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $TaskName -Force