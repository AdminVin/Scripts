#region Notes
# Running this will add the user to the proper "Staff-***" distribution list based off their company in AD
#endregion

#region Varibles
$Company1 = "SubCompany1"
$CompanySecurityGroup1 = "Staff-SubCompany1"
#
$Company2 = "SubCompany2"
$CompanySecurityGroup2 = "Staff-SubCompany2"
#
$Company3 = "SubCompany3"
$CompanySecurityGroup3 = "Staff-SubCompany3"
#
$Company4 = "SubCompany4"
$CompanySecurityGroup4 = "Staff-SubCompany4"
#
$Company5 = "SubCompany5"
$CompanySecurityGroup5 = "Staff-SubCompany5"
#
$Company6 = "SubCompany6"
$CompanySecurityGroup6 = "Staff-SubCompany6"
#
$Company7 = "SubCompany7"
$CompanySecurityGroup7 = "Staff-SubCompany7"
#
$Company8 = "SubCompany8"
$CompanySecurityGroup8 = "Staff-SubCompany8"
#
$Company9 = "SubCompany9"
$CompanySecurityGroup9 = "Staff-SubCompany9"
#
$Company10 = "SubCompany10"
$CompanySecurityGroup10 = "Staff-SubCompany10"
#
$Company11 = "SubCompany11"
$CompanySecurityGroup11 = "Staff-SubCompany11"
#
$Company12 = "SubCompany12"
$CompanySecurityGroup12 = "Staff-SubCompany12"
#
$Company13 = "SubCompany13"
$CompanySecurityGroup13 = "Staff-SubCompany13"
#
$Company14 = "SubCompany14"
$CompanySecurityGroup14 = "Staff-SubCompany14"
#endregion

#region Process Accounts/Groups
# SubCompany1
Get-ADUser -Filter {(Company -like $Company1) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup1" -Members $_ }
Get-ADUser -Filter {(Company -like $Company2) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup2" -Members $_ }
# SubCompany2
Get-ADUser -Filter {(Company -like $Company3) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup3" -Members $_ }
# SubCompany4
Get-ADUser -Filter {(Company -like $Company4) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup4" -Members $_ }
# SubCompany5
Get-ADUser -Filter {(Company -like $Company5) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup5" -Members $_ }
# SubCompany6
Get-ADUser -Filter {(Company -like $Company6) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup6" -Members $_ }
# SubCompany7
Get-ADUser -Filter {(Company -like $Company7) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup7" -Members $_ }
# SubCompany8
Get-ADUser -Filter {(Company -like $Company8) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup8" -Members $_ }
# SubCompany9
Get-ADUser -Filter {(Company -like $Company9) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup9" -Members $_ }
# SubCompany10
Get-ADUser -Filter {(Company -like $Company10) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup10" -Members $_ }
# SubCompany11
Get-ADUser -Filter {(Company -like $Company11) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup11" -Members $_ }
# SubCompany12
Get-ADUser -Filter {(Company -like $Company12) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup12" -Members $_ }
# SubCompany13
Get-ADUser -Filter {(Company -like $Company13) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup13" -Members $_ }
# SubCompany14
Get-ADUser -Filter {(Company -like $Company14) -and (extensionAttribute1 -like 'Staff') -and (Enabled -eq 'true')} | ForEach-Object { Add-ADGroupMember -Identity "$CompanySecurityGroup14" -Members $_ }
#endregion