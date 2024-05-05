# Backup Dir using Shell

## Code File :
```sh
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

```
## Code Explaination :
- **`timestamp=$(date +"%Y%m%d_%H%M%S")`** : The **date** command is used to generate a timestamp in the format **YYYYMMDD_HHMMSS**. This timestamp is stored in the variable timestamp.
- **`tar -czf "${destination_dir}/${backup_filename}" "$source_dir"`** : The tar command is used to create a compressed archive of the source directory ($source_dir) and save it to the destination directory ($destination_dir).
Options used with tar:
    - c : Create a new archive.
    - z : Compress the archive using gzip.
    - f : Specifies the filename of the archive.
- **`${destination_dir}/${backup_filename}`** :  specifies the full path of the backup file.

<hr>
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/Backup%20dir/image1.png">
