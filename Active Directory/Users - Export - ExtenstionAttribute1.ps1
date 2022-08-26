#region Modules
Import-Module ActiveDirectory
#endregion

Get-ADUser -Filter {(enabled -eq $true)} -SearchBase "dc=DOMAIN,dc=local" -Properties Samaccountname,employeeType,displayName,givenName,sn,Company,title,extensionAttribute1 | Select-Object Samaccountname,employeeType,displayName,givenName,sn,Company,title,extensionAttribute1 | Export-CSV Users-ExportwithoutExtenstionAttribute1.csv