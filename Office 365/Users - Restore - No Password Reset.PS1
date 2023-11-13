# This script is primarly designed for Un-DirSyncing users from a DirSync'ed enviroment; and removing ImmutableID (so the object can be re-dirsynced at a later time)

# Connect
Connect-MsolService
# Import
$CSV = Import-Csv "Users - Restore - No Password Reset.csv"         
            
ForEach ($User in $CSV) {            
    Restore-MsolUser -UserPrincipalName $User.EmailAddress | Set-MSOLUser -ImmutableID "$null" #Clear ImmutableID to allow DirSyncing to new AD Account
  }
