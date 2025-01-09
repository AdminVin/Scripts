#region Notes
<# This needs to be run on the server/computer that has Azure AD Connect installed on it 
Import-Module ADSync also must be ran first or commands will fail
#>
#endregion

# Disable Delete Protection
Disable-ADSyncExportDeletionThreshold

# Enable Delete Protection
Enable-ADSyncExportDeletionThreshold -DeletionThreshold 500
# 500 is the default object limit set by Microsoft.