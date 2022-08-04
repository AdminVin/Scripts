# Install Modules
install-module AzureAD
install-module AzureADPreview
install-module MSOnline

# Connect MSOL
Connect-MsolService

# Change UPN
Set-msoluserprincipalname -newuserprincipalname userNEW@DOMAIN.com -userprincipalname userOLD@DOMAIN.com