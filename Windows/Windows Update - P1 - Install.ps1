## Setup Notes
# Login to server > Scheduled Tasks > Create New Task (not basic)
# Schedule:  Weds @ 6 PM 
# Action > New
#       Program/Script: Point to PS7 (C:\Program Files\PowerShell\7\pwsh.exe or 'pwsh.exe')
#         Argument: -ExecutionPolicy Bypass -File "UNC or Local Path to this PS Script."
## Functions
Function Start-SleepProgress {
    param([int]$Num)
    1..$Num | ForEach-Object {
        Write-Progress -Activity "Sleeping for $Num seconds" -Status "Remaining:$($Num-$_)" -PercentComplete ($_/$Num*100);Start-Sleep 1}
    Write-Progress -Activity "Sleeping for $Num seconds" -Completed
}


## Modules
# PSWindowsUpdate
Write-Host "'PSWindowsUpdate' Module" -ForegroundColor Yellow
if (-not (Get-Module -Name 'PSWindowsUpdate' -ListAvailable)) {
    Write-Host "- Module not detected, installing."
    Install-Module -Name 'PSWindowsUpdate' -Force
    Write-Host "- Importing PSWindowsUpdate"
    Import-Module 'PSWindowsUpdate'
} ELSE {
    Write-Host "- Importing PSWindowsUpdate"
    Import-Module 'PSWindowsUpdate'
}


## Process Updates
Write-Host "Windows Updates - Processing" -ForegroundColor Yellow
Get-WindowsUpdate                                                   # Check/Get New Updates
Install-WindowsUpdate -AcceptAll -Confirm:$false -IgnoreReboot      # Install Updates
usoclient startinteractivescan                                      # Refresh 'Windows Update' Metro GUI
Write-Host "Delay" -ForegroundColor Yellow
Start-SleepProgress -Num 1800										# Wait thirty minutes and retry updates (if any)
Write-Host "Windows Updates - Retrying any potential failed updates" -ForegroundColor Yellow
Get-WindowsUpdate                                                   # Check/Get New Updates
Install-WindowsUpdate -AcceptAll -Confirm:$false -IgnoreReboot      # Install Updates
usoclient startinteractivescan                                      # Refresh 'Windows Update' Metro GUI


## Results
Write-Host "Email - Results" -ForegroundColor Yellow
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
# Credentials - Password
$SMTPUsername = "SENDER@DOMAIN.COM"
$CUfile = $SMTPUsername + ".txt"
$Directory = "C:\ProgramData\AV\Credentials"
IF (Test-Path "$Directory\$CUfile") {
    try {
        Get-Content -Path "$Directory\$CUfile" | ConvertTo-SecureString -ErrorAction Stop > $null
    } catch {
        Remove-Item -Path "$Directory\$CUfile" -Force
        New-Item -ItemType Directory -Path $Directory -Force | Out-Null
        $PlainPassword = Read-Host -Prompt "Enter password for $SMTPUsername to be encrypted"
        $SecurePassword = ConvertTo-SecureString $PlainPassword -Force
        $SecurePassword | ConvertFrom-SecureString | Out-File -FilePath "$Directory\$CUfile"
    }
} ELSE {
    New-Item -ItemType Directory -Path $Directory -Force | Out-Null
    $PlainPassword = Read-Host -Prompt "Enter password for $SMTPUsername to be encrypted"
    $SecurePassword = ConvertTo-SecureString $PlainPassword -Force
    $SecurePassword | ConvertFrom-SecureString | Out-File -FilePath "$Directory\$CUfile"
}
$SecureStringContent = Get-Content -Path "$Directory\$CUfile" | ConvertTo-SecureString -Force
$SMTPPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureStringContent))
# Server Settings
$SMTPServer = "smtp.office365.com"
$SMTPPort = 587
$EmailFrom = $SMTPUsername
# Recipients
$EmailTo = "DESTINATION@DOMAIN.COM"
# Send Email
if (!($WUHistoryRaw -eq '')) {
    $mailMessage = New-Object System.Net.Mail.MailMessage
    $mailMessage.From = $EmailFrom
    $mailMessage.To.Add($EmailTo)
    $mailMessage.Subject = $EmailSubject
    $mailMessage.IsBodyHtml = $true
    $mailMessage.Body = $WUHistoryHtml

    $smtpClient = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort)
    $smtpClient.EnableSsl = $true
    $smtpClient.Credentials = New-Object System.Net.NetworkCredential($SMTPUsername, $SMTPPassword)

    try {
        $smtpClient.Send($mailMessage)
        Write-Host "Email sent successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to send email: $_" -ForegroundColor Red
    }
}