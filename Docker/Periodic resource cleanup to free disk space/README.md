# Docker Periodic Cleanup:

## Automates periodic cleanup of unused Docker resources to free up disk space

## Code File :
```sh
#!/bin/bash

echo "---------------------------------------"
echo "Docker Periodic Cleanup: Freeing Disk Space"
echo "---------------------------------------"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi

# Function to remove dangling images (images not associated with any containers)
cleanup_images() {
    echo "Removing dangling images..."
    docker image prune -f
    if [ $? -ne 0 ]; then
        echo "Failed to remove dangling images."
        exit 1
    fi
    echo "Dangling images removed successfully."
}

# Function to remove stopped containers
cleanup_containers() {
    echo "Removing stopped containers..."
    docker container prune -f
    if [ $? -ne 0 ]; then
        echo "Failed to remove stopped containers."
        exit 1
    fi
    echo "Stopped containers removed successfully."
}

# Function to remove unused volumes
cleanup_volumes() {
    echo "Removing unused volumes..."
    docker volume prune -f
    if [ $? -ne 0 ]; then
        echo "Failed to remove unused volumes."
        exit 1
    fi
    echo "Unused volumes removed successfully."
}

# Function to remove unused networks
cleanup_networks() {
    echo "Removing unused networks..."
    docker network prune -f
    if [ $? -ne 0 ]; then
        echo "Failed to remove unused networks."
        exit 1
    fi
    echo "Unused networks removed successfully."
}

# Perform cleanup of all unused Docker resources
perform_cleanup() {
    cleanup_images
    cleanup_containers
    cleanup_volumes
    cleanup_networks
}

# Run the cleanup process
perform_cleanup

echo "Docker cleanup completed successfully."


```


## Features:
- **Remove dangling images**: Images that are not tagged and not associated with any containers.
- **Remove stopped containers**: Containers that are not running.
- **Remove unused volumes**: Volumes that are not attached to any container.
- **Remove unused networks**: Networks not being used by any containers.

## Prerequisites:
- Docker must be installed and running.
- The user must have permission to execute Docker commands.

## How It Works:

### 1. Running the Script:
You can run this script manually or schedule it to run periodically using **cron**.

To run the script manually:
```bash
chmod +x docker_periodic_cleanup.sh
./docker_periodic_cleanup.sh
