# ExchangeOnlineManagement
if(((Get-InstalledModule | Where-Object {($_.Name -eq "ExchangeOnlineManagement") -AND ($_.Version -ge "3.1.0")}) -eq "$null"))
{
    Uninstall-Module -Name "ExchangeOnlineManagement"
    Install-Module -Name "ExchangeOnlineManagement"
    
}
else
{
    Write-Output "Importing ExchangeOnlineManagement"
    Import-Module ExchangeOnlineManagement
}