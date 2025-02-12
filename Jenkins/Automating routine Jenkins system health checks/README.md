# Automating routine Jenkins system health checks:



## Code File :
```sh
#!/bin/bash

# Jenkins URL
JENKINS_URL="http://localhost:8080"  # Update this with your Jenkins server URL
JENKINS_CLI="/usr/local/bin/jenkins-cli"  # Path to Jenkins CLI executable (ensure Jenkins CLI is installed)
JENKINS_USER="admin"  # Jenkins username
JENKINS_PASSWORD="yourpassword"  # Jenkins password or API token

# Email settings
ALERT_EMAIL="youremail@example.com"  # Replace with your email address
SMTP_SERVER="smtp.example.com"  # SMTP server address
SMTP_PORT="587"  # SMTP server port
SENDER_EMAIL="jenkins-alerts@example.com"  # Email address from which alerts will be sent
SMTP_USER="smtp-username"  # SMTP username
SMTP_PASSWORD="smtp-password"  # SMTP password

# Check Disk Space
check_disk_space() {
    echo "Checking disk space..."
    FREE_SPACE=$(df / | grep / | awk '{ print $4 }')
    MIN_FREE_SPACE=10485760  # Minimum free space in KB (10GB)
    
    if [ "$FREE_SPACE" -lt "$MIN_FREE_SPACE" ]; then
        echo "Warning: Low disk space. Only $((FREE_SPACE / 1024)) MB left."
        send_alert "Warning: Low disk space. Only $((FREE_SPACE / 1024)) MB left."
    else
        echo "Disk space is sufficient."
    fi
}

# Check CPU Usage
check_cpu_usage() {
    echo "Checking CPU usage..."
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    MAX_CPU_USAGE=85  # Maximum acceptable CPU usage percentage

    if [ $(echo "$CPU_USAGE > $MAX_CPU_USAGE" | bc) -eq 1 ]; then
        echo "Warning: High CPU usage. Current usage is ${CPU_USAGE}%."
        send_alert "Warning: High CPU usage. Current usage is ${CPU_USAGE}%. Exceeds $MAX_CPU_USAGE%."
    else
        echo "CPU usage is within acceptable limits."
    fi
}

# Check Memory Usage
check_memory_usage() {
    echo "Checking memory usage..."
    MEM_USAGE=$(free -m | awk '/Mem:/ {print $3/$2 * 100.0}')
    MAX_MEM_USAGE=85  # Maximum acceptable memory usage percentage

    if [ $(echo "$MEM_USAGE > $MAX_MEM_USAGE" | bc) -eq 1 ]; then
        echo "Warning: High memory usage. Current usage is ${MEM_USAGE}%."
        send_alert "Warning: High memory usage. Current usage is ${MEM_USAGE}%. Exceeds $MAX_MEM_USAGE%."
    else
        echo "Memory usage is within acceptable limits."
    fi
}

# Check Jenkins Job Queue Length
check_job_queue_length() {
    echo "Checking Jenkins job queue length..."
    QUEUE_LENGTH=$($JENKINS_CLI -s $JENKINS_URL -auth $JENKINS_USER:$JENKINS_PASSWORD queue | wc -l)
    MAX_QUEUE_LENGTH=5  # Maximum acceptable job queue length

    if [ "$QUEUE_LENGTH" -gt "$MAX_QUEUE_LENGTH" ]; then
        echo "Warning: Jenkins job queue is too long. $QUEUE_LENGTH jobs are waiting."
        send_alert "Warning: Jenkins job queue is too long. $QUEUE_LENGTH jobs are waiting. Exceeds $MAX_QUEUE_LENGTH."
    else
        echo "Jenkins job queue length is within acceptable limits."
    fi
}

# Check for Outdated Plugins
check_plugin_health() {
    echo "Checking Jenkins plugins for updates..."
    OUTDATED_PLUGINS=$($JENKINS_CLI -s $JENKINS_URL -auth $JENKINS_USER:$JENKINS_PASSWORD list-plugins | grep -i "outdated")
    
    if [ ! -z "$OUTDATED_PLUGINS" ]; then
        echo "Warning: Some Jenkins plugins are outdated."
        send_alert "Warning: Some Jenkins plugins are outdated. Please check your plugin list."
    else
        echo "All Jenkins plugins are up-to-date."
    fi
}

# Function to send email alerts
send_alert() {
    local message="$1"
    echo -e "Subject:Jenkins Health Check Alert\nFrom:$SENDER_EMAIL\nTo:$ALERT_EMAIL\n\n$message" | \
    sendmail -S "$SMTP_SERVER:$SMTP_PORT" -f "$SENDER_EMAIL" -au"$SMTP_USER" -ap"$SMTP_PASSWORD" "$ALERT_EMAIL"
}

# Main Routine: Perform Health Checks
check_disk_space
check_cpu_usage
check_memory_usage
check_job_queue_length
check_plugin_health

# Optionally, you can add more checks for other health aspects such as Jenkins system load, JVM heap, etc.


```

This script automates routine Jenkins system health checks, ensuring that your Jenkins environment is running smoothly and alerting you when there are potential issues. It checks disk space, CPU and memory usage, Jenkins job queue length, and plugin health. If any issue is found, it sends an email notification.

## Features:
- **Monitors disk space**, ensuring sufficient space is available for Jenkins.
- **Monitors CPU and memory usage**, ensuring the Jenkins host is not overloaded.
- **Monitors Jenkins job queue length**, ensuring jobs are not excessively waiting.
- **Checks for outdated Jenkins plugins**, ensuring plugins are up-to-date.
- **Email alerting** when any issue is detected.

## Prerequisites:
- **Jenkins CLI**: Make sure you have the Jenkins CLI installed (`jenkins-cli.jar`).
- **Jenkins Server**: The script assumes Jenkins is running at `http://localhost:8080`. Update this with your Jenkins server URL if needed.
- **Jenkins User**: You must provide a Jenkins username and password or API token for authentication.
- **Email Configuration**: SMTP details must be configured to send email alerts.

## How It Works:

### 1. Running the Script:
Make the script executable and run it manually or schedule it with `cron` to automate Jenkins system health checks.

```bash
chmod +x jenkins_health_check.sh
./jenkins_health_check.sh
