$CSV = Import-Csv BulkConversionToShared.csv         
            
ForEach ($User in $CSV) {            
    Set-Mailbox -Identity $User.EmailAddress -Type Shared
    Write-Host "Processing "$User.EmailAddress
  }