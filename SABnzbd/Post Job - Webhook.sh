#!/bin/bash

# Array of webhook URLs
WEBHOOK_URLS=(
  "http://192.168.103.73:32400/library/sections/10/refresh?X-Plex-Token=**PLEXTOKEN**" # Movies
  "http://192.168.103.73:32400/library/sections/11/refresh?X-Plex-Token=**PLEXTOKEN**" # TV
  "http://192.168.103.73:32400/library/sections/15/refresh?X-Plex-Token=**PLEXTOKEN**" # Movies (4K)
)

# Loop through the webhook URLs
for WEBHOOK_URL in "${WEBHOOK_URLS[@]}"; do
  # Make a GET request to the webhook URL
  curl "$WEBHOOK_URL"

  # Sleep for 15 seconds
  sleep 60
done

# Close the terminal window (specific to certain terminal apps)
osascript -e 'tell application "Terminal" to close first window' & exit