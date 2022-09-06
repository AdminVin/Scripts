# Export all members from an Active Directory Group to CSV
Get-ADGroupMember -identity "SecurityGroupName" | select name | Export-CSV "SecurityGroup-ExportGroupMembers.csv" -Notypeinformation