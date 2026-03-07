# Install FFMPEG - https://www.gyan.dev/ffmpeg/builds/
# Add FFMPEG to the PATH (sysdm.cpl > Advanced > Enviroment Variables > Select Path > Edit > New > Add FFMPEG 'bin' Location)
# Alternatively: Copy ffmpeg.exe, ffplay.exe, and ffprobe.exe to C:/Windows/System32

# Quality Limits:
# Movies: 640k 6 Channels / 320k 2 Channels
# TV Shows: 320k 6 Channels / 256k 2 Channels

# --- CONFIG ---
$FILE = "\\192.168.103.40\Media\Movies\How the Grinch Stole Christmas!\Move.mkv"

if (-Not (Test-Path $FILE)) {
    Write-Host "File does not exist: $FILE" -ForegroundColor Red
    exit
}

Write-Host "Processing single file: $FILE" -ForegroundColor Green

$origFile = $FILE

# Fix for extension extraction (PowerShell has no -LeafExtension)
$folder = Split-Path $FILE
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($FILE)
$extension = [System.IO.Path]::GetExtension($FILE)

$convertedFile = Join-Path $folder ("_Converting-" + $baseName + $extension)

# --- STEP 1: Display the file being processed ---
Write-Host "File: $origFile" -ForegroundColor Red

# --- STEP 2: Check video codec and bitrate ---
$vidCodec = (& ffprobe -v error `
    -select_streams v:0 `
    -show_entries stream=codec_name `
    -of default=noprint_wrappers=1:nokey=1 `
    "$origFile").Trim()

# Get video duration in seconds
$durationSec = (& ffprobe -v error `
    -show_entries format=duration `
    -of default=noprint_wrappers=1:nokey=1 `
    "$origFile") -as [double]

# Compute approximate bitrate (kbps)
if ($durationSec -gt 0) {
    $fileSizeBytes = (Get-Item $origFile).Length
    $vidBitrate = [math]::Round(($fileSizeBytes * 8 / 1000) / $durationSec)
}
else {
    $vidBitrate = 0
}

Write-Host " - Video Codec: $vidCodec, Bitrate: $vidBitrate kbps" -ForegroundColor Green

# --- STEP 3: Convert using ffmpeg (single command) ---
if ($vidCodec -eq "h264" -and $vidBitrate -gt 10000) {
    try {
        & ffmpeg -y -i "$origFile" `
            -vcodec h264_nvenc -profile:v high -level 4.1 -rc vbr -cq 18 -b:v 0 `
            -maxrate 9000k -bufsize 18000k -vf "scale='if(gt(ih,1080),-2,iw)':1080" `
            -c:a ac3 -b:a 640k -ac 6 -metadata:s:a language=eng `
            -avoid_negative_ts make_zero -max_muxing_queue_size 4096 -ignore_chapters 1 `
            -movflags +faststart -threads 4 "$convertedFile"

        Write-Host " - Conversion successful: $origFile" -ForegroundColor Green
    }
    catch {
        Write-Host " - Error converting: $origFile" -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        exit
    }
}
else {
    Write-Host " - Skipping (not H.264 or bitrate <= 10000 kbps): $origFile" -ForegroundColor Yellow
    exit
}

# --- STEP 4: Backup/Delete original file after successful conversion ---
try {
    Rename-Item -Path $origFile -NewName ($origFile + ".old") -Force
    #Remove-Item -Path $origFile -Force
    Write-Host " - Deleted original file: $origFile" -ForegroundColor Green
}
catch {
    Write-Host " - Error deleting original: $origFile" -ForegroundColor Red
    Write-Host $_ -ForegroundColor Red
    exit
}

# --- STEP 5: Replace with converted file ---
try {
    Rename-Item -Path $convertedFile -NewName $origFile -Force
    Write-Host " - Replaced with converted file: $origFile" -ForegroundColor Green
}
catch {
    Write-Host " - Error replacing file: $origFile" -ForegroundColor Red
    Write-Host $_ -ForegroundColor Red
    exit
}

Write-Host " - Finished processing: $origFile" -ForegroundColor Green