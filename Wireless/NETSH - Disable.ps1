# Block - NETSH
# This allows Command Prompt to be available if troubleshooting is needed on the device. (WMIC, IPCONFIG, PING, etc etc)
$ACL = Get-ACL -Path "C:\Windows\System32\netsh.exe"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule(".\Administrators","FullControl","Allow")
$ACL.SetAccessRule($AccessRule)
$ACL | Set-Acl -Path "C:\Windows\System32\netsh.exe"

$ACL2 = Get-ACL -Path "C:\Windows\System32\netsh.exe"
$AccessRule2 = New-Object System.Security.AccessControl.FileSystemAccessRule(".\Users","Read","Deny")
$ACL2.SetAccessRule($AccessRule2)
$ACL2 | Set-Acl -Path "C:\Windows\System32\netsh.exe"