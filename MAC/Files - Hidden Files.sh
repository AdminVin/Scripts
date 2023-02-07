## Show Hidden Files
defaults write com.apple.Finder AppleShowAllFiles true
# Reboot

## Hide Hidden Files
defaults write com.apple.Finder AppleShowAllFiles false
# Reboot

## Hide Folder/Files
chflags hidden *FILE-PATH* # OR Drag folder/file into terminal window

## Show Folder/File
chflags nohidden *FILE-PATH # OR Drag folder/file into terminal window