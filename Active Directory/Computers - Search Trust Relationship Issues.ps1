# Script WIP/Needs to be tested
#
# Import AD Module           
Import-Module ActiveDirectory

# Pull Computer List
Get-ADComputer -Filter * -Properties LastLogonDate | Where { $_.LastLogonDate -GT (Get-Date).AddDays(-90) } | Select DNSHostName | Export-CSV PCsActive90D.csv
$Computers = Import-Csv -Path PCsActive90D.csv

# Test if PC has Trust Relationship Issue
foreach ($computer in $Computers) {            
    Write-Output "$PCName"
    Enter-PSSession $PCName.HostName
    Test-ComputerSecureChannel
    Exit-PSSession
      }