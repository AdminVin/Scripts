#region Notes
# Update a Security Group from CSV
#end region

#region Modules
Import-Module ActiveDirectory 
#endregion


#region Process Users/Groups
Import-Csv -Path “Security Groups - Update - Members from CSV.csv”
ForEach-Object {Add-ADGroupMember -Identity "SecurityGroupName" -Members $_.’SAMAccountName’}
#endregion