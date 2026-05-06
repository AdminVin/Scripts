# Display file info and rename to YYYY-MM-DD_HHMM using EXIF or CreationTime
$sharePath = "\\pi.local\web\images"
$whatIf    = $false  # Set to $false to perform actual renames

function Get-ExifDateRaw {
    param([string]$filePath)
    try {
        $shell  = New-Object -ComObject Shell.Application
        $folder = $shell.Namespace((Split-Path $filePath))
        $file   = $folder.ParseName((Split-Path $filePath -Leaf))
        $raw    = $folder.GetDetailsOf($file, 12)
        if ($raw) {
            $clean = $raw -replace '[^\x20-\x7E]', ''
            return [datetime]::Parse($clean)
        }
    } catch { }
    return $null
}

function Get-UniqueFileName {
    param([string]$folder, [string]$baseName, [string]$ext)
    $candidate = Join-Path $folder ("$baseName$ext")
    $counter   = 1
    while (Test-Path $candidate) {
        $candidate = Join-Path $folder ("${baseName}_$counter$ext")
        $counter++
    }
    return Split-Path $candidate -Leaf
}

try {
    $files = Get-ChildItem -Path $sharePath -File -ErrorAction Stop

    if ($files.Count -eq 0) {
        Write-Host "No files found in: $sharePath" -ForegroundColor Yellow
    } else {
        $results = foreach ($f in $files) {
            $exifDate = Get-ExifDateRaw $f.FullName
            $useDate  = if ($exifDate) { $exifDate } else { $f.CreationTime }
            $source   = if ($exifDate) { "EXIF" } else { "CreationTime" }

            $baseName = $useDate.ToString('yyyy-MM-dd_HHmm')
            $ext      = $f.Extension.ToLower()
            $newName  = Get-UniqueFileName $sharePath $baseName $ext

            if ($f.Name -ne $newName) {
                if (-not $whatIf) {
                    Rename-Item -Path $f.FullName -NewName $newName -ErrorAction Stop
                }
            }

            [PSCustomObject]@{
                'Original Name'  = $f.Name
                'Creation Date'  = $f.CreationTime.ToString('yyyy-MM-dd HH:mm:ss')
                'EXIF Date'      = if ($exifDate) { $exifDate.ToString('yyyy-MM-dd HH:mm:ss') } else { "N/A" }
                'Source Used'    = $source
                'New Name'       = if ($f.Name -ne $newName) { $newName } else { "(unchanged)" }
            }
        }

        $results | Format-Table -AutoSize

        if ($whatIf) {
            Write-Host "*** DRY RUN — no files were renamed. Set `$whatIf = `$false to apply. ***" -ForegroundColor Yellow
        } else {
            Write-Host "Rename complete." -ForegroundColor Green
        }
    }
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}