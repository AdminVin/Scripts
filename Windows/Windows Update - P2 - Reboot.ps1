## Setup Notes
# Login to server > Scheduled Tasks > Create New Task (not basic)
# Schedule:  Thurs/Friday @ 1 AM 
# Action > New
#       Program/Script: Point to PS7 (C:\Program Files\PowerShell\7\pwsh.exe)
#         Argument: -ExecutionPolicy Bypass -File "UNC or Local Path to this PS Script."
#
# NOTE: Script will need to be run once manually to enter in password for Office 365 account.


# Reboot Check
$rebootRequired = $false
if (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired") {
    $rebootRequired = $true
}

# Reboot PC
if ($rebootRequired) {
    ## Email
    # Body
    # Windows Update - All
    $WUHistoryRaw = Get-WUHistory | Where-Object { $_.Date -ge (Get-Date).AddDays(-2) }
    # Convert to HTML for Email Body
    $WUHistoryHtml = $WUHistoryRaw | Select-Object Date, Result, Title | ConvertTo-Html -Head "<style>table {border-collapse: collapse;} th, td {border: 1px solid black; padding: 5px;}</style>" -Body "<h2>Windows Update History</h2><b>$env:COMPUTERNAME is rebooting to complete the updates below.</b><br><br><br>" | Out-String
    # Subject
    $EmailSubject = "Windows Updates - $env:COMPUTERNAME (REBOOT)"
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
    ## Reboot
    Restart-Computer -Force
}