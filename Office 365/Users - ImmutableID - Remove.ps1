# This is for removing the ImmutableID and to attempt to DirSync the user to the in cloud account
#
Connect-MsolService
Set-MSOLUser -UserPrincipalName user@DOMAIN.com -ImmutableID $null