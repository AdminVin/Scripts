# This will remove the AD Object protection that can be scoped by OU
#
Get-ADOrganizationalUnit -searchbase "OU=ParentCompany,DC=DOMAIN,DC=local" -filter * -Properties ProtectedFromAccidentalDeletion | Where-Object {$_.ProtectedFromAccidentalDeletion -eq $true} | Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false