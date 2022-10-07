# Exported list from Office 365 of all groups
# Work in Progress / NOT FINISHED

$DistroLists = Get-Content DistributionGroupList.txt

Foreach ($DistroList in $DistroLists) {

Get-MessageTrace -RecipientAddress $DistroList -Status expanded -StartDate 03/27/2022 -EndDate 04/06/2022 |Sort-Object RecipientAddress | Group-Object RecipientAddress |Sort-Object Name |Select-Object Name, Count | Export-CSV C:\ActiveDGs.csv -Append -NotypeInformation

}