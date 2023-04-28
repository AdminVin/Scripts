$CSV = Import-Csv "Mailbox - Change Type (Bulk).csv"
# -Type parameter should be "Regular" for User Mailbox, "Room" for resource mailbox, "Equipment", or "Shared" for Shared mailbox.
$Type = "Shared" 

ForEach ($User in $CSV) {            
    Set-Mailbox -Identity $User.EmailAddress -Type $Type
    Write-Host "Processing "$User.EmailAddress
  }