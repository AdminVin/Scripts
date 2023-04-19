## Performance Mode
# See "Performance Mode - Configuration.sh"


## Dock
# Animations - Disable
sudo defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Transparency - Disable
sudo defaults write com.apple.universalaccess reduceTransparency -bool true


## Finder
# Show full Path
sudo defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES


## System
# Dashboard - Disable
sudo defaults write com.apple.dashboard mcx-disabled -boolean YES

# Siri - Disable
sudo defaults write com.apple.Siri StatusMenuVisible -bool false