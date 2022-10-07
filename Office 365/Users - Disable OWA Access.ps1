$CSV = Import-Csv "Users - Disable OWA Access.csv"
            
ForEach ($User in $CSV) {            
    Set-CASMailbox -Identity $User.EmailAddress -OWAEnabled $false
    Write-Host "Processing"$User.EmailAddress 
  }