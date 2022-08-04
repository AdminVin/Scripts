# Specific User
Get-Mailbox -Identity "user@DOMAIN.com" | select UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForward

# All Users
Get-Mailbox | select UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForward

# All Users & Export to CSV (Under 1000 Users)
Get-Mailbox | select UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | Export-csv .\users.csv -NoTypeInformation

# All Users & Export to CSV (Forwarding Only Users)
Get-Mailbox -Filter {ForwardingAddress -ne $null} | select UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | Export-csv AllUsersForwarding.csv
Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails UserMailbox | Select UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | Export-CSV Test.csv