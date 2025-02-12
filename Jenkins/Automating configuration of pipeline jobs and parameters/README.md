# Jenkins Pipeline Job Configuration:

## Automates the creation and configuration of Jenkins pipeline jobs and their parameters.

## Code File :
```sh
#!/bin/bash

echo "---------------------------------------------"
echo "Jenkins Pipeline Job Configuration"
echo "---------------------------------------------"

# Jenkins server details
JENKINS_URL="http://your-jenkins-server:8080"
JENKINS_CLI_JAR="/path/to/jenkins-cli.jar"  # Change this to your jenkins-cli.jar location
JENKINS_API_TOKEN="your-api-token"  # Replace with your Jenkins API token
JENKINS_USER="your-username"  # Replace with your Jenkins username

# Check if Jenkins CLI JAR exists
if [ ! -f "$JENKINS_CLI_JAR" ]; then
    echo "Jenkins CLI JAR not found at $JENKINS_CLI_JAR. Please verify the path."
    exit 1
fi

# Function to create a Jenkins pipeline job with parameters
create_pipeline_job() {
    read -p "Enter the job name to create: " job_name
    read -p "Enter the pipeline script file (Jenkinsfile) location: " pipeline_script

    if [ ! -f "$pipeline_script" ]; then
        echo "Pipeline script file not found. Exiting..."
        exit 1
    fi

    read -p "Do you want to add parameters to this pipeline job? (yes/no): " add_params

    # Define parameters in the pipeline job if required
    if [ "$add_params" == "yes" ]; then
        echo "Please specify the parameters (one per line, type 'done' to finish):"
        params=""
        while true; do
            read -p "Enter parameter name: " param_name
            if [ "$param_name" == "done" ]; then
                break
            fi
            read -p "Enter parameter type (string/boolean/choice/etc.): " param_type
            read -p "Enter parameter default value: " param_default

            # Append parameter to the list
            params="$params
    parameters {
        $param_type(name: '$param_name', defaultValue: '$param_default', description: '$param_name')
    }"
        done
    fi

    # Create the pipeline job using the Jenkins CLI
    job_config="<flow-definition plugin='workflow-job@2.40'>
                    <actions/>
                    <description/>
                    <keepDependencies>false</keepDependencies>
                    <properties>
                        <hudson.model.ParametersDefinitionProperty>
                            <parameterDefinitions>$params</parameterDefinitions>
                        </hudson.model.ParametersDefinitionProperty>
                    </properties>
                    <definition class='org.jenkinsci.plugins.workflow.cps.CpsFlowDefinition' plugin='workflow-cps@2.88'>
                        <script>
                            load '$pipeline_script'
                        </script>
                        <sandbox>true</sandbox>
                    </definition>
                    <triggers/>
                </flow-definition>"

    # Save the job configuration to a file
    echo "$job_config" > "$job_name-job-config.xml"

    # Create the job using Jenkins CLI
    java -jar "$JENKINS_CLI_JAR" -s "$JENKINS_URL" create-job "$job_name" < "$job_name-job-config.xml"
    if [ $? -eq 0 ]; then
        echo "Pipeline job '$job_name' created successfully with parameters."
    else
        echo "Failed to create the pipeline job '$job_name'."
    fi
}

# Menu for pipeline job configuration
while true; do
    echo ""
    echo "Choose an option:"
    echo "1. Create a Jenkins Pipeline Job with Parameters"
    echo "2. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) create_pipeline_job ;;
        2) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option! Please try again." ;;
    esac
done


```
## Features:
- **Create Jenkins pipeline jobs** with a provided pipeline script (Jenkinsfile).
- **Add parameters** to the pipeline job to collect dynamic inputs during execution.
- Supports **string**, **boolean**, **choice**, and other parameter types.

## Prerequisites:
- **Jenkins CLI JAR** (`jenkins-cli.jar`) must be downloaded from your Jenkins server. 
- **Jenkins server URL** should be accessible.
- **Jenkins API token** must be available for authentication.
- **Jenkins username** is required for authentication.

## How It Works:

### 1. Running the Script:
Make the script executable and run it:
```bash
chmod +x jenkins_pipeline_config.sh
./jenkins_pipeline_config.sh
