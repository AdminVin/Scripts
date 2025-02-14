###########################
# PowerShell 5.1 Required #
###########################
# Connect MSOL
Connect-MSOLService


## Remove by UserPrincipalName
# User - View all users in Recycle Bin
Get-MsolUser -ReturnDeletedUsers -All

# User - Delete specific user from Recycle Bin
Remove-MsolUser -UserPrincipalName USER@DOMAIN.COM -RemoveFromRecycleBin

#####################################################################
## Remove by Object ID
# User - View all users in Recycle Bin
Get-MsolUser -ReturnDeletedUsers -All | Select-Object UserPrincipalName, ObjectId

# User - Delete specific user from Recycle Bin
Remove-MsolUser -ObjectId 2dfc2555-1cd4-414b-9e40-0641a6d0998d -RemoveFromRecycleBin