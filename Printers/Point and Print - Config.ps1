# Print Server FQDN
$PrintServer = "SERVER.DOMAIN.LOCAL"

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "RestrictDriverInstallationToAdministrators" -Value "0" -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "Restricted" -Value "1" -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "TrustedServers" -Value "1" -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "ServerList" -Value $PrintServer -PropertyType String -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "InForest" -Value "0" -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "NoWarningNoElevationOnInstall" -Value "1" -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "UpdatePromptSettings" -Value "2" -PropertyType DWord -Force -ErrorAction SilentlyContinue