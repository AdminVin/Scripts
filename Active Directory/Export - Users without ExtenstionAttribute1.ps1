Import-Module ActiveDirectory
Get-ADUser -Filter {(enabled -eq $true)} -SearchBase "DC=DOMAIN,DC=local" -Properties Samaccountname,displayName,givenName,sn,Company,title,extensionAttribute1 | Select-Object Samaccountname,displayName,givenName,sn,Company,title,extensionAttribute1 |Export-CSV ADExport-ExtensionAttribute1.csv