#!/bin/bash

# Prompt user for the public IP address of the AWS EC2 instance
read -p "Enter the public IP address of the AWS EC2 instance : " public_ip

# Prompt user for the username of the AWS EC2 instance
read -p "Enter the username of the AWS EC2 instance : " username

# Key Path
key="/home/harsh/Desktop/linux-practice.pem"

# Check if both IP address and username are provided
if [ -z "$public_ip" ] || [ -z "$username" ]; then
    echo "Please enter proper data."
    exit 1
fi

# Attempt SSH connection to the EC2 instance
ssh -i $key $username@$public_ip

# Check the exit status of the SSH command
if [ $? -ne 0 ]; then
    echo "Unable to connect to instance."
fi
