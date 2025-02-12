# Docker Cleanup:

## Automates the removal of dangling images and stopped containers

## Code File :
```sh
#!/bin/bash


echo "-------------------------------------"
echo "Docker Cleanup: Removing Dangling Images & Stopped Containers"
echo "-------------------------------------"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi

# Remove dangling images (images not associated with any containers)
cleanup_images() {
    echo "Removing dangling images..."
    docker image prune -f
    if [ $? -ne 0 ]; then
        echo "Failed to remove dangling images."
        exit 1
    fi
    echo "Dangling images removed successfully."
}

# Remove stopped containers
cleanup_containers() {
    echo "Removing stopped containers..."
    docker container prune -f
    if [ $? -ne 0 ]; then
        echo "Failed to remove stopped containers."
        exit 1
    fi
    echo "Stopped containers removed successfully."
}

# Main Menu
while true; do
    echo ""
    echo "Choose an option:"
    echo "1. Remove dangling images"
    echo "2. Remove stopped containers"
    echo "3. Remove both dangling images and stopped containers"
    echo "4. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) cleanup_images ;;
        2) cleanup_containers ;;
        3) cleanup_images && cleanup_containers ;;
        4) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option! Please try again." ;;
    esac
done


```


## Features:
- **Remove dangling images**: Images that are not tagged and are not used by any containers.
- **Remove stopped containers**: Containers that have stopped running but are still on the system.
- **Interactive menu**: Allows you to choose which resources to clean up.

## Prerequisites:
- Docker must be installed and running.
- The user must have permission to execute Docker commands.

## How It Works:

### 1. Running the Script:
```bash
chmod +x docker_cleanup.sh
./docker_cleanup.sh
