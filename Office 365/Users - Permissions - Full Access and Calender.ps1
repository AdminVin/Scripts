# View - All mailboxes the user has full access
Get-Mailbox | Get-MailboxPermission -User user@DOMAIN.com

# Add - Full Access to another mailbox WITH automapping in Outlook
Add-MailboxPermission "MailboxGrantingAccessTo@DOMAIN.com" -User "UserReceivingAccess@DOMAIN.com" -AccessRights FullAccess

# Add - Full Access to another mailbox WITHOUT automapping in Outlook
Add-MailboxPermission "MailboxGrantingAccessTo@DOMAIN.com" -User "UserReceivingAccess@DOMAIN.com" -AccessRights FullAccess -AutoMapping:$False -Confirm:$True

# Remove - Full Access to another mailbox
Remove-MailboxPermission "MailboxGrantingAccessTo@DOMAIN.com" -User "UserReceivingAccess@DOMAIN.com" -AccessRights FullAccess -Confirm:$True

# View - All calendars the user has access to
$user = user@DOMAIN.com
Get-Mailbox | ForEach-Object{Get-MailboxFolderPermission (($_.PrimarySmtpAddress.ToString())+”:\Calendar”) -User $user -ErrorAction SilentlyContinue} | Select-Object Identity,User,AccessRights