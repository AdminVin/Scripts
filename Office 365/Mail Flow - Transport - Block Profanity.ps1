## Work in Progress (needs to be cleaned up)

## Download latest badword List from Google
# Directory Setup
$url = "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/badwordslist/badwords.txt"
$destinationDirectory = "C:\Windows\Temp\Office 365 - Profanity Filter"
$destinationFilename = "ProfanityFilter.csv"
$destinationFilePath = Join-Path -Path $destinationDirectory -ChildPath $destinationFilename
if (-not (Test-Path -Path $destinationDirectory)) {New-Item -ItemType Directory -Force -Path $destinationDirectory | Out-Null}
# Download
Invoke-WebRequest -Uri $url -OutFile $destinationFilePath
## Split CSV into 175 Maximum (Transport rule has 8100 character limit limitation)
$sourceCSV = "C:\Windows\Temp\Office 365 - Profanity Filter\ProfanityFilter.csv"
$outputDirectory = "C:\Windows\Temp\Office 365 - Profanity Filter\CSV-Split"
if (-not (Test-Path $outputDirectory)) { New-Item -ItemType Directory -Path $outputDirectory | Out-Null }
if (Test-Path $sourceCSV) {
    $counter = 1
    $lineCount = 0

    Get-Content $sourceCSV | ForEach-Object {
        if ($lineCount -eq 0) {
            $outputCSV = Join-Path -Path $outputDirectory -ChildPath ("ProfanityFilter_$counter.csv")
            $counter++
        }
        $_ | Out-File -Append $outputCSV -Encoding utf8
        $lineCount++
        if ($lineCount -eq 175) {
            $lineCount = 0
        }
    }
    }
####################################################################################################################################################################
## Update Transport Rules
$TransportRuleName = "Block - Profanity (3)"
$CSVPath = "C:\Windows\Temp\CSV-Split\ProfanityFilter_3.csv"
#
$Keywords = Get-Content -Path $CSVPath
$ExistingRule = Get-TransportRule -Identity $TransportRuleName
Set-TransportRule -Identity $ExistingRule -SubjectOrBodyContainsWords $Keywords