#region Varibles
# Set location of OU to search
$SearchOU = ‘DC=DOMAIN,DC=local’
# Set the number of days to exclude
$LastLogonDate= (Get-Date).AddDays(-365)
#endregion

# Search & View ONLY Computer Objects
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Sort-Object LastLogonTimeStamp | Format-Table Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize

# Search & Export Computer Objects List
Get-ADComputer -Properties Enabled,DNSHostName,LastLogonDate,LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Select-Object Enabled,DNSHostName,LastLogonDate,DistinguishedName | Export-CSV "Computers-ExportLastLoggedIn(Over1Year).csv"

# Search & Disable Computer Objects
#Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Sort-Object LastLogonTimeStamp| Format-Table Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize | Disable-ADAccount

# Search & Delete Computer Objects
#Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Sort-Object LastLogonTimeStamp| Format-Table Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize | Remove-ADComputer