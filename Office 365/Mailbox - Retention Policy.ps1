# Connect
Connect-ExchangeOnline

# Retention Policies - View All Available
Get-RetentionPolicy | Select-Object Name, Description, RetentionPolicyTagLinks | Format-Table -AutoSize

<#
Example Output:
Name                            Description RetentionPolicyTagLinks
----                            ----------- -----------------------
Default MRM Policy                          {Custom - Set Folder - Delete (5 Years), Custom - Entire Mailbox - Archive (...
COMPANY Default Archive                     {Custom - Set Folder - Delete (5 Years), Custom - Entire Mailbox - Archive (...
Company ADMIN Admin (keep for two years)    {Archive after 2 years}
#>

# Retention Policy - Set for specific user
Set-Mailbox -Identity USER@DOMAIN.com -RetentionPolicy "COMPANY Default Archive"

# Retention Policy - View for a specific user
Get-Mailbox -Identity USER@DOMAIN.com | Select-Object RetentionPolicy | Format-Table -AutoSize

<#
Example Output:
RetentionPolicy
---------------
COMPANY Default Archive
#>