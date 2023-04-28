# Import CSV of Contacts to Office 365

Import-Csv .\"Contacts - CSV Import.csv" |ForEach-Object{New-MailContact -Name $_.Name -DisplayName $_.Name -ExternalEmailAddress $_.ExternalEmailAddress -FirstName $_.FirstName -LastName $_.LastName}