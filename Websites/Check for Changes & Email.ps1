# Define the URL of the web page you want to monitor
$webPageUrl = "https://example.com/page"

# Define the Gmail account details
$senderEmail = "your_email@gmail.com"
$senderPassword = "your_password"
$recipientEmail = "recipient_email@example.com"

# Define the SMTP port (587 for TLS, 465 for SSL)
$smtpPort = 587

# Create a function to check for updates on the web page
function CheckForUpdates {
    $response = Invoke-WebRequest -Uri $webPageUrl
    $currentContent = $response.Content

    # Load the last known content from a file (or create an empty file if it doesn't exist)
    $contentFile = "last_known_content.txt"
    if (Test-Path $contentFile) {
        $lastKnownContent = Get-Content $contentFile
    } else {
        $lastKnownContent = ""
        $lastKnownContent | Out-File -FilePath $contentFile -Force
    }

    # Compare the current content with the last known content
    if ($currentContent -ne $lastKnownContent) {
        # Content has changed, send an email
        $smtpServer = "smtp.gmail.com"
        $smtpCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $senderEmail, (ConvertTo-SecureString -String $senderPassword -AsPlainText -Force)
        Send-MailMessage -From $senderEmail -To $recipientEmail -Subject "Web page update detected" -Body "The web page at $webPageUrl has been updated." -SmtpServer $smtpServer -Credential $smtpCredential -Port $smtpPort -UseSsl
        
        # Update the last known content with the current content
        $currentContent | Out-File -FilePath $contentFile -Force
    }
}

# Run the initial check
CheckForUpdates

# Schedule the script to run every hour
while ($true) {
    Start-Sleep -Seconds 3600
    CheckForUpdates
}
