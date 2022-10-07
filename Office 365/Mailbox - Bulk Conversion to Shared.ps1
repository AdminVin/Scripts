$CSV = Import-Csv "Mailbox - Bulk Conversion to Shared.csv"         
            
ForEach ($User in $CSV) {            
    Set-Mailbox -Identity $User.EmailAddress -Type Shared
    Write-Host "Processing "$User.EmailAddress
  }