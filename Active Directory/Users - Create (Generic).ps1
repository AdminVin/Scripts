# Import AD
Import-Module ActiveDirectory
# Import CSV
$CSV = Import-CSV "Users - Create (Generic).csv" -Verbose
# Update to Pulic Domain Name
$EmailDomain = "AdminVin.com"
# OU that the users will be created in
$OU = "OU=Users,OU=Company,OU=ParentCompany,DC=AV,DC=local"


#Loop through each row containing user details in the CSV file 
foreach ($User in $CSV)
{
	#Read user data from each field in each row and assign the data to a variable as below
	$Username = $User.AccountName
	$Password = $User.Password
	$FirstName = $User.FirstName
	$Lastname = $User.LastName
	$UPNMAin = $Username+"@"+$EmailDomain
 
	#Check to see if the user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		 Write-Warning "A User $Username already exist in Active Directory."
    }
	else
	{
		#User does not exist then proceed to create the new user account
	    New-ADUser -SamAccountName $Username -UserPrincipalName $UPNMAin -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -GivenName $FirstName -Surname $LastName -Name "$FirstName $LastName" -DisplayName "$FirstName $LastName" -Email $UPNMAin -OtherAttributes @{Proxyaddresses="SMTP:"+$UPNMain} -Path $OU -Enabled $True -Verbose       
    }
}