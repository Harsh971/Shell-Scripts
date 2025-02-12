# Integrating with Git repositories for automated triggers:

## Code File :
```sh
#!/bin/bash

# Jenkins URL
JENKINS_URL="http://localhost:8080"  # Update this with your Jenkins server URL
JENKINS_CLI="/usr/local/bin/jenkins-cli"  # Path to Jenkins CLI executable
JENKINS_USER="admin"  # Jenkins username
JENKINS_PASSWORD="yourpassword"  # Jenkins password or API token

# Git Repository URL
GIT_REPO_URL="https://github.com/yourusername/yourrepository.git"  # Update with your Git repository URL
GIT_BRANCH="main"  # Branch to monitor for changes

# Jenkins Job Name
JENKINS_JOB_NAME="your-job-name"  # Update with the Jenkins job name to trigger

# Polling interval in seconds (e.g., every 60 seconds)
POLL_INTERVAL=60

# Git repository polling loop
while true; do
    # Check for changes in the Git repository
    echo "Checking for changes in Git repository..."
    git ls-remote --exit-code "$GIT_REPO_URL" "$GIT_BRANCH" > /dev/null

    if [ $? -eq 0 ]; then
        echo "Changes detected in the Git repository. Triggering Jenkins build..."
        
        # Trigger Jenkins job
        java -jar $JENKINS_CLI -s $JENKINS_URL -auth $JENKINS_USER:$JENKINS_PASSWORD build $JENKINS_JOB_NAME
    else
        echo "No changes detected in the Git repository."
    fi

    # Wait for the next polling interval
    sleep $POLL_INTERVAL
done



```

This script integrates Jenkins with a Git repository to trigger builds automatically based on changes pushed to the repository. You can either use **polling** (periodic checks for changes) or **webhooks** (immediate triggering) to integrate Git with Jenkins.

## Features:
- **Polling Mode**: Checks the Git repository for changes at regular intervals.
- **Webhook Mode**: Triggers Jenkins builds immediately when changes are pushed to the repository.
- **Automated Jenkins Build Triggers**: Automatically triggers Jenkins jobs based on Git repository changes.

## Prerequisites:
- **Jenkins CLI**: Make sure Jenkins CLI (`jenkins-cli.jar`) is installed and accessible.
- **Jenkins Job**: Create a Jenkins job configured to build from the Git repository.
- **Git Repository**: The Git repository must be accessible to Jenkins.
- **Git Hosting Service Webhook**: For webhook integration, ensure your Git hosting service supports webhooks (e.g., GitHub, GitLab).

## How It Works:

### Option 1: Triggering Jenkins Build Using Polling:
The script checks the Git repository for changes at regular intervals and triggers a Jenkins job when changes are detected. The script uses the `git ls-remote` command to check the repository.

#### 1. Running the Script:
```bash
chmod +x trigger_jenkins_build_on_git_changes.sh
./trigger_jenkins_build_on_git_changes.sh
