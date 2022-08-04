$AllOffice365Users = Import-CSV CreateNewUsers-InCloud.CSV
$AllOffice365Users | ForEach-Object {New-MsolUser -UserPrincipalName $_.UserPrincipalName -DisplayName $_.DisplayName -Password $_.Password}