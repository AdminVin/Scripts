# Export all users with last login timestamp
Import-Module ActiveDirectory
get-aduser –filter * -property * | Select-object Name, UserPrincipalName, LastLogonDate | Export-Csv Users-ExportAllUserswithLastLogonDate.csv