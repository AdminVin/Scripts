# This is for changing the UPN of a user account that is NOT DirSynced.

# Install Modules
Install-Module AzureAD
Install-Module AzureADPreview
Install-Module MSOnline

# Connect MSOL
Connect-MsolService

# Change UPN
Set-msoluserprincipalname -newuserprincipalname userNEW@DOMAIN.com -userprincipalname userOLD@DOMAIN.com