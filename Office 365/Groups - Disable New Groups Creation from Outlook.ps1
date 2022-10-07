# Connect to Office 365 via PowerShell
$LiveCred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic -AllowRedirection
# Import Session
Import-PSSession $Session
# Disable "New Groups" Creation from Outlook
Set-OwaMailboxPolicy -GroupCreationEnabled $false -Identity OwaMailboxPolicy-Default
# Remove Session
Remove-PSSession $Session
# Pause to verify process was successful
pause
