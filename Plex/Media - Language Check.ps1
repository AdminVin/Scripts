# --- SETUP ---
$workingDir = "C:\MediaLanguageChecker"
$pythonScript = Join-Path $workingDir "Detect-Language.py"
$requirementsFile = Join-Path $workingDir "requirements.txt"
$outputCSV = Join-Path $workingDir "MediaCheckedResults.csv"
$tempWav = "$env:TEMP\lang_temp.wav"
$movieDir = "\\192.168.103.40\Media\Movies"
$tvDir = "\\192.168.103.40\Media\TV"

Write-Host "Step 1: Checking for Python..." -ForegroundColor Cyan
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python not installed. Exiting.`n" -ForegroundColor Red
    Write-Host "Download Python: https://www.python.org/downloads/windows/`n" -ForegroundColor Yellow
    break
    exit
}

Write-Host "Step 2: Checking for FFmpeg..." -ForegroundColor Cyan
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "FFmpeg not installed or not in PATH. Exiting.`n" -ForegroundColor Red
    Write-Host "Extract the contents of the 'bin' folder, from 'Media - FFMPEG - 2025-08-04 (Full).7z' to system32. Re-run script.`n" -ForegroundColor Yellow
    break
    exit
}

Write-Host "Step 3: Creating working directory..." -ForegroundColor Cyan
if (-not (Test-Path $workingDir)) {
    New-Item -Path $workingDir -ItemType Directory | Out-Null
}

Write-Host "Step 4: Writing requirements.txt..." -ForegroundColor Cyan
@"
torch
openai-whisper
"@ | Set-Content $requirementsFile -Encoding UTF8

Write-Host "Step 5: Writing Detect-Language.py..." -ForegroundColor Cyan
@"
import sys
import whisper
import traceback

language_map = {
    "af": "Afrikaans", "am": "Amharic", "ar": "Arabic", "as": "Assamese", "az": "Azerbaijani",
    "ba": "Bashkir", "be": "Belarusian", "bg": "Bulgarian", "bn": "Bengali", "bo": "Tibetan",
    "br": "Breton", "bs": "Bosnian", "ca": "Catalan", "cs": "Czech", "cy": "Welsh",
    "da": "Danish", "de": "German", "el": "Greek", "en": "English", "es": "Spanish",
    "et": "Estonian", "eu": "Basque", "fa": "Persian", "fi": "Finnish", "fo": "Faroese",
    "fr": "French", "gl": "Galician", "gu": "Gujarati", "haw": "Hawaiian", "he": "Hebrew",
    "hi": "Hindi", "hr": "Croatian", "ht": "Haitian Creole", "hu": "Hungarian",
    "hy": "Armenian", "id": "Indonesian", "is": "Icelandic", "it": "Italian", "ja": "Japanese",
    "jw": "Javanese", "ka": "Georgian", "kk": "Kazakh", "km": "Khmer", "kn": "Kannada",
    "ko": "Korean", "la": "Latin", "lb": "Luxembourgish", "ln": "Lingala", "lo": "Lao",
    "lt": "Lithuanian", "lv": "Latvian", "mg": "Malagasy", "mi": "Maori", "mk": "Macedonian",
    "ml": "Malayalam", "mn": "Mongolian", "mr": "Marathi", "ms": "Malay", "mt": "Maltese",
    "my": "Burmese", "ne": "Nepali", "nl": "Dutch", "no": "Norwegian", "oc": "Occitan",
    "pa": "Punjabi", "pl": "Polish", "ps": "Pashto", "pt": "Portuguese", "ro": "Romanian",
    "ru": "Russian", "sa": "Sanskrit", "sd": "Sindhi", "si": "Sinhala", "sk": "Slovak",
    "sl": "Slovenian", "sq": "Albanian", "sr": "Serbian", "su": "Sundanese", "sv": "Swedish",
    "sw": "Swahili", "ta": "Tamil", "te": "Telugu", "th": "Thai", "tk": "Turkmen",
    "tl": "Tagalog", "tr": "Turkish", "uk": "Ukrainian", "ur": "Urdu", "uz": "Uzbek",
    "vi": "Vietnamese", "xh": "Xhosa", "yi": "Yiddish", "zh": "Chinese", "zh-cn": "Chinese (Simplified)",
    "zh-tw": "Chinese (Traditional)", "zu": "Zulu"
}

