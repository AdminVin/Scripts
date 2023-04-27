$CSV = Import-Csv "Users - OWA Access.csv"
# $true = Enabled | $false = Disabled
$OWAStatus = $false          
ForEach ($User in $CSV) {            
    Set-CASMailbox -Identity $User.EmailAddress -OWAEnabled $OWAStatus
    Write-Host "Processing"$User.EmailAddress 
  }