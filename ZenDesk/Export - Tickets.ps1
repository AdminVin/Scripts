<# IMPORTANT!
    - This will export all tickets submitted (initial entry) only.
    - After this completes, run 'Export - Comments.ps1' for the replies and attachments.
#>

$Subdomain = "YOURSubDomain"
$Email = "YOURAdminEmail"
<# How to get a Zendesk API token:
1. Log in to Zendesk as an admin -> Admin Center (gear icon).
2. Go to Apps and integrations -> APIs -> Zendesk API.
3. Ensure "Token Access" is enabled.
4. Click "Add API token", give it a label, and copy the generated token immediately
   (Zendesk only shows it once).
5. Paste it into $Token above. Authentication uses $Email + "/token" as the username
   and the token as the password (handled by the Basic auth header below). #>
$Token = "YOURToken"

$OutputDir = "C:\ZenDeskExport\Tickets"
$Checkpoint = "$OutputDir\ticket_checkpoint.txt"
$LastRunFile = "$OutputDir\last_run_time.txt"

New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

$Auth = [Convert]::ToBase64String(
    [Text.Encoding]::ASCII.GetBytes("$Email/token`:$Token")
)

$Headers = @{
    Authorization = "Basic $Auth"
}

function Start-SleepProgress {
    param([int]$Num)
    1..$Num | ForEach-Object {
        $remaining = $Num - $_
        $ts = [timespan]::FromSeconds($remaining)
        if ($ts.TotalMinutes -ge 1) {
            $remainingText = "{0}m {1}s left" -f $ts.Minutes, $ts.Seconds
        }
        else {
            $remainingText = "{0}s left" -f $ts.Seconds
        }
        Write-Progress `
            -Activity "Sleeping for $Num seconds" `
            -Status $remainingText `
            -PercentComplete ($_ / $Num * 100)

        Start-Sleep 1
    }
    Write-Progress -Activity "Sleeping for $Num seconds" -Completed
}

$RunStartTime = [int][double]::Parse((Get-Date -UFormat %s))

if (Test-Path $Checkpoint) {
    $Url = Get-Content $Checkpoint -Raw
}

if (-not $Url) {

    if (Test-Path $LastRunFile) {
        $StartTime = Get-Content $LastRunFile -Raw
    }

    if (-not $StartTime) {
        $StartTime = 946684800
    }

    $Url = "https://$Subdomain.zendesk.com/api/v2/incremental/tickets/cursor.json?start_time=$StartTime"
}

$page = (Get-ChildItem "$OutputDir\tickets_*.json" -ErrorAction SilentlyContinue).Count + 1

$TicketsSoFar = 0

do {

    try {

        $Response = Invoke-WebRequest `
            -Uri $Url `
            -Headers $Headers `
            -Method Get

        $Result = $Response.Content | ConvertFrom-Json

    }
    catch {

        if ($_.Exception.Response.StatusCode.value__ -eq 429) {

            $retry = $_.Exception.Response.Headers["Retry-After"]

            if (-not $retry) { $retry = 30 }

            Write-Host "Rate Limited by Zendesk. Waiting $retry seconds" -ForegroundColor Red

            Start-SleepProgress -Num $retry

            continue
        }

        throw
    }

    $Result.tickets |
        ConvertTo-Json -Depth 100 |
        Set-Content "$OutputDir\tickets_$page.json"

    if ($Result.after_url) {
        Set-Content $Checkpoint $Result.after_url
    }

    $TicketsSoFar += $Result.tickets.Count

    Write-Host "Saved Page $page - $($Result.tickets.Count) Records | $TicketsSoFar Total Records Saved"

    $Url = $Result.after_url

    $page++

    Start-Sleep -Seconds 6

}
while (-not $Result.end_of_stream)

Remove-Item $Checkpoint -ErrorAction SilentlyContinue

Set-Content $LastRunFile $RunStartTime

Write-Host "Ticket export complete"