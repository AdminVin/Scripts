## Spacer Tile
# Add
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}';killall Dock
# Remove
#Right click on Spacer icon > Select 'Remove from Dock'

## Animations
# Disable
sudo defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false;killall Dock
# Enable (Default)
sudo defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool true;killall Dock

## Transparency
# Disable
sudo defaults write com.apple.universalaccess reduceTransparency -bool true;killall Dock
# Enable (Default)
sudo defaults write com.apple.universalaccess reduceTransparency -bool false;killall Dock