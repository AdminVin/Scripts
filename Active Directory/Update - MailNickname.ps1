# Source: https://social.technet.microsoft.com/Forums/lync/en-US/6811071e-f329-428e-a70d-8f05bbe61d1d/how-to-set-aduser-attribute-mailnickname?forum=winserverpowershell

Get-ADUser <username> -Properties MailNickName | Set-ADUser -Replace @{MailNickName = "Doris@contoso.com"}