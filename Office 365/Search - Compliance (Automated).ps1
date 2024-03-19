<# Notes
Compliance Permissions Needed:
Navigate to https://compliance.microsoft.com/ > Permissions > Microsoft Purview Solutions, select "Roles" > select "eDiscovery Manager" > Add User

Source: https://docs.microsoft.com/en-us/exchange/policy-and-compliance/ediscovery/compliance-search
#>

Connect-ExchangeOnline
Connect-IPPSSession

$name      = (Read-Host "Compliance Search Name").Trim()
$fromemail = (Read-Host "Enter email address this came from(wildcard: *domain.com also works").Trim()
$subject   = (Read-Host "Enter the subject line of the email (wildcard: Reset Your password for* also works").Trim()

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
While ($StartResult -ne [System.Windows.Forms.DialogResult]::OK)
{
    $OKButton.Text = 'Select START Date'
    $StartResult = $form.ShowDialog()
    $Startdate = $calendar.SelectionStart.tostring("MM/dd/yyyy")
}

$EndResult = $null
While  ($EndResult -ne [System.Windows.Forms.DialogResult]::OK)
{
    $OKButton.Text = 'Select END Date'
    $EndResult = $form.ShowDialog()
    $Enddate = $calendar.SelectionStart.tostring("MM/dd/yyyy")
}

# Search - Create
Write-Host "Creating ComplianceSearch: $name"
New-ComplianceSearch -Name $name -ExchangeLocation "All" -ContentMatchQuery "(sent>=$Startdate) AND (sent<=$Enddate) AND (From:`"$fromemail`") AND (subject:`"$subject`")" | Out-Null

# Search - Start
Write-Host "Starting ComplianceSearch: $name"
Start-ComplianceSearch -Identity $name

# Search - Run
Write-Host "Searching..."
while ((Get-ComplianceSearch $name).status -ne "completed")
    {
    Write-host "." -nonewline 
    Start-Sleep -Seconds 1
    }
Write-Host ""
Write-Host "Search completed!"

$search = Get-ComplianceSearch $name

# Item Count
$items = $search.items

# Mailboxes
$results = $search.SuccessResults
$mailboxes = @();
$lines = $results -split '[\r\n]+';
foreach ($line in $lines)
{
   if ($line -match 'Location: (\S+),.+Item count: (\d+)' -and $matches[2] -gt 0)
   {
       $mailboxes += $matches[1];
   }
}

Write-Host "Found '$items' items"
Write-Host ""
Write-Host "In mailboxes:"
$mailboxes

# Purge - Confirm/Skip
$purge = Read-Host "Type the word 'purge' to purge these items. If you are not purging, you can just hit enter to end."
if ($purge -eq "purge"){ New-ComplianceSearchAction -SearchName $name -Purge -PurgeType SoftDelete }

Get-PSSession | Remove-PSSession | Out-Null