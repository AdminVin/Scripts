# Add Permissions
# -AccessRights can be Owner or Editor
Add-PublicFolderClientPermission -Identity "\Corporate Contacts" -User "user@DOMAIN.com" -AccessRights Editor

# Remove Permissions
Remove-PublicFolderClientPermission -Identity "\Corporate Contacts" -User "user@DOMAIN.com"