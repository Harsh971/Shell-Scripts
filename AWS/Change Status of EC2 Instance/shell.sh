#!/bin/bash

# Function to list EC2 instances
list_ec2_instances() {
    aws ec2 describe-instances \
        --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value | [0], InstanceId, Placement.AvailabilityZone, State.Name]' \
        --output table
}

# Function to start an EC2 instance
start_instance() {
    read -p "Enter the name of the instance you want to start: " instance_name
    instance_id=$(aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=$instance_name" \
        --query 'Reservations[*].Instances[*].InstanceId' \
        --output text)

    if [ -z "$instance_id" ]; then
        echo "Instance '$instance_name' not found."
    else
        aws ec2 start-instances --instance-ids $instance_id
        echo "Instance '$instance_name' starting..."
    fi
}

# Function to stop an EC2 instance
stop_instance() {
    read -p "Enter the name of the instance you want to stop: " instance_name
    instance_id=$(aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=$instance_name" \
        --query 'Reservations[*].Instances[*].InstanceId' \
        --output text)

    if [ -z "$instance_id" ]; then
        echo "Instance '$instance_name' not found."
    else
        aws ec2 stop-instances --instance-ids $instance_id
        echo "Instance '$instance_name' stopping..."
    fi
}

# List EC2 instances
echo "Listing EC2 instances:"
list_ec2_instances

# Prompt user to start or stop an instance
read -p "Do you want to start or stop any instance? (yes/no): " choice
case $choice in
    [yY][eE][sS])
        read -p "Enter 'start' or 'stop' to perform the action: " action
        case $action in
            "start")
                start_instance
                ;;
            "stop")
                stop_instance
                ;;
            *)
                echo "Invalid action. Please enter 'start' or 'stop'."
                ;;
        esac
        ;;
    *)
        echo "No action performed."
        ;;
esac
