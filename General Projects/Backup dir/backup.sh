#!/bin/bash

# Define the source and destination directories
source_dir="/home/harsh/Desktop/testdir"
destination_dir="/home/harsh/Desktop/shells"

# Create a timestamp for the backup file
timestamp=$(date +"%Y%m%d_%H%M%S")

# Create the destination directory if it doesn't exist
mkdir -p "$destination_dir"

# Define the backup filename
backup_filename="backup_${timestamp}.tar.gz"

# Perform the backup
tar -czf "${destination_dir}/${backup_filename}" "$source_dir"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup successful! Backup saved as: ${destination_dir}/${backup_filename}"
else
    echo "Backup failed!"
fi
