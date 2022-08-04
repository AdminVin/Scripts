# Connect to O365
Connect-MSOLService

# Import CSV
$user_file = Import-CSV "Update Title and Department.CSV"

# Update Department Only
$user_file | ForEach {Set-msoluser -UserPrincipalName $_.UserPrincipalName -Department $_.Department}

# Update Title and Department
$user_file | ForEach {Set-msoluser -UserPrincipalName $_.UserPrincipalName -Title $_.Title -Department $_.Department}