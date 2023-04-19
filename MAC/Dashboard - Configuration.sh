## Dashboard
# Disable
sudo defaults write com.apple.dashboard mcx-disabled -boolean YES
# Enable (Default)
sudo defaults write com.apple.dashboard mcx-disabled -boolean NO
# Restart Dock
killall Dock