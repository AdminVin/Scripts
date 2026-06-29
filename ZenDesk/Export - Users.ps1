<# IMPORTANT!
    - This will export all users that have ever interacted with ZenDesk.
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

$OutputDir = "C:\ZenDeskExport\Users"
$Checkpoint = "$OutputDir\user_checkpoint.txt"

New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

$Auth = [Convert]::ToBase64String(
    [Text.Encoding]::ASCII.GetBytes("$Email/token`:$Token")
)

$Headers = @{
    Authorization = "Basic $Auth"
}

if (Test-Path $Checkpoint) {
    $Url = Get-Content $Checkpoint -Raw
}
else {
    $Url = "https://$Subdomain.zendesk.com/api/v2/users.json?page[size]=100"
}

$page = (Get-ChildItem "$OutputDir\users_*.json" -ErrorAction SilentlyContinue).Count + 1

$UsersSoFar = 0

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

            Write-Host "429 received. Waiting $retry seconds"

            Start-Sleep -Seconds $retry

            continue
        }

        throw
    }

    $Result.users |
        ConvertTo-Json -Depth 100 |
        Set-Content "$OutputDir\users_$page.json"

    Set-Content $Checkpoint $Result.links.next

    $UsersSoFar += $Result.users.Count

    Write-Host "Saved Page $page - $($Result.users.Count) Records | $UsersSoFar Total Records Saved"

    $Url = $Result.links.next

    $page++

    Start-Sleep -Milliseconds 500

}
while ($Result.meta.has_more)

Remove-Item $Checkpoint -ErrorAction SilentlyContinue

Write-Host "User export complete"
