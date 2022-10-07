#region Varibles
# Date
$Date = Get-Date -UFormat "%m/%d/%Y"

# Days to Exclude
# 365 = 1 Year | 730 = 2 Years
$LastLogonDate= (Get-Date).AddDays(-730)

# Active Computer OUs
$OUAdmin = "OU=Computers,OU=Administration,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite1 = "OU=Computers,OU=Site1,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite2 = "OU=Computers,OU=Site2,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite3 = "OU=Computers,OU=Site3,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite4 = "OU=Computers,OU=Site4,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite5 = "OU=Computers,OU=Site5,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite6 = "OU=Computers,OU=Site6,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite7 = "OU=Computers,OU=Site7,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite8 = "OU=Computers,OU=Site8,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite9 = "OU=Computers,OU=Site9,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite10 = "OU=Computers,OU=Site10,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite11 = "OU=Computers,OU=Site11,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite12 = "OU=Computers,OU=Support Office,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"
$OUSite13 = "OU=Computers,OU=Site13,OU=ParentCompany,DC=DOMAIN,DC=LOCAL"

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
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUAdmin | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUAdminDisabled

# Site1 / Catchall
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite1 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite1Disabled

# Site2
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite2 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite2Disabled

# Site3
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite3 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite3Disabled

# Site4
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite4 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite4Disabled

# Site5
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite5 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite5Disabled

# Site6
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite6 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite6Disabled

# Site7
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite7 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite7Disabled

# Site8
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite8 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite8Disabled

# Site9
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite9 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite9Disabled

# Site10
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite10 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite10Disabled

# Site11
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite11 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite11Disabled

# Site12
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite12 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite12Disabled

# Site13
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $OUSite13 | Set-ADComputer -Description "Updated $Date" | Disable-ADAccount | Move-ADObject -TargetPath $OUSite13Disabled
#endregion