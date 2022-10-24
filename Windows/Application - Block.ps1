# Setup "DisallowRun" Directory
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\" -Name "DisallowRun" -PropertyType DWord -Value "1" -Force -ErrorAction SilentlyContinue | Out-Null
New-item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\" -Name "DisallowRun" -Force -ErrorAction SilentlyContinue | Out-Null
# Block netsh.exe
$1 = "netsh.exe"
New-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "1" -PropertyType String -Value $1 -Force -ErrorAction SilentlyContinue | Out-Null
<# Block Registry
$2 = "regedit.exe"
New-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\explorer\DisallowRun" -Name "1" -PropertyType String -Value $2
#>