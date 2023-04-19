## Performance Mode
# Source: https://support.apple.com/en-us/HT202528
# Check if enabled (should contain `serverperfmode=1`)
nvram boot-args
# Enable
sudo nvram boot-args="serverperfmode=1 $(nvram boot-args 2>/dev/null | cut -f 2-)"
# Disable (Default)
sudo nvram boot-args="$(nvram boot-args 2>/dev/null | sed -e $'s/boot-args\t//;s/serverperfmode=1//')"
# Reboot System

## Transparency Effect
# Disable
sudo defaults write com.apple.universalaccess reduceTransparency -bool true;killall Dock
# Enable (Default)
sudo defaults write com.apple.universalaccess reduceTransparency -bool false;killall Dock


## Dashboard
# Disable
sudo defaults write com.apple.dashboard mcx-disabled -boolean YES;killall Dock
# Enable (Default)
sudo defaults write com.apple.dashboard mcx-disabled -boolean NO;killall Dock


## Dock Animations
# Disable
sudo defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false;killall Dock
# Enable (Default)
sudo defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool true;killall Dock
