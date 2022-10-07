# Connect to Office 365
Connect-MsolService

# Return List of all users in Recycle Bin
Get-Msoluser -ReturnDeletedUsers

# Remove specific user from Recycle Bin
Remove-MsolUser -UserPrincipalName user@DOMAIN.com -RemoveFromRecycleBin
