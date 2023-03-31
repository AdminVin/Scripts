# Set Eastern Time Zone
Set-TimeZone -Name "Eastern Standard Time"
Start-Service W32Time
Restart-Service W32Time

# Get the current date and time from an internet time server
$ntpServer = "time.google.com"
$dateTime = (Get-Date -UFormat %s)
$ntpResult = Invoke-WebRequest -Uri "http://$ntpServer" -Method Get -UseBasicParsing
$ntpTime = [DateTime]::Parse($ntpResult.Headers.Date)

# Set the system date and time
Set-Date $ntpTime