## Primary Method
Get-DynamicDistributionGroupMember -Identity "DynamicGroupName@DOMAIN.com" -ResultSize Unlimited | Export-CSV Export.csv

## Alternative Method
$group = Get-DynamicDistributionGroup -Identity "DynamicGroupName@DOMAIN.com"
Get-Recipient -RecipientPreviewFilter $group.RecipientFilter | Export-CSV Export.csv