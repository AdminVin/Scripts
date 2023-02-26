$Server = "SERVER.DOMAIN.LOCAL"

$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$Server/PowerShell/ -Authentication Kerberos -Credential $UserCredential
Import-PSSession $Session -DisableNameChecking