$CredentialsDir = "C:\ProgramData\AV\Credentials"
# Prompt for email to autenticate with
#$email = Read-Host -Prompt "Enter the EMAIL ADDRESS you are authenticating with"
# Set email to authenticate with
$email = "vincent@gmail.com"
$Credentials = "$CredentialsDir\$email.txt"

if (-not (Test-Path $CredentialsDir)) {
    New-Item -Path $CredentialsDir -ItemType Directory -Force | Out-Null
}

if (Test-Path $Credentials) {
    $encrypted = Get-Content $Credentials
    $securePassword = $encrypted | ConvertTo-SecureString
    $credential = New-Object System.Management.Automation.PsCredential($email, $securePassword)
} else {
    $securePassword = Read-Host -Prompt "Enter your network password for $email" -AsSecureString
    $securePassword | ConvertFrom-SecureString | Set-Content $Credentials
    $credential = New-Object System.Management.Automation.PsCredential($email, $securePassword)
}

Connect-ExchangeOnline -Credential $credential