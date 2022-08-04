### Modules
# Active Directory
Import-Module ActiveDirectory

### Varibles
## Update
# UPN Suffix
$UPN = "@adminvin.com"
# Update to root of domain/OU to scope script
$userou = "OU=Users,OU=$site,OU=ParentCompany,DC=DOMAIN,DC=local"
## No Changes Needed
Write-Host "This script is scoped by OU."
$site = Read-Host "Please enter the OU Name"
$users = Get-ADUser -Filter * -SearchBase $userou -Properties SamAccountName, userPrincipalName

### Execution
Foreach ($user in $users) {
    # General > Email
    Set-ADUser -Identity $user.samaccountname -Email $user.userPrincipalName
    GetSet-ADUser -Identity $user.samaccountname -Prope
    # Attribute Editor > Mail
    Set-ADUser -Identity $user.samaccountname @{MailNickName = $user.userPrincipalName}
    Get-ADUser -Identity $user.samaccountname -Property MailNickName
    # Proxy Address
    Set-AdUser -Identity $user.samaccountname -Clear ProxyAddresses
    Set-ADUser -Identity $user.samaccountname -Add @{Proxyaddresses="SMTP:"+$user.userPrincipalName}
    }