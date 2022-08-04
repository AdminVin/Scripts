$UserEmail= "user@DOMAIN.com"
$Mailbox = Get-Mailbox | Where {$_.PrimarySmtpAddress -eq $UserEmail}
Get-UnifiedGroup | where { (Get-UnifiedGroupLinks $_.Alias -LinkType Members | foreach {$_.name}) -contains $mailbox.Alias}