# Connect
Connect-ExchangeOnline

# Show all rules (including hidden)
Get-InboxRule -Mailbox USER@DOMAIN.com -IncludeHidden

<#
Example Output:
Name                               Enabled Priority RuleIdentity
----                               ------- -------- ------------
Delegate Rule -4035572715992645630 True    0        14411171357716905986
Junk E-mail Rule                   True    0        14339113763678978050
#>

# Remove
Remove-InboxRule -Mailbox USER@DOMAIN.com -Identity "RuleIdentity"