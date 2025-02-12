# Scripted installation or upgrades of Jenkins plugins:



## Code File :
```sh
#!/bin/bash

# Jenkins URL
JENKINS_URL="http://localhost:8080"  # Update this with your Jenkins server URL
JENKINS_CLI="/usr/local/bin/jenkins-cli"  # Path to Jenkins CLI executable (make sure Jenkins CLI is installed)
JENKINS_USER="admin"  # Jenkins username (update with your Jenkins username)
JENKINS_PASSWORD="yourpassword"  # Jenkins password or API token

# List of Jenkins plugins to install/upgrade
PLUGINS=("git" "docker-workflow" "pipeline-model-definition" "blueocean")

# Function to install or upgrade a plugin
install_or_upgrade_plugin() {
    local plugin=$1
    echo "Checking if plugin '$plugin' is installed..."

    # Check if the plugin is already installed
    INSTALLED=$(java -jar $JENKINS_CLI -s $JENKINS_URL -auth $JENKINS_USER:$JENKINS_PASSWORD list-plugins | grep "$plugin")

    if [[ -z "$INSTALLED" ]]; then
        # Plugin is not installed, installing it
        echo "Plugin '$plugin' is not installed. Installing now..."
        java -jar $JENKINS_CLI -s $JENKINS_URL -auth $JENKINS_USER:$JENKINS_PASSWORD install-plugin "$plugin" -deploy
    else
        # Plugin is installed, upgrading it
        echo "Plugin '$plugin' is already installed. Upgrading to the latest version..."
        java -jar $JENKINS_CLI -s $JENKINS_URL -auth $JENKINS_USER:$JENKINS_PASSWORD install-plugin "$plugin" -deploy
    fi
}

# Loop through the list of plugins and install/upgrade them
for plugin in "${PLUGINS[@]}"; do
    install_or_upgrade_plugin "$plugin"
done

# Restart Jenkins to apply plugin updates
echo "Restarting Jenkins to apply the plugin changes..."
java -jar $JENKINS_CLI -s $JENKINS_URL -auth $JENKINS_USER:$JENKINS_PASSWORD restart
echo "Jenkins has been restarted."


```

This script automates the installation and upgrading of Jenkins plugins. It checks whether a plugin is already installed and installs or upgrades it to the latest version. After the plugins are installed or upgraded, it restarts Jenkins to apply the changes.

## Features:
- **Installs or upgrades** plugins to the latest version.
- **Checks if a plugin is already installed** before attempting installation or upgrade.
- **Restarts Jenkins** to apply changes after plugins are installed/upgraded.

## Prerequisites:
- **Jenkins CLI**: Make sure you have the Jenkins CLI installed (`jenkins-cli.jar`). You can download it from your Jenkins server at `http://<jenkins_url>/jnlpJars/jenkins-cli.jar`.
- **Jenkins Server**: The script assumes Jenkins is running at `http://localhost:8080`. Update this with your Jenkins server URL if necessary.
- **Jenkins User**: You must provide a Jenkins username and password or API token for authentication.

## How It Works:

### 1. Running the Script:
Make the script executable and run it manually or schedule it with `cron` to automate plugin installation and upgrades.

```bash
chmod +x install_or_upgrade_jenkins_plugins.sh
./install_or_upgrade_jenkins_plugins.sh
