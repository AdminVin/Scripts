# View - Specific User
Get-Mailbox USER@DOMAIN.COM | Select-Object UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForward

# View - All Users
Get-Mailbox | Select-Object UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForward

# View - Export to CSV
Get-Mailbox -Filter {(ForwardingAddress -ne $null) -OR (DeliverToMailboxAndForward -ne $null)} -ResultSize Unlimited -RecipientTypeDetails UserMailbox | Select-Object UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | Export-CSV AllForwardedEmail.csv

# Set - Forwarding to another email, WITHOUT leaving a copy in the mailbox
Set-Mailbox user@DOMAIN.com -ForwardingSMTPAddress "ForwardedUser@DOMAIN.com"

# Set - Forwarding to another email, WITH leaving a copy in the mailbox
Set-Mailbox user@DOMAIN.com -DeliverToMailboxAndForward $true -ForwardingSMTPAddress "ForwardedUser@DOMAIN.com"

# Disable - Forwarding
Set-Mailbox user@DOMAIN.com -DeliverToMailboxAndForward $False -ForwardingAddress $Null

# Verify - Forwarding status
Get-Mailbox user@DOMAIN.com | Select-Object UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward

# Forwarding Bug: Turn on, and then turn off
Set-Mailbox user@DOMAIN.com -DeliverToMailboxAndForward $true -ForwardingSMTPAddress "ForwardedUser@DOMAIN.com"
Set-Mailbox user@DOMAIN.com -DeliverToMailboxAndForward $False -ForwardingAddress $Null