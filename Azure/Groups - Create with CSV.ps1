Connect-AzureAD

$Groups = Import-Csv -Path ".\Groups - Create with CSV.csv"

foreach($Group in $Groups)
{
New-AzureADGroup -DisplayName $Group.DisplayName -Description $Group.Description -MailEnabled $False -MailNickName "group" -SecurityEnabled $True
} 

New-AzureADGroup -DisplayName '(Cloud) (SP) Spring Mill HC - Accounting & Finance - Write' -Description 'Security Group' -MailEnabled $False -MailNickName 'SecurityGroup' -SecurityEnabled $True
