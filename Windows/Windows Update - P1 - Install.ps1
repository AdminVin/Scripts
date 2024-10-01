## Setup Notes
# Login to server > Scheduled Tasks > Create New Task (not basic)
# Schedule:  Weds @ 6 PM 
# Action > New
#       Program/Script: Point to PS7 (C:\Program Files\PowerShell\7\pwsh.exe)
#         Argument: -ExecutionPolicy Bypass -File "UNC or Local Path to this PS Script."
#
# NOTE: Script will need to be run once manually to enter in password for Office 365 account.


## PowerShell - Modules
# NuGet
if (-not (Get-PackageSource -Name 'NuGet' -ErrorAction SilentlyContinue)) {
    Install-PackageProvider -Name NuGet -Force
    Register-PackageSource -Name NuGet -ProviderName NuGet -Location https://www.nuget.org/api/v2 -Force
}
# PSWindowsUpdate
$minVersion = '2.2.1.4'
$moduleName = 'PSWindowsUpdate'
$module = Get-Module -Name $moduleName -ListAvailable | Where-Object { $_.Version -ge $minVersion } | Sort-Object Version -Descending | Select-Object -First 1
if (-not $module) {
    Install-Module -Name $moduleName -MinimumVersion $minVersion -Force -Scope CurrentUser
    Import-Module PSWindowsUpdate
} else {
    Import-Module PSWindowsUpdate
}


## Process Updates
# Check/Get
Get-WindowsUpdate
# Install
Install-WindowsUpdate -AcceptAll -Confirm:$false -IgnoreReboot
usoclient startinteractivescan                                      # Refresh 'Windows Update' Metro GUI


## Email
# Body
# Windows Update - All
$WUHistoryRaw = Get-WUHistory | Where-Object { $_.Date -ge (Get-Date).AddDays(-2) }
# Windows Update - Failed
$FailedUpdatesExist = $WUHistoryRaw | Where-Object { $_.Result -ne "Succeeded" }
$StatusIndicator = if ($FailedUpdatesExist) { "REVIEW" } else { "SUCCESS" }
# Convert to HTML
IF ($StatusIndicator -eq "SUCCESS") {
    $WUHistoryHtml = $WUHistoryRaw | Select-Object Date, Result, Title | ConvertTo-Html -Head "<style>table {border-collapse: collapse;} th, td {border: 1px solid black; padding: 5px;}</style>" -Body "<h2>Windows Update History</h2><b>$env:COMPUTERNAME has installed the updates below.</b><br><br><br>" | Out-String
} else {
    $WUHistoryHtml = $WUHistoryRaw | Select-Object Date, Result, Title | ConvertTo-Html -Head "<style>table {border-collapse: collapse;} th, td {border: 1px solid black; padding: 5px;}</style>" -Body "<h2>Windows Update History</h2><b>$env:COMPUTERNAME has attempted to install the updates below, but the updates need to be reviewed.</b><br><br><br>" | Out-String
}
# Subject
$EmailSubject = "Windows Updates - $env:COMPUTERNAME ($StatusIndicator)"
# Email Server Settings and Credentials
$SMTPUsername = "alerts@DOMAIN.COM"
$CUfile = $SMTPUsername + ".txt"
$Directory = "C:\ProgramData\AV\WindowsUpdates"
# Password
IF(Test-Path "$Directory\$CUfile") {
    # Password file exists
} ELSE {
    New-Item -ItemType Directory -Path $Directory -Force | Out-Null
    Read-Host -Prompt "Enter password for $SMTPUsername to be encrypted & used for sending alerts" -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath "$Directory\$CUfile"
}
$SecureStringContent = Get-Content -Path "$Directory\$CUfile" | ConvertTo-SecureString
$SMTPPassword = $SecureStringContent
$SMTPCredential = New-Object System.Management.Automation.PSCredential ($SMTPUsername, $SMTPPassword)
# SMTP Server Settings
$SMTPServer = "smtp.office365.com"
$SMTPPort = 587
$EmailFrom = $SMTPUsername
$EmailTo = "ITADMINS@DOMAIN.COM"
# Send Email
if (!($WUHistoryRaw -eq '')) {Send-MailMessage -SmtpServer $SMTPServer -Port $SMTPPort -From $EmailFrom -To $EmailTo -Subject $EmailSubject -Body $WUHistoryHtml -Credential $SMTPCredential -UseSsl -BodyAsHtml}


### Notes
# Hide update that continually fails/not needed
# Hide-WindowsUpdate -Title "KYOCERA Document Solutions Inc. - Printer - 6/6/2013 12:00:00 AM - 10.0.171..."