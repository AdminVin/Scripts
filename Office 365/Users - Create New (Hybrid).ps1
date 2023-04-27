New User creation Hybrid

1. Create the AD User / DirSync / License
 * Add proxyAddress and mailNickname
 
Connect Exchange Office 365 Powershell
2. Get-Mailbox username@DOMAIN.com | fl ExchangeGuid
 * to attain GUID

Connect to Local Exchange Powershell
3. Enable-RemoteMailbox "Display Name" -RemoteRoutingAddress "username@DOMAIN.mail.onmicrosoft.com"
4. Set-RemoteMailbox username -ExchangeGuid <use ID gathered from Office 365>