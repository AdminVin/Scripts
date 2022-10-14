#region Notes
# Start > Settings > Apps > Optional Features
# Install - RSAT: Active Directory Domain Services and Light Weight Directory Service Tools
#endregion

#region Process Sync - Local
repadmin /syncall /AdeP
#endregion

#region Process Sync - Remote
Invoke-Command -ComputerName SERVERNAME -ScriptBlock {repadmin /syncall /AdeP}
#endregion