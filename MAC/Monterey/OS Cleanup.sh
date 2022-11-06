# Window Animations
# Disable
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
# Restore to Default
#defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool true

# Animation Time
# Reduce to Minimum
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# Restore to Default
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.2

# Quick Look
# Disable
defaults write -g QLPanelAnimationDuration -float 0
# Restore to Default
#defaults delete -g QLPanelAnimationDuration

# Dock Delay (If dock is hidden)
# Disable Delay
defaults write com.apple.dock autohide-time-modifier -float 0
# Restore to Default
#defaults delete com.apple.dock autohide-time-modifier

# Dock - App Launch Animation
# Disable
defaults write com.apple.dock launchanim -bool false
# Restore to Default
#defaults write com.apple.dock launchanim -bool true



###################### Reboot REQUIRED after running commands in Terminal ######################


