# Connect MSOL
Connect-MSOLService

# User - View all users in 'Recycle Bin'
Get-MsolUser -ReturnDeletedUsers

# User - Delete
Remove-MsolUser -UserPrincipalName USER@DOMAIN.COM

# User - Delete and remove from Recycle Bin
Remove-MsolUser -UserPrincipalName USER@DOMAIN.COM -RemoveFromRecycleBin


