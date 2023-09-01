# Module (Install/Import)
$maximumfunctioncount = '32768' # Required in PowerShell ISE (Limitation of PowerShell 5.1)
IF(!(Get-Module -Name Microsoft.Graph -ListAvailable)){Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force;Import-Module Microsoft.Graph.Users;Import-Module Microsoft.Graph.Authentication;Write-Host "Microsoft.Graph"} ELSE {Import-Module Microsoft.Graph.Users;Import-Module Microsoft.Graph.Authentication;Write-Host "Microsoft.Graph"}

# Connect
Connect-MgGraph -Scope User.ReadWrite.All

# Specify User
$upn = USER@DOMAIN.com

# Set User's Usage Location
Update-MgUser -UserId $upn -UsageLocation "US"
Start-Sleep 30 # Delay is needed for propagation for Microsoft Data Centers, before you can assign licensing.

# Remove any existing licensing attached to user
$upn_licenses = ''
$upn_licenses = Get-MgUserLicenseDetail -UserId $upn
$LicensesToRemove = $upn_licenses | ForEach-Object {
    $_.SkuId
}
$NoLicenses = @()
IF($upn_licenses -ne '') {    
    Write-Host " - Removing existing licenses."
    Set-MgUserLicense -UserId $upn -AddLicenses $NoLicenses -RemoveLicenses $LicensesToRemove -ErrorAction "SilentlyContinue" | Out-Null
}

# Pull all SkuId/Names for tenant
Get-MgSubscribedSku | Select-Object CapabilityStatus,SkuPartNumber,SkuId,ConsumedUnits

<# Expected Output:
SkuPartNumber                               SkuId                                ConsumedUnits
-------------                               -----                                -------------
Windows12_BETA                              11111111-0000-1111-0000-111111111111          6633
Windows10/11_ENT                            11111111-0000-2222-0000-111111111111             0
M365_BUSINESS_BASIC                         11111111-0000-3333-0000-111111111111          1105
#>

# Assign new licensing to user
$Licenses = @(
    @{
        SkuId = "11111111-0000-1111-0000-111111111111"
        DisplayName = "Windows12_BETA"
    },
    @{
        SkuId = "11111111-0000-2222-0000-111111111111"
        DisplayName = "Windows10/11_ENT"
    },
    @{
        SkuId = "11111111-0000-3333-0000-111111111111"
        DisplayName = "M365_BUSINESS_BASIC"
    }
)
$AssignedLicenses = $Licenses | ForEach-Object {
    [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphAssignedLicense]@{
        SkuId = $_.SkuId
        DisabledPlans = @()
    }
}
Write-Host " - Applying current licenses:"
$Licenses | ForEach-Object {
    $DisplayName = $_.DisplayName
    Write-Host "   - $DisplayName"
    $AssignedLicenses = [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphAssignedLicense]@{
        SkuId = $_.SkuId
        DisabledPlans = @()
    }
}
    Set-MgUserLicense -UserId $upn -AddLicenses $AssignedLicenses -RemoveLicenses $NoLicenses | Out-Null

    # Verify Licensing Applied
    Get-MgUserLicenseDetail -UserID $upn
