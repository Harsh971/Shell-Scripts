# S3 Bucket Operations Script:

## Code File :
```sh
#!/bin/bash

# S3 Bucket Operations Script
# This script automates S3 bucket creation, file uploads/downloads, and syncing using AWS CLI.

BUCKET_NAME="my-s3-bucket"  # Replace with your bucket name
LOCAL_PATH="/path/to/local/folder"  # Replace with your local path
S3_PATH="s3://$BUCKET_NAME/"

case $1 in
    create)
        aws s3 mb $S3_PATH
        ;;
    upload)
        aws s3 cp $LOCAL_PATH $S3_PATH --recursive
        ;;
    download)
        aws s3 cp $S3_PATH $LOCAL_PATH --recursive
        ;;
    sync)
        aws s3 sync $LOCAL_PATH $S3_PATH
        ;;
    *)
        echo "Usage: $0 {create|upload|download|sync}"
        ;;
esac
```

## How It Works

### 1. Creating an S3 Bucket

- **Operation:**
  - When executed with the `create` argument, the script creates a new S3 bucket.
  - The `aws s3 mb` command is used to make a new bucket with the specified name.
  - Example:
    ```bash
    ./s3_operations.sh create
    ```
  - This command creates a new S3 bucket named as specified in the `BUCKET_NAME` variable.

### 2. Uploading Files to S3

- **Operation:**
  - With the `upload` argument, the script uploads files from a local directory to the S3 bucket.
  - The `aws s3 cp` command is used with the `--recursive` flag to copy all files from the local path to the S3 bucket.
  - Example:
    ```bash
    ./s3_operations.sh upload
    ```
  - This uploads all files from the specified local directory to the S3 bucket.

### 3. Downloading Files from S3

- **Operation:**
  - Using the `download` argument, the script downloads files from the S3 bucket to a local directory.
  - The `aws s3 cp` command with the `--recursive` flag copies all files from the S3 bucket to the local path.
  - Example:
    ```bash
    ./s3_operations.sh download
    ```
  - This downloads all files from the S3 bucket to the specified local directory.

### 4. Synchronizing Local and S3 Directories

- **Operation:**
  - The `sync` argument synchronizes files between the local directory and the S3 bucket.
  - The `aws s3 sync` command ensures that the destination matches the source by copying new or updated files.
  - Example:
    ```bash
    ./s3_operations.sh sync
    ```
  - This synchronizes the local directory with the S3 bucket, ensuring both locations have the same files.
