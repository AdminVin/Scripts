# Import Active Directory Powershell Module
Import-Module ActiveDirectory
  
# Import CSV with all AD users in the $CSV variable
$CSV = Import-csv "Users - ProxyAddress - Remove Specific.csv"

# Loop through each row containing user details in the CSV file 
foreach ($LineItem in $CSV)
{
	# Read user data from each field in each row and assign the data to a variable as below
		$Username 	= $LineItem.Username
		$ProxyAddress = 'smtp:'+"$Username"+'@DOMAIN.local'
		Write-Output "Removed Proxy Address: "$ProxyAddress        
            Set-ADUser -Identity $Username -Remove @{proxyAddresses=$ProxyAddress} 
            
}
pause
