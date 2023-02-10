# Import active directory module for running AD cmdlets
Import-Module ActiveDirectory
  
#Store the data from ADUsers.csv in the $ADUsers variable
$ADUsers = Import-csv ".\Users - Create (First Initial + Last Name).csv"
# Update to Pulic Domain Name
$EmailDomain = "AdminVin.com"
# OU that the users will be created in
#$OU = "OU=Users,OU=Company,OU=ParentCompany,DC=AV,DC=local"
$OU = "OU=Users,OU=Company,OU=ParentCompany,DC=AV,DC=local"


#Loop through each row containing user details in the CSV file 
foreach ($User in $ADUsers)
{
	#Read user data from each field in each row and assign the data to a variable as below
		
	$Username 	= $User.FirstName.Substring(0,1)+$User.LastName
	$Password 	= $User.Password
	$FirstName 	= $User.FirstName
	$Lastname 	= $User.LastName
    $MiddleInitial = $User.MiddleInitial
    $DirectLine = $User.DirectLine
    $Fax = $User.Fax
    $Cell = $user.Cell
    $JobTitle = $user.JobTitle
    $CompayName = $user.CompanyName
	$Street = $User.Street
    $State = $User.State
    $Zip = $User.Zip
    $City = $User.City
 
	#Check to see if the user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		 #If user does exist, give a warning
		 Write-Warning "A User $Username already exist in Active Directory."
    }

	else

	{
		#User does not exist then proceed to create the new user account
		$UPNMAin = $Username+"@"+$EmailDomain
        #Account will be created in the OU provided by the $OU variable read from the CSV file
		New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName $UPNMAin ` `
            -Name "$FirstName $LastName" `
            -GivenName $FirstName `
            -Surname $LastName `
            -Enabled $True `
            -DisplayName "$FirstName $LastName" `
            -Initials $MiddleInitial `
            -Path $OU `
            -Title $JobTitle `
            -Company $CompayName `
            -StreetAddress $Street `
            -Email $UPNMAin `
            -MobilePhone $Cell `
            -Fax $Fax `
            -OfficePhone $DirectLine `
            -State $State `
            -City $City `
            -PostalCode $Zip `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) `
            -OtherAttributes @{Proxyaddresses="SMTP:"+$UPNMain}
    }
    # Set-ADUser -Identity $user.samaccountname -Email $user.UPNMAin
}