# CloudFormation Stack Operations Script:

## Code File :
```sh
#!/bin/bash

# CloudFormation Stack Operations Script
# This script automates the creation, update, and deletion of AWS CloudFormation stacks using AWS CLI.

STACK_NAME="your-stack-name"  # Replace with your desired stack name
TEMPLATE_FILE="template.yaml"  # Replace with your CloudFormation template file
PARAMETERS_FILE="parameters.json"  # Replace with your parameters file (optional)
REGION="us-east-1"  # Replace with your desired AWS region

case $1 in
    create)
        aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://$TEMPLATE_FILE --parameters file://$PARAMETERS_FILE --region $REGION
        ;;
    update)
        aws cloudformation update-stack --stack-name $STACK_NAME --template-body file://$TEMPLATE_FILE --parameters file://$PARAMETERS_FILE --region $REGION
        ;;
    delete)
        aws cloudformation delete-stack --stack-name $STACK_NAME --region $REGION
        ;;
    *)
        echo "Usage: $0 {create|update|delete}"
        ;;
esac

```

## How It Works

### 1. Creating a CloudFormation Stack

- **Operation:**
  - When executed with the `create` argument, the script initiates the creation of a new CloudFormation stack.
  - The `aws cloudformation create-stack` command is used with parameters specifying the stack name, template file, parameters file, and region.
  - Example:
    ```bash
    ./cloudformation_stack.sh create
    ```
  - This command creates a new CloudFormation stack based on the provided template and parameters.

### 2. Updating a CloudFormation Stack

- **Operation:**
  - Executing the script with the `update` argument updates an existing CloudFormation stack.
  - The `aws cloudformation update-stack` command is invoked with the stack name, template file, parameters file, and region.
  - Example:
    ```bash
    ./cloudformation_stack.sh update
    ```
  - This updates the specified stack with any changes made to the template or parameters.

### 3. Deleting a CloudFormation Stack

- **Operation:**
  - Using the `delete` argument with the script deletes the specified CloudFormation stack.
  - The `aws cloudformation delete-stack` command is called with the stack name and region.
  - Example:
    ```bash
    ./cloudformation_stack.sh delete
    ```
  - This permanently deletes the specified CloudFormation stack.
