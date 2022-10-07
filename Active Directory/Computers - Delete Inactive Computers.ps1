#region Varibles
# Days to Exclude
$LastLogonDate= (Get-Date).AddDays(-730)

# Disabled Computer OUs
$OUAdminDisabled = "OU=Disabled,OU=Computers,OU=Administration,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite1Disabled = "OU=Disabled,OU=Computers,OU=Site1,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite2Disabled = "OU=Disabled,OU=Computers,OU=Site2,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite3Disabled = "OU=Disabled,OU=Computers,OU=Site3,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite4Disabled = "OU=Disabled,OU=Computers,OU=Site4,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite5Disabled = "OU=Disabled,OU=Computers,OU=Site5,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite6Disabled = "OU=Disabled,OU=Computers,OU=Site6,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite7Disabled = "OU=Disabled,OU=Computers,OU=Site7,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite8Disabled = "OU=Disabled,OU=Computers,OU=Site8,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite9Disabled = "OU=Disabled,OU=Computers,OU=Site9,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite10Disabled = "OU=Disabled,OU=Computers,OU=Site10,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite11Disabled = "OU=Disabled,OU=Computers,OU=Site11,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite12Disabled = "OU=Disabled,OU=Computers,OU=Support Office,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite13Disabled = "OU=Disabled,OU=Computers,OU=Site13,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
#endregion


#region Process Computer Objects
# Admin
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUAdminDisabled | Remove-ADComputer -Confirm:$false

# Site1 / Catchall
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite1Disabled | Remove-ADComputer -Confirm:$false

# Site2
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite2Disabled | Remove-ADComputer -Confirm:$false

# Site3
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite3Disabled | Remove-ADComputer -Confirm:$false

# Site4
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite4Disabled | Remove-ADComputer -Confirm:$false

# Site5
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite5Disabled | Remove-ADComputer -Confirm:$false

# Site6
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite6Disabled | Remove-ADComputer -Confirm:$false

# Site7
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite7Disabled| Remove-ADComputer -Confirm:$false

# Site8
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite8Disabled | Remove-ADComputer -Confirm:$false

# Site9
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite9Disabled | Remove-ADComputer -Confirm:$false

# Site10
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite10Disabled | Remove-ADComputer -Confirm:$false

# Site11
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite11Disabled | Remove-ADComputer -Confirm:$false

# Site12
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite12Disabled | Remove-ADComputer -Confirm:$false

# Site13
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite13Disabled | Remove-ADComputer -Confirm:$false
#endregion