## Outlook - Select all messages that have attachments > Right Click & Copy
## Windows - Navigate to folder that they will be temporarily stored > Right Click & Paste

# Load Outlook COM Object
$olApp = New-Object -ComObject Outlook.Application

# Folder containing MSG files
$folderPath = "C:\Temp\MSG"

# Output folder for extracted attachments
$outputFolder = "C:\Temp\MSG\Attachments"

# Get all MSG files in the specified folder
$msgFiles = Get-ChildItem -Path $folderPath -Filter *.msg

foreach ($msgFile in $msgFiles) {
    # Open MSG file
    $msg = $olApp.Session.OpenSharedItem($msgFile.FullName)

    # Extract attachments
    foreach ($attachment in $msg.Attachments) {
        $attachment.SaveAsFile("$outputFolder\$($attachment.FileName)")
    }

    # Release resources
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($msg) | Out-Null
}

# Quit Outlook
$olApp.Quit()

# Release resources
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($olApp) | Out-Null
