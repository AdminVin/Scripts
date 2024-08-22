# This is for changing the UPN of a user account that is NOT DirSynced.
# Connect MSOL
Connect-MsolService

# Change UPN
Set-MsolUserPrincipalName -NewUserPrincipalName userNEW@DOMAIN.com -UserPrincipalName userOLD@DOMAIN.com