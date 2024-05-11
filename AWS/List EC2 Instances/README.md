# List all Instances of AWS through Shell

## Prerequisite : 
**1. AWSCLI Package :** **`sudo apt install awscli`**
<br>
**2. Configure AWS Account :** **`aws configure`**
- IAM User Access Key
- IAM User Secret Access Key
- Default Zone
- Default Output Format

## Steps to generate Access Keys : 
1. Login to AWS Console
2. Navigate to IAM Dashboard and Create an IAM User with required Permissions
3. For that IAM User navigate to > Security Credentials > Access Keys > Create Access Keys
4. Access keys are generated (Don't forget to backup them ;) )

## Code Preview : 

```sh
#!/bin/bash

# Check if AWS CLI is installed
if ! [ -x "$(command -v aws)" ]; then
  echo 'Error: AWS CLI is not installed. Please install it before running this script.' >&2
  exit 1
fi

# List all running EC2 instances
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId, InstanceType, State.Name, PublicIpAddress, PrivateIpAddress]' --output table

```

## Code Explaination : 
- **`aws ec2 describe-instances`** : This part of the command is using the AWS CLI to describe EC2 instances. It fetches information about EC2 instances in your AWS account.

- **`--query 'Reservations[*].Instances[*].[InstanceId, InstanceType, State.Name, PublicIpAddress, PrivateIpAddress]'`** : This part specifies a JMESPath query to filter the output of the describe-instances command. JMESPath is a query language for JSON-like data. In this query:

    - **`Reservations[*]`** selects all the reservations.
    - **`Instances[*]`** selects all the instances within those reservations.
    - **`[InstanceId, InstanceType, State.Name, PublicIpAddress, PrivateIpAddress]`** specifies the attributes of each instance to be included in the output. These attributes are InstanceId, InstanceType, State.Name (the state of the instance, such as "running" or "stopped"), PublicIpAddress, and PrivateIpAddress.
- **`--output table`** : This part specifies the output format of the command. In this case, the output will be displayed in a tabular format, making it easier to read.

So, this line of shell script fetches information about EC2 instances in an AWS account and displays it in a table format, including the Instance ID, Instance Type, State, Public IP Address, and Private IP Address of each instance.


<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/AWS/List%20EC@%20Instances/image1.png">

<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/AWS/List%20EC@%20Instances/image2.png">


