# Module Import
Import-Module ActiveDirectory

# CSV Import
$CSV = Import-CSV "FOR - Example.csv"

# Loop through accounts in CSV and verify all accounts
foreach ($User in $CSV)
{
	# Read the first and last name from each row and format to AD username syntax
	$Username = $User.FirstName + "." + $User.Lastname
	# Action for each account
	Enable-ADAccount $Username
}