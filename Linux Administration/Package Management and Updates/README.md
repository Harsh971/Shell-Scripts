# Package Management and Updates:

## Installing, updating, and removing software packages (apt, yum, etc.). Automating system updates and patches

## Code File :
```sh
#!/bin/bash
# Package Management & Updates Automation Script
#
# This script detects the system's package manager (apt or yum) and then performs one of
# the following operations:
#   - Install a package
#   - Remove a package
#   - Update the package list
#   - Upgrade installed packages (apply patches/updates)
#   - Perform a full update (update list and upgrade packages)
#   - Autoremove orphaned packages (only for apt)
#
# Usage:
#   ./package_manager.sh install <package_name>
#   ./package_manager.sh remove <package_name>
#   ./package_manager.sh update
#   ./package_manager.sh upgrade
#   ./package_manager.sh fullupdate
#   ./package_manager.sh autoremove
#
# Note: You may need to run this script with sudo privileges.

# Function to display usage information
usage() {
    echo "Usage: $0 {install|remove|update|upgrade|fullupdate|autoremove} [package_name]"
    exit 1
}

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    usage
fi

# Detect available package manager
if command -v apt-get &>/dev/null; then
    PM="apt"
elif command -v yum &>/dev/null; then
    PM="yum"
else
    echo "Error: No supported package manager found (apt or yum)."
    exit 1
fi

echo "Detected package manager: $PM"

# Define function to install a package
install_package() {
    local package="$1"
    if [ -z "$package" ]; then
        echo "Error: Please provide a package name to install."
        usage
    fi
    if [ "$PM" = "apt" ]; then
        sudo apt-get update && sudo apt-get install -y "$package"
    elif [ "$PM" = "yum" ]; then
        sudo yum install -y "$package"
    fi
}

# Define function to remove a package
remove_package() {
    local package="$1"
    if [ -z "$package" ]; then
        echo "Error: Please provide a package name to remove."
        usage
    fi
    if [ "$PM" = "apt" ]; then
        sudo apt-get remove -y "$package"
    elif [ "$PM" = "yum" ]; then
        sudo yum remove -y "$package"
    fi
}

# Define function to update the package list
update_packages() {
    if [ "$PM" = "apt" ]; then
        sudo apt-get update
    elif [ "$PM" = "yum" ]; then
        sudo yum check-update
    fi
}

# Define function to upgrade installed packages (apply patches/updates)
upgrade_packages() {
    if [ "$PM" = "apt" ]; then
        sudo apt-get upgrade -y
    elif [ "$PM" = "yum" ]; then
        sudo yum update -y
    fi
}

# Define function to autoremove orphaned packages (apt-only)
autoremove_packages() {
    if [ "$PM" = "apt" ]; then
        sudo apt-get autoremove -y
    else
        echo "Autoremove is not supported for package manager $PM."
    fi
}

# Parse command-line arguments
ACTION="$1"
PACKAGE="$2"

case "$ACTION" in
    install)
        install_package "$PACKAGE"
        ;;
    remove)
        remove_package "$PACKAGE"
        ;;
    update)
        update_packages
        ;;
    upgrade)
        upgrade_packages
        ;;
    fullupdate)
        update_packages && upgrade_packages
        ;;
    autoremove)
        autoremove_packages
        ;;
    *)
        usage
        ;;
esac

echo "Operation '$ACTION' completed."

```

## How It Works

### 1. Package Manager Detection
- **Detection:**  
  The script checks whether `apt-get` or `yum` is available. It sets the package manager accordingly.  
  - If neither is found, the script exits with an error.
  
### 2. Installing a Package
- **Operation:**  
  When run with the `install` option (e.g., `./package_manager.sh install vim`), the script:
  - Updates the package list (for apt systems).
  - Installs the specified package using the appropriate command.

### 3. Removing a Package
- **Operation:**  
  When using the `remove` option (e.g., `./package_manager.sh remove vim`), the script uninstalls the specified package.

### 4. Updating and Upgrading
- **Update:**  
  The `update` option refreshes the package list.
- **Upgrade:**  
  The `upgrade` option applies available patches or updates.
- **Full Update:**  
  The `fullupdate` option combines both an update and an upgrade sequentially.

### 5. Autoremoving Orphaned Packages
- **Operation:**  
  The `autoremove` option (only available on apt systems) removes packages that are no longer required.
