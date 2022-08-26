# Update a Security Group from CSV
#
Import-Module ActiveDirectory 
Import-Csv -Path “Security Group - Update from CSV.csv” | ForEach-Object {Add-ADGroupMember -Identity “SecurityGroupName” -Members $_.’User-Name’}