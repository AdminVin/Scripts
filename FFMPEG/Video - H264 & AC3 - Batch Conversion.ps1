# Install FFMPEG - https://www.gyan.dev/ffmpeg/builds/
# Add FFMPEG to the PATH (sysdm.cpl > Advanced > Enviroment Variables > Select Path > Edit > New > Add FFMPEG 'bin' Location)
# Alternatively: Copy ffmpeg.exe, ffplay.exe, and ffprobe.exe to C:/Windows/System32

# Quality Limits:
# Movies: 640k 6 Channels / 320k 2 Channels
# TV Shows: 320k 6 Channels / 256k 2 Channels

# --- CONFIG ---
#$DIR = "\\192.168.103.40\Media\TV\"
$DIR = "\\192.168.103.40\Media\Movies\"

# --- STEP 1: Get all video files and display them as they are found ---
Write-Host "Scanning for video files in $DIR..." -ForegroundColor Green

# Initialize array
$videoFiles = @()

Get-ChildItem -Path $DIR -Recurse -Include *.mkv, *.mp4 | ForEach-Object {
    Write-Host "Found: $($_.Name)" -ForegroundColor Green
    $videoFiles += $_
}

foreach ($file in $videoFiles) {

    $origFile = $file.FullName
    $convertedFile = Join-Path $file.DirectoryName ("_Converting-" + $file.BaseName + $file.Extension)

    Write-Host "Converting: $origFile" -ForegroundColor Red

    # --- STEP 2: Check video codec and bitrate ---
    $videoInfo = & ffprobe -v error `
        -select_streams v:0 `
        -show_entries stream=codec_name,bit_rate `
        -of default=noprint_wrappers=1:nokey=1 `
        "$origFile"

    $videoLines = $videoInfo -split "`n"
    $vidCodec = $videoLines[0].Trim()
    $vidBitrate = 0
    if ($videoLines.Length -gt 1 -and [int]::TryParse($videoLines[1], [ref]$null)) {
        $vidBitrate = [int]$videoLines[1] / 1000  # Convert to kbps
    }

    Write-Host "Video Codec: $vidCodec, Bitrate: $vidBitrate kbps" -ForegroundColor Green

    # --- STEP 3: Convert using ffmpeg (single command) ---
    try {
        & ffmpeg -y -i "$origFile" `
            -vcodec h264_nvenc -profile:v high -level 4.1 -rc vbr -cq 18 -b:v 0 `
            -maxrate 9000k -bufsize 18000k -vf "scale='if(gt(ih,1080),-2,iw)':1080" `
            -c:a ac3 -b:a 640k -ac 6 -metadata:s:a language=eng `
            -avoid_negative_ts make_zero -max_muxing_queue_size 4096 -ignore_chapters 1 `
            -movflags +faststart -threads 4 "$convertedFile"

        Write-Host "Conversion successful: $origFile" -ForegroundColor Green
    }
    catch {
        Write-Host "Error converting: $origFile" -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        continue
    }

    # --- STEP 4: Delete original file after successful conversion ---
    try {
        Remove-Item -Path $origFile -Force
        Write-Host "Deleted original file: $origFile" -ForegroundColor Green
    }
    catch {
        Write-Host "Error deleting original: $origFile" -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        continue
    }

    # --- STEP 5: Replace with converted file ---
    try {
        Rename-Item -Path $convertedFile -NewName $origFile -Force
        Write-Host "Replaced with converted file: $origFile" -ForegroundColor Green
    }
    catch {
        Write-Host "Error replacing file: $origFile" -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        continue
    }

    Write-Host "Finished processing: $origFile" -ForegroundColor Green
}