# Create Secure TXT File
Read-Host -Prompt "Enter your password be encrypted" -AsSecureString | ConvertFrom-SecureString | Out-File "C:\Users\$env:Username\SecurePW.txt"

# Read TXT file into varible
$password = Get-Content "C:\Users\$env:Username\SecurePW.txt" | ConvertTo-SecureString