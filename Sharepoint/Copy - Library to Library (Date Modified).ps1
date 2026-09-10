<# ============================================================
# SharePoint Folder Migration
 - Uses Get-PnPListItem with paging (NOT Get-PnPFolderItem -Recursive,
   which silently under-counts on deep folder structures)
 - Recreates full subfolder structure at destination
 - Resume logic based on DATE MODIFIED (not size) - if destination
   file exists and its modified date is >= source's modified date,
   it is skipped. If source is newer, it is re-copied and flagged.
 - Logs source size + modified date per file (for later drift check)
 - Excludes SharePoint system "Forms" folder contents
 - Copy ONLY - nothing is deleted at source


# ============================================================
# Client ID - Setup
ONE-TIME SETUP - Register Entra ID App for PnP PowerShell
Only needs to be run once per tenant. Reuse the resulting ClientID
in every Connect-PnPOnline call across all migration scripts.

Steps:
1. Run the command below in an elevated PowerShell session
2. A browser window will open asking you to sign in as an admin
3. Check "Consent on behalf of your organization" and Approve
4. Copy the returned ClientID and use it as $ClientID in migration scripts

Command:
Register-PnPEntraIDAppForInteractiveLogin -ApplicationName "PnP Management Shell" -Tenant "eastbrunswickschools.onmicrosoft.com"

Result (already registered for this tenant):
App PnP Management Shell with id xxxxxxx-xxxx-xxx-xxxxxxxx created.


# ============================================================
# Notes
HOW TO READ A SHAREPOINT URL AND SET $SourceSiteUrl / $SourceLibraryPath

Every SharePoint URL breaks down into: [Site] + [Library] + [Folder path]
The tricky part is telling the site portion apart from the library portion.

CASE 1 - Site is a subsite (URL contains "/sites/<name>/"):
  Example: https://YOURTENANT.sharepoint.com/sites/Admin/Finance/Forms/AllItems.aspx
  - Site      = everything through "/sites/<name>"   -> /sites/Admin
  - Library   = the segment right after the site      -> Finance
  Set:
    $SourceSiteUrl     = "https://YOURTENANT.sharepoint.com/sites/Admin"
    $SourceLibraryPath = "Finance"

CASE 2 - Site is the ROOT site collection (URL has NO "/sites/" segment):
  Example: https://YOURTENANT.sharepoint.com/Administration/Forms/AllItems.aspx?id=%2FAdministration%2FManagement%20Team
  - No "/sites/" present = this library lives directly on the root site
  - Library   = first path segment after the domain    -> Administration
  - Folder    = decode the "id=" parameter to confirm  -> /Administration/Management Team
                (%2F = "/", %20 = space)
  Set:
    $SourceSiteUrl     = "https://YOURTENANT.sharepoint.com"
    $SourceLibraryPath = "Administration/Management Team"

IMPORTANT: $SourceLibraryPath / $DestLibraryPath must start with the actual
LIBRARY NAME (e.g. "Administration", "Shared Documents") as its first segment -
everything after that is treated as the folder path within that library.
#>


##########################################################################
# Client ID (see above)
$ClientID           = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Source
$SourceSiteUrl      = "https://YOURTENANT.sharepoint.com"
$SourceLibraryPath  = "Administration/Management Team"

# Destination
$DestSiteUrl        = "https://YOURTENANT.sharepoint.com/sites/Administration"
$DestLibraryPath    = "Shared Documents/Management Team"
##########################################################################

$SourceSitePath = ([Uri]$SourceSiteUrl).AbsolutePath.TrimEnd('/')
$DestSitePath   = ([Uri]$DestSiteUrl).AbsolutePath.TrimEnd('/')

$sourceSegments   = $SourceLibraryPath -split '/', 2
$SourceListTitle  = $sourceSegments[0]
$SourceSubPath    = if ($sourceSegments.Count -gt 1) { $sourceSegments[1] } else { "" }

$destSegments     = $DestLibraryPath -split '/', 2
$DestListTitle    = $destSegments[0]
$DestSubPath      = if ($destSegments.Count -gt 1) { $destSegments[1] } else { "" }

