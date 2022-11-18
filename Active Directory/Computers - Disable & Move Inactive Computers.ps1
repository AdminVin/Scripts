#region Varibles
# Date
$Date = Get-Date -UFormat "%m/%d/%Y"

# Days to Exclude
# 365 = 1 Year | 730 = 2 Years
$LastLogonDate= (Get-Date).AddDays(-730)

# Active Computer OUs
$Site1 = "OU=Computers,OU=Site1,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$Site2 = "OU=Computers,OU=Site2,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"

# Disabled Computer OUs
$Site1Disabled = "OU=Disabled,OU=Computers,OU=Site1,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$Site2Disabled = "OU=Disabled,OU=Computers,OU=Site2,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
#endregion


#region Process Computer Objects
# Site 1
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $Site1 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount
Get-ADComputer -Filter {(Enabled -eq $False)} -SearchBase $Site1 | Move-ADObject -TargetPath $Site1Disabled

# Site 2
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $Site2 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount
Get-ADComputer -Filter {(Enabled -eq $False)} -SearchBase $Site2 | Move-ADObject -TargetPath $Site2Disabled
#endregion