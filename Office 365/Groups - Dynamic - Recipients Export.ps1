# Declare Dynamic Distribution Group
$group = Get-DynamicDistributionGroup -Identity "DynamicGroupName@DOMAIN.com"

# Export all recipients to CSV File
Get-Recipient -RecipientPreviewFilter $group.RecipientFilter | Export-CSV Export.csv
