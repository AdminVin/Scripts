#region Varibles
# Set location of OU to search
$SearchOU = "DC=DOMAIN,DC=LOCAL"
# Set the number of days to exclude
$LastLogonDate= (Get-Date).AddDays(-730)
#endregion

# Search & View ONLY Computer Objects
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Sort-Object LastLogonTimeStamp | Format-Table Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize

# Search & Export Computer Objects List
Get-ADComputer -Properties Enabled,Name,LastLogonDate,LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Select-Object Enabled,Name,LastLogonDate,DistinguishedName | Export-CSV "Computers-ExportLastLoggedIn(Over2Years).csv"

# Disable and Move Computers to Specified OU from CSV Export
$DestinationOU = "OU=OU_NAME,OU=OU_NAME,OU=OU_NAME,OU=OU_NAME,DC=DOMAIN,DC=LOCAL"
$CSV = Import-CSV "Computers-ExportLastLoggedIn(Over2Years).csv"
foreach ($PC in $CSV)
{
	$PCName	= $PC.Name
    $PCDescription = Get-ADComputer $PCName | Select-Object DistinguishedName
    Get-ADComputer $PCName | Set-ADComputer -Description "Original OU: $PCDescription"
	Get-ADComputer $PCName | Disable-ADAccount -PassThru | Move-ADObject -TargetPath $DestinationOU
	Write-Output "$PCName disabled, and moved to $DestinationOU."
    }

# Search & Disable Computer Objects
#Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Sort-Object LastLogonTimeStamp| Format-Table Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize | Disable-ADAccount

# Search & Delete Computer Objects
#Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase $SearchOU | Sort-Object LastLogonTimeStamp| Format-Table Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize | Remove-ADComputer