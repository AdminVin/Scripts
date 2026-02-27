# --- CONFIG ---
$TV_DIR = "\\192.168.103.40\Media\TV\Bob's Burgers (2011)"

# --- STEP 1: Get all video files (MKV, MP4, etc.) ---
$videoFiles = Get-ChildItem -Path $TV_DIR -Recurse -Include *.mkv, *.mp4

foreach ($file in $videoFiles) {
    $origFile = $file.FullName
    $convertedFile = Join-Path $file.DirectoryName ("converted_temp" + $file.Extension)
    $backupFile = $origFile + ".old"

    # --- SKIP if backup already exists ---
    if (Test-Path $backupFile) {
        Write-Output "Skipping already converted file:" $origFile
        continue
    }

    Write-Output "Started converting:" $origFile

    # --- STEP 2: Convert using ffmpeg ---
    try {
        # Surround (5.1)
        #& ffmpeg "-i" "$origFile" "-c:v" "copy" "-c:a" "ac3" "-b:a" "320k" "-ac" "6" "-af" "volume=0.3dB" "$convertedFile"
        # Stereo (2.0)
        & ffmpeg "-i" "$origFile" "-c:v" "copy" "-c:a" "ac3" "-b:a" "320k" "-ac" "2" "-af" "volume=0.3dB" "$convertedFile"
    } catch {
        Write-Output "Error converting:" $origFile
        Write-Output $_
        continue
    }

    # --- STEP 3: Backup original ---
    try {
        Rename-Item -Path $origFile -NewName $backupFile -Force
    } catch {
        Write-Output "Error backing up:" $origFile
        Write-Output $_
        continue
    }

    # --- STEP 4: Replace with converted ---
    try {
        Rename-Item -Path $convertedFile -NewName $origFile -Force
    } catch {
        Write-Output "Error replacing file:" $origFile
        Write-Output $_
        continue
    }

    Write-Output "Finished converting:" $origFile
}