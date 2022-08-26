#region Import Modules
Import-Module ActiveDirectory

#endregion


#region Process Verification
# Import CSV
$CSV = Import-CSV "Users - Verify Account by Name.csv"

# Loop through accounts in CSV and verify all accounts
foreach ($Users in $CSV)
{
	# Read user data from each field in each row and assign the data to a variable as below
	$Username = $Users.FirstName + "." + $Users.Lastname	
	# Full Command Example
	# Get-ADUser $Username -Properties ProxyAddresses,Mail,ExtensionAttribute1 | Select-Object Mail,ExtensionAttribute1,ProxyAddresses, @{Name='PrimarySMTPAddress';Expression={$_.ProxyAddresses -cmatch '^SMTP:' -creplace 'SMTP:'}}
	# Truncated Command
	Get-ADUser $Username -Properties UserPrincipalName,employeeNumber,ProxyAddresses | Select-Object Enabled,Samaccountname,employeeNumber,@{Name='PrimarySMTPAddress';Expression={$_.ProxyAddresses -cmatch '^SMTP:' -creplace 'SMTP:'}} 
}

#endregion