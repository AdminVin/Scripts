# Specify limits for one user
Set-Mailbox user@DOMAIN.com -MaxSendSize 40MB -MaxReceiveSize 40MB

# Specify limits for entire organization
Get-Mailbox | Set-Mailbox -MaxSendSize 40MB -MaxReceiveSize 40MB