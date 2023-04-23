## Disabling Siri will not affect Spotlight Search

# Disable
sudo defaults write com.apple.Siri StatusMenuVisible -bool false
# Enable (Default)
sudo defaults write com.apple.Siri StatusMenuVisible -bool true

# Restart Dock
killall Dock