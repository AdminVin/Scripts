# Connect
Connect-ExchangeOnline

# Check Time
Get-MailboxStatistics USER@DOMAIN.com | Select-Object LastUserActionTime

<#
Output Example:
PS C:\Users\vincent> Get-MailboxStatistics USER@DOMAIN.com | Select-Object LastUserActionTime

LastUserActionTime
------------------
10/20/2024 3:48:26 PM
#>