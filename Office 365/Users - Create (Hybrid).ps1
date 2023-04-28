## New user in Hybrid Enviornment

# 1. Create the AD User / DirSync / License
# - Add proxyAddress and mailNickname
 
# 2. Connect to Office 365 via PowerShell
Get-Mailbox username@DOMAIN.com | Format-List ExchangeGuid
# * to attain GUID

# 3. Connect to Local Exchange via Powershell
Enable-RemoteMailbox "Display Name" -RemoteRoutingAddress "username@DOMAIN.mail.onmicrosoft.com"

# 4. Set-RemoteMailbox
4. Set-RemoteMailbox username@DOMAIN.com -ExchangeGuid <#use GUID from Step 2#>