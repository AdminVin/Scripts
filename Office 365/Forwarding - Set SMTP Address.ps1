# Set Forwarding to another mailbox, without leaving a copy
Set-Mailbox -Identity "user@DOMAIN.com" -ForwardingSMTPAddress "ForwaredUser@DOMAIN.com"

# Set Forwarding Address
Set-Mailbox -Identity "user@DOMAIN.com" -DeliverToMailboxAndForward $true -ForwardingSMTPAddress "ForwardedUser@DOMAIN.com"

# Forwarding Bug: Turn on, and then turn off
Set-Mailbox -Identity "user@DOMAIN.com" -DeliverToMailboxAndForward $true -ForwardingSMTPAddress "ForwardedUser@DOMAIN.com"
Set-Mailbox -Identity "user@DOMAIN.com" -DeliverToMailboxAndForward $false

# Verify forwarding status
Get-Mailbox user@DOMAIN.com | select UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward