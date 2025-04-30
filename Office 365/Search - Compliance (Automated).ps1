<# Notes
Compliance Permissions Needed:
Navigate to https://purview.microsoft.com/ (New Portal) > Settings > Roles and Scopes > Role Groups > Select "eDiscovery Manager" > Add User to "eDiscovery Administrator"

Source: https://docs.microsoft.com/en-us/exchange/policy-and-compliance/ediscovery/compliance-search

Requirements: Powershell 7
#>


## PowerShell 7 - Check
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "This script requires PowerShell 7." -ForegroundColor Red
    break; exit
}


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
Connect-ExchangeOnline
if (!(Get-Command -Name Connect-IPPSSession -ErrorAction SilentlyContinue)) {
    Install-Module -Name ExchangeOnlineComplianceManagement -Scope CurrentUser -Force
}
Connect-IPPSSession


## Compliance Search - Parameters
Write-Host ("Compliance search started at " + (Get-Date -Format "MM/dd/yyyy hh:mm tt")) -ForegroundColor Green
$name      = (Read-Host "[Step 1/6] Compliance Search Name").Trim()
# Search - Sender
$fromemail = (Read-Host "[Step 2/6] Sender Email Address [Note: Use * for any sender | WILDCARD: vincent*]").Trim()
# Search - Term
Write-Host "Search term in SUBJECT or BODY? [Note: Use SUBJECT and * for searching all messages.]" -ForegroundColor DarkYellow
$searchScope = (Read-Host "[Step 3/6] Enter 'subject' or 'body'").Trim().ToUpper()
while ($searchScope -notin @("subject", "body")) {
    Write-Host "Invalid input. Please type 'subject' or 'body'." -ForegroundColor Red
    $searchScope = (Read-Host "[Enter 'subject' or 'body']").Trim().ToUpper()
}
if ($searchScope -eq "subject") {
    $searchTerm = (Read-Host "[Step 4/6] Search term for the $searchScope [Note: Use * for all messages - WILDCARD: Spam Message* -]").Trim()
} elseif ($searchScope -eq "body") {
    $searchTerm = (Read-Host "[Step 4/6] Search term for the $searchScope [WILDCARD: Spam Message*]").Trim()
}

# Search - Remove unsupported use of */wildcard at the beginning (not supported by compliance search)
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
Write-Host "[Step 5/6] Start Date: $StartDate"

$EndResult = $null
While  ($EndResult -ne [System.Windows.Forms.DialogResult]::OK) {
    $OKButton.Text = 'Select END Date'
    $EndResult = $form.ShowDialog()
    $EndDate = $calendar.SelectionStart.ToString("yyyy-MM-dd")
}
Write-Host "[Step 6/6] End Date: $EndDate"

# Search - Query - Construct the search query based on wildcard logic
if ($searchTerm -eq "*") {
    $searchTerm = $null
}

if ($searchScope -eq "subject") {
    if ($fromemail -eq "*") {
        $query = $searchTerm ? "(Subject:$searchTerm) (date=$StartDate..$EndDate)" : "(date=$StartDate..$EndDate)"
    } elseif ($fromemail -match '\*') {
        $query = $searchTerm ? "(Subject:$searchTerm) (From:$fromemail OR Participants:$fromemail)(date=$StartDate..$EndDate)" : "(From:$fromemail OR Participants:$fromemail)(date=$StartDate..$EndDate)"
    } else {
        $query = $searchTerm ? "(Subject:$searchTerm) (From:$fromemail OR Participants:$fromemail)(date=$StartDate..$EndDate)" : "(From:$fromemail OR Participants:$fromemail)(date=$StartDate..$EndDate)"
    }
} elseif ($searchScope -eq "body") {
    if ($fromemail -eq "*") {
        $query = $searchTerm ? "$searchTerm (date=$StartDate..$EndDate)" : "(date=$StartDate..$EndDate)"
    } elseif ($fromemail -match '\*') {
        $query = $searchTerm ? "$searchTerm (From:$fromemail OR Participants:$fromemail)(date=$StartDate..$EndDate)" : "(From:$fromemail OR Participants:$fromemail)(date=$StartDate..$EndDate)"
    } else {
        $query = $searchTerm ? "$searchTerm (From:$fromemail OR Participants:$fromemail)(date=$StartDate..$EndDate)" : "(From:$fromemail OR Participants:$fromemail)(date=$StartDate..$EndDate)"
    }
}

# Search - Notify User
Write-Host "`nSearch Query: $query`n" -ForegroundColor Green

# Search - Create
Write-Host "Creating ComplianceSearch: $name"
New-ComplianceSearch -Name $name -ExchangeLocation "All" -ContentMatchQuery $query | Out-Null

# Search - Start
Write-Host "Starting ComplianceSearch: $name"
Start-ComplianceSearch -Identity $name

# Search - Start Timer
Write-Host "Searching:"
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

while ((Get-ComplianceSearch $name -ErrorAction SilentlyContinue).status -ne "completed") {
    Write-Host "." -NoNewline 
    Start-Sleep -Seconds 5
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

Write-Host "Mailboxes:" 
$mailboxes
Write-Host "Total items found '$items'."

## Compliance Search - Purge Results
Write-Host "`nType the word 'purge' to purge/delete these items." -ForegroundColor Yellow
Write-Host "If you are not purging, press enter to end." -ForegroundColor Yellow
$purge = Read-Host "`nType 'purge' or press enter to continue"
if ($purge -eq "purge"){
    Write-Host "`nDo you want to delete the compliance search '$name' after purging?`n"-ForegroundColor Red
    $deleteSearch = Read-Host "Type 'Y' to DELETE or 'N' to KEEP"
    New-ComplianceSearchAction -SearchName $name -Purge -PurgeType SoftDelete -Confirm:$false
    Write-Host "Sleeping for five minutes to process purge/deletion." -ForegroundColor DarkYellow
    Start-SleepProgress -Num 300
    if ($deleteSearch -eq "Y") {
        Write-Host "`nDeleting ComplianceSearch: $name" -ForegroundColor Gray
        Remove-ComplianceSearch -Identity $name -Confirm:$false | Out-Null
        Write-Host "`nComplianceSearch '$name' has been deleted." -ForegroundColor Yellow
    } else {
        Write-Host "`nComplianceSearch '$name' was not deleted." -ForegroundColor Yellow
    }
} ELSE {
    Write-Host "`nDo you want to delete the compliance search '$name'?`n"-ForegroundColor Red
    $deleteSearch = Read-Host "Type 'Y' to DELETE or 'N' to KEEP"
    if ($deleteSearch -eq "Y") {
        Write-Host "`nDeleting ComplianceSearch: $name" -ForegroundColor Gray
        Remove-ComplianceSearch -Identity $name -Confirm:$false | Out-Null
        Write-Host "`nComplianceSearch '$name' has been deleted." -ForegroundColor Yellow
    } else {
        Write-Host "`nComplianceSearch '$name' was not deleted." -ForegroundColor Yellow
    }
}
# Clear Session
Get-PSSession | Remove-PSSession | Out-Null