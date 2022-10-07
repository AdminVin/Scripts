# Import CSV of Contacts to Office 365

Import-Csv .\"Mail Contact - Import with CSV.csv"|%{New-MailContact -Name $_.Name -DisplayName $_.Name -ExternalEmailAddress $_.ExternalEmailAddress -FirstName $_.FirstName -LastName $_.LastName}