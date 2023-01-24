# ExchangeOnlineManagement
$EOM_Version = Get-InstalledModule | Where-Object {($_.Name -eq "ExchangeOnlineManagement") -AND ($_.Version -ge "3.1.0")}
if((($EOM_Version -eq "$null")))
{
    Write-Host "Install Updated Module"
    Uninstall-Module -Name "ExchangeOnlineManagement"

    Install-Module -Name "ExchangeOnlineManagement"
    
}
else
{
    Write-Output "Importing ExchangeOnlineManagement"
    Import-Module ExchangeOnlineManagement
}




#| Select-Object Name
#-eq "$null"