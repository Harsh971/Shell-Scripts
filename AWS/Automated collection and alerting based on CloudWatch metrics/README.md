# CloudWatch Metrics Collection and Alerting Automation:

## This script installs and configures the CloudWatch Agent on an EC2 instance, sets up CloudWatch alarms, and configures notifications via SNS

## Code File :
```sh
#!/bin/bash

# Variables
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION="us-east-1"  # Replace with your desired AWS region
SNS_TOPIC_NAME="CloudWatchAlerts"
ALARM_THRESHOLD=80  # CPU utilization threshold for alarm

# Install CloudWatch Agent
sudo yum update -y
sudo yum install amazon-cloudwatch-agent -y

# Create CloudWatch Agent configuration file
cat <<EOL | sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
    "metrics": {
        "append_dimensions": {
            "InstanceId": "$INSTANCE_ID"
        },
        "metrics_collected": {
            "cpu": {
                "measurement": [
                    {"name": "cpu_usage_idle", "rename": "CPUUsageIdle", "unit": "Percent"}
                ],
                "metrics_collection_interval": 60
            },
            "mem": {
                "measurement": [
                    {"name": "mem_used_percent", "rename": "MemoryUsedPercent", "unit": "Percent"}
                ],
                "metrics_collection_interval": 60
            }
        }
    }
}
EOL

# Start the CloudWatch Agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s

# Create SNS topic for alerts
aws sns create-topic --name $SNS_TOPIC_NAME --region $REGION

# Subscribe an email endpoint to the SNS topic
read -p "Enter the email address to receive alerts: " EMAIL_ADDRESS
aws sns subscribe --topic-arn arn:aws:sns:$REGION:$(aws sts get-caller-identity --query Account --output text):$SNS_TOPIC_NAME \
    --protocol email --notification-endpoint $EMAIL_ADDRESS --region $REGION

# Create CloudWatch alarm for CPU utilization
aws cloudwatch put-metric-alarm --alarm-name "HighCPUUtilization" \
    --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average \
    --period 300 --threshold $ALARM_THRESHOLD --comparison-operator GreaterThanThreshold \
    --dimensions Name=InstanceId,Value=$INSTANCE_ID --evaluation-periods 1 \
    --alarm-actions arn:aws:sns:$REGION:$(aws sts get-caller-identity --query Account --output text):$SNS_TOPIC_NAME \
    --region $REGION

echo "CloudWatch Agent configured, SNS topic and subscription created, and alarm set for CPU utilization."

```

## How It Works

### 1. Install CloudWatch Agent

- **Operation:**
  - The script updates the system packages and installs the Amazon CloudWatch Agent.
  - Commands:
    ```bash
    sudo yum update -y
    sudo yum install amazon-cloudwatch-agent -y
    ```

### 2. Configure CloudWatch Agent

- **Operation:**
  - A configuration file for the CloudWatch Agent is created, specifying the collection of CPU and memory metrics at 60-second intervals.
  - The configuration includes appending the `InstanceId` dimension for identification.
  - Commands:
    ```bash
    cat <<EOL | sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
    {
        "metrics": {
            "append_dimensions": {
                "InstanceId": "$INSTANCE_ID"
            },
            "metrics_collected": {
                "cpu": {
                    "measurement": [
                        {"name": "cpu_usage_idle", "rename": "CPUUsageIdle", "unit": "Percent"}
                    ],
                    "metrics_collection_interval": 60
                },
                "mem": {
                    "measurement": [
                        {"name": "mem_used_percent", "rename": "MemoryUsedPercent", "unit": "Percent"}
                    ],
                    "metrics_collection_interval": 60
                }
            }
        }
    }
    EOL
    ```

### 3. Start CloudWatch Agent

- **Operation:**
  - The CloudWatch Agent is started with the specified configuration to begin collecting and publishing metrics.
  - Command:
    ```bash
    sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
        -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s
    ```

### 4. Create SNS Topic and Subscription

- **Operation:**
  - An SNS topic named `CloudWatchAlerts` is created to handle alarm notifications.
  - The script prompts for an email address to subscribe to the SNS topic for receiving alerts.
  - Commands:
    ```bash
    aws sns create-topic --name $SNS_TOPIC_NAME --region $REGION
    read -p "Enter the email address to receive alerts: " EMAIL_ADDRESS
    aws sns subscribe --topic-arn arn:aws:sns:$REGION:$(aws sts get-caller-identity --query Account --output text):$SNS_TOPIC_NAME \
        --protocol email --notification-endpoint $EMAIL_ADDRESS --region $REGION
    ```

### 5. Set Up CloudWatch Alarm

- **Operation:**
  - A CloudWatch alarm named `HighCPUUtilization` is created to monitor the `CPUUtilization` metric.
  - The alarm triggers when the average CPU utilization exceeds the defined threshold (default is 80%) over a 5-minute period.
  - Upon triggering, the alarm sends a notification to the SNS topic, which in turn sends an email alert.
  - Command:
    ```bash
    aws cloudwatch put-metric-alarm --alarm-name "HighCPUUtilization" \
        --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average \
        --period 300 --threshold $ALARM_THRESHOLD --comparison-operator GreaterThanThreshold \
        --dimensions Name=InstanceId,Value=$INSTANCE_ID --evaluation-periods 1 \
        --alarm-actions arn:aws:sns:$REGION:$(aws sts get-caller-identity --query Account --output text):$SNS_TOPIC_NAME \
        --region $REGION
    ```
