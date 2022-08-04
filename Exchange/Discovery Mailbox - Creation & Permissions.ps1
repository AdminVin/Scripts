### Exchange 2016
# Create Mailbox
New-Mailbox -Name "1367424" -Discovery

## Add Permissions
# Syntax Example
Add-MailboxPermission "Discovery Mailbox" -User "User needing permission" -AccessRights FullAccess -InheritanceType all
# Actual Example
Add-MailboxPermission -Identity "g46be88234c4a4f32a2041b7a331538f2@DOMAIN.com" -User "administrator@DOMAIN.com" -AccessRights FullAccess -InheritanceType all

# Get list of all Discovery Mailboxes
Get-Mailbox –RecipientTypeDetails DiscoveryMailbox | Format-Table Name