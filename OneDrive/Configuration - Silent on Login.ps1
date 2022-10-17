$HKLMregistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"##Path to HKLM keys
$DiskSizeregistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\DiskSpaceCheckThresholdMB"##Path to max disk size key
$TenantGUID = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

if(!(Test-Path $HKLMregistryPath)){New-Item -Path $HKLMregistryPath -Force}
if(!(Test-Path $DiskSizeregistryPath)){New-Item -Path $DiskSizeregistryPath -Force}

New-ItemProperty -Path $HKLMregistryPath -Name "SilentAccountConfig" -Value "1" -PropertyType DWORD -Force | Out-Null ##Enable silent account configuration
New-ItemProperty -Path $DiskSizeregistryPath -Name $TenantGUID -Value "102400" -PropertyType DWORD -Force | Out-Null ##Set max OneDrive threshold before prompting