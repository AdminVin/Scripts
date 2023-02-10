## Settings
Import-Module ActiveDirectory
$CSV = Import-CSV ".\Users - Create (First Initial + Last Name).csv"
$EmailDomain = "AdminVin.com"
$OU = "OU=Users,OU=Company,OU=ParentCompany,DC=AV,DC=local"

## Process Accounts
foreach ($User in $CSV)
{
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
    $UPN = $Username+"@"+$EmailDomain
 
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		 Write-Warning "A User $Username already exist in Active Directory."
    }
	else
	{
		New-ADUser -SamAccountName $Username -UserPrincipalName $UPN -Name "$FirstName $LastName" -GivenName $FirstName -Surname $LastName -DisplayName "$FirstName $LastName" -Initials $MiddleInitial -Title $JobTitle -Company $CompayName -StreetAddress $Street -Email $UPN -MobilePhone $Cell -Fax $Fax -OfficePhone $DirectLine -State $State -City $City -PostalCode $Zip -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -OtherAttributes @{Proxyaddresses="SMTP:"+$UPN} -Path $OU -Enabled $True -VERBOSE
    }
 }