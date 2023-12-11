# Connect
Connect-MgGraph -Scope User.ReadWrite.All

# OU
#$ouPath = "OU=Disabled Accounts,OU=People,DC=DOMAIN,DC=local"
$ouPath = "OU=People,DC=DOMAIN,DC=local"

# Search
# All users in OU
#$users = Get-ADUser -Filter * -SearchBase $ouPath -SearchScope Subtree
# Only disabled users in OU
$users = Get-ADUser -Filter {Enabled -eq $false} -SearchBase $ouPath -SearchScope Subtree

# Process Accounts
foreach ($upn in $users) {
    Write-Host $upn.UserPrincipalName""
    $upn_licenses = ''
    $upn_licenses = Get-MgUserLicenseDetail -UserId $upn.UserPrincipalName
    $LicensesToRemove = $upn_licenses | ForEach-Object {
        $_.SkuId
    }
    $NoLicenses = @()
    IF($upn_licenses -ne '') {    
        Write-Host " - Removing existing licenses.`n"
        Set-MgUserLicense -UserId $upn.UserPrincipalName -AddLicenses $NoLicenses -RemoveLicenses $LicensesToRemove -ErrorAction "SilentlyContinue" | Out-Null
    }
}