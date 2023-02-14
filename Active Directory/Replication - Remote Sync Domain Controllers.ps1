#region Notes
<#
Start > Settings > Apps > Optional Features
Install - RSAT: Active Directory Domain Services and Light Weight Directory Service Tools

Flags Definition
/syncall: Synchronizes a specified domain controller with all replication partners.
/A: Perform /SyncAll for all NC’s held by <Dest DSA> (ignores <Naming Context>)
/d: ID servers by DN in messages (instead of GUID DNS)
/e: Enterprise, cross sites (default: only home site)
/P: Push changes outward from home server (default: pull changes)
#>
#endregion

#region Process Sync
repadmin /syncall /AdeP
#endregion