file_path = sys.argv[1]
model = whisper.load_model("base")

try:
    import traceback

    audio = whisper.load_audio(file_path)

    # Start at 1:00, extract 2 minutes (120 seconds)
    sample_rate = whisper.audio.SAMPLE_RATE
    start_time = 60
    duration = 120

    start_sample = start_time * sample_rate
    end_sample = start_sample + (duration * sample_rate)

    if len(audio) > end_sample:
        segment = audio[start_sample:end_sample]
    else:
        segment = whisper.pad_or_trim(audio)

    mel = whisper.log_mel_spectrogram(segment).to(model.device)

    _, probs = model.detect_language(mel)
    lang_code = max(probs, key=probs.get)

    full_name = language_map.get(lang_code, 'Unknown')
    print(full_name)

except Exception as e:
    print("Unknown")
    traceback.print_exc()

sys.stdout.flush()
"@ | Set-Content $pythonScript -Encoding UTF8

Write-Host "Step 6: Installing required Python packages..." -ForegroundColor Cyan
& python -m pip install -r $requirementsFile

Write-Host "Step 7: Scanning media folders..." -ForegroundColor Cyan
$allFiles = @()
$allFiles += Get-ChildItem -Path $movieDir -Recurse -Include *.mkv, *.mp4 -ErrorAction SilentlyContinue
$allFiles += Get-ChildItem -Path $tvDir -Recurse -Include *.mkv, *.mp4 -ErrorAction SilentlyContinue

Write-Host "Step 8: Found $($allFiles.Count) media files.`n" -ForegroundColor Green

if ($allFiles.Count -eq 0) {
    Write-Host "No media files found. Exiting." -ForegroundColor Yellow
    exit
}

Write-Host "Step 9: Preparing CSV output..." -ForegroundColor Cyan
if (!(Test-Path $outputCSV)) {
    "FilePath,Language" | Out-File $outputCSV -Encoding UTF8
}

Write-Host "Step 10: Processing media files..." -ForegroundColor Cyan
$total = $allFiles.Count
$i = 0

foreach ($file in $allFiles) {
    $i++

    Write-Progress -Activity "Detecting Language" -Status "$($file.Name)" -PercentComplete (($i / $total) * 100)
    Write-Host "`n[$i of $total] Processing: $($file.FullName)" -ForegroundColor Cyan

    Write-Host "  - Extracting audio with ffmpeg..." -ForegroundColor DarkGray
    & ffmpeg -y -i "$($file.FullName)" -t 60 -vn -ar 16000 -ac 1 -f wav "$tempWav"
    
    if (Test-Path $tempWav) {
        $size = (Get-Item $tempWav).Length
        Write-Host "  ✓ Audio extracted to $tempWav ($size bytes)" -ForegroundColor Gray
    } else {
        Write-Host "  ✗ Audio extraction failed!" -ForegroundColor Red
        continue
    }

    Write-Host "  - Running Whisper transcription..." -ForegroundColor DarkGray
    $lang = & python $pythonScript $tempWav
    if ([string]::IsNullOrWhiteSpace($lang)) { $lang = "Unknown" }
    Write-Host "  ✓ Detected language: $lang" -ForegroundColor Green

    '"{0}","{1}"' -f $file.FullName, $lang | Out-File $outputCSV -Append -Encoding UTF8
}

Write-Host "`nStep 11: All files processed." -ForegroundColor Cyan
Write-Host "Output saved to: $outputCSV`n" -ForegroundColor Green
