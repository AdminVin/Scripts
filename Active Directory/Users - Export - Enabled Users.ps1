#region Notes
# Export all ENABLED users
#endregion

#region Modules
Import-Module ActiveDirectory
#endregion

#region Process Accounts
Get-ADUser -Filter {Enabled -eq $true} -Properties DisplayName, SamAccountName, EmailAddress, Company, Title, LastLogon, PasswordLastSet | Select-Object DisplayName, SamAccountName, EmailAddress, Title,@{n='LastLogon';e={[DateTime]::FromFileTime($_.LastLogon)}},@{n='PasswordLastSet';e={[DateTime]::FromFileTime($_.LastLogon)}} | Export-CSV "Users-Export-EnabledUsers.csv"
#endregion