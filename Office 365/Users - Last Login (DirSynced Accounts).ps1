## Notes:
# This is for Active Directory accounts synced to Office 365.

## Modules
Connect-ExchangeOnline

## Varibles
# Active Directory - Pull all enabled users.
$ActiveUsers = Get-ADUser -Filter {Enabled -eq $true}
$TotalUsers = $ActiveUsers.Count
# Array for all accounts
$UserData = @()
# CSV Export Location
$CsvFilePath = "C:\Users - Last Login Status $(Get-Date -Format "MM/dd/yyyy").csv"
# Counter
$CountNumber = "0"

## Process Accounts
# Office 365 - Check LastInteractionTime
foreach ($O365user in $ActiveUsers) {
  $CountNumber = [int]$CountNumber
  $CountNumber++
  $CountNumber = $CountNumber.ToString()
  $O365userUPN = $O365user.UserPrincipalName
  Write-Host "Checking $O365userUPN ($CountNumber of $TotalUsers)"
  
  $O365Status = Get-MailboxStatistics $O365user.UserPrincipalName | Select-Object LastInteractionTime
  $UserDataRow = New-Object PSObject -Property @{
    "User" = $O365user.Name
    "UserPrincipalName" = $O365user.UserPrincipalName
    "LastInteractionTime" = $O365Status.LastInteractionTime
  }
  $UserData += $UserDataRow
}


## Export Data / Notify
$UserData | Export-Csv -Path $CsvFilePath -NoTypeInformation
Write-Host "User data has been exported to $CsvFilePath"