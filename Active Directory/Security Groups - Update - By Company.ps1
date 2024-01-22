#region Notes
# Running this will add the user to the proper security based off their company in AD, and remove any users that are disabled (if any).
#endregion

$Company1 = "CompanyName"
$CompanySG1 = "CompanySecurity Group"
<# Add Enabled Acounts #>
Get-ADUser -Filter {(Company -like $Company1) -and (enabled -eq 'true')} | ForEach-Object { 
    Write-Host "Adding $_ to $Company1" -ForegroundColor Green
    Add-ADGroupMember -Identity "$CompanySG1" -Members $_ }
<# Remove Disabled Accounts #>
    $Members = (Get-ADGroup $CompanySG1 -Properties members).members
foreach($member in $members){
    Write-Host "Checking '$member'..." -ForegroundColor Yellow
    $UserStatus = Get-ADUser $member
    if(-not($UserStatus.enabled)){
        Write-Host "Removing '$member'" -ForegroundColor Red
        Remove-ADGroupMember $CompanySG1 -Members $member -Confirm:$false
    }
}