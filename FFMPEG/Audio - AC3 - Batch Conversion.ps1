# Install FFMPEG - https://www.gyan.dev/ffmpeg/builds/
# Add FFMPEG to the PATH (sysdm.cpl > Advanced > Enviroment Variables > Select Path > Edit > New > Add FFMPEG 'bin' Location)
# Alternatively: Copy ffmpeg.exe, ffplay.exe, and ffprobe.exe to C:/Windows/System32

# Quality Limits:
# Movies: 640k 6 Channels / 320k 2 Channels
# TV Shows: 320k 6 Channels / 256k 2 Channels

# --- CONFIG ---
$TV_DIR = "\\192.168.103.40\Media\TV\Bob's Burgers (2011)"

# --- STEP 1: Get all video files (MKV, MP4, etc.) ---
$videoFiles = Get-ChildItem -Path $TV_DIR -Recurse -Include *.mkv, *.mp4

foreach ($file in $videoFiles) {
    $origFile = $file.FullName
    $convertedFile = Join-Path $file.DirectoryName ("_Converting-" + $file.BaseName + $file.Extension)
    $backupFile = $origFile + ".old"

    # --- SKIP if backup already exists ---
    if (Test-Path $backupFile) {
        Write-Host "Skipping already converted file:" $origFile -ForegroundColor Red
        continue
    }

    Write-Host "Started converting:" $origFile -ForegroundColor Green

    # --- STEP 2: Convert using FFMPEG ---
    try {
        # Stereo (2.0 / 256K)
        & ffmpeg "-i" "$origFile" "-c:v" "copy" "-c:a" "ac3" "-b:a" "256k" "-ac" "2" "-af" "volume=0.3dB" "$convertedFile" "-sn"
        # Surround (5.1 / 640k [Max])
        #& ffmpeg "-i" "$origFile" "-c:v" "copy" "-c:a" "ac3" "-b:a" "320k" "-ac" "6" "-af" "volume=0.3dB" "$convertedFile" "-sn"
    } catch {
        Write-Host "Error converting:" $origFile -ForegroundColor Red
        Write-Host $_
        continue
    }

    # --- STEP 3: Backup original ---
    try {
        Rename-Item -Path $origFile -NewName $backupFile -Force
    } catch {
        Write-Host "Error backing up:" $origFile -ForegroundColor Red
        Write-Host $_
        continue
    }

    # --- STEP 4: Replace with converted ---
    try {
        Rename-Item -Path $convertedFile -NewName $origFile -Force
    } catch {
        Write-Host "Error replacing file:" $origFile -ForegroundColor Red
        Write-Host $_
        continue
    }

    Write-Host "Finished converting:" $origFile -ForegroundColor Green
}