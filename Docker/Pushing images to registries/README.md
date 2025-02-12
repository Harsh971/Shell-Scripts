# Docker Image Push Automation:

## Code File :
```sh
#!/bin/bash

echo "--------------------------------------"
echo "Docker Image Push Automation"
echo "--------------------------------------"

# Prompt user for registry type
echo "Choose the registry to push the image to:"
echo "1. Docker Hub"
echo "2. AWS ECR"
read -p "Enter your choice (1 or 2): " registry_choice

# Common input fields
read -p "Enter image name (e.g., myapp): " image_name
read -p "Enter image tag (default: latest): " image_tag
image_tag=${image_tag:-latest}

# Docker Hub
if [[ "$registry_choice" == "1" ]]; then
    read -p "Enter your Docker Hub username: " docker_user
    read -sp "Enter your Docker Hub password: " docker_pass
    echo

    echo "Logging into Docker Hub..."
    echo "$docker_pass" | docker login -u "$docker_user" --password-stdin

    if [ $? -ne 0 ]; then
        echo "Docker Hub login failed. Exiting."
        exit 1
    fi

    repo_name="$docker_user/$image_name"

# AWS ECR
elif [[ "$registry_choice" == "2" ]]; then
    read -p "Enter AWS region (e.g., us-east-1): " aws_region
    read -p "Enter AWS account ID: " aws_account_id

    repo_name="$aws_account_id.dkr.ecr.$aws_region.amazonaws.com/$image_name"

    echo "Authenticating with AWS ECR..."
    aws ecr get-login-password --region "$aws_region" | docker login --username AWS --password-stdin "$aws_account_id.dkr.ecr.$aws_region.amazonaws.com"

    if [ $? -ne 0 ]; then
        echo "AWS ECR login failed. Exiting."
        exit 1
    fi
fi

# Tag the image
echo "Tagging image as $repo_name:$image_tag"
docker tag "$image_name:$image_tag" "$repo_name:$image_tag"

# Push the image
echo "Pushing image to registry..."
docker push "$repo_name:$image_tag"

if [ $? -ne 0 ]; then
    echo "Image push failed. Please check your credentials and network."
    exit 1
fi

echo "Image successfully pushed to $repo_name:$image_tag"

```

## Features:
- Supports pushing to **Docker Hub** and **AWS Elastic Container Registry (ECR)**.
- Prompts the user for registry credentials and details.
- Automatically logs in, tags, and pushes the image.
- Ensures successful authentication before proceeding.

## Prerequisites:
- Docker must be installed and running.
- The user must have permission to execute Docker commands.
- For AWS ECR:
  - AWS CLI must be installed and configured (`aws configure`).
  - The ECR repository must exist in your AWS account.

## How It Works:

### 1. Running the Script:
```bash
chmod +x docker_push_to_registry.sh
./docker_push_to_registry.sh
