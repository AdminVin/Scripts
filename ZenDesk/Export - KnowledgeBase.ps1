<# IMPORTANT!
    - This will export all Knowledge Base/Articles from Zendesk.
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

$OutputDir = "C:\ZenDeskExport\Knowledge Base"
$AttachmentsDir = "$OutputDir\Attachments"

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

$Articles = @()

$Url = "https://$Subdomain.zendesk.com/api/v2/help_center/articles.json"

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

    $Articles += $Result.articles

    $Url = $Result.next_page

    Start-Sleep -Milliseconds 500

}
while ($Url)

$Articles |
    ConvertTo-Json -Depth 100 |
    Set-Content "$OutputDir\articles.json"

$Total = $Articles.Count
$i = 0

foreach ($Article in $Articles) {

    $i++

    if (-not $Article.id) { continue }

    $ArticleID = $Article.id

    Write-Host "Processing Article $ArticleID | $i / $Total Articles Processed"

    $AttachmentsFile = "$AttachmentsDir\$ArticleID.json"

    if (Test-Path $AttachmentsFile) {

        $ArticleAttachments = Get-Content $AttachmentsFile -Raw | ConvertFrom-Json
    }
    else {

        $ArticleAttachments = @()

        $Url = "https://$Subdomain.zendesk.com/api/v2/help_center/articles/$ArticleID/attachments.json"

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

            $ArticleAttachments += $Result.article_attachments

            $Url = $Result.next_page

            Start-Sleep -Milliseconds 500

        }
        while ($Url)

        $ExistingUrls = @($ArticleAttachments | ForEach-Object { $_.content_url })

        $InlineMatches = [regex]::Matches($Article.body, '<img[^>]+src="([^">]+)"')

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
                $InlineFileName = "inline_$($ArticleID)_$InlineIndex.jpg"
            }

            $InlineAttachments += [PSCustomObject]@{
                id          = "$($ArticleID)IL$InlineIndex"
                file_name   = $InlineFileName
                content_url = $ImageUrl
            }

            $InlineIndex++
        }

        if ($InlineAttachments.Count -gt 0) {
            $ArticleAttachments = @($ArticleAttachments) + $InlineAttachments
        }

        New-Item -ItemType Directory -Force -Path $AttachmentsDir | Out-Null

        $ArticleAttachments |
            ConvertTo-Json -Depth 100 |
            Set-Content $AttachmentsFile
    }

    foreach ($Attachment in $ArticleAttachments) {

        $SafeFileName = [string]::Join("_", $Attachment.file_name.Split([System.IO.Path]::GetInvalidFileNameChars()))

        $ArticleAttachmentsDir = "$AttachmentsDir\$ArticleID"
        $AttachmentPath = "$ArticleAttachmentsDir\$($Attachment.id)_$SafeFileName"

        if (Test-Path $AttachmentPath) {
            continue
        }

        New-Item -ItemType Directory -Force -Path $ArticleAttachmentsDir | Out-Null

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
                    throw
                }
            }

        }
        while ($Retry)

        Start-Sleep -Milliseconds 500
    }

}

Write-Host "KB export complete"
