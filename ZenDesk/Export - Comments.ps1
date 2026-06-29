<# IMPORTANT!
    - Run 'Export - Tickets.ps1' before executing this script.
    - This will export all replys (comments) and attachments for tickets. 
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

$TicketsDir = "C:\ZenDeskExport\Tickets"
$CommentsDir = "C:\ZenDeskExport\Comments"
$AttachmentsDir = "$CommentsDir\Attachments"

New-Item -ItemType Directory -Force -Path $CommentsDir | Out-Null

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

$AllTickets = Get-ChildItem "$TicketsDir\tickets_*.json" | ForEach-Object {
    Get-Content $_ -Raw | ConvertFrom-Json
}

$Total = $AllTickets.Count
$i = 0

foreach ($Ticket in $AllTickets) {

    $i++

    if (-not $Ticket.id) { continue }

    $TicketID = $Ticket.id

    Write-Host "Processing Ticket $TicketID | $i / $Total Tickets Processed"

    $CommentsFile = "$CommentsDir\$TicketID.json"

    $IsCacheFresh = $false

    if (Test-Path $CommentsFile) {

        $CommentsFileTime = (Get-Item $CommentsFile).LastWriteTimeUtc
        $TicketUpdatedTime = (Get-Date $Ticket.updated_at).ToUniversalTime()

        if ($CommentsFileTime -ge $TicketUpdatedTime) {
            $IsCacheFresh = $true
        }
    }

    if ($IsCacheFresh) {

        $Comments = Get-Content $CommentsFile -Raw | ConvertFrom-Json
    }
    else {

        $Comments = @()

        $Url = "https://$Subdomain.zendesk.com/api/v2/tickets/$TicketID/comments.json"

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

                if ($_.Exception.Response.StatusCode.value__ -eq 404) {

                    Write-Host "Ticket $TicketID not found (likely archived). Skipping."

                    break
                }

                throw
            }

            $Comments += $Result.comments

            $Url = $Result.next_page

            Start-Sleep -Milliseconds 500

        }
        while ($Url)

        foreach ($Comment in $Comments) {

            $ExistingUrls = @($Comment.attachments | ForEach-Object { $_.content_url })

            $InlineMatches = [regex]::Matches($Comment.html_body, '<img[^>]+src="([^">]+)"')

            $InlineIndex = 0
            $InlineAttachments = @()

            foreach ($InlineMatch in $InlineMatches) {

                $ImageUrl = $InlineMatch.Groups[1].Value

                if ($ImageUrl -notmatch "^https?://$([regex]::Escape($Subdomain)).zendesk.com/") {
                    continue
                }

                if ($ExistingUrls -contains $ImageUrl) {
                    continue
                }

                $NameMatch = [regex]::Match($ImageUrl, 'name=([^&]+)')

                if ($NameMatch.Success) {
                    $InlineFileName = [Uri]::UnescapeDataString($NameMatch.Groups[1].Value)
                }
                else {
                    $InlineFileName = "inline_$($Comment.id)_$InlineIndex.jpg"
                }

                $InlineAttachments += [PSCustomObject]@{
                    id          = "$($Comment.id)IL$InlineIndex"
                    file_name   = $InlineFileName
                    content_url = $ImageUrl
                }

                $InlineIndex++
            }

            if ($InlineAttachments.Count -gt 0) {
                $Comment.attachments = @($Comment.attachments) + $InlineAttachments
            }
        }

        $Comments |
            ConvertTo-Json -Depth 100 |
            Set-Content $CommentsFile
    }

    foreach ($Comment in $Comments) {

        foreach ($Attachment in $Comment.attachments) {

            $SafeFileName = [string]::Join("_", $Attachment.file_name.Split([System.IO.Path]::GetInvalidFileNameChars()))

            $TicketAttachmentsDir = "$AttachmentsDir\$TicketID"
            $AttachmentPath = "$TicketAttachmentsDir\$($Attachment.id)_$SafeFileName"

            if (Test-Path $AttachmentPath) {
                continue
            }

            New-Item -ItemType Directory -Force -Path $TicketAttachmentsDir | Out-Null

            do {

                $Retry = $false

                try {

                    Invoke-WebRequest `
                        -Uri $Attachment.content_url `
                        -Headers $Headers `
                        -Method Get `
                        -OutFile $AttachmentPath
                }
                catch {

                    if ($_.Exception.Message -like "*scheme*not supported*") {

                        Write-Host "  Unsupported URL scheme, skipping: $($Attachment.content_url)"
                        break
                    }

                    if ($_.Exception.Response.StatusCode.value__ -eq 429) {

                        $retry = $_.Exception.Response.Headers["Retry-After"]

                        if (-not $retry) { $retry = 30 }

                        Write-Host "Rate Limited by Zendesk on attachment. Waiting $retry seconds" -ForegroundColor Red

                        Start-SleepProgress -Num $retry

                        $Retry = $true
                    }
                    else {

                        Write-Host "  Failed to download attachment, skipping: $($Attachment.content_url) - $_" -ForegroundColor Red
                        break
                    }
                }

            }
            while ($Retry)

            Start-Sleep -Milliseconds 500
        }
    }

}

Write-Host "Comment export complete"
