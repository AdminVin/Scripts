# Set the path to ExifTool executable
$exifToolPath = "C:\Users\vincent\Downloads\exiftool-12.84\exiftool.exe"

# Set the path to your picture folder
$folderPath = "C:\Pics"

# Prompt for the desired creation date (format: YYYY:MM:DD)
$creationDateString = Read-Host "Enter the desired creation date (format: YYYY:MM:DD)"

# Append the time part (00:00:00) to the date string
$creationDateString += " 00:00:00"

# Parse the date string to a DateTime object
$creationDate = [DateTime]::ParseExact($creationDateString, "yyyy:MM:dd HH:mm:ss", $null)

# Get all the picture files in the folder and its subdirectories
$pictureFiles = Get-ChildItem -Path $folderPath -Filter *.jpg -Recurse

# Loop through each picture file
foreach ($file in $pictureFiles) {
    # Set the creation date for the file
    $file.CreationTime = $creationDate
    $file.LastWriteTime = $creationDate
    
    # Use ExifTool to update the "Date Taken" metadata and overwrite the original files
    & $exifToolPath "-DateTimeOriginal=$creationDateString" "-overwrite_original" $file.FullName
    
    # Output the updated file information
    Write-Host "Updated creation date and Date Taken for $($file.FullName) to $creationDateString"
}
