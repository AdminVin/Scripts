# Export all members from an Active Directory Group to CSV
Get-ADGroupMember -identity "SecurityGroupName" | Select-Object Name | Export-CSV "SecurityGroup-ExportGroupMembers.csv" -Notypeinformation