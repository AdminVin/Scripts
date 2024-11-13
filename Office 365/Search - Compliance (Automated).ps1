<# Notes
Compliance Permissions Needed:
Navigate to https://compliance.microsoft.com/ > Permissions > Microsoft Purview Solutions, select "Roles" > select "eDiscovery Manager" > Add User

Source: https://docs.microsoft.com/en-us/exchange/policy-and-compliance/ediscovery/compliance-search
#>

## Functions
Function Start-SleepProgress {
    param([int]$Num)
    1..$Num | ForEach-Object {
        Write-Progress -Activity "Sleeping for $Num seconds" -Status "Remaining:$($Num-$_)" -PercentComplete ($_/$Num*100); Start-Sleep 1
    }
    Write-Progress -Activity "Sleeping for $Num seconds" -Completed
}

## Install/Connect to Exchange/Compliance
if (!(Get-Command -Name Connect-ExchangeOnline -ErrorAction SilentlyContinue)) {
    Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser -Force
}
if (!(Get-Command -Name Connect-IPPSSession -ErrorAction SilentlyContinue)) {
    Install-Module -Name ExchangeOnlineComplianceManagement -Scope CurrentUser -Force
}


## Compliance Search - Parameters
Write-Host ("Compliance search started at " + (Get-Date -Format "MM/dd/yyyy hh:mm tt")) -ForegroundColor Green
$name      = (Read-Host "Compliance Search Name").Trim()
$fromemail = (Read-Host "Sender Email Address [WILDCARD: * (for any/all senders) - vincent* - Multiple addresses with commas (jacksmith*,*smith@domain.com)]").Trim()

# Process multiple email addresses by splitting, trimming, and joining with " OR "
$fromemail = ($fromemail -split "," | ForEach-Object { $_.Trim() }) -join " OR "

# Select search field (subject or body)
$searchField = ""
while ($searchField -notmatch "^(subject|body)$") {
    $searchField = (Read-Host "Search by 'subject' or 'body'?").Trim().ToUpper()
}

# Get search term, allowing wildcard usage for all messages
$searchTerm = (Read-Host "Search term for the $searchField [WILDCARD: *Spam Term* - Bitcoin Hack* - *Account Ending in - * for any messages]").Trim()

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.Text = 'Date'
$form.Size = New-Object Drawing.Size @(243,230)
$form.StartPosition = 'CenterScreen'

$calendar = New-Object System.Windows.Forms.MonthCalendar
$calendar.ShowTodayCircle = $false
$calendar.MaxSelectionCount = 1
$form.Controls.Add($calendar)

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(40,165)
$OKButton.Size = New-Object System.Drawing.Size(150,23)
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$form.Topmost = $true

$StartResult = $null
While ($StartResult -ne [System.Windows.Forms.DialogResult]::OK) {
    $OKButton.Text = 'Select START Date'
    $StartResult = $form.ShowDialog()
    $Startdate = $calendar.SelectionStart.ToString("MM/dd/yyyy")
}

$EndResult = $null
While  ($EndResult -ne [System.Windows.Forms.DialogResult]::OK) {
    $OKButton.Text = 'Select END Date'
    $EndResult = $form.ShowDialog()
    $Enddate = $calendar.SelectionStart.ToString("MM/dd/yyyy")
}

# Build the content match query based on user input
$query = "(sent>=$Startdate) AND (sent<=$Enddate) AND (From:($fromemail)) AND (${searchField}:`"$searchTerm`")"

# Search - Create
Write-Host "Creating ComplianceSearch: $name"
New-ComplianceSearch -Name $name -ExchangeLocation "All" -ContentMatchQuery $query | Out-Null

# Search - Start
Write-Host "Starting ComplianceSearch: $name"
Start-ComplianceSearch -Identity $name

# Search - Run with elapsed time
Write-Host "Searching..."
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()  # Start the stopwatch

while ((Get-ComplianceSearch $name).status -ne "completed") {
    Write-Host "." -NoNewline 
    Start-Sleep -Seconds 1
}
$stopwatch.Stop()  # Stop the stopwatch

$totalTime = "{0:00}:{1:00}" -f $stopwatch.Elapsed.Hours, $stopwatch.Elapsed.Minutes
Write-Host "`nSearch completed! (Search Time: $totalTime)"

## Results - Mailboxes
$search = Get-ComplianceSearch -Identity $name
$items = $search.Items
$results = $search.SuccessResults
$mailboxes = @()
if ($results -is [string] -and $results -ne "") {
    $lines = $results -split '[\r\n]+'
    foreach ($line in $lines) {
       if ($line -match 'Location: (\S+),.+Item count: (\d+)' -and $matches[2] -gt 0) {
           $mailboxes += $matches[1]
       }
    }
}

Write-Host "Found '$items' items"
Write-Host ""
Write-Host "In mailboxes:"
$mailboxes

## Compliance Search - Purge Results
$purge = Read-Host "Type the word 'purge' to purge these items. If you are not purging, you can just hit enter to end."
if ($purge -eq "purge"){ New-ComplianceSearchAction -SearchName $name -Purge -PurgeType SoftDelete }

# Delay five minutes for purge to complete
Start-SleepProgress -Num 300

## Compliance Search - Delete Search
$deleteSearch = Read-Host "Do you want to delete the compliance search '$name'? Type 'Y' to confirm or 'N' to skip."
if ($deleteSearch -eq "Y") {
    Write-Host "Deleting ComplianceSearch: $name"
    Remove-ComplianceSearch -Identity $name | Out-Null
    Write-Host "ComplianceSearch '$name' has been deleted."
} else {
    Write-Host "ComplianceSearch '$name' was not deleted."
}

Get-PSSession | Remove-PSSession | Out-Null