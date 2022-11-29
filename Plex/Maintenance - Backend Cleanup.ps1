#region Notes
# Media Index Files
# Server Settings > Server > Library > Advanced Toggle > Turn OFF

# Generate media index files during scans & Server 
# Settings > Server > Scheduled Tasks > Turn OFF
#endregion

#region Cleanup
Set-Location "C:\Users\$env:username\AppData\Local\Plex Media Server\Media\localhost" | Remove-Item * -Include *.bif -Force
#endregion