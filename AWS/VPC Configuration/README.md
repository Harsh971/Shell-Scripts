# VPC Configuration:

## This script automates the creation and configuration of AWS Virtual Private Cloud (VPC) settings using AWS CLI.

## Code File :
```sh

#!/bin/bash


REGION="us-east-1"  # Replace with your desired AWS region

case $1 in
    create-vpc)
        CIDR_BLOCK="10.0.0.0/16"  # Replace with your desired CIDR block
        aws ec2 create-vpc --cidr-block $CIDR_BLOCK --region $REGION
        ;;
    create-subnet)
        VPC_ID="your-vpc-id"  # Replace with your VPC ID
        SUBNET_CIDR="10.0.1.0/24"  # Replace with your desired subnet CIDR block
        aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block $SUBNET_CIDR --region $REGION
        ;;
    create-route-table)
        VPC_ID="your-vpc-id"  # Replace with your VPC ID
        aws ec2 create-route-table --vpc-id $VPC_ID --region $REGION
        ;;
    associate-route-table)
        ROUTE_TABLE_ID="your-route-table-id"  # Replace with your route table ID
        SUBNET_ID="your-subnet-id"  # Replace with your subnet ID
        aws ec2 associate-route-table --route-table-id $ROUTE_TABLE_ID --subnet-id $SUBNET_ID --region $REGION
        ;;
    *)
        echo "Usage: $0 {create-vpc|create-subnet|create-route-table|associate-route-table}"
        ;;
esac

```

