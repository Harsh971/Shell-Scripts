# Jenkins Build and Artifact Archiving:

## Automates build process (Maven/Gradle) and archives build artifacts.

## Code File :
```sh
#!/bin/bash

echo "--------------------------------------------"
echo "Jenkins Build and Artifact Archiving"
echo "--------------------------------------------"

# Jenkins server details
JENKINS_URL="http://your-jenkins-server:8080"
JENKINS_CLI_JAR="/path/to/jenkins-cli.jar"  # Change this to your jenkins-cli.jar location
JENKINS_API_TOKEN="your-api-token"  # Replace with your Jenkins API token
JENKINS_USER="your-username"  # Replace with your Jenkins username

# Build tool options (e.g., Maven or Gradle)
BUILD_TOOL="maven"  # Change to "gradle" if using Gradle instead of Maven

# S3 Bucket details (if archiving to S3)
S3_BUCKET="your-s3-bucket-name"
S3_ACCESS_KEY="your-access-key"
S3_SECRET_KEY="your-secret-key"

# Check if Jenkins CLI JAR exists
if [ ! -f "$JENKINS_CLI_JAR" ]; then
    echo "Jenkins CLI JAR not found at $JENKINS_CLI_JAR. Please verify the path."
    exit 1
fi

# Function to trigger the build process
trigger_build() {
    echo "Starting build process using $BUILD_TOOL..."

    if [ "$BUILD_TOOL" == "maven" ]; then
        mvn clean install
    elif [ "$BUILD_TOOL" == "gradle" ]; then
        gradle build
    else
        echo "Unsupported build tool: $BUILD_TOOL. Please configure Maven or Gradle."
        exit 1
    fi

    if [ $? -eq 0 ]; then
        echo "Build completed successfully!"
    else
        echo "Build failed."
        exit 1
    fi
}

# Function to archive the build artifacts to S3
archive_to_s3() {
    echo "Archiving artifacts to S3..."

    # Set the environment variables for AWS CLI
    export AWS_ACCESS_KEY_ID=$S3_ACCESS_KEY
    export AWS_SECRET_ACCESS_KEY=$S3_SECRET_KEY
    export AWS_DEFAULT_REGION="us-east-1"  # Replace with your AWS region if needed

    # Assuming the build produces a .jar file or other artifacts
    ARTIFACT_PATH="target/*.jar"  # Adjust based on your build tool/output path

    # Upload the artifact to S3
    aws s3 cp $ARTIFACT_PATH s3://$S3_BUCKET/ --recursive

    if [ $? -eq 0 ]; then
        echo "Artifacts successfully uploaded to S3."
    else
        echo "Failed to upload artifacts to S3."
    fi
}

# Function to archive artifacts in Jenkins
archive_in_jenkins() {
    echo "Archiving artifacts in Jenkins..."

    ARTIFACT_PATH="target/*.jar"  # Adjust based on your build tool/output path

    java -jar "$JENKINS_CLI_JAR" -s "$JENKINS_URL" build "your-job-name" \
        -p ARTIFACT_PATH=$ARTIFACT_PATH \
        -u "$JENKINS_USER" -p "$JENKINS_API_TOKEN"

    if [ $? -eq 0 ]; then
        echo "Artifacts successfully archived in Jenkins."
    else
        echo "Failed to archive artifacts in Jenkins."
    fi
}

# Menu for build and archiving options
while true; do
    echo ""
    echo "Choose an option:"
    echo "1. Trigger Build and Archive Artifacts to S3"
    echo "2. Trigger Build and Archive Artifacts in Jenkins"
    echo "3. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) 
            trigger_build
            archive_to_s3
            ;;
        2) 
            trigger_build
            archive_in_jenkins
            ;;
        3) 
            echo "Exiting..."; 
            exit 0
            ;;
        *) 
            echo "Invalid option! Please try again." 
            ;;
    esac
done


```

## Features:
- **Trigger builds** using **Maven** or **Gradle**.
- **Archive build artifacts** in **AWS S3**.
- **Archive build artifacts** in **Jenkins** (using Jenkins jobs and artifacts storage).
- Flexible for different CI/CD pipelines and build tools.

## Prerequisites:
- **Jenkins CLI JAR** (`jenkins-cli.jar`) must be downloaded from your Jenkins server.
- **AWS CLI** must be installed and configured for S3 artifact storage (if applicable).
- **Maven** or **Gradle** must be installed, depending on the chosen build tool.
- **AWS access keys** for uploading artifacts to an S3 bucket.

## How It Works:

### 1. Running the Script:
Make the script executable and run it:
```bash
chmod +x jenkins_build_and_archive.sh
./jenkins_build_and_archive.sh
