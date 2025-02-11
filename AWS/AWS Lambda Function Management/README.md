# AWS Lambda Function Management: 

## Code File :
```sh
#!/bin/bash

# AWS Lambda Function Management Script
# This script automates the creation, update, and deletion of AWS Lambda functions using AWS CLI.

FUNCTION_NAME="your-function-name"  # Replace with your Lambda function name
ROLE_ARN="arn:aws:iam::123456789012:role/your-role"  # Replace with your IAM role ARN
HANDLER="index.handler"  # Replace with your function handler
ZIP_FILE="function.zip"  # Replace with your deployment package
RUNTIME="nodejs14.x"  # Replace with your runtime environment
REGION="us-east-1"  # Replace with your desired AWS region

case $1 in
    create)
        aws lambda create-function --function-name $FUNCTION_NAME --runtime $RUNTIME --role $ROLE_ARN --handler $HANDLER --zip-file fileb://$ZIP_FILE --region $REGION
        ;;
    update)
        aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://$ZIP_FILE --region $REGION
        ;;
    delete)
        aws lambda delete-function --function-name $FUNCTION_NAME --region $REGION
        ;;
    *)
        echo "Usage: $0 {create|update|delete}"
        ;;
esac

```

## How It Works

### 1. Creating a Lambda Function

- **Operation:**
  - When executed with the `create` argument, the script creates a new AWS Lambda function.
  - The `aws lambda create-function` command is used with parameters specifying the function name, runtime environment, IAM role ARN, handler, deployment package, and region.
  - Example:
    ```bash
    ./lambda_manage.sh create
    ```
  - This command creates a new Lambda function with the provided configuration.

### 2. Updating a Lambda Function

- **Operation:**
  - Executing the script with the `update` argument updates the code of an existing Lambda function.
  - The `aws lambda update-function-code` command is invoked with the function name, deployment package, and region.
  - Example:
    ```bash
    ./lambda_manage.sh update
    ```
  - This updates the specified Lambda function's code with the new deployment package.

### 3. Deleting a Lambda Function

- **Operation:**
  - Using the `delete` argument with the script deletes the specified Lambda function.
  - The `aws lambda delete-function` command is called with the function name and region.
  - Example:
    ```bash
    ./lambda_manage.sh delete
    ```
  - This permanently deletes the specified Lambda function.
