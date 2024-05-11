#!/bin/bash

# Check if AWS CLI is installed
if ! [ -x "$(command -v aws)" ]; then
  echo 'Error: AWS CLI is not installed. Please install it before running this script.' >&2
  exit 1
fi

# List all running EC2 instances
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId, InstanceType, State.Name, PublicIpAddress, PrivateIpAddress]' --output table
