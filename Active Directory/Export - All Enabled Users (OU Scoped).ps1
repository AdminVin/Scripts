# This script will export all user accounts in AD (scoped to an OU) to a CSV that are Enabled.
#
# Update OU Location
#
# $OUpath = 'OU=Staff,OU=Company,OU=ParentCompany,DC=DOMAIN,DC=local'

Import-Module ActiveDirectory
$OUpath = 'OU=Staff,OU=Company,OU=ParentCompany,DC=DOMAIN,DC=local'
Get-ADUser -Filter * -Properties * -SearchBase $OUpath | Select-object Name,UserPrincipalName,Enabled,LastLogonDate | Export-Csv Export.csv