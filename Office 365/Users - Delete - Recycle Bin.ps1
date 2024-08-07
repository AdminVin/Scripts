# PowerShell 5.1 Required

# Connect MSOL
Connect-MSOLService

# User - View all users in 'Recycle Bin'
Get-MsolUser -ReturnDeletedUsers -All

# User - Delete
Remove-MsolUser -UserPrincipalName USER@DOMAIN.COM

# User - Delete specific user from Recycle Bin
Remove-MsolUser -UserPrincipalName USER@DOMAIN.COM -RemoveFromRecycleBin
