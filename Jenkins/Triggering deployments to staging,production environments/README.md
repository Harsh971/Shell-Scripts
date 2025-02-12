# Deployment Script for Staging/Production Environments:

## This script triggers deployments to staging or production environments using Jenkins, EC2, or Kubernetes.

## Code File :
```sh
#!/bin/bash

echo "--------------------------------------------"
echo "Deploying to Staging/Production Environments"
echo "--------------------------------------------"

# Environment options
STAGING_ENV="staging"
PRODUCTION_ENV="production"

# Jenkins server details
JENKINS_URL="http://your-jenkins-server:8080"
JENKINS_CLI_JAR="/path/to/jenkins-cli.jar"  # Change this to your jenkins-cli.jar location
JENKINS_API_TOKEN="your-api-token"  # Replace with your Jenkins API token
JENKINS_USER="your-username"  # Replace with your Jenkins username

# AWS EC2 Instance details (if deploying to EC2)
EC2_USER="ec2-user"
EC2_PRIVATE_KEY="/path/to/private-key.pem"
EC2_STAGING_IP="your-staging-ec2-ip"
EC2_PRODUCTION_IP="your-production-ec2-ip"

# Kubernetes Deployment Details (if deploying to Kubernetes)
K8S_CONTEXT="your-k8s-context"
K8S_NAMESPACE="your-k8s-namespace"
K8S_DEPLOYMENT="your-k8s-deployment"

# Function to trigger deployment via Jenkins
deploy_via_jenkins() {
    echo "Triggering deployment via Jenkins..."
    JOB_NAME=$1
    java -jar "$JENKINS_CLI_JAR" -s "$JENKINS_URL" build "$JOB_NAME" \
        -u "$JENKINS_USER" -p "$JENKINS_API_TOKEN"
    if [ $? -eq 0 ]; then
        echo "Deployment triggered via Jenkins job '$JOB_NAME'."
    else
        echo "Failed to trigger deployment via Jenkins job '$JOB_NAME'."
    fi
}

# Function to trigger deployment to EC2 instance via SSH
deploy_to_ec2() {
    echo "Triggering deployment to EC2 ($1)..."
    ENV_IP=$1
    ssh -i "$EC2_PRIVATE_KEY" "$EC2_USER"@"$ENV_IP" << 'EOF'
        # Replace with actual deployment commands
        cd /path/to/application
        git pull origin main
        ./deploy.sh  # Custom script for deployment
        echo "Deployment successful."
EOF
    if [ $? -eq 0 ]; then
        echo "Deployment to EC2 at $ENV_IP successful."
    else
        echo "Failed to deploy to EC2 at $ENV_IP."
    fi
}

# Function to deploy to Kubernetes
deploy_to_kubernetes() {
    echo "Triggering deployment to Kubernetes ($K8S_DEPLOYMENT)..."
    kubectl --context="$K8S_CONTEXT" -n "$K8S_NAMESPACE" rollout restart deployment "$K8S_DEPLOYMENT"
    if [ $? -eq 0 ]; then
        echo "Deployment to Kubernetes cluster '$K8S_CONTEXT' successful."
    else
        echo "Failed to deploy to Kubernetes."
    fi
}

# Menu for deployment options
while true; do
    echo ""
    echo "Choose an environment to deploy to:"
    echo "1. Staging"
    echo "2. Production"
    echo "3. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) 
            echo "Choose deployment method:"
            echo "1. Jenkins"
            echo "2. AWS EC2"
            echo "3. Kubernetes"
            read -p "Enter your choice: " method

            case $method in
                1)
                    deploy_via_jenkins "staging-deploy-job"
                    ;;
                2)
                    deploy_to_ec2 "$EC2_STAGING_IP"
                    ;;
                3)
                    deploy_to_kubernetes
                    ;;
                *)
                    echo "Invalid option! Please try again."
                    ;;
            esac
            ;;
        2) 
            echo "Choose deployment method:"
            echo "1. Jenkins"
            echo "2. AWS EC2"
            echo "3. Kubernetes"
            read -p "Enter your choice: " method

            case $method in
                1)
                    deploy_via_jenkins "production-deploy-job"
                    ;;
                2)
                    deploy_to_ec2 "$EC2_PRODUCTION_IP"
                    ;;
                3)
                    deploy_to_kubernetes
                    ;;
                *)
                    echo "Invalid option! Please try again."
                    ;;
            esac
            ;;
        3) 
            echo "Exiting..."
            exit 0
            ;;
        *) 
            echo "Invalid option! Please try again."
            ;;
    esac
done


```

This script automates the process of triggering deployments to **staging** or **production** environments. It supports three deployment methods:
1. **Jenkins** - Triggering a Jenkins job to deploy artifacts.
2. **AWS EC2** - SSH-based deployment to AWS EC2 instances.
3. **Kubernetes** - Deployment to a Kubernetes cluster.

## Features:
- **Trigger Jenkins Jobs** for deployment to staging or production.
- **Deploy to AWS EC2** instances via SSH.
- **Deploy to Kubernetes** clusters via `kubectl`.

## Prerequisites:
- **Jenkins CLI JAR** (`jenkins-cli.jar`) must be downloaded from your Jenkins server.
- **AWS EC2** instances must be accessible, with SSH private key configured for login.
- **Kubernetes** must be configured and the `kubectl` CLI must be set up for the relevant cluster context.
- For **Jenkins**, you need **API token** and **Jenkins username** for authentication.

## How It Works:

### 1. Running the Script:
Make the script executable and run it:
```bash
chmod +x deploy_to_staging_production.sh
./deploy_to_staging_production.sh
