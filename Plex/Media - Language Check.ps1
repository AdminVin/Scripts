# --- SETUP ---
$workingDir = "C:\MediaLanguageChecker"
$pythonScript = Join-Path $workingDir "Detect-Language.py"
$requirementsFile = Join-Path $workingDir "requirements.txt"
$outputCSV = Join-Path $workingDir "MediaCheckedResults.csv"
$tempWav = "$env:TEMP\lang_temp.wav"
$movieDir = "\\192.168.103.40\Media\Movies"
$tvDir = "\\192.168.103.40\Media\TV"

# --- CHECK PYTHON ---
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python not installed. Exiting.`n" -ForegroundColor Red
    Write-Host "Download Python: https://www.python.org/downloads/windows/`n" -ForegroundColor Yellow
    break
    exit
}

# --- CHECK FFMPEG ---
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "FFmpeg not installed or not in PATH. Exiting.`n" -ForegroundColor Red
    Write-Host "Extract the contents of the 'bin' folder, from 'Media - FFMPEG - 2025-08-04 (Full).7z' to system32. Re-run script.`n" -ForegroundColor Yellow
    break
    exit
}

# --- CREATE FOLDER ---
if (-not (Test-Path $workingDir)) {
    New-Item -Path $workingDir -ItemType Directory | Out-Null
}

# --- WRITE requirements.txt ---
@"
torch
openai-whisper
"@ | Set-Content $requirementsFile -Encoding UTF8

# --- WRITE Detect-Language.py ---
@"
import sys
import whisper

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
    result = model.transcribe(file_path, language='auto')
    lang_code = result.get('language', '')
    full_name = language_map.get(lang_code, 'Unknown')
    print(full_name)
except:
    print("Unknown")
"@ | Set-Content $pythonScript -Encoding UTF8

# --- INSTALL PYTHON DEPENDENCIES ---
Write-Host "Installing required Python packages..." -ForegroundColor Cyan
Start-Process -NoNewWindow -Wait -FilePath "python" -ArgumentList "-m pip install -r `"$requirementsFile`""

# --- BUILD FILE LIST ---
$allFiles = @()
$allFiles += Get-ChildItem -Path $movieDir -Recurse -Include *.mkv, *.mp4 -ErrorAction SilentlyContinue
$allFiles += Get-ChildItem -Path $tvDir -Recurse -Include *.mkv, *.mp4 -ErrorAction SilentlyContinue

if ($allFiles.Count -eq 0) {
    Write-Host "No media files found. Exiting." -ForegroundColor Yellow
    exit
}

# --- PREP OUTPUT ---
if (!(Test-Path $outputCSV)) {
    "FilePath,Language" | Out-File $outputCSV -Encoding UTF8
}

# --- PROCESS FILES ---
$total = $allFiles.Count
$i = 0

foreach ($file in $allFiles) {
    $i++

    Write-Progress -Activity "Detecting Language" -Status "$($file.Name)" -PercentComplete (($i / $total) * 100)
    Write-Host "[$i of $total] Processing: $($file.FullName)"

    # Extract audio
    & ffmpeg -y -i "`"$file.FullName`"" -t 60 -vn -ar 16000 -ac 1 -f wav "`"$tempWav`"" -loglevel quiet

    # Run Python detection
    $lang = & python "`"$pythonScript`"" "`"$tempWav`""
    if ([string]::IsNullOrWhiteSpace($lang)) { $lang = "Unknown" }

    '"{0}","{1}"' -f $file.FullName, $lang | Out-File $outputCSV -Append -Encoding UTF8
}

Write-Host "`nDone. Output saved to: $outputCSV" -ForegroundColor Green
