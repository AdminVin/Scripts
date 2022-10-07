#region Notes
<# This needs to be run on the server/computer that has Azure AD Connect installed on it #>
#endregion


# Disable Delete Protection
Disable-ADSyncExportDeletionThreshold

# Enable Delete Protection
Enable-ADSyncExportDeletionThreshold
# Enter "500" as that is the default object limit