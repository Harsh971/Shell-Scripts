# EC2 Instance Management Script:

## Code File :
```sh
#!/bin/bash

# EC2 Instance Management Script
# This script allows launching, stopping, and terminating EC2 instances using AWS CLI.

REGION="us-east-1"  # Replace with your desired region
INSTANCE_ID=""  # Replace with your instance ID if stopping or terminating

case $1 in
    launch)
        aws ec2 run-instances --image-id ami-0abcdef1234567890 --count 1 --instance-type t2.micro --key-name MyKeyPair --region $REGION
        ;;
    stop)
        if [ -z "$INSTANCE_ID" ]; then
            echo "Please set the INSTANCE_ID variable in the script."
            exit 1
        fi
        aws ec2 stop-instances --instance-ids $INSTANCE_ID --region $REGION
        ;;
    terminate)
        if [ -z "$INSTANCE_ID" ]; then
            echo "Please set the INSTANCE_ID variable in the script."
            exit 1
        fi
        aws ec2 terminate-instances --instance-ids $INSTANCE_ID --region $REGION
        ;;
    *)
        echo "Usage: $0 {launch|stop|terminate}"
        ;;
esac



```

## How It Works

### 1. Launching an EC2 Instance

- **Operation:**
  - When executed with the `launch` argument, the script initiates a new EC2 instance.
  - The `aws ec2 run-instances` command is used with parameters specifying the Amazon Machine Image (AMI) ID, instance count, instance type, key pair name, and region.
  - Example:
    ```bash
    ./ec2_manage.sh launch
    ```
  - This command launches a new EC2 instance based on the provided parameters.

### 2. Stopping an EC2 Instance

- **Operation:**
  - Executing the script with the `stop` argument stops the specified EC2 instance.
  - The `aws ec2 stop-instances` command is invoked with the instance ID and region.
  - Example:
    ```bash
    ./ec2_manage.sh stop
    ```
  - This stops the running instance identified by the provided instance ID.

### 3. Terminating an EC2 Instance

- **Operation:**
  - Using the `terminate` argument with the script terminates the specified EC2 instance.
  - The `aws ec2 terminate-instances` command is called with the instance ID and region.
  - Example:
    ```bash
    ./ec2_manage.sh terminate
    ```
  - This permanently terminates the instance identified by the provided instance ID.
