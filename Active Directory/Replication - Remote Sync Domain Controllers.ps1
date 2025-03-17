<#
Arguments
/A: Initiates asynchronous replication.
    - Replicates all partitions.
/e: Synchronizes enterprise partitions (applies to a single forest with multiple child domains).
    - Examples:
     ✅ domain.local
     ✅ child.domain.local
     ✅ sub.child.domain.local
/d: Synchronizes the domain partition.
    - Includes all sites in Active Directory Sites and Services
/p: Forces a PULL replication
    - From the local DC to its replication partners
/P: Forces a PUSH replication
    - From the local DC to its replication partners
#>

repadmin /syncall /AdP