#region Modules
Import-Module ActiveDirectory
#endregion

#region Varibles
Set-PSDebug -Off
CLS
#$UsernameOLD = Read-Host "Please enter in the EXISTING username for the user you wish to rename"
$UsernameOLD = "test.acccount"
$NameOLD = Get-ADUser $UsernameOLD -Properties UserPrincipalName | Select-Object GivenName, Surname
$FirstNameOLD = Get-ADUser $UsernameOLD -Properties UserPrincipalName | Select-Object GivenName
$LastNameOLD = Get-ADUser $UsernameOLD -Properties UserPrincipalName | Select-Object Surname
$EmailOLD = Get-ADUser $UsernameOLD -Properties EmailAddress | Select-Object EmailAddress
Write-Host "Existing Account Information | Username: "$UsernameOLD " | First Name: "$FirstNameOLD "Last Name: "$LastNameOLD " | Email: "$EmailOLD -ForegroundColor Gray -BackgroundColor Red


$FirstNameNEW = Read-Host "Please enter in the NEW first name"
$LastNameNEW = Read-Host "Please enter in the NEW last name"


$ProxyAddressOLD = Get-ADUser -Filter * -Properties ProxyAddresses | Where-Object { $UsernameOLD -contains $_.SamAccountName } | Select-Object proxyAddress
Write-OutPut "ProxyAddress:"
Write-Output $ProxyAddressOLD



#endregion

#region Process Changes
# Change User Principal Name
#Get-ADUser $UsernameOLD | Set-ADUser -UserPrincipalName $UsernameNew

# User Login name (pre-Windows 2000) [Account Tab > User Login Name]
#Rename-LocalUser -Name $UsernameOLD -NewName $UsernameNEW

# Update Email [General Tab > Email]
#Set-ADUser -Identity $UsernameNew -Email $UsernameNew.userPrincipalName

#endregion