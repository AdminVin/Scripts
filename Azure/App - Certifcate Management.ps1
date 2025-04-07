############################################
# Step 1: Generate CSR from Server/Account #
############################################

$cert = New-SelfSignedCertificate -Subject "CN=YourCustomAPP" `
  -CertStoreLocation "Cert:\CurrentUser\My" `
  -KeyExportPolicy Exportable `
  -KeySpec Signature `
  -KeyLength 2048 `
  -NotAfter (Get-Date).AddYears(3)
# Cert length can be up to ten years; if needed.

$pwd = ConvertTo-SecureString -String 'YourCustomPW!' -Force -AsPlainText
Export-PfxCertificate -Cert $cert `
  -FilePath "C:\YourCustomAPP-AppCert.pfx" `
  -Password $pwd

Export-Certificate -Cert $cert `
  -FilePath "C:\YourCustomAPP-AppCert.cer"


####################################
# Step 2: Add certificate to Azure #
####################################
<#
Navigate to http://porta.azure.com
    - App Registrations > All Applications > App Name > Mange > Certs & Secrets > Upload

#>


##################################
# Step 3: Pull Thumbprint (Full) # 
##################################

Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object {
    $_.Subject -like "*YourCustomAPP*"
} | Select-Object Thumbprint, Subject, NotAfter


<# Example Output:
PS C:\WINDOWS\system32> Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object {
>>     $_.Subject -like "*YourCustomAPP*"
>> } | Select-Object Thumbprint, Subject, NotAfter

Thumbprint                               Subject     NotAfter
----------                               -------     --------
E499D93EFEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX CN=YourCustomAPP 4/4/2028 3:27:59 PM
#>


####################################
# Step 4: Update PowerShell Script #
####################################

<#
Update the new Thumbprint ID in your connection script.


Example Connection Script to Azure/Exchange:

# App-based Authentication Settings
$AppId = "11111111-2222-3333-4444-555555555"
$Thumbprint = "E499D93EFEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
$TenantDomain = "DOMAIN.COM"  # Used by ExchangeOnline
$TenantId = "555555555-4444-3333-2222-111111"  # Used by Microsoft Graph

# Exchange Online connection
Connect-ExchangeOnline -AppId $AppId -CertificateThumbprint $Thumbprint -Organization $TenantDomain
Write-Host "Connected to Office 365."


# Microsoft Graph connection
Connect-MgGraph -ClientId $AppId -TenantId $TenantDomain -CertificateThumbprint $Thumbprint
Write-Host "Connected to Microsoft Graph."
#>


###################################################
# Step 5: Removal of existing certificate/Renewal #
###################################################

# View - All Self Created Certs
Get-ChildItem Cert:\CurrentUser\My | Where-Object {
    $_.Issuer -eq $_.Subject
} | Select-Object Thumbprint, Subject, NotAfter

# Removal - Name
Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object {
    $_.Subject -like "*YourCustomAPP*"
} | Remove-Item

# Removal - Thumbprint
Remove-Item -Path "Cert:\CurrentUser\My\<THUMBPRINT>"