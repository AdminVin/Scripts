## Settings
Import-Module ActiveDirectory
$CSV = Import-CSV "Users - Create (Generic).csv" -Verbose
$EmailDomain = "AdminVin.com"
$OU = "OU=Users,OU=Company,OU=ParentCompany,DC=AV,DC=local"

## Process Accounts
foreach ($User in $CSV)
{
	$Username = $User.AccountName
	$Password = $User.Password
	$FirstName = $User.FirstName
	$Lastname = $User.LastName
	$UPNMAin = $Username+"@"+$EmailDomain
 
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		 Write-Warning "A User $Username already exist in Active Directory."
    }
	else
	{
	    New-ADUser -SamAccountName $Username -UserPrincipalName $UPNMAin -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -GivenName $FirstName -Surname $LastName -Name "$FirstName $LastName" -DisplayName "$FirstName $LastName" -Email $UPNMAin -OtherAttributes @{Proxyaddresses="SMTP:"+$UPNMain} -Path $OU -Enabled $True -Verbose       
    }
}