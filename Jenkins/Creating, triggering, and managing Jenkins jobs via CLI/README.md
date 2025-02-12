# Jenkins Job Manager:

## Automates the creation, triggering, and management of Jenkins jobs via CLI

## Code File :
```sh
#!/bin/bash

echo "--------------------------------------------"
echo "Jenkins Job Manager: Create, Trigger, Manage"
echo "--------------------------------------------"

# Jenkins server details
JENKINS_URL="http://your-jenkins-server:8080"
JENKINS_CLI_JAR="/path/to/jenkins-cli.jar"  # Change this to your jenkins-cli.jar location
JENKINS_API_TOKEN="your-api-token"  # Replace with your Jenkins API token
JENKINS_USER="your-username"  # Replace with your Jenkins username

# Check if the Jenkins CLI JAR exists
if [ ! -f "$JENKINS_CLI_JAR" ]; then
    echo "Jenkins CLI JAR not found at $JENKINS_CLI_JAR. Please verify the path."
    exit 1
fi

# Function to create a Jenkins job from an XML configuration file
create_job() {
    read -p "Enter the job name to create: " job_name
    read -p "Enter the path to the job configuration XML: " config_xml

    if [ ! -f "$config_xml" ]; then
        echo "Job configuration file not found. Exiting..."
        exit 1
    fi

    java -jar "$JENKINS_CLI_JAR" -s "$JENKINS_URL" create-job "$job_name" < "$config_xml"
    if [ $? -eq 0 ]; then
        echo "Job '$job_name' created successfully."
    else
        echo "Failed to create the job '$job_name'."
    fi
}

# Function to trigger a Jenkins job
trigger_job() {
    read -p "Enter the job name to trigger: " job_name
    java -jar "$JENKINS_CLI_JAR" -s "$JENKINS_URL" build "$job_name" --username "$JENKINS_USER" --password "$JENKINS_API_TOKEN"
    if [ $? -eq 0 ]; then
        echo "Job '$job_name' triggered successfully."
    else
        echo "Failed to trigger the job '$job_name'."
    fi
}

# Function to list all Jenkins jobs
list_jobs() {
    echo "Listing all Jenkins jobs..."
    java -jar "$JENKINS_CLI_JAR" -s "$JENKINS_URL" list-jobs --username "$JENKINS_USER" --password "$JENKINS_API_TOKEN"
}

# Function to delete a Jenkins job
delete_job() {
    read -p "Enter the job name to delete: " job_name
    java -jar "$JENKINS_CLI_JAR" -s "$JENKINS_URL" delete-job "$job_name" --username "$JENKINS_USER" --password "$JENKINS_API_TOKEN"
    if [ $? -eq 0 ]; then
        echo "Job '$job_name' deleted successfully."
    else
        echo "Failed to delete the job '$job_name'."
    fi
}

# Menu for job management
while true; do
    echo ""
    echo "Choose an option:"
    echo "1. Create a Jenkins job"
    echo "2. Trigger a Jenkins job"
    echo "3. List all Jenkins jobs"
    echo "4. Delete a Jenkins job"
    echo "5. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) create_job ;;
        2) trigger_job ;;
        3) list_jobs ;;
        4) delete_job ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option! Please try again." ;;
    esac
done



```

## Features:
- **Create Jenkins jobs** using an XML configuration file.
- **Trigger Jenkins jobs** manually.
- **List all Jenkins jobs** in the Jenkins instance.
- **Delete Jenkins jobs** from the Jenkins instance.

## Prerequisites:
- **Jenkins CLI JAR** (`jenkins-cli.jar`) must be downloaded from your Jenkins server. 
- **Jenkins server URL** should be accessible.
- **Jenkins API token** must be available for authentication.
- **Jenkins username** is required for authentication.

## How It Works:

### 1. Running the Script:
Make the script executable and run it:
```bash
chmod +x jenkins_job_manager.sh
./jenkins_job_manager.sh
