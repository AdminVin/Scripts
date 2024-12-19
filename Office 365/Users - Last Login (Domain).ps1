## Notes
# This is for Active Directory accounts synced to Office 365.


## Modules
IF(!(Get-Module -Name ExchangeOnlineManagement -ListAvailable)){Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser -Force;Import-Module ExchangeOnlineManagement;Write-Host "ExchangeOnlineManagement";Connect-ExchangeOnline} ELSE {Import-Module ExchangeOnlineManagement;Write-Host "ExchangeOnlineManagement";Connect-ExchangeOnline}


## Varibles
# Active Directory - Pull all enabled users.
$ActiveUsers = Get-ADUser -Filter {Enabled -eq $true} -Properties GivenName, Surname, Title
$UserData = @()
# CSV Export Location
$CsvFilePath = "C:\Users - Last Login Status $(Get-Date -Format "MM-dd-yyyy").csv"
# Counter
$TotalUsers = $ActiveUsers.Count
$CountNumber = "0"


## Process Accounts
# Office 365 - Check LastUserActionTime
foreach ($O365user in $ActiveUsers) {
  $CountNumber = [int]$CountNumber
  $CountNumber++
  $CountNumber = $CountNumber.ToString()
  $O365userUPN = $O365user.UserPrincipalName
  Write-Host "Checking $O365userUPN ($CountNumber of $TotalUsers)"
  
  $O365Status = Get-MailboxStatistics $O365user.UserPrincipalName | Select-Object LastInteractionTime, LastUserActionTime
  $UserDataRow = New-Object PSObject -Property @{
    "First Name" = $O365user.GivenName
    "Last Name" = $O365user.Surname
    "Title" = $O365user.Title
    "Email" = $O365user.UserPrincipalName
    "LastUserActionTime" = $O365Status.LastUserActionTime
  }
  $UserData += $UserDataRow
}


## Export Data / Notify
$UserData | Select-Object "First Name", "Last Name", "Title", "Email", "LastUserActionTime" | Export-Csv -Path $CsvFilePath -NoTypeInformation
Write-Host "`nUser data has been exported to $CsvFilePath" -ForegroundColor Green


## Notes
<#
*** Updated information from MS Ticket on 2023-11-06

- LastEmailTime:
This attribute gets updated while accessing mailbox. Even when the user is not using their mailbox, LastEmailTime gets updated when the user receives a new mail. 
 
- LastContactTime: 
When a user adds or removes a contact, LastContactTime value gets updated. Even when the user has not performed any contact related actions, the value gets updated. Similar behavior occurs in LastCalendarTime, LastTasksTime, and LastProfileTime. 
For e.g., below user logged into his mailbox alone. Other than login, no action performed by the user but most of the attributes got updated. 
 
- LastInteractionTime:  
LastInteractionTime gets updated independently of other attributes. It gets updated when the mailbox has interactions like login to the mailbox, receiving a new mail or reading an email.  Unfortunately, it gets updated even when a background mailbox assistant accesses the mailbox. The value gets updated in real time.

- LastLogonTime:
Most people use LastLogonTime to retrieve inactive users list, which leads to inaccurate data. LastLogonTime does not reflect when the user logged in to mailbox alone, but also when a process like mailbox assistant accesses the mailbox. The same applies to LastLogOffTime. These two attributes get updated in real time. 
 
- LastModernGroupsTime: 
LastModernGroupsTime gets populated only for Office 365 group mailboxes. Some background tasks also update this. Hence, the exact reason for this attribute remains unknown. 
 
- LastUserActionWorkLoadAggregateTime: 
LastUserActionWorkLoadAggregateTime gets updated by comparing all workloads like LastEmailTime, LastContactsTime, LastCalendarTime, LastTaskTime, LastProfileTime,  and LastModernGroupTime and shows the most recent time. As these basic attributes are getting updated by background tasks also, this attribute won’t be reliable for getting inactive users. 
 
- LastUserActionUpdateTime: 
This attribute doesn’t indicate the user’s action. That being said, some attributes alone get updated in real time, remaining attributes get updated in a certain interval.  LastUserActionUpdateTime shows when the mailbox was last accessed to get the value for non-real time attributes like LastEmailTime, LastContactsTime, LastCalendarTime, LastTaskTime, LastProfileTime, LastModernGroupTime, and LastUserActionTime. So, you couldn’t see any non-real time attributes value later than this value. It’s like a schedule time to retrieve non-real time attributes value.  LastUserAccessTime and LastLoggedOnUserAccount value are empty for all object when I checked in my tenant. 
 
- LastUserActionTime: 
Finally, LastUserActionTime. As the name implies, LastUserActionTime gets updated based on the user’s real actions. This attribute includes all user actions like login to the mailbox, when sending mail, and when reading a mail, etc. Unlike other attributes, its value will not be updated by a background task or process. So, user’s inactivity can be retrieved from LastUserActionTime. (LastUserActionTime doesn’t show up-to-date data. There will be some delay like a day or two.
 
Conclusion:
Getting inactive mailboxes is the most needed task as it involves regaining unused licenses, archiving mailboxes, etc. Hence, the attribute used to get inactive mailbox must be more accurate. From the research, we found that getting inactive mailboxes using LastUserActionTime is the best solution.
#>