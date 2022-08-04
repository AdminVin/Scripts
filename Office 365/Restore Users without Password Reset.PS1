# This script is primarly designed for Un-DirSyncing users from a DirSync'ed enviroment; and removing ImmutableID (so the object can be re-dirsynced at a later time)

Connect-MsolService

$CSV = Import-Csv RestoreUsersWithoutPasswordReset.csv         
            
ForEach ($User in $CSV) {            
    Restore-MsolUser -UserPrincipalName $User.EmailAddress | Set-MSOLUser -ImmutableID "$null"
  }
