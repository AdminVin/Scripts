# Install FFMPEG - https://www.gyan.dev/ffmpeg/builds/
# Add FFMPEG to the PATH (sysdm.cpl > Advanced > Enviroment Variables > Select Path > Edit > New > Add FFMPEG 'bin' Location)
# Alternatively: Copy ffmpeg.exe, ffplay.exe, and ffprobe.exe to C:/Windows/System32

# Quality Limits:
# Movies: 640k 6 Channels / 320k 2 Channels
# TV Shows: 320k 6 Channels / 256k 2 Channels

# --- CONFIG ---
$DIR = "\\192.168.103.40\Media\TV\"
#DIR = "\\192.168.103.40\Media\Movies\"

# --- STEP 1: Get all video files ---
$videoFiles = Get-ChildItem -Path $DIR -Recurse -Include *.mkv, *.mp4

foreach ($file in $videoFiles) {

    $origFile = $file.FullName
    $convertedFile = Join-Path $file.DirectoryName ("_Converting-" + $file.BaseName + $file.Extension)
    $backupFile = $origFile + ".old"

    # --- STEP 2: Check audio codec (first audio stream) ---
    $codec = & ffprobe -v error `
        -select_streams a:0 `
        -show_entries stream=codec_name `
        -of default=noprint_wrappers=1:nokey=1 `
        "$origFile"

    if (-not $codec) {
        Write-Host "Skipping (No audio found): $origFile"
        continue
    }

    # --- SKIP if already AC3 ---
    if ($codec -eq "ac3" -or $codec -eq "aac") {
        Write-Host "Skipping (Already AC3 or AAC): $origFile" -ForegroundColor Yellow
        continue
    }

    Write-Host "Converting: $origFile (Current codec: $codec)" -ForegroundColor Red

    # --- STEP 3: Convert using ffmpeg ---
    try {
            # TV (2 Channel / 256k)
            & ffmpeg -y -i "$origFile" -c:v copy -c:a ac3 -b:a 256k -ac 2 -metadata:s:a language=eng -af "volume=0.1dB" "$convertedFile"
            # Movie (6 Channel / 640k)
            #& ffmpeg -y -i "$origFile" -c:v copy -c:a ac3 -b:a 640k -ac 6 -metadata:s:a language=eng -af "volume=0.1dB" "$convertedFile"
    }
    catch {
        Write-Host "Error converting: $origFile"
        Write-Host $_
        continue
    }

    # --- STEP 4: Backup original ---
    try {
        Rename-Item -Path $origFile -NewName $backupFile -Force
    }
    catch {
        Write-Host "Error backing up: $origFile"
        continue
    }

    # --- STEP 5: Replace with converted ---
    try {
        Rename-Item -Path $convertedFile -NewName $origFile -Force
    }
    catch {
        Write-Host "Error replacing file: $origFile"
        continue
    }

    Write-Host "Finished converting: $origFile"
}

