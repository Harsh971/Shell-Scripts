# Docker Container Management:

## This script allows users to start, stop, and restart Docker containers interactively.

## Code File :
```sh
#!/bin/bash

# Function to display running containers
list_containers() {
    echo "Fetching list of running containers..."
    docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
}

# Function to start a container
start_container() {
    read -p "Enter container ID or name to start: " container
    docker start "$container"
    echo "Container '$container' started successfully!"
}

# Function to stop a container
stop_container() {
    read -p "Enter container ID or name to stop: " container
    docker stop "$container"
    echo "Container '$container' stopped successfully!"
}

# Function to restart a container
restart_container() {
    read -p "Enter container ID or name to restart: " container
    docker restart "$container"
    echo "Container '$container' restarted successfully!"
}

# Menu for user selection
while true; do
    echo "--------------------------"
    echo "Docker Container Manager"
    echo "--------------------------"
    echo "1. List running containers"
    echo "2. Start a container"
    echo "3. Stop a container"
    echo "4. Restart a container"
    echo "5. Exit"
    echo "--------------------------"
    read -p "Choose an option: " option

    case $option in
        1) list_containers ;;
        2) start_container ;;
        3) stop_container ;;
        4) restart_container ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option! Please try again." ;;
    esac
done


```

## Features:
- List currently running containers.
- Start a stopped container.
- Stop a running container.
- Restart a container.

## Prerequisites:
- Docker must be installed and running on the system.
- The user running the script must have permission to execute Docker commands.

## How It Works:

### 1. Running the Script:
```bash
chmod +x docker_container_manager.sh
./docker_container_manager.sh
