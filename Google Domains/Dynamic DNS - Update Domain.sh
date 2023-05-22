#!/bin/bash

# Functions
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
    ## Domain
    domain="DOMAIN.COM"                         # Google Domain being updated (example: domain="MyDomain.com")
    host="@"                                    # @ being A Record for DOMAIN.com
    # API Credentials
    apiUserID="XXXXX"                           # Google Domains - API Username
    apiPassword="XXXXX"                         # Google Domains - API Password
    # IP Address - Pull Current
    ipAddress=$(curl -s https://api.ipify.org) 
    # Google Domains - Update
    response=$(curl -s "https://domains.google.com/nic/update?hostname=$host.$domain&myip=$ipAddress" \
              --user "$apiUserID:$apiPassword" \
              --silent \
              --show-error)
    # Display Results
    echo "$domain: $response"                   # Example Output: DOMAIN.com: nochg 1.2.3.4
    # Sleep 30 Minutes
    show_progress_bar 1800
done
