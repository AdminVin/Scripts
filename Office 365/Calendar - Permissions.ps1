# Add - User to Calendar
Add-MailboxFolderPermission -Identity "UserCalendar@DOMAIN.com:\Calendar" -User "UserGettingAccessToCalendar@DOMAIN.com" -AccessRights Editor

# Remove - User from Calendar
Remove-MailboxFolderPermission -Identity "UserCalendar@DOMAIN.com:\Calendar" -User "UserGettingAccessToCalendar@DOMAIN.com"