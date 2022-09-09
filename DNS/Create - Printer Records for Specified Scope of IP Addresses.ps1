#region Modules
# If you are running this from your workstation and NOT a domain controller, you will need to install "RSAT: DNS Server Tools" from Windows Features
Get-Module DNSServer
#endregion

#region Varibles
$Domain = "AV.LOCAL"
$DomainController = "VinDC.AV.LOCAL"
#endregion

#region Connect to Domain Controller
Enter-PSSession $DomainController
#endregion

#region Process DNS Records

Add-DnsServerSecondaryZone -Name "Printers.$Domain" -PassThru

#endregion

#region Sync changes to all domain controllers
Sync-DnsServerZone -PassThru
#endregion