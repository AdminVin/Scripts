# This will pull the active users of the last thirty days

Import-Module ActiveDirectory
get-aduser -filter {lastlogondate -gt "3/15/2015"} -Properties lastlogondate | select Name,LastLogonDate | sort name | Export-Csv C:/ActiveUsers.csv