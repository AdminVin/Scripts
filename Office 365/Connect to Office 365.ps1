### MFA Enabled Office 365 Tenants
# Prerequisities
Set-ExecutionPolicy Unrestricted
Install-Module MSOnline
Install-Module AzureADPreview
Install-Module ExchangeOnlineManagement

# Connect
Connect-EXOPSSession

# Connect with Compliance Search
Connect-IPPSSession -UserPrincipalName GlobalAdministrator@DOMAIN.com

# Connect with MSOL Module
Connect-MsolService

# Office 365 (Alternative Method)
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline
Connect-IPPSSession -UserPrincipalName GlobalAdministrator@DOMAIN.com