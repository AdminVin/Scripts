#region Modules
Import-Module ActiveDirectory
#endregion

#region Varibles
# Pull from AD
$UsernameOLD = Read-Host "Please enter in the existing username"
$FirstNameOLD = Get-ADUser -Filter * -Properties GivenName | Where-Object { $UsernameOLD -contains $_.SamAccountName } | Select-Object GivenName
Write-Output "First Name:"
Write-Output $FirstNameOLD
$LastNameOLD = Get-ADUser -Filter * | Where-Object { $UsernameOLD -contains $_.SamAccountName } | Select-Object sn
Write-Output "Last Name:"
Write-Output $LastNameOLD
$EmailOLD = Get-ADUser -Filter * | Where-Object { $UsernameOLD -contains $_.SamAccountName } | Select-Object Email
Write-Output "Email:"
Write-Output $EmailOLD
$ProxyAddressOLD = Get-ADUser -Filter * -Properties ProxyAddresses | Where-Object { $UsernameOLD -contains $_.SamAccountName } | Select-Object proxyAddress
Write-OutPut "ProxyAddress:"
Write-Output $ProxyAddressOLD

# Pull from CSV
$FirstNameNEW
$LastNameNEW
$UsernameNEW
$ProxyAddressNEW

#endregion

#region Process Changes
# Change User Principal Name
#Get-ADUser $UsernameOLD | Set-ADUser -UserPrincipalName $UsernameNew

# User Login name (pre-Windows 2000) [Account Tab > User Login Name]
#Rename-LocalUser -Name $UsernameOLD -NewName $UsernameNEW

# Update Email [General Tab > Email]
#Set-ADUser -Identity $UsernameNew -Email $UsernameNew.userPrincipalName

#endregion