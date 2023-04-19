## Performance Mode
# Source: https://support.apple.com/en-us/HT202528

# Check if enabled (should contain `serverperfmode=1`)
nvram boot-args

# Enable
sudo nvram boot-args="serverperfmode=1 $(nvram boot-args 2>/dev/null | cut -f 2-)"

# Disable (Default)
sudo nvram boot-args="$(nvram boot-args 2>/dev/null | sed -e $'s/boot-args\t//;s/serverperfmode=1//')"

# Reboot System