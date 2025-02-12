# Docker Container Monitoring:

## Provides health checks and logs for running Docker containers

## Code File :
```sh
#!/bin/bash


echo "--------------------------------------"
echo "Docker Container Health & Log Monitor"
echo "--------------------------------------"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi

# Function to monitor container health
monitor_health() {
    echo "Fetching container health status..."
    docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"
}

# Function to stream logs of a specific container
stream_logs() {
    read -p "Enter container name or ID to view logs: " container_id
    echo "Streaming logs for container: $container_id"
    docker logs -f "$container_id"
}

# Function to monitor real-time resource usage
monitor_stats() {
    echo "Fetching real-time container stats..."
    docker stats --no-stream
}

# Menu for user selection
while true; do
    echo ""
    echo "Choose an option:"
    echo "1. Monitor container health status"
    echo "2. View logs of a specific container"
    echo "3. Monitor real-time resource usage"
    echo "4. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) monitor_health ;;
        2) stream_logs ;;
        3) monitor_stats ;;
        4) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option! Please try again." ;;
    esac
done
```

## Features:
- Check the **health status** of all running containers.
- View **real-time logs** of a specific container.
- Monitor **CPU, memory, and network usage** of containers.

## Prerequisites:
- Docker must be installed and running.
- The user must have permission to execute Docker commands.

## How It Works:

### 1. Running the Script:
```bash
chmod +x docker_monitor.sh
./docker_monitor.sh
