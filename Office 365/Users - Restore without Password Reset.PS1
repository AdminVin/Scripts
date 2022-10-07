# This script is primarly designed for Un-DirSyncing users from a DirSync'ed enviroment; and removing ImmutableID (so the object can be re-dirsynced at a later time)

Connect-MsolService

$CSV = Import-Csv "Users - Restore without Password Reset"         
            
ForEach ($User in $CSV) {            
    Restore-MsolUser -UserPrincipalName $User.EmailAddress | Set-MSOLUser -ImmutableID "$null"
  }
