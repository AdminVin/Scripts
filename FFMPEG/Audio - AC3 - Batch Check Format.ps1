# --- CONFIG ---
$TV_DIR = "\\192.168.103.40\Media\TV\The Sopranos (1999)"

# Track shows that contain non-AC3 episodes
$showsNeedingFix = New-Object System.Collections.Generic.HashSet[string]

# --- Get all video files ---
$videoFiles = Get-ChildItem -Path $TV_DIR -Recurse -Include *.mkv, *.mp4

foreach ($file in $videoFiles) {

    $filePath = $file.FullName
    $showFolder = $file.Directory.Parent.FullName

    # Use ffprobe to get audio codec + bitrate (first audio stream)
    $ffprobeOutput = & ffprobe -v error `
        -select_streams a:0 `
        -show_entries stream=codec_name,bit_rate `
        -of default=noprint_wrappers=1:nokey=1 `
        "$filePath"

    if (-not $ffprobeOutput) {
        Write-Host "$($file.Name) - No audio stream found" -ForegroundColor Yellow
        $showsNeedingFix.Add($showFolder) | Out-Null
        continue
    }

    $codec = $ffprobeOutput[0]
    $bitrateRaw = $ffprobeOutput[1]

    # --- Safe Bitrate Handling ---
    if ($bitrateRaw -match '^\d+$') {
        $bitrateK = [math]::Round([int]$bitrateRaw / 1000)
        $bitrateFormatted = "$($bitrateK)k"
    }
    else {
        $bitrateK = $null
        $bitrateFormatted = "Unknown"
    }

    $output = "$($file.Name) - $codec / $bitrateFormatted"

    # --- Compliance Check (AC3 ONLY) ---
    if ($codec -eq "ac3") {
        Write-Host $output -ForegroundColor Green
    }
    else {
        Write-Host $output -ForegroundColor Red
        $showsNeedingFix.Add($showFolder) | Out-Null
    }
}

# --- FINAL AUDIT SUMMARY ---
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Shows With Episodes NOT in AC3:" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

if ($showsNeedingFix.Count -eq 0) {
    Write-Host "All shows are fully AC3 compliant." -ForegroundColor Green
}
else {
    foreach ($show in $showsNeedingFix) {
        Write-Host $show -ForegroundColor Red
    }
}