$LogFolder = "C:\FinanceMigration"
if (-not (Test-Path $LogFolder)) {
    New-Item -Path $LogFolder -ItemType Directory | Out-Null
    Write-Host "Created log folder: $LogFolder" -ForegroundColor Green
} else {
    Write-Host "Log folder already exists: $LogFolder" -ForegroundColor DarkGray
}
$DestSiteName       = ($DestSitePath -split '/')[-1]
$DestFolderName     = ($DestLibraryPath.TrimEnd('/') -split '/')[-1]
$CsvLogPath         = Join-Path $LogFolder "$DestSiteName - $DestFolderName.csv"


Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Migration started: $(Get-Date)" -ForegroundColor Cyan
Write-Host "Source: $SourceSiteUrl/$SourceLibraryPath  (List: $SourceListTitle | SubPath: $SourceSubPath)" -ForegroundColor Cyan
Write-Host "Destination: $DestSiteUrl/$DestLibraryPath  (List: $DestListTitle | SubPath: $DestSubPath)" -ForegroundColor Cyan
Write-Host "Enumeration method: Get-PnPListItem (paged) - NOT Get-PnPFolderItem" -ForegroundColor Cyan
Write-Host "Resume check: DATE MODIFIED (source newer than dest = re-copy)" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

$detailLog = @()

function Get-PnPLibraryFiles {
    param(
        [string]$ListTitle,
        [string]$SubPathFilter
    )
    $items = Get-PnPListItem -List $ListTitle -PageSize 500 -Fields "FileLeafRef","FileRef","FSObjType","File_x0020_Size","Modified"
    $files = $items | Where-Object { $_["FSObjType"] -ne 1 -and $_["FileRef"] -notmatch "/Forms/" }
    if ($SubPathFilter) {
        $files = $files | Where-Object { $_["FileRef"] -like "*/$SubPathFilter/*" -or $_["FileRef"] -like "*/$SubPathFilter" }
    }
    return $files
}

