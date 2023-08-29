# User will need have the licensing Exchange Online 2 at minimum.

# Install/Import Module/Connect
Install-Module -Name ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

# Enable Auto Expanding Archive
Enable-Mailbox USER@DOMAIN.com -AutoExpandingArchive
# Verify Auto Expanding Archive is Enabled
Get-Mailbox USER@DOMAIN.com | Format-List AutoExpandingArchiveEnabled

# Force start auto expanding archive on the mailbox immediately, rather than wait to start on the next scheduled interval.
Start-ManagedFolderAssistant -Identity USER@DOMAIN.com -FullCrawl


## Complance Hold Tag
# If archiving has not started and 24 hours has passed, there can be a 'Compliance Hold Tag' on the mailbox.  This can only be removed from Microsoft's end as of 2023/08/29.
#
## RetentionHoldEnabled
# You can also check the mailbox to see if it has "RetentionHoldEnabled" to $true.  If it set to $true it will not permit retention policies to run.
# Check Mailbox
Get-Mailbox USER@DOMAIN.com | Select-Object RetentionHoldEnabled
# Remove Retention Hold
Set-Mailbox USER@DOMAIN.com -RetentionHoldEnabled $false