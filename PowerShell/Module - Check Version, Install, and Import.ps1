# ExchangeOnlineManagement
$EOM_Version = Get-InstalledModule | Where-Object {($_.Name -eq "ExchangeOnlineManagement") -AND ($_.Version -ge "3.1.0")}
if($EOM_Version -eq "$null")
{
Write-Host "Install/Update 'ExchangeOnlineManagement' Module"
Uninstall-Module -Name "ExchangeOnlineManagement"
Install-Module -Name "ExchangeOnlineManagement"
Write-Output "Importing 'ExchangeOnlineManagement' Module"
Import-Module ExchangeOnlineManagement -Verbose
}
else
{
Write-Output "Importing 'ExchangeOnlineManagement' Module"
Import-Module ExchangeOnlineManagement -Verbose
}




#| Select-Object Name
#-eq "$null"




#| Select-Object Name
#-eq "$null"