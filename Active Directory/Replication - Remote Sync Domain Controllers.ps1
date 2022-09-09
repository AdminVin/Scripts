#region Notes
# Start > Settings > Apps > Optional Features
# Install - RSAT: Active Directory Domain Services and Light Weight Directory Service Tools
#endregion

#region Process Sync
Invoke-Command -ComputerName SERVERNAME -ScriptBlock {repadmin /syncall /AdeP}
#endregion