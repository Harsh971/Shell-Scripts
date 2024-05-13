#!/bin/bash

# Function to install Nginx and setup web server
install_nginx() {
  echo "Setting up Nginx on EC2 instance..."
  ssh -i "$KEY_FILE" ec2-user@"$EC2_INSTANCE_IP" << EOF
    sudo yum update -y
    sudo yum install nginx -y
    sudo mv /tmp/index.html /usr/share/nginx/html/index.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
}

# Function to install Nginx and setup web server on Ubuntu
install_nginx_ubuntu() {
  echo "Setting up Nginx on EC2 instance..."
  ssh -i "$KEY_FILE" ubuntu@"$EC2_INSTANCE_IP" << EOF
    sudo apt-get update -y
    sudo apt-get install nginx -y
    sudo mv /tmp/index.html /var/www/html/index.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
}

# Replace these variables with your own values
read -p "Enter the AMI of the EC2 instance (amazon-linux or ubuntu): " AMI_TYPE
EC2_INSTANCE_IP="YOUR_EC2_INSTANCE_IP"
KEY_FILE="YOUR_AWS_KEY_FILE.pem"
LOCAL_HTML_FILE="index.html"

# Copy index.html to EC2 instance
echo "Copying index.html to EC2 instance..."
scp -i "$KEY_FILE" "$LOCAL_HTML_FILE" ec2-user@"$EC2_INSTANCE_IP":/tmp

# SSH into EC2 instance based on selected AMI type
case "$AMI_TYPE" in
  "amazon-linux")
    install_nginx
    ;;
  "ubuntu")
    install_nginx_ubuntu
    ;;
  *)
    echo "Invalid AMI type. Please choose 'amazon-linux' or 'ubuntu'."
    exit 1
    ;;
esac

echo "Nginx setup complete. You can access your webpage at http://$EC2_INSTANCE_IP"
