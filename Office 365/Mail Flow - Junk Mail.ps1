# View Current Config
Get-MailboxJunkEmailConfiguration user@DOMAIN.com 

# Disable Junk Mail Filter
Set-MailboxJunkEmailConfiguration user@DOMAIN.com -Enabled $false

# Enable Junk Mail Filter (Default)
Set-MailboxJunkEmailConfiguration user@DOMAIN.com -Enabled $true


<# NOTE 

This command WILL technically work in Office 365.

However, the Anti-Spam policy will still dicate what goes into the junk mail folder regardless set to $true or $false.

Source: https://learn.microsoft.com/en-us/powershell/module/exchange/set-mailboxjunkemailconfiguration?view=exchange-ps


 In Exchange Online, the safelist collection of the mailbox is unable to move messages between the Inbox and the Junk Email folder. Messages are still delivered to the Junk Email folder based on the verdict and corresponding action of anti-spam policies.
#>