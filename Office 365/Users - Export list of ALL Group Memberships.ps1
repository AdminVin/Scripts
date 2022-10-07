# Work In Progress
$UserEmail= "EMAIL@DOMAIN.COM"
$Mailbox = Get-Mailbox | Where-Object {$_.PrimarySmtpAddress -eq $UserEmail}
Get-UnifiedGroup -ResultSize Unlimited | Where-Object { (Get-UnifiedGroupLinks $_.Alias -LinkType Members | ForEach-Object {$_.name}) -contains $mailbox.Alias} | Export-Csv Test.csv