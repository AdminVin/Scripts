# ExchangeOnlineManagement
if(((Get-InstalledModule | Where-Object {($_.Name -eq "ExchangeOnlineManagement") -AND ($_.Version -ge "3.1.0")} -eq "$null")))
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



#Get-InstalledModule | Where-Object {($_.Name -eq "ExchangeOnlineManagement") -AND ($_.Version -ge "3.1.0")} -eq "$null"