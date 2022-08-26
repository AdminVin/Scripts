Import-Module ActiveDirectory
$site = Read-Host "Please enter the OU"
$userou = "OU=Users,OU=$site,OU=ParentCompany,DC=DOMAIN,DC=local"
$users = Get-ADUser -Filter * -SearchBase $userou -Properties SamAccountName, userPrincipalName

Foreach ($user in $users) {
If ($user.UserPrincipalName -like "*DOMAIN.local") {
}
Else {
    Set-ADUser -Identity $user.samaccountname -Email $user.userPrincipalName
    }
    }