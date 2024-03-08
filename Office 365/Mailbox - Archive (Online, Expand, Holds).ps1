### Prerequisites 
# User will need have the licensing Exchange Online 2 at minimum.


### Connect to Office 365
Connect-ExchangeOnline


## Auto Expanding Archive
Enable-Mailbox USER@DOMAIN.com -AutoExpandingArchive                            # Enable
Get-Mailbox USER@DOMAIN.com | Format-List AutoExpandingArchiveEnabled           # Verify
Start-ManagedFolderAssistant -Identity USER@DOMAIN.com -FullCrawl               # Force start auto archiving immediately, and not wait for scheduled start.

# "-FullCrawl"
# The full crawl option ensures that all items in the mailbox are thoroughly examined during this process, even if they have been previously processed. This can be useful in situations where you want to reevaluate and apply policies to all items, not just those that have been modified since the last crawl.


## Compliance Hold Tag
# If archiving has not started and 24 hours has passed, there can be a 'Compliance Hold Tag' on the mailbox. You can check this by identifying if "RetentionHoldEnabled" is set to $true.
Get-Mailbox USER@DOMAIN.com | Select-Object RetentionHoldEnabled
# Disable Retention Hold & Enable Retention Policies
Set-Mailbox USER@DOMAIN.com -RetentionHoldEnabled $false