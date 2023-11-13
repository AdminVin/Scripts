# Dynamic distribution groups can take up to twenty four hours to update as per Microsoft documentation.
# Source: https://learn.microsoft.com/en-us/exchange/recipients-in-exchange-online/manage-dynamic-distribution-groups/modern-dynamic-distribution-groups

Set-DynamicDistributionGroup -Identity "DynamicGroupName@DOMAIN.com" -ForceMembershipRefresh