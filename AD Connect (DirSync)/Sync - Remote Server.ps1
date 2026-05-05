#region Replication between Domain Controllers
# View current Queue
repadmin /queue
# Replicate
repadmin /syncall /AdeP
# Verify queue is processed
repadmin /queue
#endregion

#region Sync to O365/Azure
Invoke-Command -ComputerName SERVERNAME -ScriptBlock {Start-ADSyncSyncCycle -PolicyType delta}
#endregion