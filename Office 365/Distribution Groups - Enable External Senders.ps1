# Distribution Groups
$Groups = Import-Csv -Path "Distribution Groups - Enable External Senders.csv"
foreach ($Group in $Groups) {            
Get-DistributionGroup -Identity $Group | Set-DistributionGroup -RequireSenderAuthenticationEnabled $False
} 


# Dynamic Distribution Groups
$Groups = Import-Csv -Path "Distribution Groups - Enable External Senders.csv"
foreach ($Group in $Groups) {            
Get-DynamicDistributionGroup -Identity $Group | Set-DynamicDistributionGroup -RequireSenderAuthenticationEnabled $False
} 
