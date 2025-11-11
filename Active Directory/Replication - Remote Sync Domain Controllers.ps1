<# Arguments
/A: Synchronizes all naming contexts
    - Includes Schema, Configuration, Domain, and DNS application partitions.
/a: Synchronizes only the local domain partition 
    - Does NOT include Schema, Configuration, Domain, and DNS partitions.

/e: Synchronizes enterprise partitions **within the local site**.
    - Applies to partitions that exist across the enterprise, but only contacts DCs in the same site.
    - Examples:
        ✅ domain.local
        ✅ child.domain.local
        ✅ sub.child.domain.local
/E: Synchronizes enterprise partitions **across all sites in the forest**
    - Ensures full enterprise-wide replication for the selected partitions.)

/d: Synchronizes the domain partition only.
    - Replicates only to normal replication partners (usually same site unless /E is added).
/D: Displays distinguished names (DNs) of directory partitions and DCs in output.
    - Does NOT affect what gets replicated; only changes the display format.

/p: Forces a PULL replication
    - From the local DC to its replication partners
/P: Forces a PUSH replication
    - From the local DC to its replication partners
#>

repadmin /syncall /AedP