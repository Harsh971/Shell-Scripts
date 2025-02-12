# AWS Resource Tagging Audit and Enforcement:

## This script audits AWS resources for compliance with tagging policies and enforces required tags using AWS CLI.

## Code File :
```sh
#!/bin/bash

REQUIRED_TAGS=("Environment" "Owner" "Project")  # Define the required tags
REGION="us-east-1"  # Replace with your desired AWS region

# Function to check and enforce tags on a resource
enforce_tags() {
    RESOURCE_ID=$1
    RESOURCE_TYPE=$2
    MISSING_TAGS=()

    # Get the current tags for the resource
    CURRENT_TAGS=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$RESOURCE_ID" --region $REGION --query 'Tags[*].Key' --output text)

    # Check for missing tags
    for TAG in "${REQUIRED_TAGS[@]}"; do
        if [[ ! " $CURRENT_TAGS " =~ " $TAG " ]]; then
            MISSING_TAGS+=($TAG)
        fi
    done

    # If there are missing tags, add them
    if [ ${#MISSING_TAGS[@]} -ne 0 ]; then
        echo "Resource $RESOURCE_ID is missing tags: ${MISSING_TAGS[@]}"
        TAGS_TO_ADD=()
        for TAG in "${MISSING_TAGS[@]}"; do
            read -p "Enter value for tag '$TAG': " VALUE
            TAGS_TO_ADD+=("Key=$TAG,Value=$VALUE")
        done
        aws ec2 create-tags --resources $RESOURCE_ID --tags ${TAGS_TO_ADD[@]} --region $REGION
        echo "Added missing tags to resource $RESOURCE_ID."
    else
        echo "Resource $RESOURCE_ID has all required tags."
    fi
}

# Audit and enforce tags on EC2 instances
INSTANCE_IDS=$(aws ec2 describe-instances --region $REGION --query 'Reservations[*].Instances[*].InstanceId' --output text)
for INSTANCE_ID in $INSTANCE_IDS; do
    enforce_tags $INSTANCE_ID "instance"
done

# Audit and enforce tags on VPCs
VPC_IDS=$(aws ec2 describe-vpcs --region $REGION --query 'Vpcs[*].VpcId' --output text)
for VPC_ID in $VPC_IDS; do
    enforce_tags $VPC_ID "vpc"
done
```

## How It Works

### 1. Define Required Tags

- **Operation:**
  - The script begins by defining an array of required tags that must be present on AWS resources.
  - Example:
    ```bash
    REQUIRED_TAGS=("Environment" "Owner" "Project")
    ```
  - These tags are essential for resource management, cost allocation, and organizational policies.

### 2. Function to Enforce Tags

- **Operation:**
  - A function named `enforce_tags` is defined to check and enforce tags on a given resource.
  - The function performs the following steps:
    - Retrieves the current tags associated with the resource using the `aws ec2 describe-tags` command.
    - Compares the current tags against the required tags to identify any missing tags.
    - Prompts the user to input values for any missing tags.
    - Adds the missing tags to the resource using the `aws ec2 create-tags` command.
  - This ensures that all resources have the necessary tags for proper identification and management.

### 3. Audit and Enforce Tags on EC2 Instances

- **Operation:**
  - The script retrieves a list of all EC2 instance IDs in the specified region using the `aws ec2 describe-instances` command.
  - It iterates through each instance ID and calls the `enforce_tags` function to ensure compliance with the tagging policy.
  - Example:
    ```bash
    INSTANCE_IDS=$(aws ec2 describe-instances --region $REGION --query 'Reservations[*].Instances[*].InstanceId' --output text)
    for INSTANCE_ID in $INSTANCE_IDS; do
        enforce_tags $INSTANCE_ID "instance"
    done
    ```
  - This process ensures that all EC2 instances have the required tags.

### 4. Audit and Enforce Tags on VPCs

- **Operation:**
  - Similarly, the script retrieves a list of all VPC IDs in the specified region using the `aws ec2 describe-vpcs` command.
  - It iterates through each VPC ID and calls the `enforce_tags` function to ensure compliance with the tagging policy.
  - Example:
    ```bash
    VPC_IDS=$(aws ec2 describe-vpcs --region $REGION --query 'Vpcs[*].VpcId' --output text)
    for VPC_ID in $VPC_IDS; do
        enforce_tags $VPC_ID "vpc"
    done
    ```
  - This process ensures that all VPCs have the required tags.

### 5. Extending to Other Resource Types

- **Operation:**
  - The script can be extended to audit and enforce tags on additional AWS resource types by adding similar blocks of code for each resource type.
  - For example, to audit and enforce tags on security groups, you can add:
    ```bash
    SECURITY_GROUP_IDS=$(aws ec2 describe-security-groups --region $REGION --query 'SecurityGroups[*].GroupId' --output text)
    for SG_ID in $SECURITY_GROUP_IDS; do
        enforce_tags $SG_ID "security-group"
    done
    ```
  - This flexibility allows for comprehensive tagging compliance across various AWS resources.
