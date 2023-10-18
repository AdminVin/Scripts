# Notes: This is for Active Directory accounts synced to Office 365.

# Modules
Connect-ExchangeOnline

# Active Directory - Check all enabled users
$ActiveUsers = Get-ADUser -Filter {Enabled -eq $true}

# Initialize an array to store user data
$UserData = @()

# Office 365 - Check Last Interaction Time
foreach ($O365user in $ActiveUsers) {
  $O365userUPN = $O365user.UserPrincipalName
  Write-Host "Checking $O365userUPN"
  $O365Status = Get-MailboxStatistics $O365user.UserPrincipalName | Select-Object LastInteractionTime
  $UserDataRow = New-Object PSObject -Property @{
    "User" = $O365user.Name
    "UserPrincipalName" = $O365user.UserPrincipalName
    "LastInteractionTime" = $O365Status.LastInteractionTime
  }
  $UserData += $UserDataRow
}

# Define the CSV file path
$CsvFilePath = "C:\Users - Last Login Status.csv"

# Export the data to a CSV file
$UserData | Export-Csv -Path $CsvFilePath -NoTypeInformation

# Notify
Write-Host "User data has been exported to $CsvFilePath"