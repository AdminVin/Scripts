# Will export a list of all users in AD to a CSV file (User, Email, and Title)
#
Import-Module ActiveDirectory
Get-ADUser -Filter * -Properties DisplayName, SamAccountName, EmailAddress, Title, LastLogonTimeStamp, Enabled, passwordlastset | select DisplayName, SamAccountName, EmailAddress, Title, LastLogonTimeStamp, Enabled | Export-CSV "Export - All AD Users.csv"