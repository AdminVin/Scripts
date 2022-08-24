# Connect to Office 365
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

# Get all Dynamic Distribution Groups
Get-DynamicDistributionGroup *

# Get Current Filter for Dynamic Group
Get-DynamicDistributionGroup “Group Name” | fl Name,RecipientFilter


### Examples
## Example Modifer to ADD with Custom Attribute
-and (CustomAttribute15 -like 'IncludeFacilityAllEmails')

## Example Modifer to REMOVE with Custom Attribute
-and (-not(CustomAttribute15 -like 'ExcludeALL'))

# Original Scope
((((((RecipientType -eq 'UserMailbox') -and (Alias -ne $null))) -and (RecipientTypeDetailsValue -eq 'UserMailbox'))) -and (-not(Name -like 'SystemMailbox{*')) -and (-not(Name -like 'CAS_{*')) -and (-not(RecipientTypeDetailsValue -eq 'MailboxPlan')) -and (-not(RecipientTypeDetailsValue -eq 'DiscoveryMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'PublicFolderMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'ArbitrationMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuxAuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'SupervisoryReviewPolicyMailbox')))

# Modified Scope
((((((RecipientType -eq 'UserMailbox') -and (Alias -ne $null))) -and (RecipientTypeDetailsValue -eq 'UserMailbox'))) -and (-not(Name -like 'SystemMailbox{*')) -and (-not(Name -like 'CAS_{*')) -and (-not(RecipientTypeDetailsValue -eq 'MailboxPlan')) -and (-not(RecipientTypeDetailsValue -eq 'DiscoveryMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'PublicFolderMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'ArbitrationMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuxAuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'SupervisoryReviewPolicyMailbox')) -and (-not(CustomAttribute15 -like 'ExcludeALL')))

# Update Office 365
Set-DynamicDistributionGroup -Identity “DynamicGroupName@DOMAIN.com” -RecipientFilter "((((((RecipientType -eq 'UserMailbox') -and (Alias -ne $null))) -and (RecipientTypeDetailsValue -eq 'UserMailbox'))) -and (-not(Name -like 'SystemMailbox{*')) -and (-not(Name -like 'CAS_{*')) -and (-not(RecipientTypeDetailsValue -eq 'MailboxPlan')) -and (-not(RecipientTypeDetailsValue -eq 'DiscoveryMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'PublicFolderMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'ArbitrationMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuxAuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'SupervisoryReviewPolicyMailbox') -and (-not(CustomAttribute15 -like 'ExcludeALL'))))"

#Example
Set-DynamicDistributionGroup -Identity “DynamicGroupName@DOMAIN.com” -RecipientFilter "((((((((RecipientType -eq 'UserMailbox') -and (Alias -ne $null))) -and (CustomAttribute1 -ne 'ExcludeAll'))) -and (RecipientTypeDetailsValue -eq 'UserMailbox'))) -and (-not(Name -like 'SystemMailbox{*')) -and (-not(Name -like 'CAS_{*')) -and (-not(RecipientTypeDetailsValue -eq 'MailboxPlan')) -and (-not(RecipientTypeDetailsValue -eq 'DiscoveryMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'PublicFolderMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'ArbitrationMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuxAuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'SupervisoryReviewPolicyMailbox') -and (CustomAttribute1 -like 'Company1_ALL') -and (CustomAttribute2 -like 'Company2_ALL'))))"

((((((((RecipientType -eq 'UserMailbox') -and (Alias -ne $null))) -and (CustomAttribute1 -ne 'ExcludeAll'))) -and (CustomAttribute14 -like 'Company1_ALL') -and (RecipientTypeDetailsValue -eq 'UserMailbox'))) -and (-not(Name -like 'SystemMailbox{*')) -and (-not(Name -like 'CAS_{*')) -and (-not(RecipientTypeDetailsValue -eq 'MailboxPlan')) -and (-not(RecipientTypeDetailsValue -eq 'DiscoveryMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'PublicFolderMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'ArbitrationMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuxAuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'SupervisoryReviewPolicyMailbox')))
