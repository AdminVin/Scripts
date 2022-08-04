#region Modules
Import-Module ActiveDirectory
#endregion

#region Varibles
# Pull from AD
#$UsernameOLD = Read-Host "Please enter in the existing username"
cls
$UsernameOLD = "vincent.briffa"
$NameOLD = Get-ADUser -Identity $UsernameOLD -Properties EmailAddress | Select-Object GivenName, Surname
$FirstNameOLD = Get-ADUser -Identity $UsernameOLD -Properties EmailAddress | Select-Object GivenName
$LastNameOLD = Get-ADUser -Identity $UsernameOLD -Properties EmailAddress | Select-Object Surname
$EmailOLD = Get-ADUser $UsernameOLD -Properties EmailAddress | Select-Object EmailAddress
Write-Output "Username (Existing): " $UsernameOLD
Write-Output " "
Write-Output "Name (Existing): " $NameOLD
Write-Output " "
Write-Output "Email (Existing): " $EmailOLD
Write-Output "First Name: " $FirstNameOLD
Write-Output "Last Name: " $LastNameOLD

$FirstNameNEW = Read-Host "Please enter in the NEW first name"
$LastNameNEW = Read-Host "Please enter in the NEW last name"

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