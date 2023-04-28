### Office 365
# Connect
Connect-EXOPSSession
Connect-IPPSSession -UserPrincipalName GlobalAdministrator@DOMAIN.com

# Office 365 (Alternative Method)
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline
Connect-IPPSSession -UserPrincipalName GlobalAdministrator@DOMAIN.com

### Exchange 2016
# Create Search (with single word)
New-ComplianceSearch -Name "SearchID" -ExchangeLocation All -ContentMatchQuery "'SearchTerm'"

# Create Search (with two words, searching for either word in the message)
New-ComplianceSearch -Name “SearchID” -ExchangeLocation All -ContentMatchQuery '“SearchTerm" OR "SearchTerm2”'

# Create Search (with two words, searching for both in the message)
New-ComplianceSearch -Name “SearchID” -ExchangeLocation All -ContentMatchQuery '“SearchTerm" AND "SearchTerm2”'

# Start Search
Start-ComplianceSearch -Identity "SearchID"
# View Results
Get-ComplianceSearch -Identity "SearchID" | Format-List

### Purge
#SoftDelete (Recovereable)
New-ComplianceSearchAction -SearchName "SearchID" -Purge -PurgeType SoftDelete
# HardDelete (Not Recoverable)
New-ComplianceSearchAction -SearchName "SearchID" -Purge -PurgeType HardDelete
# Check Status of all searches
Get-ComplianceSearch

# Stop Search
Stop-ComplianceSearch "SearchID"