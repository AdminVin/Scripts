# View Current Restrictions
Get-Mailbox USER@DOMAIN.COM | Select-Object AcceptMessagesOnlyFrom 

<# 
# Output for all email addresses
AcceptMessagesOnlyFrom
----------------------
{}

# Output for only administrator
AcceptMessagesOnlyFrom
----------------------
{Admin}

#>
# Set Restrictions
Set-Mailbox USER@DOMAIN.COM -AcceptMessagesOnlyFrom administrator@DOMAIN.COM

# Clear Restrictions
Set-Mailbox USER@DOMAIN.COM -AcceptMessagesOnlyFrom $Null