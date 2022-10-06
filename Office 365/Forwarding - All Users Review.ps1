# Specific User
Get-Mailbox -Identity "user@DOMAIN.com" | Select-Object UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForwardSelect-Object

# All Users
Get-Mailbox | Select-Object UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForward

# All Users & Export to CSV (Under 1000 Users)
Get-Mailbox | Select-Object UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | Export-csv .\users.csv -NoTypeInformation

# All Users & Export to CSV (Forwarding Only Users)
Get-Mailbox -Filter {ForwardingAddress -ne $null} | Select-Object UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | Export-Csv AllForwardedEmail.csv

Get-Mailbox -Filter {ForwardingAddress -ne $null} -ResultSize Unlimited -RecipientTypeDetails UserMailbox | Select-Object UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | Export-CSV AllForwardedEmail.csv