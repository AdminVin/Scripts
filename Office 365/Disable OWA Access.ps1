$CSV = Import-Csv DisableOwaAccess.csv
            
ForEach ($User in $CSV) {            
    Set-CASMailbox -Identity $User.EmailAddress -OWAEnabled $false
    Write-Host "Processing"$User.EmailAddress 
  }