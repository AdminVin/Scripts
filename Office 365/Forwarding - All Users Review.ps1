# Specific User
Get-Mailbox -Identity "USER@DOMAIN.COM" | Select-Object UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForward

# All Users - View
Get-Mailbox | Select-Object UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForward

# All Users Forwarding Email - Export to CSV
Get-Mailbox -Filter {(ForwardingAddress -ne $null) -OR (DeliverToMailboxAndForward -ne $null)} -ResultSize Unlimited -RecipientTypeDetails UserMailbox | Select-Object UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | Export-CSV AllForwardedEmail.csv