### MFA Enabled Office 365 Tenants
# Prerequisities
IF(!(Get-Module -Name AzureAD -ListAvailable)){Install-Module -Name AzureAD -Scope CurrentUser -Force;Import-Module AzureAD;Write-Host "AzureAD"} ELSE {Import-Module AzureAD;Write-Host "AzureAD"}
IF(!(Get-Module -Name ExchangeOnlineManagement -ListAvailable)){Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser -Force;Import-Module ExchangeOnlineManagement;Write-Host "ExchangeOnlineManagement"} ELSE {Import-Module ExchangeOnlineManagement;Write-Host "ExchangeOnlineManagement"}
IF(!(Get-Module -Name MSOnline -ListAvailable)){Install-Module -Name MSOnline -Scope CurrentUser -Force;Import-Module MSOnline;Write-Host "MSOnline"} ELSE {Import-Module MSOnline;Write-Host "MSOnline"}

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