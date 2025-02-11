# User and Permission Management:

## Create, modify, and delete users and groups. Set file permissions and ownership

## Code File :
```sh
#!/bin/bash
# User and Permission Management Script
# This script performs the following operations:
#  - Create, modify, and delete users and groups.
#  - Set file permissions and ownership.
#
# Usage:
#   ./manage.sh <operation> <parameters>
#
# Operations:
#   create-user <username> [home_directory] [shell]
#   delete-user <username>
#   modify-user <username> <usermod_options>
#   create-group <groupname>
#   delete-group <groupname>
#   modify-group <groupname> <new_groupname>
#   set-permissions <file/directory> <permissions>
#   set-ownership <file/directory> <owner>:<group>

# Ensure the script is run as root.
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

# Function to display usage instructions.
usage() {
    echo "Usage: $0 <operation> <parameters>"
    echo "Operations:"
    echo "  create-user <username> [home_directory] [shell]   - Create a new user (optionally specifying home and shell)."
    echo "  delete-user <username>                            - Delete an existing user (with home directory removal)."
    echo "  modify-user <username> <usermod_options>          - Modify user attributes (e.g., change shell with: -s /bin/bash)."
    echo "  create-group <groupname>                          - Create a new group."
    echo "  delete-group <groupname>                          - Delete an existing group."
    echo "  modify-group <groupname> <new_groupname>          - Rename a group."
    echo "  set-permissions <file/directory> <permissions>    - Set file permissions (e.g., 755 or 644)."
    echo "  set-ownership <file/directory> <owner>:<group>      - Set owner and group for file/directory."
    exit 1
}

# Check if at least 2 arguments are provided.
if [ $# -lt 2 ]; then
    usage
fi

operation=$1
shift  # Remove the operation from the arguments list

case "$operation" in
    create-user)
        # Create a new user.
        # Usage: create-user username [home_directory] [shell]
        username=$1
        home_dir=$2
        user_shell=$3
        if [ -z "$username" ]; then
            echo "Error: Username is required for create-user."
            exit 1
        fi
        if [ -n "$home_dir" ] && [ -n "$user_shell" ]; then
            useradd -m -d "$home_dir" -s "$user_shell" "$username"
        elif [ -n "$home_dir" ]; then
            useradd -m -d "$home_dir" "$username"
        elif [ -n "$user_shell" ]; then
            useradd -m -s "$user_shell" "$username"
        else
            useradd -m "$username"
        fi
        if [ $? -eq 0 ]; then
            echo "User '$username' created successfully."
        else
            echo "Failed to create user '$username'."
        fi
        ;;
    delete-user)
        # Delete an existing user.
        # Usage: delete-user username
        username=$1
        if [ -z "$username" ]; then
            echo "Error: Username is required for delete-user."
            exit 1
        fi
        userdel -r "$username"
        if [ $? -eq 0 ]; then
            echo "User '$username' deleted successfully."
        else
            echo "Failed to delete user '$username'."
        fi
        ;;
    modify-user)
        # Modify user information.
        # Usage: modify-user username <usermod_options>
        username=$1
        shift
        if [ -z "$username" ]; then
            echo "Error: Username is required for modify-user."
            exit 1
        fi
        usermod "$@" "$username"
        if [ $? -eq 0 ]; then
            echo "User '$username' modified successfully."
        else
            echo "Failed to modify user '$username'."
        fi
        ;;
    create-group)
        # Create a new group.
        # Usage: create-group groupname
        groupname=$1
        if [ -z "$groupname" ]; then
            echo "Error: Group name is required for create-group."
            exit 1
        fi
        groupadd "$groupname"
        if [ $? -eq 0 ]; then
            echo "Group '$groupname' created successfully."
        else
            echo "Failed to create group '$groupname'."
        fi
        ;;
    delete-group)
        # Delete an existing group.
        # Usage: delete-group groupname
        groupname=$1
        if [ -z "$groupname" ]; then
            echo "Error: Group name is required for delete-group."
            exit 1
        fi
        groupdel "$groupname"
        if [ $? -eq 0 ]; then
            echo "Group '$groupname' deleted successfully."
        else
            echo "Failed to delete group '$groupname'."
        fi
        ;;
    modify-group)
        # Modify (rename) a group.
        # Usage: modify-group groupname new_groupname
        groupname=$1
        new_groupname=$2
        if [ -z "$groupname" ] || [ -z "$new_groupname" ]; then
            echo "Error: Both current group name and new group name are required for modify-group."
            exit 1
        fi
        groupmod -n "$new_groupname" "$groupname"
        if [ $? -eq 0 ]; then
            echo "Group '$groupname' renamed to '$new_groupname' successfully."
        else
            echo "Failed to modify group '$groupname'."
        fi
        ;;
    set-permissions)
        # Set file or directory permissions.
        # Usage: set-permissions <file/directory> <permissions>
        target=$1
        perms=$2
        if [ -z "$target" ] || [ -z "$perms" ]; then
            echo "Error: Both target and permissions are required for set-permissions."
            exit 1
        fi
        chmod "$perms" "$target"
        if [ $? -eq 0 ]; then
            echo "Permissions for '$target' set to '$perms' successfully."
        else
            echo "Failed to set permissions for '$target'."
        fi
        ;;
    set-ownership)
        # Set file or directory ownership.
        # Usage: set-ownership <file/directory> <owner>:<group>
        target=$1
        owner_group=$2
        if [ -z "$target" ] || [ -z "$owner_group" ]; then
            echo "Error: Both target and owner:group are required for set-ownership."
            exit 1
        fi
        chown "$owner_group" "$target"
        if [ $? -eq 0 ]; then
            echo "Ownership for '$target' set to '$owner_group' successfully."
        else
            echo "Failed to set ownership for '$target'."
        fi
        ;;
    *)
        echo "Invalid operation: $operation"
        usage
        ;;
esac



```

# How It Works

1. **Privilege Check:**  
   The script first checks if it is being run as root. If not, it prints an error message and exits.

2. **Usage Function:**  
   A `usage` function is defined to guide the user on how to invoke the script.

3. **Case Statement:**  
   The script then uses a case statement to determine which operation to perform:
   - **create-user:** Uses `useradd` (with optional home directory and shell arguments).
   - **delete-user:** Uses `userdel -r` to remove the user along with its home directory.
   - **modify-user:** Leverages `usermod` with any options passed after the username.
   - **create-group / delete-group / modify-group:** Uses the corresponding `groupadd`, `groupdel`, and `groupmod` commands.
   - **set-permissions:** Uses `chmod` to change file or directory permissions.
   - **set-ownership:** Uses `chown` to set the owner and group for a file or directory.

4. **Feedback:**  
   After each operation, the script checks the exit status and prints a success or failure message.
