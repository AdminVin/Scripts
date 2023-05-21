# User will need have the licensing Exchange Online 2 at minimum.

# Install/Import Module
Install-Module -Name ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
# Connect to Office 365
Connect-ExchangeOnline

# Enable Auto Expanding Archive
Enable-Mailbox USER@DOMAIN.com -AutoExpandingArchive
# Force start auto expanding archive on the mailbox immediately, rather than wait to start on the next scheduled time.
Start-ManagedFolderAssistant -Identity USER@DOMAIN.com

# Verify Auto Expanding Archive is Enabled
Get-Mailbox USER@DOMAIN.com | Format-List AutoExpandingArchiveEnabled
