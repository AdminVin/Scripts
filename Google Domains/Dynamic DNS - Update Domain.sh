#!/bin/bash

# Set the API user ID and password
apiUserID="xxxxxxxxx"
apiPassword="xxxxxxxxx"

# Get the current public IP address
ipAddress=$(curl -s https://api.ipify.org)

# Set the domain name and host
domain="example.com"
host="@"

# Update the dynamic DNS
response=$(curl -s "https://domains.google.com/nic/update?hostname=$host.$domain&myip=$ipAddress" \
          --user "$apiUserID:$apiPassword" \
          --silent \
          --show-error)

# Print the response
echo $response
