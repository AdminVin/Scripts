#region Varibles
# Set location of OU to search
$SearchOU = ‘DC=DOMAIN,DC=local’
# Set the number of days to exclude
$LastLogonDate= (Get-Date).AddDays(-365)
#endregion

# Search & View AD Computer List
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Sort LastLogonTimeStamp| FT Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize

# Search & Export AD Computer List
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Sort LastLogonTimeStamp| FT Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize | Export-CSV "InactiveADComputerList.csv"

# Search & Disable AD Computer List
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Sort LastLogonTimeStamp| FT Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize | Disable-ADAccount

# Search & Delete AD Computer List
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Sort LastLogonTimeStamp| FT Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize | Remove-ADComputer