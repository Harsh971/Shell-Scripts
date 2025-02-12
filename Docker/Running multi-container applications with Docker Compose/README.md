# Docker Compose Manager:

## Automates running multi-container applications with Docker Compose

## Code File :
```sh
#!/bin/bash

echo "--------------------------------------"
echo "Docker Compose Application Manager"
echo "--------------------------------------"

# Check if Docker and Docker Compose are installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed. Please install Docker Compose and try again."
    exit 1
fi

# Get the directory where docker-compose.yml is located
read -p "Enter the directory containing docker-compose.yml (default: current directory): " compose_dir
compose_dir=${compose_dir:-.}

# Navigate to the directory
cd "$compose_dir" || { echo "Directory not found! Exiting..."; exit 1; }

# Display menu options
while true; do
    echo "Select an option:"
    echo "1. Start containers (docker-compose up -d)"
    echo "2. Stop containers (docker-compose down)"
    echo "3. Restart containers"
    echo "4. View running containers (docker ps)"
    echo "5. View logs (docker-compose logs -f)"
    echo "6. Rebuild and restart (docker-compose up --build -d)"
    echo "7. Exit"
    read -p "Choose an option: " option

    case $option in
        1) echo "Starting containers..."; docker-compose up -d ;;
        2) echo "Stopping containers..."; docker-compose down ;;
        3) echo "Restarting containers..."; docker-compose down && docker-compose up -d ;;
        4) echo "Listing running containers..."; docker ps ;;
        5) echo "Showing logs..."; docker-compose logs -f ;;
        6) echo "Rebuilding and restarting containers..."; docker-compose up --build -d ;;
        7) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option! Please try again." ;;
    esac
done


```

## Features:
- Start, stop, and restart containers.
- View running containers.
- Stream real-time logs from all services.
- Rebuild and restart containers.

## Prerequisites:
- Docker and Docker Compose must be installed.
- A valid `docker-compose.yml` file should be present.

## How It Works:

### 1. Running the Script:
```bash
chmod +x docker_compose_manager.sh
./docker_compose_manager.sh
