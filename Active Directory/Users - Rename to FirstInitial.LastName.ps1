#region Settings
Import-Module ActiveDirectory
$LogFile = ".\Users - Rename to FirstName.LastName.txt"
$Domain = "@DOMAIN.org"
$MicrosoftDomain = "@DOMAIN.onmicrosoft.com"
Write-Host "Please enter in the EXISTING username for the user you wish to rename" -ForegroundColor Yellow 
$UsernameOLD = Read-Host "EXISTING Username"
#endregion


#region Old Account Information
Write-Host "***************************************" -ForegroundColor Red
Write-Host "* ACCOUNT - EXISTING USER INFORMATION *" -ForegroundColor Red
Write-Host "***************************************" -ForegroundColor Red
Write-Host " "
Get-ADUser $UsernameOLD -Properties UserPrincipalName,DisplayName,employeeNumber,ProxyAddresses,HomeDirectory | Select-Object Enabled,Samaccountname,DisplayName,GivenName,Surname,employeeNumber,@{Name='PrimarySMTPAddress';Expression={$_.ProxyAddresses -cmatch '^SMTP:' -creplace 'SMTP:'}},HomeDirectory
Write-Host "Please verify the correct is listed above." -ForegroundColor Yellow
#endregion


#region New Account Information
Write-Host " "
Write-Host "**********************************" -ForegroundColor Red
Write-Host "* ACCOUNT - NEW USER INFORMATION *" -ForegroundColor Red
Write-Host "**********************************" -ForegroundColor Red
Write-Host " "
Write-Host "Note: Usernames are updated to proper synxtax after script completes." -ForegroundColor Yellow
Write-Host "Example: If the name 'joseph smith' is entered, it will return as Joseph Smith" -ForegroundColor Yellow
$FirstNameNEWEntered = Read-Host "Please enter in the NEW first name"
$LastNameNEWEntered = Read-Host "Please enter in the NEW last name"
# Convert first and last name to upper case
$FirstNameNew = $FirstNameNEWEntered.substring(0,1).ToUpper()+$FirstNameNewEntered.substring(1).ToLower()
$LastNameNew = $LastNameNEWEntered.substring(0,1).ToUpper()+$LastNameNewEntered.substring(1).ToLower()
# Convert first name to first initial
$FirstInitial = $FirstNameNEWEntered.substring(0,1)
# Combine first and last name to create NEW username
$UsernameNEW = $FirstInitial.ToUpper() + $LastNameNEW
$EmailNEW = $UsernameNEW+$Domain
Write-Host " "
#endregion


#region Log - Old Account Information
## Log (Description)
"OLD ACCOUNT INFORMATION" | Out-File -Append -FilePath $LogFile
## Log (Date)
Get-Date | Out-File -Append -FilePath $LogFile
## Log (Old Account information)
Get-ADUser $UsernameOLD -Properties UserPrincipalName,DisplayName,employeeNumber,ProxyAddresses,HomeDirectory | Select-Object Enabled,Samaccountname,DisplayName,GivenName,Surname,employeeNumber,@{Name='PrimarySMTPAddress';Expression={$_.ProxyAddresses -cmatch '^SMTP:' -creplace 'SMTP:'}},HomeDirectory | Out-File -Append -FilePath $LogFile
#endregion


#region Process Account Changes
# User Prinicipal Name [Account Tab]
Get-ADUser $UsernameOLD | Set-ADUser -UserPrincipalName $UsernameNew$Domain
Set-ADUser $UsernameOLD -Replace @{samaccountname=$UsernameNEW}

# Update Name [General Tab]
Set-ADUser $UsernameNEW -GivenName $FirstNameNEW -Surname $LastNameNEW -DisplayName $FirstNameNEW" "$LastNameNEW
Get-Aduser $UsernameNEW | Rename-ADObject -NewName "$FirstNameNEW $LastNameNEW"
# Write-Host "New Account Name:"$UsernameNEW -ForegroundColor Yellow

# User Login [Local Account on Local System] / Not relevant for AD Enviroment
# Rename-LocalUser -Name $UsernameOLD -NewName $UsernameNEW

