# Docker Image Build & Tag Automation:


## Code File :
```sh
#!/bin/bash

echo "-------------------------------------"
echo "Docker Image Build & Tag Automation"
echo "-------------------------------------"

# Prompt user for details
read -p "Enter the Dockerfile directory (default: current directory): " build_dir
build_dir=${build_dir:-.}

read -p "Enter image name: " image_name
read -p "Enter image tag (default: latest): " image_tag
image_tag=${image_tag:-latest}

# Build the Docker image
echo "Building Docker image..."
docker build -t "$image_name:$image_tag" "$build_dir"

# Check if build was successful
if [ $? -ne 0 ]; then
    echo "Docker build failed. Exiting."
    exit 1
fi

echo "Docker image built successfully: $image_name:$image_tag"

# Prompt for additional tagging
read -p "Do you want to tag the image for a repository? (y/n): " tag_choice
if [[ "$tag_choice" == "y" ]]; then
    read -p "Enter repository name (e.g., myrepo/myimage): " repo_name
    read -p "Enter repository tag (default: latest): " repo_tag
    repo_tag=${repo_tag:-latest}

    docker tag "$image_name:$image_tag" "$repo_name:$repo_tag"
    echo "Image tagged as $repo_name:$repo_tag"
fi

# Prompt for pushing to a registry
read -p "Do you want to push the image to a registry? (y/n): " push_choice
if [[ "$push_choice" == "y" ]]; then
    echo "Pushing image to registry..."
    docker push "$repo_name:$repo_tag"

    if [ $? -ne 0 ]; then
        echo "Failed to push image. Check your credentials and registry access."
        exit 1
    fi

    echo "Image successfully pushed to $repo_name:$repo_tag"
fi

echo "Docker build and tagging process complete!"



```

## Features:
- Build a Docker image from a specified directory.
- Assign a custom tag to the image.
- Tag the image for a repository.
- Push the image to a remote registry.

## Prerequisites:
- Docker must be installed and running.
- User must have permission to execute Docker commands.
- If pushing to a registry, ensure you are authenticated (`docker login`).

## How It Works:

### 1. Running the Script:
```bash
chmod +x docker_build_and_tag.sh
./docker_build_and_tag.sh
