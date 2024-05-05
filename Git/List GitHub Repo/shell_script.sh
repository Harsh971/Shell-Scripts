#!/bin/bash

# Your GitHub username
USERNAME="[Github Account User Name Here]"

# Your GitHub Personal Access Token
TOKEN="[Token Here]"

# API endpoint to list repositories
API_URL="https://api.github.com/user/repos"

# Send request to GitHub API to retrieve repositories
response=$(curl -s -u $USERNAME:$TOKEN $API_URL)

# Check if there's an error in the response
error=$(echo $response | jq -r '.message')
if [ "$error" != "null" ]; then
    echo "Error: $error"
    exit 1
fi

# Parse repository names from JSON response
repos=$(echo $response | jq -r '.[].full_name')

# Print repository names
echo "Your GitHub repositories:"
echo "$repos"
