## Dashboard
# Disable
sudo defaults write com.apple.dashboard mcx-disabled -boolean YES
killall Dock
# Enable (Default)
sudo defaults write com.apple.dashboard mcx-disabled -boolean NO
killall Dock