# View - Specific User
Get-Mailbox USER@DOMAIN.COM | Select-Object UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForward

# View - All Users with Forwarding Enabled
Get-Mailbox -ResultSize Unlimited | Where-Object {($_.DeliverToMailboxAndForward -like "True") -AND ($_.ForwardingSMTPAddress -notlike $null)} | Select-Object UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForward

# View - All Users with Forwarding Enabled | Export to CSV
Get-Mailbox -ResultSize Unlimited | Where-Object {($_.DeliverToMailboxAndForward -like "True") -AND ($_.ForwardingSMTPAddress -notlike $null)} | Select-Object UserPrincipalName,ForwardingSMTPAddress,DeliverToMailboxAndForward | Export-CSV "Forwarding-AllUserswithForwardingEnabled.csv"

# Set - Forwarding to another email, WITHOUT leaving a copy in the mailbox
Set-Mailbox USER@DOMAIN.COM -ForwardingSMTPAddress "ForwardedUSER@DOMAIN.COM"

# Set - Forwarding to another email, WITH leaving a copy in the mailbox
Set-Mailbox USER@DOMAIN.COM -DeliverToMailboxAndForward $true -ForwardingSMTPAddress "ForwardedUSER@DOMAIN.COM"

# Disable - Forwarding
Set-Mailbox USER@DOMAIN.COM -DeliverToMailboxAndForward $False -ForwardingAddress $Null

# Verify - Forwarding Status
Get-Mailbox USER@DOMAIN.COM | Select-Object UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward

# Forwarding Bug: Turn on, and then turn off
Set-Mailbox USER@DOMAIN.COM -DeliverToMailboxAndForward $true -ForwardingSMTPAddress "ForwardedUSER@DOMAIN.COM"
Set-Mailbox USER@DOMAIN.COM -DeliverToMailboxAndForward $False -ForwardingAddress $Null