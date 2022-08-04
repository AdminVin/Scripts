Import-Module ActiveDirectory

$newproxy = "@adminvin.com"
$userou = 'OU=Users,OU=Company,OU=ParentCompany,DC=DOMAIN,DC=local'
$users = Get-ADUser -Filter * -SearchBase $userou -Properties SamAccountName, ProxyAddresses 


Foreach ($user in $users) {
    Set-ADUser -Identity $user.samaccountname -Add @{Proxyaddresses="SMTP:"+$user.samaccountname+$newproxy}
    } 