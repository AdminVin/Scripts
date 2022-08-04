# Import CSV of Contacts to Office 365

Import-Csv .\MailContact-ImportwithCSV.csv|%{New-MailContact -Name $_.Name -DisplayName $_.Name -ExternalEmailAddress $_.ExternalEmailAddress -FirstName $_.FirstName -LastName $_.LastName}