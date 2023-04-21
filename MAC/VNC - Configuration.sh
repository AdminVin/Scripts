# Enable and Configure
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -clientopts -setvnclegacy -vnclegacy yes -clientopts -setvncpw -vncpw YOUR_PASSWORD

# Restart Service
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent
launchctl unload -w /System/Library/LaunchDaemons/com.apple.screensharing.plist
launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist
