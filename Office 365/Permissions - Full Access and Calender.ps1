# Pull what mailboxes the user has full access to
Get-Mailbox | Get-MailboxPermission -User user@DOMAIN.com

# Pull what calendars the user has access to
$user = user@DOMAIN.com
Get-Mailbox | % { Get-MailboxFolderPermission (($_.PrimarySmtpAddress.ToString())+”:\Calendar”) -User $user -ErrorAction SilentlyContinue} | select Identity,User,AccessRights
