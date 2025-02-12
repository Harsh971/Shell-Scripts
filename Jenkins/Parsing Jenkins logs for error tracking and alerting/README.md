# Parsing Jenkins logs for error tracking and alerting:

## Code File :
```sh
#!/bin/bash

# Jenkins log file path
JENKINS_LOG_FILE="/var/log/jenkins/jenkins.log"  # Change to the correct Jenkins log path if needed

# Email settings
ALERT_EMAIL="youremail@example.com"  # Replace with your email address
SUBJECT="Jenkins Error Alert"
SMTP_SERVER="smtp.example.com"  # SMTP server address
SMTP_PORT="587"  # SMTP server port
SENDER_EMAIL="jenkins-alerts@example.com"  # Email address from which alerts will be sent
SMTP_USER="smtp-username"  # SMTP username
SMTP_PASSWORD="smtp-password"  # SMTP password

# Keywords or error patterns to look for in the Jenkins log
ERROR_PATTERNS=("ERROR" "Exception" "Failed" "Fatal" "Critical" "Stacktrace")

# Temporary file to store errors detected in the Jenkins log
TEMP_LOG="/tmp/jenkins_error_log.txt"

# Function to send email alert
send_alert() {
    local error_details="$1"
    echo -e "Subject:$SUBJECT\nFrom:$SENDER_EMAIL\nTo:$ALERT_EMAIL\n\n$error_details" | \
    sendmail -S "$SMTP_SERVER:$SMTP_PORT" -f "$SENDER_EMAIL" -au"$SMTP_USER" -ap"$SMTP_PASSWORD" "$ALERT_EMAIL"
}

# Check if Jenkins log exists
if [ ! -f "$JENKINS_LOG_FILE" ]; then
    echo "Jenkins log file not found: $JENKINS_LOG_FILE"
    exit 1
fi

# Parse the Jenkins log for error patterns
echo "Parsing Jenkins log for errors..."
grep -iE "${ERROR_PATTERNS[*]}" "$JENKINS_LOG_FILE" > "$TEMP_LOG"

# If errors are found, send an alert email
if [ -s "$TEMP_LOG" ]; then
    echo "Errors found in Jenkins log. Sending alert..."
    send_alert "$(cat $TEMP_LOG)"
else
    echo "No errors found in Jenkins log."
fi

# Clean up temporary log file
rm -f "$TEMP_LOG"

```


This script parses the Jenkins log file for specific error patterns (e.g., `ERROR`, `Exception`, `Failed`, etc.) and sends an email alert when errors are detected. It helps track and monitor errors in Jenkins job executions or Jenkins itself.

## Features:
- **Monitors Jenkins logs** for error patterns such as `ERROR`, `Exception`, `Failed`, and others.
- **Sends email notifications** with error details when errors are found.
- **Customizable**: You can change error patterns and configure email settings.

## Prerequisites:
- **Jenkins Log File**: The path to the Jenkins log file, which is usually located at `/var/log/jenkins/jenkins.log` (or another path depending on your setup).
- **Email Configuration**: You must provide an SMTP server address and credentials to send email alerts.

## How It Works:

### 1. Running the Script:
Make the script executable and run it manually or schedule it with `cron` to monitor Jenkins logs regularly.

```bash
chmod +x parse_jenkins_logs.sh
./parse_jenkins_logs.sh
