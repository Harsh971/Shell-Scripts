# IAM User and Role Setup:

## Code File :
```sh
#!/bin/bash

# IAM User and Role Setup Script
# This script automates the creation of IAM users and roles using AWS CLI.

USER_NAME="your-username"  # Replace with your desired IAM username
ROLE_NAME="your-role-name"  # Replace with your desired IAM role name
POLICY_ARN="arn:aws:iam::aws:policy/AdministratorAccess"  # Replace with the ARN of the policy to attach
TRUST_POLICY_FILE="trust-policy.json"  # Replace with your trust policy file
REGION="us-east-1"  # Replace with your desired AWS region

case $1 in
    create-user)
        aws iam create-user --user-name $USER_NAME --region $REGION
        aws iam attach-user-policy --user-name $USER_NAME --policy-arn $POLICY_ARN --region $REGION
        ;;
    delete-user)
        aws iam detach-user-policy --user-name $USER_NAME --policy-arn $POLICY_ARN --region $REGION
        aws iam delete-user --user-name $USER_NAME --region $REGION
        ;;
    create-role)
        aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document file://$TRUST_POLICY_FILE --region $REGION
        aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN --region $REGION
        ;;
    delete-role)
        aws iam detach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN --region $REGION
        aws iam delete-role --role-name $ROLE_NAME --region $REGION
        ;;
    *)
        echo "Usage: $0 {create-user|delete-user|create-role|delete-role}"
        ;;
esac

```

## How It Works

### 1. Creating an IAM User

- **Operation:**
  - When executed with the `create-user` argument, the script performs the following steps:
    - Creates a new IAM user with the specified username.
    - Attaches a specified managed policy to the user to grant permissions.
  - Example:
    ```bash
    ./iam_setup.sh create-user
    ```
  - This command creates a new IAM user and assigns the specified permissions.

### 2. Deleting an IAM User

- **Operation:**
  - Executing the script with the `delete-user` argument performs the following steps:
    - Detaches the specified managed policy from the user.
    - Deletes the IAM user.
  - Example:
    ```bash
    ./iam_setup.sh delete-user
    ```
  - This command removes the specified IAM user and associated permissions.

### 3. Creating an IAM Role

- **Operation:**
  - Using the `create-role` argument with the script performs the following steps:
    - Creates a new IAM role with the specified role name and trust policy.
    - Attaches a specified managed policy to the role to grant permissions.
  - Example:
    ```bash
    ./iam_setup.sh create-role
    ```
  - This command creates a new IAM role and assigns the specified permissions.

### 4. Deleting an IAM Role

- **Operation:**
  - Executing the script with the `delete-role` argument performs the following steps:
    - Detaches the specified managed policy from the role.
    - Deletes the IAM role.
  - Example:
    ```bash
    ./iam_setup.sh delete-role
    ```
  - This command removes the specified IAM role and associated permissions.
