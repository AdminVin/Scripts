# Setup "DisallowRun" Directory
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\" -Name "DisallowRun" -PropertyType DWord -Value "1" -Force -ErrorAction SilentlyContinue | Out-Null
New-item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\" -Name "DisallowRun" -Force -ErrorAction SilentlyContinue | Out-Null
# Block - Registry
$1 = "regedit.exe"
New-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "1" -PropertyType String -Value $1 -Force -ErrorAction SilentlyContinue | Out-Null
# Network Connections
$2 = "ncpa.cpl"
New-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "2" -PropertyType String -Value $2 -Force -ErrorAction SilentlyContinue | Out-Null

# Block - NETSH
$ACL = Get-ACL -Path "C:\Windows\System32\netsh.exe"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule(".\Users","Read","Deny")
$ACL.SetAccessRule($AccessRule)
$ACL | Set-Acl -Path "C:\Windows\System32\netsh.exe"