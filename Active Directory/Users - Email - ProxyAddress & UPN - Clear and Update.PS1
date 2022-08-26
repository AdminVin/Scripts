$Username = Read-Host -Prompt 'Please enter the USERNAME'
$ProxyOLD = "@adminvinOLD.com"
$ProxyNEW = "@adminvinNEW.com"
Import-Module ActiveDirectory
Set-AdUser -Identity $Username -Clear ProxyAddresses
Set-ADUser -Identity $Username -Add @{Proxyaddresses="SMTP:"+$Username+$ProxyNEW}
Set-ADUser -Identity $Username -Add @{Proxyaddresses="smtp:"+$Username+$ProxyOLD}
Set-ADUser -Identity $Username -UserPrincipalName $Username+$ProxyNEW
pause