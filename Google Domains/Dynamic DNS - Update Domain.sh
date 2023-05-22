#!/bin/bash

# Set the API user ID and password
apiUserID="XXXXX"                # Google Domains - API Username
apiPassword="XXXXX"              # Google Domains - API Password

# Function to display a progress bar, live countdown, and timer
function show_progress_bar() {
    local duration=$1
    local progress=0
    local progress_char="#"
    local empty_char="-"
    local bar_length=20

    while [ $progress -lt $duration ]; do
        remaining=$((duration - progress))
        mins=$((remaining / 60))
        secs=$((remaining % 60))
        printf "Progress: ["
        printf "%-$((progress * bar_length / duration))s" | tr ' ' $progress_char
        printf "%-$(((duration - progress) * bar_length / duration))s" | tr ' ' $empty_char
        printf "] Next Sync: %02d:%02d " "$mins" "$secs"
        sleep 1
        printf "\r"
        progress=$((progress + 1))
    done
    printf "\n"
}

while true; do
    # Get the current public IP address
    ipAddress=$(curl -s https://api.ipify.org)

    # Set the domain name and host
    domain="DOMAIN.COM"                    # Google Domain being updated (example: domain="MyDomain.com")
    host="@"

    # Update the dynamic DNS
    response=$(curl -s "https://domains.google.com/nic/update?hostname=$host.$domain&myip=$ipAddress" \
              --user "$apiUserID:$apiPassword" \
              --silent \
              --show-error)

    # Print the response
    echo $response

    # Show a progress bar, live countdown, and timer for 30 minutes (1800 seconds) sleep
    show_progress_bar 1800

done
