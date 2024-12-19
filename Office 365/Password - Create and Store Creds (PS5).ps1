# Check/Create Password Folder
$folderPath = "C:\ProgramData\AV\Credentials"
if (!(Test-Path -Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath | Out-Null
}

$CUfile = $env:UserName + ".txt"
$filePath = "$folderPath\$CUfile"

# Remove existing file if it exists without prompt
if (Test-Path -Path $filePath) {
    Remove-Item -Path $filePath -Force
}

# Prompt for password with the full file path in the prompt
Read-Host -Prompt "`nEnter password for $env:UserName to be encrypted" -AsSecureString | ConvertFrom-SecureString | Out-File $filePath
Write-Host "`nPassword created in $filePath" -ForegroundColor Green