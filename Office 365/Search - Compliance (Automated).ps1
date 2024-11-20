<# Notes
Compliance Permissions Needed:
Navigate to https://compliance.microsoft.com/ > Microsoft Purview Solutions (New Portal) > Settings > Roles and Scopes > Role Groups > Select "eDiscovery Manager" > Add User

Source: https://docs.microsoft.com/en-us/exchange/policy-and-compliance/ediscovery/compliance-search

Requirements: Powershell 7
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
    Connect-ExchangeOnline
} ELSE {
    Connect-ExchangeOnline
}
if (!(Get-Command -Name Connect-IPPSSession -ErrorAction SilentlyContinue)) {
    Install-Module -Name ExchangeOnlineComplianceManagement -Scope CurrentUser -Force
    Connect-IPPSSession
} ELSE {
    Connect-IPPSSession
}

## Compliance Search - Parameters
Write-Host ("Compliance search started at " + (Get-Date -Format "MM/dd/yyyy hh:mm tt")) -ForegroundColor Green
$name      = (Read-Host "Compliance Search Name").Trim()
# Search - Sender
$fromemail = (Read-Host "Sender Email Address [* for any sender - WILDCARD: vincent*]").Trim()
# Search - Term
$searchScope = (Read-Host "Search term in SUBJECT or BODY? [Enter 'subject' or 'body']").Trim().ToUpper()
while ($searchScope -notin @("subject", "body")) {
    Write-Host "Invalid input. Please type 'subject' or 'body'." -ForegroundColor Red
    $searchScope = (Read-Host "Search Term in SUBJECT or BODY? [Enter 'subject' or 'body']").Trim().ToUpper()
}
if ($searchScope -eq "subject") {
    $searchTerm = (Read-Host "Search term for the $searchScope [* for all messages - WILDCARD: Spam Message* -]").Trim()
} elseif ($searchScope -eq "body") {
    $searchTerm = (Read-Host "Search term for the $searchScope [WILDCARD: Spam Message*]").Trim()
}

## Remove unsupported use of */wildcard at the beginning (not supported by compliance search)
if ($searchTerm -match '^\*') {
    $searchTerm = $searchTerm.TrimStart('*')
}
# Search - Date 
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
    $StartDate = $calendar.SelectionStart.ToString("yyyy-MM-dd")
}

$EndResult = $null
While  ($EndResult -ne [System.Windows.Forms.DialogResult]::OK) {
    $OKButton.Text = 'Select END Date'
    $EndResult = $form.ShowDialog()
    $EndDate = $calendar.SelectionStart.ToString("yyyy-MM-dd")
}
Write-Host "Start Date: $StartDate"
Write-Host "End Date: $EndDate"

# # Search - Query - Construct the search query based on wildcard logic
if ($searchTerm -eq "*") {
    $searchTerm = $null
}

if ($searchScope -eq "subject") {
    if ($fromemail -eq "*") {
        $query = $searchTerm ? "(Subject:$searchTerm) (date=$StartDate..$EndDate)" : "(date=$StartDate..$EndDate)"
    } elseif ($fromemail -match '\*') {
        $query = $searchTerm ? "(Subject:$searchTerm) (From:$fromemail)(date=$StartDate..$EndDate)" : "(From:$fromemail)(date=$StartDate..$EndDate)"
    } else {
        $query = $searchTerm ? "(Subject:$searchTerm) (From:$fromemail)(date=$StartDate..$EndDate)" : "(From:$fromemail)(date=$StartDate..$EndDate)"
    }
} elseif ($searchScope -eq "body") {
    if ($fromemail -eq "*") {
        $query = $searchTerm ? "$searchTerm (date=$StartDate..$EndDate)" : "(date=$StartDate..$EndDate)"
    } elseif ($fromemail -match '\*') {
        $query = $searchTerm ? "$searchTerm (From:$fromemail)(date=$StartDate..$EndDate)" : "(From:$fromemail)(date=$StartDate..$EndDate)"
    } else {
        $query = $searchTerm ? "$searchTerm (From:$fromemail)(date=$StartDate..$EndDate)" : "(From:$fromemail)(date=$StartDate..$EndDate)"
    }
}


# Search - Notify User
Write-Host "`nSearch Query: $query`n" -ForegroundColor DarkYellow

# Search - Create
Write-Host "Creating ComplianceSearch: $name"
New-ComplianceSearch -Name $name -ExchangeLocation "All" -ContentMatchQuery $query | Out-Null

# Search - Start
Write-Host "Starting ComplianceSearch: $name"
Start-ComplianceSearch -Identity $name

# Search - Start Timer
Write-Host "Searching..."
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

while ((Get-ComplianceSearch $name -ErrorAction SilentlyContinue).status -ne "completed") {
    Write-Host "." -NoNewline 
    Start-Sleep -Seconds 1
}
$stopwatch.Stop()

$totalTime = "{0:00}:{1:00}" -f $stopwatch.Elapsed.Hours, $stopwatch.Elapsed.Minutes
Write-Host "`nSearch completed! (Search Time: $totalTime)`n" -ForegroundColor Green

## Results - Mailboxes
$search = Get-ComplianceSearch -Identity $name -ErrorAction SilentlyContinue
if ($null -eq $search) {
    Write-Host "Error: Unable to retrieve compliance search details. Please verify the search name." -ForegroundColor Red
    exit
}

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
$purge = Read-Host "`nType the word 'purge' to purge these items.`nIf you are not purging, you can just hit enter to end."
if ($purge -eq "purge"){
    Write-Host "`nDo you want to delete the compliance search '$name' after purging?`n"-ForegroundColor Red
    $deleteSearch = Read-Host "Type 'Y' to DELETE or 'N' to KEEP"
    New-ComplianceSearchAction -SearchName $name -Purge -PurgeType SoftDelete -Confirm:$false
    Write-Host "Sleeping for five minutes to process purge/deletion." -ForegroundColor DarkYellow
    Start-SleepProgress -Num 300
}

if ($deleteSearch -eq "Y") {
    Write-Host "`nDeleting ComplianceSearch: $name" -ForegroundColor Gray
    Remove-ComplianceSearch -Identity $name -Confirm:$false | Out-Null
    Write-Host "`nComplianceSearch '$name' has been deleted." -ForegroundColor Yellow
} else {
    Write-Host "`nComplianceSearch '$name' was not deleted." -ForegroundColor Yellow
}
# Clear Session
Get-PSSession | Remove-PSSession | Out-Null