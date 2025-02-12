# Security Group Management:

## This script automates the creation, updating, and deletion of AWS EC2 security groups using AWS CLI.

## Code File :
```sh
#!/bin/bash


REGION="us-east-1"  # Replace with your desired AWS region

case $1 in
    create)
        GROUP_NAME="your-security-group-name"  # Replace with your security group name
        DESCRIPTION="Your security group description"  # Replace with your description
        VPC_ID="your-vpc-id"  # Replace with your VPC ID
        aws ec2 create-security-group --group-name $GROUP_NAME --description "$DESCRIPTION" --vpc-id $VPC_ID --region $REGION
        ;;
    add-rule)
        GROUP_ID="your-security-group-id"  # Replace with your security group ID
        PROTOCOL="tcp"  # Replace with the protocol (e.g., tcp, udp, icmp)
        PORT="22"  # Replace with the port number
        CIDR="0.0.0.0/0"  # Replace with the CIDR block
        aws ec2 authorize-security-group-ingress --group-id $GROUP_ID --protocol $PROTOCOL --port $PORT --cidr $CIDR --region $REGION
        ;;
    remove-rule)
        GROUP_ID="your-security-group-id"  # Replace with your security group ID
        PROTOCOL="tcp"  # Replace with the protocol
        PORT="22"  # Replace with the port number
        CIDR="0.0.0.0/0"  # Replace with the CIDR block
        aws ec2 revoke-security-group-ingress --group-id $GROUP_ID --protocol $PROTOCOL --port $PORT --cidr $CIDR --region $REGION
        ;;
    delete)
        GROUP_ID="your-security-group-id"  # Replace with your security group ID
        aws ec2 delete-security-group --group-id $GROUP_ID --region $REGION
        ;;
    *)
        echo "Usage: $0 {create|add-rule|remove-rule|delete}"
        ;;
esac


```

## How It Works

### 1. Creating a Security Group

- **Operation:**
  - When executed with the `create` argument, the script creates a new security group within a specified VPC.
  - The `aws ec2 create-security-group` command is used with parameters specifying the group name, description, VPC ID, and region.
  - Example:
    ```bash
    ./security_group_manage.sh create
    ```
  - This command creates a new security group with the provided configuration.

### 2. Adding a Rule to a Security Group

- **Operation:**
  - Executing the script with the `add-rule` argument adds an inbound rule to an existing security group.
  - The `aws ec2 authorize-security-group-ingress` command is invoked with the security group ID, protocol, port, CIDR block, and region.
  - Example:
    ```bash
    ./security_group_manage.sh add-rule
    ```
  - This adds an inbound rule to allow traffic based on the specified parameters.

### 3. Removing a Rule from a Security Group

- **Operation:**
  - Using the `remove-rule` argument with the script removes an existing inbound rule from a security group.
  - The `aws ec2 revoke-security-group-ingress` command is called with the security group ID, protocol, port, CIDR block, and region.
  - Example:
    ```bash
    ./security_group_manage.sh remove-rule
    ```
  - This removes the specified inbound rule from the security group.

### 4. Deleting a Security Group

- **Operation:**
  - Executing the script with the `delete` argument deletes the specified security group.
  - The `aws ec2 delete-security-group` command is used with the security group ID and region.
  - Example:
    ```bash
    ./security_group_manage.sh delete
    ```
  - This permanently deletes the specified security group.
