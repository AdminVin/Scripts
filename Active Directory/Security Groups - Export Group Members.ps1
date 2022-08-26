# Export all members from an Active Directory Group to CSV
Get-ADGroupMember -identity "AlreadyProofedMailboxSEC" | select name | Export-CSV Alreadyproofed.csv -Notypeinformation