repadmin /syncall /AdeP

<# Notes
Command Breakdown
repadmin: This is the command-line tool used to manage and troubleshoot replication in Active Directory.

/syncall: This parameter instructs repadmin to initiate a synchronization between all domain controllers in the forest.

/A: This flag specifies that all naming contexts (partitions) should be replicated. It ensures that replication occurs for all domain-related information, including user accounts, groups, group policies, and more.

/d: This flag is optional and can be used to specify a specific domain to replicate. If not provided, replication will occur for all domains in the forest.

/e: This flag is optional and indicates that replication should be done in a more efficient mode by compressing data during the replication process.

/P: This flag is optional and directs repadmin to push changes from the source domain controller to the destination domain controllers. This can help speed up replication, especially in scenarios where the source domain controller has more up-to-date data.
#>