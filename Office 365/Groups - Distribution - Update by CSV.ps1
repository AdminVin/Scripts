# CSV Import
$CSV = Import-Csv -Path "Groups - Distribution - Update by CSV.csv"


# Update Distribution Group
$DistributionGroupEmail = "group@example.com"
$groupMembers = $CSV.Email
Set-DistributionGroup -Identity $DistributionGroupEmail -Members $groupMembers