# Email [Attribute Editor Tab > mail]
Set-ADUser -Identity $UsernameNEW -Email $EmailNEW
Set-ADUser -Identity $UsernameNEW -Clear mailNickname
Set-ADUser -Identity $UsernameNEW -Add @{mailNickname=$UsernameNEW}
# Write-Host "New Email Address:"$EmailNEW -ForegroundColor Yellow

# Email [Attribute Editor Tab > Target Address]
Set-ADUser -Identity $UsernameNEW -Clear targetAddress
Set-ADUser -Identity $UsernameNEW -Add @{targetAddress=$UsernameNEW+$MicrosoftDomain}
# Write-Host "New Target Email Address:"$UsernameNEW$MicrosoftDomain -ForegroundColor Yellow

# msExchArchiveName [Attribute Editor Tab > mxExchArchiveName]
$msExchArchiveNameNEW = "In-Place Archive -"+" "+$FirstNameNEW.ToUpper()+" "+$LastNameNEW.ToUpper()
Set-ADUser -Identity $UsernameNEW -Clear msExchArchiveName
Set-ADUser -Identity $UsernameNEW -Add @{msExchArchiveName=$msExchArchiveNameNEW}
# Write-Host "New mxExchArchiveName: "$msExchArchiveNameNew -ForegroundColor Yellow

# Proxy Addresses [Attribute Editor Tab > Proxy Addresses]
$ProxyAddressOLD = $UsernameOLD+$MicrosoftDomain
$ProxyAddressOLD2 = $UsernameOLD+$Domain
$ProxyAddressNEW = $EmailNEW
$ProxyAddressNEW2 = $UsernameNEW.ToUpper()+$MicrosoftDomain

Set-ADUser -Identity $UsernameNEW -Clear ProxyAddresses
Set-ADUser -Identity $UsernameNEW -Add @{Proxyaddresses="smtp:"+$ProxyAddressOLD}
Set-ADUser -Identity $UsernameNEW -Add @{ProxyAddresses="smtp:"+$ProxyAddressOLD2}
Set-ADUser -Identity $UsernameNEW -Add @{ProxyAddresses="SMTP:"+$ProxyAddressNEW}
Set-ADUser -Identity $UsernameNEW -Add @{ProxyAddresses="smtp:"+$ProxyAddressNEW2}

# Home Directory [Attribute Editor Tab > homeDirectory]
$NewHomeDir = "C:\users\"+$UsernameNEW.ToUpper()+"\OneDrive - Company Name"
Set-ADUser $UsernameNew -HomeDirectory $NewHomeDir
# Write-Host "New homeDirectory:"$NewHomeDir -ForegroundColor Yellow

# Description
$Date = Get-Date -UFormat "%m/%d/%Y"
Set-ADUser $UsernameNEW -Description "Updated $Date"

# Display - NEW account information
Get-ADUser $UsernameNEW -Properties UserPrincipalName,DisplayName,employeeNumber,ProxyAddresses,HomeDirectory | Select-Object Enabled,Samaccountname,DisplayName,GivenName,Surname,employeeNumber,@{Name='PrimarySMTPAddress';Expression={$_.ProxyAddresses -cmatch '^SMTP:' -creplace 'SMTP:'}},HomeDirectory
#endregion


#region Log - New Account Information
## Log (Description)
"NEW ACCOUNT INFORMATION" | Out-File -Append -FilePath $LogFile
## Log (Date)
Get-Date | Out-File -Append -FilePath $LogFile
## Log (New Account information)
Get-ADUser $UsernameNEW -Properties UserPrincipalName,DisplayName,employeeNumber,ProxyAddresses,HomeDirectory | Select-Object Enabled,Samaccountname,DisplayName,GivenName,Surname,employeeNumber,@{Name='PrimarySMTPAddress';Expression={$_.ProxyAddresses -cmatch '^SMTP:' -creplace 'SMTP:'}},HomeDirectory | Out-File -Append -FilePath $LogFile
## Log (Seperator)
"#################################################################################################" | Out-File -Append -FilePath $LogFile
#endregion


#region Notify User
Write-Host " " -ForegroundColor Yellow
Write-Host "If the above looks correct, run a DirSync (Delta Update) to sync the changes Azure/Office 365" -ForegroundColor Yellow
#endregion