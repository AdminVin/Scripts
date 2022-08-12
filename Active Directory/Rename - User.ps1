#region Modules
Import-Module ActiveDirectory

#endregion

#region Varibles / Settings
Set-PSDebug -Off
$Domain = "@DOMAIN.com"
$MicrosoftDomain = "@DOMAIN.onmicrosoft.com"
$UsernameOLD = Read-Host "Please enter in the EXISTING username for the user you wish to rename"
CLS

#endregion


#region Old Account Information
Write-Host "*****************************" -ForegroundColor Red
Write-Host "* EXISTING USER INFORMATION *" -ForegroundColor Red
Write-Host "*****************************" -ForegroundColor Red


Get-ADUser $UsernameOLD -Properties UserPrincipalName,employeeNumber,ProxyAddresses | Select-Object Enabled,Samaccountname,GivenName,Surname,employeeNumber,@{Name='PrimarySMTPAddress';Expression={$_.ProxyAddresses -cmatch '^SMTP:' -creplace 'SMTP:'}} 
$EmailOLD = Get-ADUser $UsernameOLD -Properties ProxyAddresses | Select-Object @{Name='PrimarySMTPAddress';Expression={$_.ProxyAddresses -cmatch '^SMTP:' -creplace 'SMTP:'}} 
Write-Host "Please verify the correct is listed above." -ForegroundColor Yellow

#endregion


#region New Account Information
Write-Host " "
Write-Host "************************" -ForegroundColor Red
Write-Host "* NEW USER INFORMATION *" -ForegroundColor Red
Write-Host "************************" -ForegroundColor Red
Write-Host " "
$FirstNameNEW = Read-Host "Please enter in the NEW first name"
$LastNameNEW = Read-Host "Please enter in the NEW last name"
$UsernameNEW = $FirstNameNEW + "." + $LastNameNEW
$EmailNEW = $UsernameNEW+$Domain
Write-Host " "
Write-Host "New Account Name:"$UsernameNEW -ForegroundColor Yellow
Write-Host "New Email Address:"$EmailNEW -ForegroundColor Yellow

#endregion


#region Process Changes
# User Prinicipal Name [Account Tab]
Get-ADUser $UsernameOLD | Set-ADUser -UserPrincipalName $UsernameNew$Domain
Set-ADUser $UsernameOLD -Replace @{samaccountname=$UsernameNEW}

# Update Name [General Tab]
Set-ADUser $UsernameNEW -GivenName $FirstNameNEW -Surname $LastNameNEW -DisplayName $FirstNameNEW" "$LastNameNEW
Get-Aduser $UsernameNEW | Rename-ADObject -NewName "$FirstNameNEW $LastNameNEW"

# User Login [Local Account on Local System] / Not relevant for AD Enviroment
# Rename-LocalUser -Name $UsernameOLD -NewName $UsernameNEW

# Email [Attribute Editor Tab > mail]
Set-ADUser -Identity $UsernameNEW -Email $EmailNEW

# Proxy Addresses [Attribute Editor Tab > Proxy Addresses]
$ProxyAddressOLD = $UsernameOLD+$MicrosoftDomain
$ProxyAddressOLD2 = $UsernameOLD+$Domain
$ProxyAddressNEW = $EmailNEW
$ProxyAddressNEW2 = $UsernameNEW+$MicrosoftDomain

Set-ADUser -Identity $UsernameNEW -Clear ProxyAddresses
Set-ADUser -Identity $UsernameNEW -Add @{Proxyaddresses="smtp:"+$ProxyAddressOLD}
Set-ADUser -Identity $UsernameNEW -Add @{ProxyAddresses="smtp:"+$ProxyAddressOLD2}
Set-ADUser -Identity $UsernameNEW -Add @{ProxyAddresses="SMTP:"+$ProxyAddressNEW}
Set-ADUser -Identity $UsernameNEW -Add @{ProxyAddresses="smtp:"+$ProxyAddressNEW2}

#endregion