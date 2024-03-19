<# Notes
Compliance Permissions Needed:
Navigate to https://compliance.microsoft.com/ > Permissions > Microsoft Purview Solutions, select "Roles" > select "eDiscovery Manager" > Add User
#>


### Connect
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline
# Requires role "Organization Management" role in Office 365 (Exchange Admin > Roles > Admin Roles > Organization Management > Assigned > Add > Search by display name)
Connect-IPPSSession -UserPrincipalName GlobalAdministrator@DOMAIN.com

## Create
# Create search and paramaters at https://compliance.microsoft.com/contentsearchv2?viewid=search

### Purge
## Delete
#SoftDelete (Recovereable)
New-ComplianceSearchAction -SearchName "SearchID" -Purge -PurgeType SoftDelete
# HardDelete (Not Recoverable)
New-ComplianceSearchAction -SearchName "SearchID" -Purge -PurgeType HardDelete

## Misc
# Check Status of all searches
Get-ComplianceSearch
# Stop Search
Stop-ComplianceSearch "SearchID"