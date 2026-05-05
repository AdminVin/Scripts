# Connect to Office 365 & MSOL
Connect-ExchangeOnline
Connect-MsolService

# Useful for identifying the error cause when viewing a mailbox under Office 365 > Exchange and there is a error like below
# Exchange: An unknown error has occurred. Refer to correlation ID: b9dcb780-a885-43e7-a85e-905fa177af88.;

# User Specific Error
(Get-MsolUser -UserPrincipalName USERNAME@DOMAIN.COM
).errors[0].ErrorDetail.objecterrors.errorrecord.ErrorDescription

# All Users with Errors
Get-MsolUser -HasErrorsOnly | Format-Table DisplayName,UserPrincipalName,@{Name="Error";Expression={($_.errors[0].ErrorDetail.objecterrors.errorrecord.ErrorDescription)}} -AutoSize