# Import AD Module             
Import-Module ActiveDirectory            

write-Host 'Starting to update AD Attributes.......' -NoNewline -ForegroundColor Yellow            
# Import CSV into variable $users           
      
$users = Import-Csv -Path "Users - Update ADattributes.csv"           
# Loop through CSV and update users if the exist in CVS file            
            
foreach ($user in $users) {            
#Search in specified OU and Update existing attributes            
 Get-ADUser -Filter "SamAccountName -eq '$($user.samaccountname)'" -Properties * -SearchBase "DC=DOMAIN,DC=local" |            
  Set-ADUser -Title $($user.Title) -Company $($user.Company) -StreetAddress $($user.StreetAddress) -City $($user.City) -State $($user.State) -PostalCode $($user.PostalCode) -OfficePhone $($user.OfficePhone) -MobilePhone $($user.MobilePhone) -Fax $($user.Fax)
  }
Write-Host 'done!' -ForegroundColor Green