try {
    Write-Host "`nConnecting to source site..." -ForegroundColor Yellow
    Connect-PnPOnline -Url $SourceSiteUrl -ClientID $ClientID
    $currentContext = "source"

    Write-Host "Enumerating source files via Get-PnPListItem (paged, reliable for deep structures)..." -ForegroundColor Yellow
    $sourceFiles = Get-PnPLibraryFiles -ListTitle $SourceListTitle -SubPathFilter $SourceSubPath
    $totalCount = $sourceFiles.Count
    Write-Host "Found $totalCount source file(s) (system Forms folder excluded).`n" -ForegroundColor Green

    Write-Host "Checking destination for already-copied files..." -ForegroundColor Yellow
    Connect-PnPOnline -Url $DestSiteUrl -ClientID $ClientID
    $currentContext = "dest"

    $destExisting = @{}
    try {
        $existingDestFiles = Get-PnPLibraryFiles -ListTitle $DestListTitle -SubPathFilter $DestSubPath
        foreach ($ef in $existingDestFiles) {
            $destExisting[$ef["FileRef"]] = [datetime]$ef["Modified"]
        }
    } catch { }
    Write-Host "Found $($destExisting.Count) existing file(s) at destination.`n" -ForegroundColor Green

    $sourceRootPrefix = "$SourceSitePath/$SourceLibraryPath/"
    $destRootPrefix    = "$DestSitePath/$DestLibraryPath/"

    $counter = 0
    $successCount = 0
    $skipCount = 0
    $newerVersionCount = 0
    $failCount = 0
    $foldersEnsured = @{}

    foreach ($file in $sourceFiles) {
        $counter++
        $fileServerRelativeUrl = $file["FileRef"]
        $fileName        = $file["FileLeafRef"]
        $sourceSize      = $file["File_x0020_Size"]
        $sourceModified  = [datetime]$file["Modified"]

        $relativePath = $fileServerRelativeUrl -replace [regex]::Escape($sourceRootPrefix), ""
        $relativeFolder = Split-Path $relativePath -Parent
        $relativeFolder = if ($relativeFolder) { $relativeFolder -replace '\\','/' } else { "" }
        $targetFolderUrl = if ($relativeFolder) { "$DestSiteUrl/$DestLibraryPath/$relativeFolder" } else { "$DestSiteUrl/$DestLibraryPath" }
        $destCheckUrl = if ($relativeFolder) { "$destRootPrefix$relativeFolder/$fileName" } else { "$destRootPrefix$fileName" }

        Write-Host "[$counter / $totalCount] $relativePath" -ForegroundColor White

        $isNewerVersion = $false
        $destModified = $null

        if ($destExisting.ContainsKey($destCheckUrl)) {
            $destModified = $destExisting[$destCheckUrl]
            if ($destModified -ge $sourceModified) {
                Write-Host "   -> Already copied, destination up to date (Dest: $destModified >= Source: $sourceModified) - SKIPPED" -ForegroundColor DarkGray
                $skipCount++
                $detailLog += [PSCustomObject]@{
                    Timestamp = Get-Date; FileName = $fileName; RelativePath = $relativePath
                    SourceSize = $sourceSize; SourceModified = $sourceModified; DestModified = $destModified
                    NewerVersion = "No"; DestFolder = $targetFolderUrl
                    Status = "Skipped (destination up to date)"; Error = ""
                }
                continue
            }
            else {
                $isNewerVersion = $true
                $newerVersionCount++
                Write-Host "   -> NEWER VERSION detected at source (Source: $sourceModified > Dest: $destModified) - RE-COPYING" -ForegroundColor Yellow
            }
        }

        try {
            if ($relativeFolder -and -not $foldersEnsured.ContainsKey($relativeFolder)) {
                if ($currentContext -ne "dest") {
                    Connect-PnPOnline -Url $DestSiteUrl -ClientID $ClientID
                    $currentContext = "dest"
                }
                Resolve-PnPFolder -SiteRelativePath "$DestLibraryPath/$relativeFolder" | Out-Null
                $foldersEnsured[$relativeFolder] = $true
                Write-Host "   -> Created destination folder: $DestLibraryPath/$relativeFolder" -ForegroundColor DarkCyan
            }

            if ($currentContext -ne "source") {
                Connect-PnPOnline -Url $SourceSiteUrl -ClientID $ClientID
                $currentContext = "source"
            }

            Copy-PnPFile -SourceUrl $fileServerRelativeUrl `
                         -TargetUrl $targetFolderUrl `
                         -Force `
                         -IgnoreVersionHistory:$false `
                         -ErrorAction Stop

            if ($isNewerVersion) {
                Write-Host "   -> Success (newer version copied over existing destination file)" -ForegroundColor Green
            } else {
                Write-Host "   -> Success" -ForegroundColor Green
            }
            $successCount++

            $detailLog += [PSCustomObject]@{
                Timestamp = Get-Date; FileName = $fileName; RelativePath = $relativePath
                SourceSize = $sourceSize; SourceModified = $sourceModified; DestModified = $destModified
                NewerVersion = if ($isNewerVersion) { "Yes" } else { "No" }
                DestFolder = $targetFolderUrl
                Status = if ($isNewerVersion) { "Copied (newer version replaced destination)" } else { "Copied" }
                Error = ""
            }
        }
        catch {
            Write-Host "   -> FAILED: $($_.Exception.Message)" -ForegroundColor Red
            $failCount++

            $detailLog += [PSCustomObject]@{
                Timestamp = Get-Date; FileName = $fileName; RelativePath = $relativePath
                SourceSize = $sourceSize; SourceModified = $sourceModified; DestModified = $destModified
                NewerVersion = if ($isNewerVersion) { "Yes" } else { "No" }
                DestFolder = $targetFolderUrl
                Status = "FAILED"; Error = $_.Exception.Message
            }
        }
    }

    Write-Host "`n============================================================" -ForegroundColor Cyan
    Write-Host "COPY COMPLETE" -ForegroundColor Cyan
    Write-Host "Total source files:      $totalCount"
    Write-Host "Copied (first time):     $($successCount - $newerVersionCount)" -ForegroundColor Green
    Write-Host "Copied (newer version):  $newerVersionCount" -ForegroundColor Yellow
    Write-Host "Skipped (up to date):    $skipCount" -ForegroundColor DarkGray
    Write-Host "Failed:                  $failCount" -ForegroundColor $(if ($failCount -gt 0) { "Red" } else { "Green" })

    Write-Host "`nConnecting to destination site to verify..." -ForegroundColor Yellow
    Connect-PnPOnline -Url $DestSiteUrl -ClientID $ClientID
    $destFiles = Get-PnPLibraryFiles -ListTitle $DestListTitle -SubPathFilter $DestSubPath
    $destCount = $destFiles.Count

    Write-Host "`n--- RECONCILIATION ---" -ForegroundColor Cyan
    Write-Host "Source file count:      $totalCount"
    Write-Host "Destination file count: $destCount"

    $reconcileResult = if ($totalCount -eq $destCount -and $failCount -eq 0) { "MATCH" } else { "MISMATCH - REVIEW" }
    Write-Host "Result: $reconcileResult" -ForegroundColor $(if ($reconcileResult -eq "MATCH") { "Green" } else { "Red" })

    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "Migration ended: $(Get-Date)" -ForegroundColor Cyan
}
finally {
    $detailLog | Export-Csv -Path $CsvLogPath -NoTypeInformation -Encoding UTF8
    Write-Host "`nDetailed per-file log written to $CsvLogPath" -ForegroundColor Green
}