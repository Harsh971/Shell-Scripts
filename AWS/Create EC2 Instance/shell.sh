#!/bin/bash

# AWS Region
region="us-east-1"

# Read user inputs
read -p "Enter AMI option (Amazon-Linux/Ubuntu): " ami_option
case $ami_option in
    "Amazon-Linux")
        ami_id="ami-07caf09b362be10b8"
        ;;
    "Ubuntu")
        ami_id="ami-04b70fa74e45c3917"
        ;;
    *)
        echo "Invalid AMI option"
        exit 1
        ;;
esac

read -p "Enter instance type (e.g., t2.micro): " instance_type
read -p "Enter key pair name: " key_name
read -p "Enter security group ID: " security_group_id
read -p "Enter instance name: " instance_name

# Run Instance
echo "Initiating EC2 instance..."
instance_id=$(aws ec2 run-instances \
    --region $region \
    --image-id $ami_id \
    --instance-type $instance_type \
    --key-name $key_name \
    --security-group-ids $security_group_id \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" \
    --output text \
    --query 'Instances[0].InstanceId')

if [ $? -eq 0 ]; then
    echo "EC2 instance initiated successfully with Instance ID: $instance_id"
else
    echo "Failed to initiate EC2 instance"
fi
