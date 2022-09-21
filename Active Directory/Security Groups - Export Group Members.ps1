# Export all members from an Active Directory Group to CSV
$SecurityGroupName = "ITDept"
Get-ADGroupMember -identity "$SecurityGroupName" | Select-Object Name | Export-CSV "$SecurityGroupName-ExportGroupMembers.csv" -Notypeinformation