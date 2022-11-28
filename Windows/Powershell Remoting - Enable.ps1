#region Enable PowerShell Remoting
# IP Address Range
# IPv4 Range
# Set to "*" for all IP addresses
# Set to "" for no IP addresses
# Set multiple ranges "192.168.100.1-192.168.103.254,192.168.105.1-192.168.105.254"
$IPv4Range = "*" 
# IPv6 Range
$IPv6Range = "" 

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service' -Name 'AllowAutoConfig' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service' -Name 'IPv4Filter' -Value $IPv4Range -PropertyType String -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service' -Name 'IPv6Filter' -Value $IPv6Range -PropertyType String -Force -ErrorAction SilentlyContinue
#endregion

#enable Firewall Rules
Enable-PSRemoting -Force
#endregion

#region Enable and Auto Start 'Windows Remote Management (WinRM)' Widnows Service
WINRM QUICKCONFIG
#endregion