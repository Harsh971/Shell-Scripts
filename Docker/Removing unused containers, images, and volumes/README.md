# Docker Cleanup:

## This script helps remove unused containers, images, and volumes.

## Code File :
```sh
#!/bin/bash


echo "-----------------------------------"
echo "Docker Cleanup Utility"
echo "-----------------------------------"

# Function to remove stopped containers
cleanup_containers() {
    echo "Removing all stopped containers..."
    docker container prune -f
    echo "Stopped containers removed!"
}

# Function to remove unused images
cleanup_images() {
    echo "Removing all unused images..."
    docker image prune -a -f
    echo "Unused images removed!"
}

# Function to remove unused volumes
cleanup_volumes() {
    echo "Removing all unused volumes..."
    docker volume prune -f
    echo "Unused volumes removed!"
}

# Function to remove unused networks
cleanup_networks() {
    echo "Removing all unused networks..."
    docker network prune -f
    echo "Unused networks removed!"
}

# Menu for user selection
while true; do
    echo "Select an option:"
    echo "1. Remove stopped containers"
    echo "2. Remove unused images"
    echo "3. Remove unused volumes"
    echo "4. Remove unused networks"
    echo "5. Clean everything (containers, images, volumes, networks)"
    echo "6. Exit"
    read -p "Choose an option: " option

    case $option in
        1) cleanup_containers ;;
        2) cleanup_images ;;
        3) cleanup_volumes ;;
        4) cleanup_networks ;;
        5) cleanup_containers; cleanup_images; cleanup_volumes; cleanup_networks ;;
        6) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option! Please try again." ;;
    esac
done


```

## Features:
- Remove stopped containers.
- Remove unused images.
- Remove unused volumes.
- Remove unused networks.
- Perform a full cleanup of all unused Docker resources.

## Prerequisites:
- Docker must be installed and running.
- The user running the script must have permission to execute Docker commands.

## How It Works:

### 1. Running the Script:
```bash
chmod +x docker_cleanup.sh
./docker_cleanup.sh
