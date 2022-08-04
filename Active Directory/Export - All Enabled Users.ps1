# Export all ENABLED users
#
Import-Module ActiveDirectory
Get-ADUser -Filter {Enabled -eq $true} -Properties DisplayName, SamAccountName, EmailAddress, Company, Title, LastLogon, PasswordLastSet | Select-Object DisplayName, SamAccountName, EmailAddress, Title,@{n='LastLogon';e={[DateTime]::FromFileTime($_.LastLogon)}},@{n='PasswordLastSet';e={[DateTime]::FromFileTime($_.LastLogon)}} | Export-CSV "Export - All AD Users.csv"