#region Notes
# This will export a list of all users (enabled/disabled) in AD to a CSV file.
# CSV Fields (Display Name, Enabled/Disabled, Username, Email, Title, and LastLogonDate)
#endregion

#region Modules
Import-Module ActiveDirectory
#endregion

#region Process Accounts
Get-ADUser -Filter * -Properties DisplayName, Enabled, SamAccountName, EmailAddress, Company, Title, LastLogonDate | Select-Object DisplayName, Enabled, SamAccountName, EmailAddress, Company, Title, LastLogonDate | Export-CSV "Users-Export-AllUsers.csv"
#endregion