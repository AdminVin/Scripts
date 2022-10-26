# Export all members from an Active Directory Group to CSV
Import-Module ActiveDirectory

$SecurityGroupName = "ITDept"
Get-ADGroupMember "$SecurityGroupName" | Select-Object Name | Export-CSV ".\SecurityGroups-ExportGroupMembers-$SecurityGroupName.csv" -Notypeinformation