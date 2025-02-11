# File & Directory Operations:

## Automated file backups, copy/move, and directory traversals. Archiving and compressing logs or datasets

## Code File :
```sh
#!/bin/bash
# File & Directory Operations Script
# This script supports:
#   - Automated file backups (with timestamp)
#   - Copying and moving files
#   - Directory traversal (listing all files recursively)
#   - Archiving and compressing a directory (e.g., for logs or datasets)
#
# Usage:
#   ./file_dir_ops.sh <operation> [arguments]
#
# Operations:
#   backup   <source_directory> <backup_directory>
#   copy     <source_file> <destination_file>
#   move     <source_file> <destination_file>
#   traverse <directory>
#   archive  <directory> <archive_name>

usage() {
    echo "Usage: $0 <operation> [arguments]"
    echo ""
    echo "Operations:"
    echo "  backup <source_directory> <backup_directory>"
    echo "      - Creates a backup of the source directory in the backup directory with a timestamp."
    echo "  copy <source_file> <destination_file>"
    echo "      - Copies a file from source to destination."
    echo "  move <source_file> <destination_file>"
    echo "      - Moves a file from source to destination."
    echo "  traverse <directory>"
    echo "      - Recursively lists all files in the given directory."
    echo "  archive <directory> <archive_name>"
    echo "      - Archives and compresses the given directory into a tar.gz file named <archive_name>.tar.gz."
    exit 1
}

# Ensure that at least one argument is provided.
if [ $# -lt 1 ]; then
    usage
fi

operation=$1
shift

case "$operation" in
    backup)
        # Usage: backup <source_directory> <backup_directory>
        if [ $# -ne 2 ]; then
            echo "Error: 'backup' requires a source directory and a backup directory."
            usage
        fi
        src_dir=$1
        backup_dir=$2
        timestamp=$(date +%Y%m%d_%H%M%S)
        # Create backup directory if it doesn't exist
        mkdir -p "$backup_dir"
        backup_target="${backup_dir}/$(basename "$src_dir")_backup_${timestamp}"
        cp -r "$src_dir" "$backup_target"
        if [ $? -eq 0 ]; then
            echo "Backup of '$src_dir' completed successfully at '$backup_target'."
        else
            echo "Backup failed."
        fi
        ;;
    copy)
        # Usage: copy <source_file> <destination_file>
        if [ $# -ne 2 ]; then
            echo "Error: 'copy' requires a source file and a destination file."
            usage
        fi
        cp "$1" "$2"
        if [ $? -eq 0 ]; then
            echo "Copied '$1' to '$2' successfully."
        else
            echo "Copy failed."
        fi
        ;;
    move)
        # Usage: move <source_file> <destination_file>
        if [ $# -ne 2 ]; then
            echo "Error: 'move' requires a source file and a destination file."
            usage
        fi
        mv "$1" "$2"
        if [ $? -eq 0 ]; then
            echo "Moved '$1' to '$2' successfully."
        else
            echo "Move failed."
        fi
        ;;
    traverse)
        # Usage: traverse <directory>
        if [ $# -ne 1 ]; then
            echo "Error: 'traverse' requires a directory."
            usage
        fi
        echo "Listing all files under '$1':"
        find "$1" -type f
        ;;
    archive)
        # Usage: archive <directory> <archive_name>
        if [ $# -ne 2 ]; then
            echo "Error: 'archive' requires a directory and an archive name."
            usage
        fi
        dir_to_archive=$1
        archive_name=$2
        tar -czvf "${archive_name}.tar.gz" -C "$(dirname "$dir_to_archive")" "$(basename "$dir_to_archive")"
        if [ $? -eq 0 ]; then
            echo "Directory '$dir_to_archive' archived successfully as '${archive_name}.tar.gz'."
        else
            echo "Archive failed."
        fi
        ;;
    *)
        echo "Invalid operation: $operation"
        usage
        ;;
esac




```

### Available Operations

1. **Backup**
   - **Command:** `backup <source_directory> <backup_directory>`
   - **Example:** `./file_dir_ops.sh backup /var/www/html /backup`
   - **Description:** Creates a backup of `/var/www/html` by copying it to `/backup` with a timestamp appended (e.g., `html_backup_20250211_153045`).

2. **Copy**
   - **Command:** `copy <source_file> <destination_file>`
   - **Example:** `./file_dir_ops.sh copy file.txt /tmp/file.txt`
   - **Description:** Copies `file.txt` to `/tmp/file.txt`.

3. **Move**
   - **Command:** `move <source_file> <destination_file>`
   - **Example:** `./file_dir_ops.sh move file.txt /tmp/file.txt`
   - **Description:** Moves `file.txt` to `/tmp/file.txt`.

4. **Traverse**
   - **Command:** `traverse <directory>`
   - **Example:** `./file_dir_ops.sh traverse /var/log`
   - **Description:** Lists all files under `/var/log` and its subdirectories.

5. **Archive**
   - **Command:** `archive <directory> <archive_name>`
   - **Example:** `./file_dir_ops.sh archive /var/log/myapp myapp_logs_backup`
   - **Description:** Archives the `/var/log/myapp` directory into a compressed file named `myapp_logs_backup.tar.gz`.

## Script Breakdown

- **Usage Function:**  
  The script begins with a `usage` function that displays proper usage information when incorrect arguments are provided.

- **Case Statement:**  
  A `case` statement is used to branch into different operations based on the first argument:
  - **backup:**  
    Uses `cp -r` to recursively copy the source directory to the backup destination with a timestamp.
  - **copy:**  
    Uses the `cp` command to copy a file.
  - **move:**  
    Uses the `mv` command to move a file.
  - **traverse:**  
    Uses the `find` command to list all files in a directory.
  - **archive:**  
    Uses `tar -czvf` to create a compressed (tar.gz) archive of the specified directory.

- **Feedback Mechanism:**  
  After each operation, the script checks the command’s exit status (`$?`) and displays a success or failure message.

## Making the Script Executable

Before running the script, make it executable:

