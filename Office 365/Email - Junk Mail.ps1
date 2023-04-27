# View Current Config
Get-MailboxJunkEmailConfiguration user@DOMAIN.com 

# Disable Junk Mail Filter
Set-MailboxJunkEmailConfiguration user@DOMAIN.com -Enabled $false

# Enable Junk Mail Filter (Default)
Set-MailboxJunkEmailConfiguration user@DOMAIN.com -Enabled $true