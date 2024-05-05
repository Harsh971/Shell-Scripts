#!/bin/bash

# Function to list all GitHub repositories
list_repos() {
    echo "Fetching list of GitHub repositories..."
    response=$(curl -s -u $USERNAME:$TOKEN $API_URL)
    error=$(echo $response | jq -r '.message')
    if [ "$error" != "null" ]; then
        echo "Error: $error"
        exit 1
    fi
    repos=$(echo $response | jq -r '.[].full_name')
    echo "Your GitHub repositories:"
    echo "$repos"
}

# Function to list files in a specific repository
list_files_in_repo() {
    local repo_name="$1"
    echo "Fetching files in repository: $repo_name..."
    files_response=$(curl -s -u $USERNAME:$TOKEN "https://api.github.com/repos/$repo_name/contents")
    files=$(echo $files_response | jq -r '.[].name')
    echo "Files in $repo_name:"
    echo "$files"
}

# Your GitHub username
USERNAME="your_username"

# Your GitHub Personal Access Token
TOKEN="your_personal_access_token"

# API endpoint to list repositories
API_URL="https://api.github.com/user/repos"

# List all GitHub repositories
list_repos

# Ask for input: repository name
echo "Enter the name of the repository you want to explore:"
read repo_name

# List files in the specified repository
list_files_in_repo "$repo_name"
