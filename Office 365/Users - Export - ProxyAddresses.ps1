$domain = "DC=DOMAIN,DC=local"
$results = @()
$users = Get-ADUser -Filter {ProxyAddresses -like "*smtp:*"} -SearchBase $domain -Property ProxyAddresses, DistinguishedName

foreach ($user in $users) {
    $filteredAddresses = $user.ProxyAddresses | Where-Object {
        $_ -notlike "x500:*" -and $_ -notlike "smtp:*onmicrosoft.com"
    }

    if ($filteredAddresses.Count -gt 1) {
        $userDetails = [PSCustomObject]@{
            Name            = $user.Name
            ProxyAddresses  = ($filteredAddresses -join "; ") + ";"
            OU              = $user.DistinguishedName
        }

        $userDetails | Format-List
        $results += $userDetails
    }
}

$results | Export-Csv -Path "Users-EmailAliases.csv" -NoTypeInformation
